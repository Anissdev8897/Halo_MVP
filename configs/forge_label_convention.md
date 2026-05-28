# Forge Label Convention — HaloRP MVP

Source de vérité unique pour les labels Forge `game-specific` du projet. Toute mention de label dans une autre doc doit se référer ici — ne duplique pas les noms.

> **Décision figée le 2026-05-28.** Tout renommage post-figeage impose une migration explicite (cf. section *Migration* ci-bas) car les scripts Megalo v2 référencent les labels par hash de chaîne — un rename tardif = re-test exhaustif.

---

## Règles générales

| Règle | Valeur | Pourquoi |
|---|---|---|
| Format | `<category>_<role>[_<index>]` | Tri visuel + sélection bulk via regex |
| Casse | `snake_case` strict | Le moteur Reach est **case-sensitive** sur les labels |
| Longueur max | **16 caractères** | Limite observée des labels Forge Reach (retours communautaires) |
| Indexation | 1-based, suffixe numérique | `spawn_def_1`, `spawn_def_2`, …, `spawn_def_8` |
| Stabilité | Un label, une fois lock = pas de rename hors migration formelle | Évite désync v1 settings ↔ v2 Megalo |

## Catégories

| Préfixe | Usage | Exemples MVP |
|---|---|---|
| `spawn_*` | Spawn points joueurs | `spawn_def`, `spawn_atk`, `spawn_def_fb` |
| `obj_*` | Objectifs game-specific | `obj_flag`, `obj_extract`, `obj_sabo` |
| `weapon_*` | Spawn arme on-map | `weapon_sniper`, `weapon_shotgun`, `weapon_rocket` |
| `grenade_*` | Spawn grenade on-map | `grenade_frag_1`, `grenade_plasma_1` |
| `vehicle_*` | Spawn véhicule | `vehicle_warthog`, `vehicle_ghost` |
| `health_*` | Equipement médical / soin | `health_pack_1` |

---

## Table de mapping MVP — game-specific (One Flag CTF)

| Rôle fonctionnel | Label | Forge object | Position FOB Alpha | Quantité | Affiliation team |
|---|---|---|---|---|---|
| Spawn défenseur primaire | `spawn_def` (puis `spawn_def_1`..`spawn_def_8`) | Initial / Respawn Point | Sud-est intérieur FOB | 8 | Defender |
| Spawn défenseur fallback | `spawn_def_fb` (puis `spawn_def_fb_1`..`spawn_def_fb_4`) | Respawn Point (multi-team on) | Sud extérieur FOB | 4 | Defender |
| Spawn attaquant | `spawn_atk` (puis `spawn_atk_1`..`spawn_atk_4`) | Initial / Respawn Point | Plateau nord canyon | 4 | Attacker |
| Drapeau (objectif principal) | `obj_flag` | CTF Flag Stand | Centre Command Bunker | 1 | Defender |
| Zone de capture | `obj_extract` | CTF Capture Plate | Echo Point sud-ouest FOB | 1 | Attacker |
| Objectif sabotage secondaire | `obj_sabo` | Crate, Explosive | Generator Hut ouest | 1 | n/a (neutre) |

---

## Table de mapping MVP — armes & équipement

| Rôle | Label | Forge object | Position | Respawn |
|---|---|---|---|---|
| Sniper Rifle | `weapon_sniper` | Weapon | Sniper Ridge ouest | 90s |
| Shotgun | `weapon_shotgun` | Weapon | Command Bunker | 60s |
| Rocket Launcher | `weapon_rocket` | Weapon | Covenant Spawn rack | 120s |
| Plasma Launcher | `weapon_plsm_lnch` | Weapon | Covenant Spawn rack | 120s |
| Frag Grenades | `grenade_frag_1`, `grenade_frag_2` | Equipment | Approach Center | 30s |
| Plasma Grenades | `grenade_plasma_1`, `grenade_plasma_2` | Equipment | Approach W / E | 30s |
| Health Pack | `health_pack_1` | Equipment | Command Bunker | 45s |

> ⚠️ **Note** : `weapon_plasma_launcher` (utilisé dans `forge_maps/fob_alpha/design.md`) dépasse les 16 chars (22). À renommer en `weapon_plsm_lnch` au moment du build Forge — pas patché dans cette migration car hors scope validé du `2026-05-28`.

---

## Table de mapping MVP — véhicules

| Rôle | Label | Forge object | Position | Respawn |
|---|---|---|---|---|
| Warthog (UNSC) | `vehicle_warthog` | Warthog chaingun | Warthog Bay intérieur FOB | jamais |
| Mongoose (UNSC) | `vehicle_mongoose` | Mongoose | Sortie est FOB | 60s |
| Ghost (Covenant) | `vehicle_ghost` | Ghost | Vehicle Road | 90s |

---

## Migration v0.0 → v0.1 (effectuée 2026-05-28)

Mapping appliqué à toutes les docs existantes :

| Ancien label (pré-convention) | Nouveau label | Fichiers patchés |
|---|---|---|
| `unsc_spawn` (et `unsc_spawn_1` à `_8`) | `spawn_def` (et `spawn_def_1` à `_8`) | `forge_maps/fob_alpha/design.md`, `variants/sentinel_defense_v1/spec.md`, `documentation/07_test_checklist.md` |
| `unsc_fallback` (et `_1-4`) | `spawn_def_fb` (et `_1-4`) | idem |
| `cov_spawn` (et `_1-4`) | `spawn_atk` (et `_1-4`) | idem |
| `flag_spawn` | `obj_flag` | `forge_maps/fob_alpha/design.md`, `variants/sentinel_defense_v1/spec.md`, `documentation/06_ai_npc_capabilities.md`, `configs/maps_catalog.md` |
| `extract_zone` | `obj_extract` | `forge_maps/fob_alpha/design.md`, `variants/sentinel_defense_v1/spec.md` |
| `cap_zone` (alias historique de `extract_zone`) | `obj_extract` | `documentation/06_ai_npc_capabilities.md`, `configs/maps_catalog.md` |
| `obj_sabotage` | `obj_sabo` | `forge_maps/fob_alpha/build_guide.md`, `forge_maps/fob_alpha/design.md` |

---

## Justification du choix rôle-préfixé (vs faction-préfixé)

Décision validée le 2026-05-28 :

1. **Réutilisabilité maps** : `spawn_def` permet de réutiliser FOB Alpha pour une variante "Reverse Sentinel" où Covenant défend. Un script Megalo v2 référence le rôle (`def` / `atk`), pas la faction (`unsc` / `cov`) — donc la même map sert sans modification de labels.
2. **Préfixe catégorique** : tri visuel dans Forge label browser + sélection bulk via regex `^spawn_*` dans outillage futur.
3. **Limite 16 chars** : marge confortable pour suffixe numérique (`spawn_def_fb_4` = 14 chars).
4. **Stabilité v1 → v2** : Megalo référence labels par hash de chaîne. Renommage tardif post-écriture script v2 = re-test complet et risque de breakage silencieux.

---

## Procédure de validation Forge (à exécuter pendant le build)

Après chaque placement d'objet game-specific :

1. **Sélectionner l'objet** (Monitor mode + A)
2. **Edit → Game-Specific Edit**
3. Onglet **Label** → saisir manuellement la chaîne EXACTE de cette table
4. **Team Affiliation** → selon la colonne "Affiliation team" ci-dessus
5. Vérifier dans Forge label browser que le label apparaît bien (preuve qu'il a été enregistré)

> ⚠️ Le moteur **n'avertit PAS** si un label est tronqué (>16 chars) ou non-reconnu — il fallback silencieusement sur le comportement par défaut. Toute discordance avec cette table = bug runtime invisible au build mais visible au playtest.

---

## Voir aussi

- [../forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)
- [../forge_maps/fob_alpha/build_guide.md](../forge_maps/fob_alpha/build_guide.md)
- [../variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)
- [../documentation/07_test_checklist.md](../documentation/07_test_checklist.md)
- [maps_catalog.md](maps_catalog.md)
