# Structure Discord

Plan complet du serveur Discord communautaire. À reproduire à l'identique pour l'instance MVP.

---

## Rôles (top → bottom)

| # | Rôle | Couleur | Permissions clés |
|---|---|---|---|
| 1 | `🛡 Command Staff` | rouge foncé `#8B0000` | admin total |
| 2 | `⚙ Operations Officer` | rouge `#C8102E` | manage Ops, manage canaux d'Op |
| 3 | `📋 Squad Leader` | orange `#FF8C00` | manage messages dans canaux squad |
| 4 | `🎖 [UNSC] Captain` | bleu vif `#0066FF` | accès UNSC complet |
| 5 | `🎖 [UNSC] Lieutenant` | bleu `#3399FF` | accès UNSC complet |
| 6 | `🎖 [UNSC] Sergeant` | bleu pâle `#66B2FF` | accès UNSC complet |
| 7 | `🎖 [UNSC] Corporal` | gris-bleu `#99CCFF` | accès UNSC standard |
| 8 | `🎖 [UNSC] Private` | gris `#B3CDE0` | accès UNSC standard |
| 9 | `🎖 [UNSC] Recruit` | blanc cassé `#E0E0E0` | accès UNSC limité |
| 10 | `☠ [COV] Field Marshal` | violet foncé `#4B0082` | accès Covenant complet |
| 11 | `☠ [COV] Zealot` | violet `#7B1FA2` | accès Covenant complet |
| 12 | `☠ [COV] Spec Ops Officer` | mauve `#9C27B0` | accès Covenant complet |
| 13 | `☠ [COV] Ultra` | rose-violet `#BA68C8` | accès Covenant standard |
| 14 | `☠ [COV] Major` | rose pâle `#D1A3FF` | accès Covenant standard |
| 15 | `☠ [COV] Minor` | blanc cassé `#E0E0E0` | accès Covenant limité |
| 16 | `🟢 Verified` | vert `#43A047` | accès canaux RP |
| 17 | `🟡 Recruit Pending` | jaune `#FBC02D` | accès canaux d'accueil seulement |
| 18 | `@everyone` | défaut | lecture des canaux d'info uniquement |

---

## Catégories & canaux

### 📢 INFORMATION (lecture, tous)
- `📌 #annonces` — Command Staff post-only
- `📌 #règles-rp` — Command Staff post-only, lien vers [05_rp_rules.md](../documentation/05_rp_rules.md)
- `📌 #lore-univers` — contexte fictionnel
- `📌 #patch-notes` — versions de Game Pack, équilibrages
- `📌 #faq`

### 🚪 ACCUEIL (visible everyone)
- `🚪 #bienvenue` — auto-message de bienvenue + lien candidature
- `📋 #candidatures-rp` — formulaire / submission template
- `🎓 #formation` — texte + vocal pour onboarding (vu par Recruit Pending)
- `🎓 Formation-Vocale` (vocal)

### 💬 COMMUNAUTÉ (Verified+)
- `💬 #général` — off-topic OK
- `🎬 #clips-screenshots` — highlights post-match
- `🛠 #suggestions` — propositions
- `🐛 #bugs-feedback`
- `🎮 #autres-jeux`

### 🔒 COMMAND (Command Staff + Ops Officer)
- `🔒 #strategic-planning`
- `🔒 #moderation-log`
- `🔒 #squad-leaders` (SL+ accès)

### 🪖 FACTION : UNSC (rôle UNSC requis)
- `🪖 #unsc-quartier-général` — IC général
- `📡 #unsc-comms` — chat radio IC, format `[GRADE/CALLSIGN] message`
- `📋 #unsc-briefing-ops`
- `🎯 #unsc-mission-board` — Ops à venir, inscriptions par réaction
- `🏅 #unsc-promotions-log` (lecture)
- `🔊 UNSC-Command-Net` (vocal)
- `🔊 UNSC-Squad-Alpha` (vocal)
- `🔊 UNSC-Squad-Bravo` (vocal)
- `🔊 UNSC-Squad-Charlie` (vocal)
- `🔊 UNSC-Quartier-Détente` (vocal)

### ☠ FACTION : COVENANT (rôle COV requis)
- `☠ #cov-cellule-mère` — IC général
- `📡 #cov-canal-crypté` — équivalent radio
- `📋 #cov-briefing-ops`
- `🎯 #cov-mission-board`
- `🏅 #cov-promotions-log` (lecture)
- `🔊 COV-Council-Net` (vocal — Spec Ops Officer+)
- `🔊 COV-Strike-Team-1` (vocal)
- `🔊 COV-Strike-Team-2` (vocal)
- `🔊 COV-Détente` (vocal)

### 🟢 OPERATIONS LIVE (canaux temporaires)
- `🟢 #op-{nom}-{date}` — créé par bot ou Ops Officer 24h avant chaque Op
- `🔊 OP-Voice-Joint` (vocal mixte interfaction si nécessaire)

---

## Conventions de pseudonymes

Format obligatoire : `[ABRÉV] CallsignNom`

Exemples :
- `[CPT] Cmdr Reed-117` (UNSC Captain)
- `[SGT] Hawk-Reed` (UNSC Sergeant)
- `[RCT] Smith-J` (UNSC Recruit)
- `[FMR] Vor 'Tarosee` (Covenant Field Marshal)
- `[MAJ] Rho 'Tariimee` (Covenant Major)
- `[MIN] Jul 'Volamee` (Covenant Minor)

**Modération** : avertissement → kick après 7 jours non conformes.

---

## Conventions de communication IC

### Messages écrits (canaux radio)
Format : `[GRADE/CALLSIGN] message court, en CAPS si urgent`

Exemples :
- `[CPL HAWK] Mouvement Covenant secteur Echo, demande appui.`
- `[SGT REED] Reçu, je redéploie Bravo. ETA 30s.`
- `[CPT REED-117] CONFIRMEZ POSITION FLAG.`

### Vocaux IC pendant Op
- Brièveté militaire
- Callsigns au lieu de prénoms réels
- Pas de hors-sujet
- Hors-sujet = kick temporaire vers `#général`

---

## Bot Discord (optionnel, MVP+)

Pas requis pour MVP v0.1. Pour v0.2 (Tier 1.5), bot léger :
- Création auto canal `#op-xxx` avant chaque Op
- Kick auto Recruit Pending après 30 jours sans validation
- Sync grade ↔ rôle (lecture Sheet → update Discord, manuel via commande `!syncgrade @user`)
- Annonce auto promotions

---

## Permissions matrix résumé

| Catégorie | @everyone | Recruit Pending | Verified | UNSC any | COV any | SL | Ops Officer | Command Staff |
|---|---|---|---|---|---|---|---|---|
| Information | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Accueil | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Communauté | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| UNSC | ❌ | ❌ | ❌ | ✅ | ❌ | ✅ (si UNSC) | ✅ | ✅ |
| COV | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ (si COV) | ✅ | ✅ |
| Squad Leaders | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ |
| Command | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ |
| Modération-log | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |

---

## Voir aussi

- [grades.md](grades.md)
- [factions.md](factions.md)
- [../documentation/05_rp_rules.md](../documentation/05_rp_rules.md)
