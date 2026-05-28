/**
 * HaloRP MVP — Persistence Google Apps Script
 * =============================================
 * À coller dans la Google Sheet : Extensions > Apps Script > colle ce fichier > Save.
 *
 * Rôle :
 *   - Auto-calcule le NIVEAU (level) depuis l'XP cumulée (table leveling.json)
 *   - Auto-calcule l'XP final par session (MatchResults) via la formule d'économie
 *   - Valide les bornes anti-abus (XP_POLICY) à chaque édition
 *   - Verrouille les Ops > 48h (audit immuable)
 *   - NE TOUCHE JAMAIS au grade militaire (manuel — voir promotion_rules.json)
 *
 * Décisions figées 2026-05-28 :
 *   - Grade = MANUEL (promotion_rules.json fait autorité, pas xp_system.md)
 *   - Level = AUTO depuis la table explicite leveling.json (pas la formule trompeuse)
 *
 * Voir : configs/persistence_sheet.md (schéma des onglets)
 */

// ============================================================
// 1. POLICY XP (validée par le tech lead 2026-05-28)
// ============================================================
const XP_POLICY = {
  MAX_XP_PER_SESSION:        600,   // plafond dur par session/joueur
  MIN_XP_PER_SESSION:        -300,  // plancher (somme des sanctions max)

  // Plafonds par composant (anti-typo / anti-abus, pas les valeurs normales)
  MAX_PRESENCE:              200,   // 8 XP/min × 25 min
  MAX_VICTORY:               200,   // normalement 100, headroom pour bonus
  MAX_OBJECTIVES:            250,   // cov flag_captured_and_extracted = 250
  MAX_ROLE:                  100,   // Operation Commander
  MAX_DISCIPLINE:            200,   // somme zero_violation + comms + mvp
  MAX_MVP_KILL:              180,   // zealot kill (field_marshal=300 = exception)
  MIN_PENALTY_SINGLE:        -200,  // team_kill_intentional

  // Bonus spéciaux
  FIRST_OP_MULTIPLIER:       1.5,   // première Op lifetime (peut dépasser 600)
  AFK_THRESHOLD_PCT:         50,    // si présence < 50% durée Op → XP = 0

  // Anti-grind / audit
  COOLDOWN_SESSIONS_PER_DAY: 3,     // max 3 sessions comptées/jour/joueur
  LEDGER_LOCK_AFTER_HOURS:   48,    // verrou édition après 48h
};

// Stratégie quand une borne est violée — À TOI DE CHOISIR (voir handleViolation)
//   "FLAG"   : laisse passer, colore la cellule en rouge pour revue manuelle (défaut, audit-friendly)
//   "CLAMP"  : plafonne à la valeur max autorisée + ajoute une note
//   "REJECT" : annule l'édition (revert)
const VIOLATION_STRATEGY = "FLAG";

// ============================================================
// 2. SEUILS DE NIVEAU (copie EXACTE de leveling.json — source de vérité)
// ============================================================
const LEVEL_THRESHOLDS = [
  { level: 1,  xp: 0,     tier: "Bronze"   },
  { level: 2,  xp: 200,   tier: "Bronze"   },
  { level: 3,  xp: 480,   tier: "Bronze"   },
  { level: 4,  xp: 840,   tier: "Bronze"   },
  { level: 5,  xp: 1280,  tier: "Bronze"   },
  { level: 6,  xp: 1800,  tier: "Bronze"   },
  { level: 7,  xp: 2400,  tier: "Bronze"   },
  { level: 8,  xp: 3080,  tier: "Bronze"   },
  { level: 9,  xp: 3840,  tier: "Bronze"   },
  { level: 10, xp: 4680,  tier: "Silver"   },
  { level: 12, xp: 6520,  tier: "Silver"   },
  { level: 15, xp: 9750,  tier: "Silver"   },
  { level: 18, xp: 13320, tier: "Silver"   },
  { level: 20, xp: 15800, tier: "Gold"     },
  { level: 22, xp: 18280, tier: "Gold"     },
  { level: 25, xp: 22250, tier: "Gold"     },
  { level: 28, xp: 26320, tier: "Gold"     },
  { level: 30, xp: 29100, tier: "Platinum" },
  { level: 33, xp: 33330, tier: "Platinum" },
  { level: 35, xp: 36240, tier: "Platinum" },
  { level: 38, xp: 40700, tier: "Platinum" },
  { level: 40, xp: 43760, tier: "Diamond"  },
  { level: 42, xp: 46860, tier: "Diamond"  },
  { level: 45, xp: 51570, tier: "Diamond"  },
  { level: 48, xp: 56360, tier: "Diamond"  },
  { level: 50, xp: 59600, tier: "Onyx"     },
];

// ============================================================
// 3. CONFIG ONGLETS & COLONNES (1-based, voir persistence_sheet.md)
// ============================================================
const SHEETS = {
  ROSTER:     "Roster",
  OPERATIONS: "Operations",
  MATCH:      "MatchResults",
  PROMO:      "PromotionsLog",
};

// MatchResults : A..M (inputs SL → M = XP final auto)
const MATCH_COL = {
  OP_ID: 1, DISCORD: 2, FACTION: 3, DIVISION: 4, ROLE: 5, LOADOUT: 6,
  MINUTES: 7, VICTORY: 8, OBJECTIVES: 9, DISCIPLINE: 10, BONUS: 11,
  PENALTIES: 12, XP_FINAL: 13,
};

// Roster : A..K (révisé — voir persistence_sheet.md)
const ROSTER_COL = {
  DISCORD: 1, STEAM_ID: 2, FACTION: 3, DIVISION: 4, GRADE: 5,
  XP_TOTAL: 6, LEVEL: 7, TIER: 8, LAST_OP: 9, STATUS: 10, NOTES: 11,
};

const OP_COL = { OP_ID: 1, DATE: 2, NAME: 3, TYPE: 4, MAP: 5, VARIANT: 6,
  HOST: 7, UNSC: 8, COV: 9, OUTCOME: 10, DURATION: 11, REPORT: 12 };

// ============================================================
// 4. MENU CUSTOM
// ============================================================
function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu("HaloRP")
    .addItem("Recalculer XP + niveaux (Roster)", "recalcRoster")
    .addItem("Recalculer XP final (MatchResults)", "recalcMatchResults")
    .addSeparator()
    .addItem("Verrouiller les Ops > 48h", "lockOldOperations")
    .addItem("Valider tout le ledger", "validateAllMatchResults")
    .addToUi();
}

// ============================================================
// 5. CALCUL DE NIVEAU (table explicite, pas la formule)
// ============================================================
/**
 * Retourne { level, tier } pour une XP cumulée donnée.
 * Le niveau = le plus haut palier dont xp <= xpTotal.
 */
function levelFromXp(xpTotal) {
  let result = LEVEL_THRESHOLDS[0];
  for (const t of LEVEL_THRESHOLDS) {
    if (xpTotal >= t.xp) {
      result = t;
    } else {
      break;
    }
  }
  return { level: result.level, tier: result.tier };
}

// ============================================================
// 6. FORMULE XP SESSION  ←←← TON SPOT DE CONTRIBUTION
// ============================================================
/**
 * Calcule l'XP final d'une session à partir des composants saisis par le SL.
 *
 * c = {
 *   minutes:    int,   // colonne G
 *   victory:    0|1,   // colonne H
 *   objectives: int,   // colonne I (count d'objectifs secondaires)
 *   discipline: 0|1,   // colonne J
 *   penalties:  int,   // colonne L (valeur négative ou 0)
 *   isFirstOp:  bool,  // dérivé (joueur sans XP_TOTAL préalable)
 * }
 *
 * ┌─────────────────────────────────────────────────────────────┐
 * │ DÉCISION ÉCONOMIQUE — c'est TON système, pas une vérité       │
 * │ universelle. Les poids ci-dessous viennent de xp_system.md +  │
 * │ xp_rewards_*.json, mais l'équilibrage final t'appartient.     │
 * │                                                               │
 * │ Trade-offs à considérer :                                     │
 * │  - objectif × 75 : généreux ? un Covenant qui sabote ET       │
 * │    capture cumule 150. Trop fort vs un Rifleman à 0 objectif ?│
 * │  - discipline 50 : suffisant pour inciter le RP propre ?      │
 * │  - faut-il un bonus de rôle ici (Operation Commander +100) ?  │
 * │    Pour l'instant le rôle n'est PAS compté (col E ignorée).   │
 * │    À toi de décider si tu l'ajoutes.                          │
 * └─────────────────────────────────────────────────────────────┘
 */
function computeSessionXp(c) {
  // Anti-AFK : présence sous le seuil → session nulle
  // (durée Op de référence = 25 min, cf. sentinel_defense_v1)
  const OP_REFERENCE_MIN = 25;
  if (c.minutes < OP_REFERENCE_MIN * (XP_POLICY.AFK_THRESHOLD_PCT / 100)) {
    return 0;
  }

  // Composants (bornés par les caps de la policy)
  const presence   = Math.min(c.minutes * 8, XP_POLICY.MAX_PRESENCE);
  const victory    = Math.min((c.victory ? 100 : 0), XP_POLICY.MAX_VICTORY);
  const objectives = Math.min(c.objectives * 75, XP_POLICY.MAX_OBJECTIVES);
  const discipline = Math.min((c.discipline ? 50 : 0), XP_POLICY.MAX_DISCIPLINE);
  const penalties  = Math.max(c.penalties, XP_POLICY.MIN_PENALTY_SINGLE);

  // TODO (toi) : ajouter un terme de rôle ici si tu le veux, ex:
  //   const role = ROLE_BONUS[c.role] || 0;
  // et l'inclure dans la somme. Voir xp_rewards_*.json role_bonuses.

  let total = presence + victory + objectives + discipline + penalties;

  // Bonus première Op (peut dépasser 600 — exception documentée)
  if (c.isFirstOp) {
    total = Math.round(total * XP_POLICY.FIRST_OP_MULTIPLIER);
    return Math.max(total, 0); // pas de clamp 600 sur la 1ère Op
  }

  // Clamp standard [MIN ; MAX]
  return Math.max(XP_POLICY.MIN_XP_PER_SESSION, Math.min(total, XP_POLICY.MAX_XP_PER_SESSION));
}

// ============================================================
// 7. VALIDATION onEdit (anti-abus en temps réel)
// ============================================================
function onEdit(e) {
  if (!e || !e.range) return;
  const sheet = e.range.getSheet();
  if (sheet.getName() !== SHEETS.MATCH) return;
  if (e.range.getRow() === 1) return; // header

  // Recalcule + valide la ligne éditée
  recomputeMatchRow(sheet, e.range.getRow());
}

/**
 * Recalcule l'XP final d'une ligne MatchResults + valide les bornes.
 */
function recomputeMatchRow(sheet, row) {
  const vals = sheet.getRange(row, 1, 1, MATCH_COL.XP_FINAL).getValues()[0];
  const discord = vals[MATCH_COL.DISCORD - 1];
  if (!discord) return; // ligne vide

  const components = {
    minutes:    Number(vals[MATCH_COL.MINUTES - 1])    || 0,
    victory:    Number(vals[MATCH_COL.VICTORY - 1])    || 0,
    objectives: Number(vals[MATCH_COL.OBJECTIVES - 1]) || 0,
    discipline: Number(vals[MATCH_COL.DISCIPLINE - 1]) || 0,
    penalties:  Number(vals[MATCH_COL.PENALTIES - 1])  || 0,
    isFirstOp:  isPlayerFirstOp_(discord),
  };

  const computed = computeSessionXp(components);
  const xpCell = sheet.getRange(row, MATCH_COL.XP_FINAL);
  const manual = Number(vals[MATCH_COL.XP_FINAL - 1]);

  // Si le SL a saisi une valeur manuelle qui diffère du calcul → violation potentielle
  if (manual && manual !== computed) {
    handleViolation(xpCell, computed, manual,
      "XP manuel (" + manual + ") != calcul (" + computed + ")");
  } else {
    xpCell.setValue(computed);
    xpCell.setBackground(null);
  }
}

/**
 * Applique la stratégie de violation choisie (VIOLATION_STRATEGY).
 */
function handleViolation(cell, computed, manual, reason) {
  switch (VIOLATION_STRATEGY) {
    case "REJECT":
      cell.setValue(computed);
      cell.setNote("Valeur manuelle rejetée. Recalcul: " + computed + "\n" + reason);
      cell.setBackground("#fff2cc"); // jaune léger
      break;
    case "CLAMP":
      const clamped = Math.max(XP_POLICY.MIN_XP_PER_SESSION,
                               Math.min(manual, XP_POLICY.MAX_XP_PER_SESSION));
      cell.setValue(clamped);
      cell.setNote("Plafonné à " + clamped + " (saisi: " + manual + ")\n" + reason);
      cell.setBackground("#fce5cd"); // orange léger
      break;
    case "FLAG":
    default:
      cell.setNote("VIOLATION — revue manuelle requise.\n" + reason +
                   "\nValeur calculée attendue: " + computed);
      cell.setBackground("#f4cccc"); // rouge léger
      break;
  }
}

// ============================================================
// 8. RECALCUL GLOBAL (menu)
// ============================================================
function recalcMatchResults() {
  const sheet = ss_().getSheetByName(SHEETS.MATCH);
  const last = sheet.getLastRow();
  for (let r = 2; r <= last; r++) {
    recomputeMatchRow(sheet, r);
  }
  toast_("MatchResults recalculé (" + (last - 1) + " lignes)");
}

/**
 * Recalcule Roster : XP cumulée (somme MatchResults) + Level + Tier.
 * NE TOUCHE PAS au grade (col E) — manuel.
 */
function recalcRoster() {
  const roster = ss_().getSheetByName(SHEETS.ROSTER);
  const match  = ss_().getSheetByName(SHEETS.MATCH);

  // 1. Agrège l'XP par joueur depuis MatchResults
  const xpByPlayer = {};
  const lastOpByPlayer = {};
  const mLast = match.getLastRow();
  if (mLast >= 2) {
    const mData = match.getRange(2, 1, mLast - 1, MATCH_COL.XP_FINAL).getValues();
    for (const row of mData) {
      const discord = row[MATCH_COL.DISCORD - 1];
      const xp = Number(row[MATCH_COL.XP_FINAL - 1]) || 0;
      const opId = row[MATCH_COL.OP_ID - 1];
      if (!discord) continue;
      xpByPlayer[discord] = (xpByPlayer[discord] || 0) + xp;
      if (opId) lastOpByPlayer[discord] = opId;
    }
  }

  // 2. Écrit XP_TOTAL + LEVEL + TIER + LAST_OP dans Roster (jamais le grade)
  const rLast = roster.getLastRow();
  for (let r = 2; r <= rLast; r++) {
    const discord = roster.getRange(r, ROSTER_COL.DISCORD).getValue();
    if (!discord) continue;
    const xpTotal = xpByPlayer[discord] || 0;
    const { level, tier } = levelFromXp(xpTotal);
    roster.getRange(r, ROSTER_COL.XP_TOTAL).setValue(xpTotal);
    roster.getRange(r, ROSTER_COL.LEVEL).setValue(level);
    roster.getRange(r, ROSTER_COL.TIER).setValue(tier);
    if (lastOpByPlayer[discord]) {
      roster.getRange(r, ROSTER_COL.LAST_OP).setValue(lastOpByPlayer[discord]);
    }
  }
  toast_("Roster recalculé (" + (rLast - 1) + " joueurs)");
}

// ============================================================
// 9. AUDIT : verrou des Ops > 48h
// ============================================================
function lockOldOperations() {
  const ops = ss_().getSheetByName(SHEETS.OPERATIONS);
  const last = ops.getLastRow();
  const now = new Date();
  let locked = 0;
  for (let r = 2; r <= last; r++) {
    const dateVal = ops.getRange(r, OP_COL.DATE).getValue();
    if (!(dateVal instanceof Date)) continue;
    const ageHours = (now - dateVal) / (1000 * 60 * 60);
    if (ageHours > XP_POLICY.LEDGER_LOCK_AFTER_HOURS) {
      const range = ops.getRange(r, 1, 1, OP_COL.REPORT);
      const protection = range.protect()
        .setDescription("Op verrouillée (>48h) — audit immuable");
      protection.removeEditors(protection.getEditors());
      locked++;
    }
  }
  toast_(locked + " Op(s) verrouillée(s) (>48h)");
}

function validateAllMatchResults() {
  recalcMatchResults();
  toast_("Validation complète terminée");
}

// ============================================================
// 10. HELPERS
// ============================================================
function ss_() { return SpreadsheetApp.getActiveSpreadsheet(); }
function toast_(msg) { ss_().toast(msg, "HaloRP", 5); }

/**
 * Détecte si c'est la première Op d'un joueur (aucune autre ligne MatchResults).
 */
function isPlayerFirstOp_(discord) {
  const match = ss_().getSheetByName(SHEETS.MATCH);
  const last = match.getLastRow();
  if (last < 2) return true;
  const col = match.getRange(2, MATCH_COL.DISCORD, last - 1, 1).getValues();
  let count = 0;
  for (const row of col) {
    if (row[0] === discord) count++;
  }
  return count <= 1; // <=1 car la ligne courante compte déjà
}

// ============================================================
// 11. OPTIONNEL : webhook Discord sur level-up (Sprint 2)
// ============================================================
/**
 * À appeler depuis recalcRoster si tu veux notifier les level-ups.
 * Nécessite un webhook Discord (Server Settings > Integrations > Webhooks).
 * NON câblé par défaut (évite spam au premier recalc massif).
 */
function notifyLevelUp_(discord, oldLevel, newLevel) {
  const WEBHOOK_URL = ""; // TODO: colle ton webhook Discord ici
  if (!WEBHOOK_URL) return;
  const payload = {
    content: "📈 **" + discord + "** passe niveau **" + oldLevel + " → " + newLevel + "** !",
  };
  UrlFetchApp.fetch(WEBHOOK_URL, {
    method: "post",
    contentType: "application/json",
    payload: JSON.stringify(payload),
    muteHttpExceptions: true,
  });
}
