# Persistance — Google Sheet + Apps Script (Mode B)

Schéma de référence de la Google Sheet de persistance HaloRP et de son Apps Script associé ([persistence_gas.js](persistence_gas.js)).

> **Décisions figées 2026-05-28.** Ce document **supersede** la section "Structure Google Sheet" de [xp_system.md](xp_system.md) là où elles divergent (voir § Réconciliation).

---

## ⚠️ Réconciliation de 2 contradictions des docs

Pendant l'implémentation, 2 incohérences entre `xp_system.md`, `leveling.json` et `promotion_rules.json` ont été détectées et tranchées :

| # | Contradiction | Résolution | Autorité |
|---|---|---|---|
| 1 | `xp_system.md` Roster col E = "Grade actuel (**formule auto**)" VS `promotion_rules.json` = "**TOUTES** les promotions sont MANUELLES" | **Grade = MANUEL.** Le GAS n'écrit jamais la colonne Grade. | `promotion_rules.json` (doc détaillée + explicite) |
| 2 | `leveling.json` donne `xp ≈ 200 × level^1.6` mais la formule ne reproduit pas la table (écart 2×) | **On utilise la TABLE explicite**, pas la formule. Niveau = plus haut palier listé ≤ XP. | Table `level_thresholds` de `leveling.json` |

**Conséquence #2** : seuls les **26 paliers listés** sont des breakpoints. Un joueur passe directement de niveau 10 → 12 → 15 (les niveaux 11, 13, 14… ne s'affichent pas). Si tu veux les 50 niveaux pleins, il faut densifier la table dans `leveling.json` ET dans `persistence_gas.js` (constante `LEVEL_THRESHOLDS`).

---

## Architecture en 4 onglets

```
Roster          ← état courant par joueur (XP/level AUTO, grade MANUEL)
Operations      ← log des Ops jouées
MatchResults    ← saisie SL post-Op (composants → XP final AUTO)
PromotionsLog   ← historique des promotions (100% manuel)
```

Le GAS dérive `Roster` depuis `MatchResults`. `Operations` et `PromotionsLog` sont saisis à la main.

---

## Onglet 1 — `Roster` (schéma révisé)

| Col | Champ | Source | Note |
|---|---|---|---|
| A | Discord Tag | manuel | **clé** de jointure avec MatchResults |
| B | Steam/Discord ID | manuel | identité stable |
| C | Faction | manuel | UNSC / Covenant |
| D | Division | manuel | cf. divisions.md |
| **E** | **Grade** | **MANUEL** | ⚠️ jamais touché par le GAS — promotion manuelle uniquement |
| F | XP cumulée | **AUTO** | `recalcRoster` : somme MatchResults.M du joueur |
| G | Level | **AUTO** | `recalcRoster` : `levelFromXp(F)` |
| H | Tier | **AUTO** | Bronze/Silver/Gold/Platinum/Diamond/Onyx |
| I | Dernière Op | **AUTO** | dernier Op ID trouvé |
| J | Statut | manuel | active / inactive / banned |
| K | Notes | manuel | libre |

> **Changement vs xp_system.md** : ajout des colonnes Level (G) et Tier (H). L'ancienne col E "Grade (formule auto)" devient "Grade (MANUEL)". L'ancienne "Score promotion" est retirée du MVP (réintroductible plus tard).

---

## Onglet 2 — `Operations`

Identique à xp_system.md. Saisi par l'Ops Officer avant chaque Op.

| Col | Champ |
|---|---|
| A | Op ID (pattern `OP-YYYY-NNN`) |
| B | Date (format Date réel, pas texte — requis pour le verrou 48h) |
| C | Nom |
| D | Type (sentinel / invasion / firefight / skirmish) |
| E | Map |
| F | Variante |
| G | Host (Discord) |
| H | Effectif UNSC |
| I | Effectif Covenant |
| J | Outcome (UNSC_WIN / COV_WIN / DRAW / FORFEIT) |
| K | Durée (min) |
| L | Lien rapport Discord |

> ⚠️ **Col B doit être un vrai type Date** (pas du texte) sinon `lockOldOperations` ne peut pas calculer l'âge.

---

## Onglet 3 — `MatchResults` (saisie SL → XP auto)

Le SL remplit les colonnes A→L. **La colonne M (XP final) est calculée automatiquement** par le GAS à chaque édition.

| Col | Champ | Saisie | Note |
|---|---|---|---|
| A | Op ID | SL | doit exister dans Operations |
| B | Discord Tag | SL | clé joueur |
| C | Faction | SL | |
| D | Division | SL | |
| E | Rôle assigné | SL | (non compté dans l'XP par défaut — voir computeSessionXp) |
| F | Loadout | SL | |
| G | Minutes présent | SL | → XP présence = min(G×8, 200) |
| H | Victoire (1/0) | SL | → +100 si 1 |
| I | Objectifs (count) | SL | → ×75, plafond 250 |
| J | Discipline (1/0) | SL | → +50 si 1 |
| K | Bonus spéciaux (texte) | SL | descriptif, non auto-compté |
| L | Pénalités | SL | valeur négative (ex: -200 team-kill) |
| **M** | **XP final** | **AUTO** | `computeSessionXp()` clampé [-300 ; 600] |

**Anti-abus en temps réel** : si le SL saisit manuellement une valeur en M qui diffère du calcul, le GAS applique la `VIOLATION_STRATEGY` (par défaut `FLAG` = colore en rouge + note).

---

## Onglet 4 — `PromotionsLog` (100% manuel)

Le GAS n'y touche pas. Trace l'audit des promotions (décidées par les chefs de faction).

| Col | Champ |
|---|---|
| A | Date |
| B | Discord Tag |
| C | Faction |
| D | Ancien grade |
| E | Nouveau grade |
| F | XP au moment |
| G | Validé par (signature obligatoire) |
| H | Notes |

> Règle (héritée de xp_system.md) : **promotion sans col G remplie = annulée**.

---

## Installation du GAS

1. Ouvre ta Google Sheet
2. **Extensions → Apps Script**
3. Supprime le `Code.gs` par défaut, colle tout [persistence_gas.js](persistence_gas.js)
4. **Save** (Ctrl+S)
5. Recharge la Sheet → un menu **"HaloRP"** apparaît dans la barre
6. Premier run d'une fonction → Google demande l'autorisation (accepte les scopes Sheet)

### Triggers
- `onEdit` et `onOpen` sont des **triggers simples** : actifs automatiquement, aucune config.
- `lockOldOperations` (verrou 48h) : à lancer manuellement via le menu, OU créer un **trigger temporel** (Apps Script → Triggers → Add → `lockOldOperations` → Time-driven → daily).

### Permissions Sheet (anti-triche)
- **Partage** : lecture pour tous les membres, **écriture restreinte aux SL + Command Staff**
- **Historique Google Drive** : activé par défaut (rollback possible)
- Le verrou 48h (`lockOldOperations`) ajoute une protection par-ligne sur les Ops anciennes

---

## Fonctions du menu HaloRP

| Item menu | Fonction | Effet |
|---|---|---|
| Recalculer XP + niveaux (Roster) | `recalcRoster` | Somme MatchResults → XP cumulée + Level + Tier (jamais le grade) |
| Recalculer XP final (MatchResults) | `recalcMatchResults` | Re-applique `computeSessionXp` sur toutes les lignes |
| Verrouiller les Ops > 48h | `lockOldOperations` | Protège les lignes Operations anciennes |
| Valider tout le ledger | `validateAllMatchResults` | Recalcul + flag des violations |

---

## 🎯 Ton spot de contribution — la formule XP

Dans [persistence_gas.js](persistence_gas.js), fonction **`computeSessionXp(c)`** (§6).

J'ai implémenté un défaut fonctionnel basé sur tes JSON, mais **l'équilibrage final t'appartient** — c'est ton économie de jeu. Points de décision marqués `TODO` dans le code :

1. **Bonus de rôle** : actuellement le rôle (col E) n'est PAS compté. Tes `xp_rewards_*.json` ont une table `role_bonuses` (Operation Commander +100, SL +75, etc.). Veux-tu l'inclure ? Si oui, il faut une map `ROLE_BONUS` et l'ajouter à la somme.
2. **Poids des objectifs** : actuellement `objectifs × 75`. Trop généreux ? Un Covenant qui sabote + capture cumule 150 vs un Rifleman à 0.
3. **Stratégie de violation** : constante `VIOLATION_STRATEGY` (FLAG / CLAMP / REJECT). Défaut = FLAG (audit-friendly).

C'est ~5-10 lignes à ajuster selon ta vision RP. Dis-moi tes choix et je câble, ou tu édites directement le `.js`.

---

## Voir aussi

- [persistence_gas.js](persistence_gas.js) — le code Apps Script
- [xp_system.md](xp_system.md) — système XP (superseded ici sur le schéma)
- [leveling.json](leveling.json) — table des niveaux (source de `LEVEL_THRESHOLDS`)
- [promotion_rules.json](promotion_rules.json) — grades manuels (autorité)
- [xp_rewards_unsc.json](xp_rewards_unsc.json) / [xp_rewards_covenant.json](xp_rewards_covenant.json) — valeurs XP par action
