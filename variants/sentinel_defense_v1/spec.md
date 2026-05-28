# Spec Variante — Sentinel-Defense v1

Spécification complète pour la création de la variante Custom Game **Sentinel-Defense v1** dans Halo Reach (MCC).

> Document de référence pour le designer. Configurer la variante dans le menu Custom Games en suivant exactement les valeurs ci-dessous, puis sauvegarder comme `sentinel_defense_v1.bin`.

---

## Métadonnées

| Champ | Valeur |
|---|---|
| Nom in-game | Sentinel-Defense |
| Version | v1.0 |
| Base game type | **One Flag CTF** |
| Effectif | 16 (12 UNSC + 4 Covenant) |
| Map associée | FOB Alpha |
| Op compatible | Sentinel |
| Méthode | Settings tweak via Custom Games menu (PAS de Megalo custom — réservé v2) |

---

## Stratégie de design

**Pour le MVP, on n'écrit PAS de Megalo custom.** Le moteur Reach permet de modifier finement les paramètres d'une variante stock via le menu Custom Games. C'est suffisant pour Sentinel.

Une variante Megalo custom (multi-objectifs, HUD custom, lives limitées) sera développée comme **Sentinel-Defense v2** au Sprint 3 (semaines 9–12). Cette spec couvre **uniquement la v1**.

---

## Configuration globale

| Paramètre | Valeur |
|---|---|
| Base | One Flag CTF |
| Round time | 25 minutes |
| Score limit | 1 capture |
| Number of rounds | 1 |
| Sudden death | Off |
| Friendly fire | OFF |
| Betrayal booting | manuel (pas auto) |
| Kill cam | Off |
| Spawning | Standard (Forge labels respectés) |

---

## Teams

### Team Defender = UNSC
| Paramètre | Valeur |
|---|---|
| Couleur | Bleu primaire |
| Espèce | Spartan-III |
| Effectif | 12 |
| Spawn label | `spawn_def` (puis `spawn_def_fb` si "hot") |

### Team Attacker = Covenant
| Paramètre | Valeur |
|---|---|
| Couleur | Rouge primaire (ou Violet si dispo) |
| Espèce | **Élite** (Sangheili) — option officielle Reach |
| Effectif | 4 |
| Spawn label | `spawn_atk` |

---

## Round Settings

| Paramètre | Valeur |
|---|---|
| Round time limit | 25:00 |
| Number of rounds | 1 |
| Lives per round | ∞ (infini) |
| Suicide penalty | 2s |
| Betrayal penalty | 5s |
| Respawn time UNSC | 8s |
| Respawn time Covenant | 12s |
| Respawn traits duration | 10s (boost initial après respawn) |
| Respawn traits | shield recharge boost x2 |
| Hill respawn time | n/a |

---

## Player Traits — Defender (UNSC)

| Catégorie | Trait | Valeur |
|---|---|---|
| **Shields/Health** | Damage Resistance | 110% |
| | Shield recharge rate | 100% |
| | Health recharge rate | 100% |
| | Vampirism | Off |
| **Weapons** | Damage modifier | 100% |
| | Melee damage modifier | 100% |
| | Grenade count | 2 frag (par loadout) |
| | Infinite ammo | Off |
| **Movement** | Player speed | 100% |
| | Player gravity | 100% |
| | Jump height | 100% |
| **Sensors** | Motion tracker mode | Normal |
| | Motion tracker range | 25m |
| **Appearance** | Forced color | Bleu primaire |

---

## Player Traits — Attacker (Covenant)

| Catégorie | Trait | Valeur |
|---|---|---|
| **Shields/Health** | Damage Resistance | 90% |
| | Shield recharge rate | 130% |
| | Health recharge rate | 100% |
| | Vampirism | Off |
| **Weapons** | Damage modifier | 115% |
| | Melee damage modifier | 100% |
| | Grenade count | 2 plasma (par loadout) |
| | Infinite ammo | Off |
| **Movement** | Player speed | 110% |
| | Player gravity | 100% |
| | Jump height | 110% |
| **Sensors** | Motion tracker mode | Normal |
| | Motion tracker range | 18m |
| **Appearance** | Forced color | Rouge primaire (ou Violet) |

---

## Loadouts

### Tier 1 — Loadouts UNSC (Defender)

#### UNSC-Rifleman (default, accessible Recruit+)
| Slot | Item |
|---|---|
| Primary | Assault Rifle |
| Secondary | Magnum |
| Grenades | Frag Grenade x2 |
| Armor Ability | Sprint |

#### UNSC-Marksman (Private+)
| Slot | Item |
|---|---|
| Primary | DMR |
| Secondary | Magnum |
| Grenades | Frag Grenade x1 |
| Armor Ability | Sprint |

#### UNSC-Spec (Corporal+)
| Slot | Item |
|---|---|
| Primary | Battle Rifle (BR) |
| Secondary | SMG |
| Grenades | Frag Grenade x2 |
| Armor Ability | Evade |

#### UNSC-Heavy (Sergeant+)
| Slot | Item |
|---|---|
| Primary | Shotgun |
| Secondary | Magnum |
| Grenades | Frag Grenade x2 |
| Armor Ability | Armor Lock |

> Note : la sélection du loadout est faite **manuellement par le joueur** au spawn (menu loadout Reach standard). Le SL contrôle le choix via attribution de rôle au briefing.

### Tier 2 — Loadouts Covenant (Attacker)

#### COV-Militia (Minor+, equivalent rifleman)
| Slot | Item |
|---|---|
| Primary | Plasma Repeater |
| Secondary | Plasma Pistol |
| Grenades | Plasma Grenade x2 |
| Armor Ability | Sprint |

#### COV-Saboteur (Major+, infiltration)
| Slot | Item |
|---|---|
| Primary | Plasma Repeater |
| Secondary | Plasma Pistol |
| Grenades | Plasma Grenade x2 |
| Armor Ability | Active Camo |

#### COV-Designated (Spec Ops Officer)
| Slot | Item |
|---|---|
| Primary | Focus Rifle |
| Secondary | Plasma Pistol |
| Grenades | Plasma Grenade x1 |
| Armor Ability | Active Camo |

#### COV-Heavy (Spec Ops Officer)
| Slot | Item |
|---|---|
| Primary | Concussion Rifle |
| Secondary | Plasma Pistol |
| Grenades | Plasma Grenade x2 |
| Armor Ability | Hologram |

---

## Vehicle Settings

| Paramètre | Valeur |
|---|---|
| Vehicle damage modifier | 100% |
| Driver-only vehicle | Mongoose autorisé pour tous |
| Warthog driver lock | Corporal+ uniquement (RP, pas mécanique) |
| Banshee | absent dans Sentinel v1 |
| Wraith | absent |

---

## Weapon On-Map Settings

| Arme | Spawn timer | Custom |
|---|---|---|
| Sniper Rifle (Sniper Ridge) | 90s | 1 chargeur extra |
| Shotgun (Command Bunker) | 60s | standard |
| Rocket Launcher (Covenant Spawn) | 120s | 1 roquette |
| Plasma Launcher (Covenant Spawn) | 120s | standard |
| Frag Grenades (Approach Center) | 30s | x2 |
| Plasma Grenades (Approach West/East) | 30s | x2 |
| Health Pack (Command Bunker) | 45s | standard |

---

## Flag Settings

| Paramètre | Valeur |
|---|---|
| Flag location | label `obj_flag` (Command Bunker) |
| Flag return time | 30s |
| Flag at home requirement | Yes (capture impossible si flag pas chez Defender — n/a ici, Defender n'a qu'un flag) |
| Flag carrier traits | Speed -10%, no jumping ability boost |
| Capture zone | label `obj_extract` (Echo Point) |
| Capture time | instantané dès entrée en zone |

---

## Conditions de victoire

| Condition | Issue |
|---|---|
| Drapeau capturé en zone Echo avant T+25 | **Covenant gagne** |
| Timer atteint 0 sans capture | **UNSC gagne** |
| Tous Covenant déco / quittent | **UNSC gagne (forfait)** |
| Tous UNSC déco / quittent | **Covenant gagne (forfait)** |

---

## Procédure de configuration

### J1 — Setup variante (1h)
1. Lancer MCC en AC OFF
2. Custom Games → Halo Reach
3. Sélectionner game type **One Flag CTF**
4. **Edit Game Type** → entrer dans la configuration

### J2 — Round & teams (30 min)
- Régler Round time, score limit, lives, friendly fire
- Définir Defender = UNSC bleu, Attacker = Covenant rouge/Élite
- Vérifier 12v4 quand effectif posé

### J3 — Player traits (45 min)
- Onglet Player Traits → Defender → entrer toutes les valeurs UNSC
- Onglet Player Traits → Attacker → entrer toutes les valeurs Covenant
- Vérifier que la "vie" totale UNSC > vie totale Covenant (asymétrie défense)

### J4 — Loadouts (1h)
- Onglet Loadouts → Defender → créer les 4 UNSC avec restrictions
- Onglet Loadouts → Attacker → créer les 4 Covenant
- Vérifier que les armes sont bien attribuées (pas de Battle Rifle pour Covenant, etc.)

### J5 — Vehicle, weapon on map (30 min)
- Régler les timers d'armes
- Régler les véhicules (1 Warthog, 1 Mongoose, 1 Ghost)

### J6 — Sauvegarde
- Save Variant → nommer `Sentinel-Defense v1`
- Vérifier que la variante apparaît dans la liste Custom Games
- Test load avec map FOB Alpha

---

## Tests d'équilibrage

### Test 1 — Test sec (semaine 2)
- 8 testeurs (6 UNSC vs 2 Covenant — version réduite)
- Vérifier que Covenant peut **atteindre** le flag dans les 25 min sans bug
- Vérifier que UNSC peut **tenir** 25 min sans bug

### Test 2 — Test grandeur nature (semaine 3-4)
- 16 testeurs (12 UNSC vs 4 Covenant)
- 5 sessions consécutives
- **Critère** : ratio victoire Covenant ∈ [35% ; 55%]
- Si <35% : ajuster en boostant Covenant (vitesse +5%, dégâts +5%, ou flag carrier traits améliorés)
- Si >55% : ajuster en boostant UNSC (damage resistance +5%, augmenter Covenant respawn à 15s)

---

## Versions futures

### v1.1 (Sprint 2, post-test)
- Patch d'équilibrage selon résultats tests
- Possible ajustement des player traits

### v2.0 (Sprint 3, semaine 9+) — Megalo custom
Cette version utilisera un script Megalo écrit avec les Mod Tools (ou éditeur Megalo+ communautaire). Elle ajoutera :
- **Score multi-objectifs** : sabotage = 1 point, capture = 3 points, exfiltration vivante = 1 point bonus
- **HUD custom** indiquant les zones contrôlées et le timer
- **Lives limited Covenant** (4 joueurs × 3 vies = 12 tentatives totales)
- **Phase d'infiltration** : 5 premières minutes Covenant a Active Camo permanent
- **Renforts UNSC** : à T+15min, UNSC débloque le loadout Heavy même pour Privates

---

## Voir aussi

- [../../forge_maps/fob_alpha/design.md](../../forge_maps/fob_alpha/design.md) — design de la map associée
- [../../gamepacks/halo_reach_mvp_v0.1/manifest.md](../../gamepacks/halo_reach_mvp_v0.1/manifest.md) — manifest du Game Pack
- [../../gamepacks/halo_reach_mvp_v0.1/briefings/op_sentinel.md](../../gamepacks/halo_reach_mvp_v0.1/briefings/op_sentinel.md) — briefing IC
- [../../configs/operations_types.md](../../configs/operations_types.md)
- [../../configs/roles.md](../../configs/roles.md)
