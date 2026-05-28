# Types d'Opérations

5 types d'Ops, chacun exploitant un mode de jeu officiel Halo Reach pour produire un scénario RP différent.

---

## Vue d'ensemble

| Type | Mode Reach | Effectif | Durée | Difficulté MVP |
|---|---|---|---|---|
| **Sentinel** (défense) | One Flag CTF custom | 12 UNSC vs 4 COV | 25 min | 🟢 facile (MVP v0.1) |
| **Invasion** (assaut) | Invasion (officiel) | 6 UNSC vs 6 COV | 15 min ×3 phases | 🟡 moyen (v0.2) |
| **Skirmish** (rencontre) | Slayer Pro custom | 8 UNSC vs 8 COV | 12 min | 🟢 facile |
| **Firefight** (PvE) | Firefight custom | 4 UNSC vs AI Covenant | 20–40 min | 🟢 facile |
| **Stronghold** (capture) | Territories | 8 UNSC vs 8 COV | 15 min | 🟡 moyen |

---

## 1. Op type **Sentinel** — Défense de FOB

### Concept
Une force UNSC tient un FOB clé. Une équipe de Spec Ops Covenant attaque pour voler/saboter.

### Asymétrie
- **12 UNSC défendent** depuis l'intérieur
- **4 Covenant Spec Ops attaquent** avec traits boostés (dégâts +15 %, vitesse +10 %, shield recharge +30 %)
- Les Covenant compensent leur infériorité numérique par mobilité, équipement (Active Camo, Energy Sword) et choix de l'angle d'attaque

### Conditions de victoire
- **UNSC** : tenir 25 min sans perte du flag
- **Covenant** : capture flag + extraction zone Echo

### Variante associée
Voir [variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)

### Map associée
[FOB Alpha](../forge_maps/fob_alpha/design.md) sur Forge World

### Briefing type
Voir [gamepacks/halo_reach_mvp_v0.1/briefings/](../gamepacks/halo_reach_mvp_v0.1/briefings/) (TBD)

---

## 2. Op type **Invasion** — Assaut multi-phases

### Concept
Mode officiel Reach. Trois phases successives, attaquants ouvrent progressivement la map, défenseurs reculent.

### Effectif
**6 UNSC vs 6 Covenant** (officiel, modifiable jusqu'à 8v8 sur certaines maps).

### Phases types (selon variante stock)
1. **Phase 1** : Capture point territoire neutre. Loadouts limités (BR/AR/DMR/Magnum + Plasma Rifle/Needle Rifle/Plasma Pistol).
2. **Phase 2** : Capture point central. Loadouts élargis (Sniper, Shotgun / Energy Sword, Concussion Rifle).
3. **Phase 3** : Récupérer/Extraire le "core" jusqu'à un véhicule. Loadouts complets + véhicules.

### Maps Reach officielles compatibles
- Boneyard
- Spire
- Breakpoint

### Avantage MVP
**Aucune variante custom à fabriquer pour la base** — Invasion existe en stock. On charge la variante stock + on impose nos règles RP par-dessus.

### Inconvénient MVP
Maps de 6v6 fixes. Pas de modifs Forge majeures sur ces maps officielles.

---

## 3. Op type **Skirmish** — Rencontre tactique

### Concept
Affrontement direct symétrique entre patrouilles UNSC et Covenant qui se croisent. Pas d'objectif fixe, le score est tactique.

### Mode
**Slayer Pro** custom (Slayer sans loadouts non-tactiques, traits réalistes).

### Effectif
8 UNSC vs 8 Covenant.

### Conditions de victoire
- 50 kills OU 12 min écoulées
- Bonus XP RP : zéro mort par friendly fire, communication radio sur 80% du match

### Maps Reach compatibles
- Powerhouse
- Reflection
- Countdown
- Sword Base
- Anchor 9
- Forge World (zones Hemorrhage / Asylum)

### Avantage MVP
Très simple à organiser, aucun build Forge custom requis. Idéal pour **première Op publique**.

---

## 4. Op type **Firefight** — Patrouille PvE

### Concept
Toutes les forces sont UNSC, défendent contre des **vagues d'IA Covenant** scriptées par le moteur Reach.

### Mode
**Firefight Limited** custom variant (Firefight officiel modifié).

### Effectif
4 UNSC humains vs AI Covenant (Grunts, Jackals, Élites, Hunters, Brutes).

### Maps Firefight Reach disponibles
- Beachhead
- Corvette
- Courtyard
- Outpost
- Overlook
- Waterfront
- Holdout
- Glacier

### Conditions de victoire
- Tenir N vagues (configurable, MVP : 3 sets × 5 vagues)
- Bonus selon multiplicateur de score Firefight

### Avantage MVP
- **Pas besoin de joueurs Covenant** → utilisable dès qu'on a 4 joueurs UNSC
- Idéal pour **formation des recrues** et entraînement
- Permet du RP "patrouille de routine qui dégénère"

### Inconvénient
- Plafonné à 4 joueurs (limitation Firefight Reach)
- Pas d'asymétrie joueur

### IA & PNJ
Voir [documentation/06_ai_npc_capabilities.md](../documentation/06_ai_npc_capabilities.md) pour les détails de ce qui est possible.

---

## 5. Op type **Stronghold** — Capture de positions

### Concept
3 territoires sur la map, deux factions s'arrachent leur contrôle.

### Mode
**Territories** custom.

### Effectif
8 UNSC vs 8 Covenant.

### Conditions de victoire
- Contrôler 2 territoires sur 3 pendant 10 min cumulées
- OU temps total maximum atteint (15 min) → vainqueur = plus de temps cumulé

### Maps compatibles
Mêmes que Skirmish, plus :
- Asylum (Forge map officielle)
- Hemorrhage (Forge)
- Pinnacle (Forge)

### Avantage MVP
Déclinaison facile de Slayer, scénario RP riche (zones tactiques nommées : "Tour Comm", "Hangar", "Rampe").

---

## Stratégie de déploiement progressif

| Sprint | Op active | Pourquoi |
|---|---|---|
| Sprint 1 (semaines 1–4) | **Sentinel uniquement** | MVP centré sur 1 scénario validé |
| Sprint 2 (semaines 5–8) | + **Skirmish** | 2e Op, aucune build custom requise (maps stock) |
| Sprint 3 (semaines 9–12) | + **Invasion** + **Firefight** | Diversification PvE/PvP |
| Sprint 4 (semaines 13+) | + **Stronghold** + variantes Sentinel custom | Maturité du framework |

---

## Voir aussi

- [maps_catalog.md](maps_catalog.md) — liste des maps Reach disponibles
- [factions.md](factions.md)
- [grades.md](grades.md)
- [variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)
- [forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)
