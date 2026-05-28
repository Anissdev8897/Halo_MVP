# Design Map Forge — FOB Alpha

Spécification complète pour la construction de **FOB Alpha** sur **Forge World** (Halo Reach MCC).

> Document de référence pour le mapper. Suivre cette spec pour produire `fob_alpha.mvar` cohérent avec la variante Sentinel-Defense v1.

---

## Métadonnées

| Champ | Valeur |
|---|---|
| Nom in-game | FOB Alpha |
| Canvas | Forge World — Hemorrhage canyon (centre de Forge World) |
| Effectif | 16 (12 UNSC + 4 Covenant) |
| Op compatible | Sentinel (priorité MVP), Skirmish 8v8 (variante future) |
| Variante associée | Sentinel-Defense v1 |
| Budget Forge cible | < 90 % |

---

## Plan général (vue de dessus)

```
                          ╭────────────────────╮
                          │   COVENANT SPAWN   │  ← canyon nord (haut)
                          │   (label spawn_atk)│
                          ╰──────────┬─────────╯
                                     │
                            INFILTRATION ROUTES
                            ─────────────────
                          ╱             │             ╲
                ╔═════════╪═════════════╪═════════════╪═════╗
                ║ SNIPER  │  APPROACH   │   APPROACH  │ FLANK
                ║ RIDGE W │   CENTER    │     EAST    │  E
                ║ (sniper)│             │ (vehicle    │
                ║         │             │   road)     │
                ╚═════════╪═════════════╪═════════════╪═════╝
                          │             │             │
                          ▼             ▼             ▼
            ┌───────────────────── FOB ALPHA ─────────────────────┐
            │  ┌───────────[WALL N]──────────[WALL N]────────┐    │
            │  │                                              │    │
            │  │  GENERATOR                                   │    │
            │  │   HUT W       COMMAND BUNKER                 │    │
            │  │ (objectif    ┌──────────────┐                │    │
            │  │  saboterie)  │  ★ FLAG      │                │    │
            │  │              │  (terminal)  │                │    │
            │  │              └──────────────┘                │    │
            │  │                                              │    │
            │  │  WARTHOG BAY            UNSC SPAWN INTERNAL  │    │
            │  │  (1 Warthog)            (label spawn_def)   │    │
            │  └───[WALL S]──────[ENTRÉE SO][ENTRÉE E]─[WALL S]    │
            │                                              │
            │       ┌──────────[UNSC FALLBACK SPAWN]───────┘
            │       │
            │       ▼
            │   [EXTRACT POINT ECHO]   ← objectif Covenant
            │   (label obj_extract)
            │
            └─────────────────────────────────────────────────────┘
```

---

## Zones détaillées

### Zone 1 — FOB ALPHA (périmètre fortifié UNSC)

**Position** : centre du canyon Hemorrhage, sur la zone plate naturelle
**Dimensions** : ~50 m × 35 m
**Forme** : rectangle avec angles renforcés

#### Contenu

| Élément | Quantité | Note |
|---|---|---|
| Murs hauts (Wall, Large) | 12 | Périmètre + entrées |
| Tours d'observation | 2 | Angles nord-est et nord-ouest |
| Sacs de sable (Sandbag) | 20–25 | Couverture, ambiance |
| Drapeaux UNSC déco | 4 | Coins du périmètre |
| Lampadaires | 4 | Éclairage |
| Portes / entrées | 2 | SO (sud-ouest) et E (est) |

#### Sous-zones

##### 1a. Command Bunker (centre du FOB)
- **Bâtiment fermé** : 4 murs, 2 entrées (nord et sud)
- **Au centre** : Flag stand (label `obj_flag`) — c'est le terminal de comms
- **À côté** : 2 ammo crates, 1 health pack
- **Toit** : ouverture pour grenades (RP : "lucarne d'aération")

##### 1b. Warthog Bay (intérieur sud du FOB)
- **Sol marqué** : Warthog spawn
- **Ouverture sud** : permet de sortir vers le sud / Vehicle Road
- **À proximité** : 1 Mongoose (utilité tactique limitée mais présent)

##### 1c. UNSC Spawn intérieur
- **Position** : zone sud-est du FOB, derrière Wall S
- **8 spawn points** label `spawn_def` répartis
- **1 weapon rack** : 2 BR, 2 DMR
- **Position protégée** des angles d'attaque directs

##### 1d. Generator Hut (objectif sabotage Covenant)
- **Petite cabane** détachée du FOB principal, 8 m à l'ouest du Wall O
- **Contient** : 1 caisse explosive (label `obj_sabo`) destructible
- **Visible** depuis Sniper Ridge → choix RP : la fortifier ou la laisser exposée

---

### Zone 2 — APPROACH ROUTES (côté Covenant)

**Position** : nord du canyon, axe d'attaque Covenant

#### 2a. Sniper Ridge ouest
- **Crête naturelle** ouest du canyon (utiliser le terrain Forge World)
- **1 spawn Sniper Rifle** (timer 90s, label `weapon_sniper`)
- **Couverts placés** : 4–5 blocs pour permettre du back-and-forth tactique
- **Accessible aux deux factions** mais avec un trajet d'environ 25s depuis chaque spawn

#### 2b. Approach Center
- **Zone dégagée**, large, dangereuse à traverser
- **2 caches Forge** (sandbags, blocs) pour éviter le 100% open
- **Pas de cover total** — favorise les phases de tir

#### 2c. Vehicle Road est
- **Route plate**, large, peut accueillir véhicules
- **1 Mongoose** UNSC respawn 60s (sortie du FOB côté est)
- **1 Ghost Covenant** capturable, respawn 90s (déposé en route, hors-spawn Covenant immédiat)

#### 2d. Flank East
- **Petit chemin** plus rocheux/accidenté
- **Permet une approche silencieuse** à pied
- **Active Camo viable** ici pour Spec Ops Covenant

---

### Zone 3 — COVENANT SPAWN (nord canyon)

**Position** : extrémité nord du canyon Hemorrhage, sur le plateau élevé
**Dimensions** : ~15 m × 10 m

#### Contenu

| Élément | Quantité | Note |
|---|---|---|
| Spawn points | 4 | label `spawn_atk` |
| Weapon rack Covenant | 1 | 2 Plasma Repeaters, 1 Needle Rifle, 1 Concussion Rifle |
| Plasma Launcher spawn | 1 | timer 120s |
| Plasma Grenade spawn | 4 | timer 30s chacune |
| Vue dégagée vers FOB | — | distance ~150 m (vue tactique mais hors portée AR) |

---

### Zone 4 — EXTRACT POINT ECHO (objectif Covenant)

**Position** : sud-ouest du FOB, à 80 m du périmètre, sur une zone basse
**Dimensions** : ~10 m × 10 m

#### Contenu

| Élément | Quantité | Note |
|---|---|---|
| Hill marker | 1 | label `obj_extract` — c'est la zone de capture du flag |
| Marqueurs visuels | 4 | Drapeaux ou objets indicateurs (l'objectif doit être lisible) |
| Aucun spawn | — | Zone neutre |

---

## Spawn points complets

### UNSC primaires (8)
| Label | Position | Note |
|---|---|---|
| `spawn_def_1` | UNSC Spawn intérieur, angle SE | défense Wall S |
| `spawn_def_2` | UNSC Spawn intérieur, angle SW | défense Wall S |
| `spawn_def_3` | UNSC Spawn intérieur, centre | flexible |
| `spawn_def_4` | UNSC Spawn intérieur, près Warthog Bay | mobilité véhicule |
| `spawn_def_5` | Tour observation NE | défense Wall N |
| `spawn_def_6` | Tour observation NW | défense Wall N |
| `spawn_def_7` | Près Command Bunker (entrée nord) | défense flag |
| `spawn_def_8` | Près Command Bunker (entrée sud) | défense flag |

### UNSC fallback (4)
| Label | Position | Activation |
|---|---|---|
| `spawn_def_fb_1-4` | Sud du FOB, près Extract Point | si zone primaire "hot" (variante Megalo, à terme — pour l'instant fallback manuel via settings) |

### Covenant (4)
| Label | Position | Note |
|---|---|---|
| `spawn_atk_1-4` | Plateau nord du canyon, espacés de 4-5 m | tous orientés vers le sud (vers le FOB) |

---

## Armes & équipement

| Arme | Position | Faction (par défaut) | Respawn | Label |
|---|---|---|---|---|
| Sniper Rifle | Sniper Ridge ouest | neutre (premier arrivé) | 90s | `weapon_sniper` |
| Shotgun | Command Bunker | UNSC (intérieur fortifié) | 60s | `weapon_shotgun` |
| Rocket Launcher | Covenant Spawn rack | Covenant | 120s | `weapon_rocket` |
| Plasma Launcher | Covenant Spawn rack | Covenant | 120s | `weapon_plasma_launcher` |
| Plasma Grenades x2 | Approach West/East | neutre | 30s chacune | `grenade_plasma_*` |
| Frag Grenades x2 | Approach Center | neutre | 30s chacune | `grenade_frag_*` |
| Health pack | Command Bunker | UNSC | 45s | `health_pack_1` |

---

## Véhicules

| Véhicule | Position | Faction | Quantité | Respawn |
|---|---|---|---|---|
| Warthog (chaingun) | Warthog Bay (intérieur FOB) | UNSC | 1 | aucun (perdu = perdu) |
| Mongoose | Sortie est du FOB | UNSC | 1 | 60s |
| Ghost | Vehicle Road (Covenant capturable) | Covenant | 1 | 90s |

---

## Procédure de build (étape par étape)

### J1 — Préparation (1h)
- Charger Forge World en mode Forge
- Aller au centre de la map (zone Hemorrhage)
- **Supprimer toute la map existante** (sélectionner tout, supprimer) pour partir vierge

### J2 — FOB primaire (3–4h)
- Construire les 4 murs du périmètre
- Placer les 2 entrées (SO + E)
- Construire le Command Bunker au centre
- Construire le Warthog Bay
- Placer les 2 tours d'observation
- Décoration : sacs de sable, lampadaires, drapeaux

### J3 — Spawns + zones secondaires (2h)
- Placer les 8 + 4 spawn points UNSC avec labels
- Placer les 4 spawn points Covenant
- Construire le Sniper Ridge (utiliser terrain naturel + couverts)
- Marquer Extract Point Echo (hill marker + visuels)
- Construire Generator Hut (cabane + caisse explosive label)

### J4 — Armes + véhicules + tests (2h)
- Placer toutes les armes avec timers
- Placer les véhicules
- Tester chargement en customs
- **Test Slayer 4v4** pour valider sightlines et spawns

### J5 — Itération (variable)
- Selon retours du test : ajuster spawns trop exposés, ajouter/retirer couverts, équilibrer Sniper Ridge

### J6 — Sauvegarde & publication
- Sauvegarde finale avec nom `fob_alpha.mvar`
- Export et inclusion dans le Game Pack v0.1

---

## Critères d'acceptance

La map est **livrable** quand :
- [ ] Toutes les zones décrites présentes
- [ ] Tous les labels Forge appliqués correctement
- [ ] Budget Forge < 90 %
- [ ] Test Slayer 8v8 sur Forge World ne révèle pas de spot abusif (camp invisible, exploit hors-map)
- [ ] FPS stable >60 fps en partie 16 joueurs
- [ ] Le Sniper Ridge a un contrebalancement (couvert opposé, autre angle)
- [ ] Les spawns UNSC ne sont pas vus depuis Covenant Spawn
- [ ] Les spawns Covenant ne sont pas vus depuis le FOB intérieur

---

## Versions futures

### v0.1.1 (post-test)
- Ajustements spawns selon retours
- Possibles couverts ajoutés/retirés sur Approach Center

### v0.2 (Sprint 3)
- Variante "FOB Alpha — Night" (paramètres Custom Game pour ambiance nuit)
- Variante "FOB Alpha — Hardcore" (avec moins d'armes au sol, traits plus durs)

---

## Voir aussi

- [../../variants/sentinel_defense_v1/spec.md](../../variants/sentinel_defense_v1/spec.md)
- [../../gamepacks/halo_reach_mvp_v0.1/manifest.md](../../gamepacks/halo_reach_mvp_v0.1/manifest.md)
- [../../documentation/07_test_checklist.md](../../documentation/07_test_checklist.md)
