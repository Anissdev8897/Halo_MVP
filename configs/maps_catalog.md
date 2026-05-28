# Catalogue des cartes — Halo Reach (MCC)

Liste des maps Reach disponibles dans Custom Games + leur adéquation aux types d'Ops du MVP.

> Toutes ces maps sont **présentes dans l'install MCC légitime du joueur**. On ne les redistribue jamais — on charge des **variantes** de jeu et des **map variants** Forge qui s'appuient dessus.

---

## Maps multijoueur "Arena" (PvP)

| Map | Taille | Ops compatibles | Notes |
|---|---|---|---|
| **Powerhouse** | M | Skirmish, Stronghold | Map symétrique, 2 bases + zone centrale, idéale 8v8 |
| **Reflection** | S | Skirmish | Map intérieure, combat rapproché, 4v4 à 6v6 |
| **Countdown** | M | Skirmish, Stronghold | Multi-niveaux verticaux, complexe |
| **Sword Base** | M | Skirmish, Stronghold | Couloirs et atriums UNSC, RP-friendly visuel |
| **Boardwalk** | M | Skirmish | Map urbaine ouverte, rythme moyen |
| **Zealot** | S | Skirmish | Petite map zéro-G, gimmick Covenant |
| **The Cage** | S | Skirmish | Multi-étages, rapide |
| **Anchor 9** | S | Skirmish | Station orbitale, zones fragmentées |

## Maps "Big Team" / Invasion

| Map | Taille | Ops compatibles | Notes |
|---|---|---|---|
| **Boneyard** | XL | **Invasion** (officiel), Stronghold | Cimetière de vaisseaux, 6v6 Invasion stock — **idéale Op type Invasion** |
| **Spire** | XL | **Invasion** (officiel), Stronghold | Tour Forerunner, asymétrie verticale — **idéale Op type Invasion** |
| **Breakpoint** | XL | **Invasion** (officiel) | Glacier, large terrain dégagé |
| **Highlands** | L | Stronghold, Skirmish 8v8 | Map rurale, véhicules viables |
| **Paradiso** | XL | Stronghold | Forge World preset |
| **Hemorrhage** | XL | **Sentinel** (modifiée), Skirmish, Stronghold | Forge canyon — **base de FOB Alpha** |
| **Asylum** | M | Stronghold, Skirmish | Forge preset (remake Sanctuary) |
| **Pinnacle** | M | Stronghold, Skirmish | Forge preset |

## Maps Firefight (PvE)

| Map | Type | Notes |
|---|---|---|
| **Beachhead** | Plage / falaises | Map de référence Firefight Reach |
| **Corvette** | Vaisseau Covenant | Couloirs, ambiance horror |
| **Courtyard** | Cour intérieure | Compact |
| **Outpost** | Avant-poste UNSC | Idéal RP "patrouille de routine" |
| **Overlook** | Bunker en hauteur | Position défensive |
| **Waterfront** | Quais | Mixte vehicle/infantry |
| **Holdout** | Bunker | Petite, intense |
| **Glacier** | Glace | Ouvertures longues distances |
| **Installation 04** (DLC) | Halo nostalgia | Si DLC installé |
| **Unearthed** (DLC) | Excavation | Si DLC installé |

---

## Forge — Maps de base utilisables comme "canvas"

Pour construire des maps RP custom, on part d'un canvas Forge :

| Canvas | Surface | Recommandé pour | Budget Forge |
|---|---|---|---|
| **Forge World** | énorme (canyon + île + falaise + mer + grotte) | maps grandes, FOBs, bases vastes | très large |
| **Tempest** | moyenne, côtière | maps moyennes, ambiance naturelle | moyen |
| **Ridgeline** | moyenne, montagneuse | bases UNSC isolées | moyen |
| **Anchor 9** (avec Forge limité) | petite, station | maps couloirs sci-fi | petit |
| **Breakpoint** | grande, neige | Ops froides | moyen |

**Recommandation MVP** : Forge World pour FOB Alpha, Tempest pour la 2ème map (Op. Hammer plus tard).

---

## Map principale du MVP

**Halo Reach Custom Game / Forge World — Hemorrhage canyon**, sur lequel on construit **FOB Alpha** (voir [forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)).

Pourquoi ce choix :
- Forge World permet le plus large budget de construction
- La zone "Hemorrhage" est emblématique (remake Blood Gulch) et lisible
- Position naturelle de chokepoints : 2 entrées principales, falaise pour sniper post
- Compatible 16 joueurs sans lag
- Aucune restriction MCC particulière

---

## Considérations techniques

### Limites Forge Reach
- Budget objet limité par map (≈ 9000 unités sur Forge World)
- Maximum ~600 objets placés en pratique
- Pas d'AI placeable en Forge classique
- Labels Forge utilisables : `obj_flag`, `obj_extract`, `vehicle_spawn`, `weapon_spawn`, etc.

### Limites Custom Games Reach
- 16 joueurs max par lobby (sauf Firefight = 4 max)
- 1 seul host (P2P, NAT-dependent)
- Variantes max ~20 ko de configuration

### Maps DLC requises pour certaines Ops
- **Defiant Map Pack** : Highlands, Condemned, Unearthed
- **Noble Map Pack** : Tempest, Anchor 9, Breakpoint
- **Anniversary Map Pack** : Battle Canyon, High Noon, Penance, Ridgeline, Solitary, Breakneck

→ **MVP** = uniquement les maps de base Reach (sans DLC), pour ne pas exclure les joueurs.

---

## Voir aussi

- [operations_types.md](operations_types.md)
- [forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)
- [documentation/06_ai_npc_capabilities.md](../documentation/06_ai_npc_capabilities.md)
