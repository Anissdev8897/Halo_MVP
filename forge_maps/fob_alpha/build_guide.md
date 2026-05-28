# Build Guide — FOB Alpha (Forge)

Guide de construction **étape par étape, exploitable pendant la session Forge**. À garder ouvert sur un 2e écran ou imprimé.

> **Référence design** : [design.md](design.md). Ce guide-ci dit *comment* construire ; le design dit *quoi* construire et *pourquoi*.

---

## Pré-requis

- MCC en **Anti-Cheat OFF**
- Halo Reach + Multiplayer installés
- Custom Games → Halo Reach → **Forge World** (preset)
- Game Type : **Forge** (mode édition)
- 3–4 heures dispo pour la première passe complète

---

## Vue d'ensemble — l'ordre de construction

L'idée : construire **du gros au fin**. Si on bloque sur un détail, le squelette est déjà là.

```
Phase 0 — Préparation              5 min
Phase 1 — Localisation & nettoyage 10 min
Phase 2 — Périmètre du FOB         45 min
Phase 3 — Command Bunker           30 min
Phase 4 — Spawns                   15 min
Phase 5 — Tours + sandbags         20 min
Phase 6 — Generator Hut            10 min
Phase 7 — Sniper Ridge ouest       15 min
Phase 8 — Vehicle Road + véhicules 15 min
Phase 9 — Armes + équipement       15 min
Phase 10 — Extract Point Echo      10 min
Phase 11 — Test sec + sauvegarde   15 min
TOTAL                              ~3h30
```

→ Ne pas hésiter à scinder en 2 sessions de 2h. Sauvegarder fréquemment (`Start → Save Map → Overwrite`).

---

## PHASE 0 — Préparation (5 min)

1. **Lancer MCC en AC OFF**
2. Multiplayer → Custom Games → Halo Reach
3. **Map** : `Forge World` (preset, pas un MVar custom)
4. **Game Type** : `Forge` (mode édition, pas Slayer)
5. **Start Game** → tu apparais en mode Forge avec le Monitor (forme volante)
6. **Familiarisation rapide** :
   - **B** = passer Spartan ↔ Monitor
   - **RT** (gâchette) = saisir/poser un objet
   - **LT** = deselect
   - **A** sur un objet = ouvrir Edit menu (Coordinates, Physics, Game-Specific labels…)
   - **X** = budget restant
   - **Y** = menu Object Types

> Astuce : régler "Snap to Grid = ON" et "Object Stand Up = ON" dans le menu options Forge avant de commencer. Tu gagneras 30 % de temps de placement.

---

## PHASE 1 — Localisation & nettoyage (10 min)

### Position cible : Hemorrhage canyon, **extrémité SUD**

Le canyon Hemorrhage de Forge World est un long couloir naturel orienté nord-sud avec des falaises latérales. On installe le FOB UNSC à **l'extrémité sud** (l'emplacement original de la "Red Base" de Blood Gulch).

### Pour t'y rendre vite

1. Ouvrir le **menu Forge** (Start)
2. **Edit Coordinates** ou **Quick Travel** → sélectionner **Hemorrhage** dans les presets de localisation
3. Tu es téléporté à la zone du canyon
4. Vol vers le sud du canyon (flotter en Monitor) jusqu'à voir l'**arche rocheuse sud** (la falaise courbe qui ferme le canyon)

### Repères visuels du sud du canyon Hemorrhage
- À ta gauche (ouest) : **falaise élevée** avec corniche → futur **Sniper Ridge**
- À ta droite (est) : **plaine et accès route** → future **Vehicle Road**
- Devant toi (sud) : **arche rocheuse** + **plaine plate** → emplacement du **FOB**
- Derrière toi (nord) : **canyon ouvert** → futurs **Approach Routes** + **Covenant Spawn**

### Nettoyage

Si la version Forge World que tu as a des objets stock placés (rare en preset Forge vide, mais possible) :
1. Mode Monitor → **Y → Object Browser → Sorting → "On Map"**
2. Sélectionner les objets indésirables un par un, **A → Delete**
3. Ou : **Start → Delete All Map Objects** (purge totale, attention)

---

## PHASE 2 — Périmètre du FOB (45 min)

### Position du FOB

Au sol, dans la **plaine sud** du canyon, environ **30 m au nord de l'arche rocheuse sud**.

### Dimensions cibles

Rectangle ~50 m × 35 m, axe long est-ouest.

### Pièces à utiliser

- **Wall, Coliseum** (ou **Wall, Large**) → 12 unités
- Préférer **Wall, Coliseum** : plus haute, plus solide visuellement
- Budget : ~120 par mur si "Wall, Coliseum" — **vérifier `X` régulièrement**

### Procédure pas à pas

#### 2a. Premier mur sud (4 pièces)
1. **Y → Structure → Wall, Coliseum** → spawn
2. Saisir le mur, le **rotater** pour qu'il soit orienté est-ouest (gâchettes RT/LT pour rotation)
3. Le poser au sol au point sud de la zone FOB
4. **Aligner sur la grille** (Snap to Grid)
5. Spawner 3 autres exemplaires, les aligner en ligne pour faire un mur complet
6. **Laisser un trou de 4-5 m** au milieu pour l'**Entrée Sud-Ouest** (pas tout au centre, plutôt aux 2/3 ouest)

#### 2b. Mur nord (4 pièces)
- Même procédure, parallèle au mur sud, distant de **35 m** vers le nord
- Pas d'entrée nord (le mur est continu — la défense pointe vers le canyon)

#### 2c. Mur ouest (2 pièces)
- Perpendiculaire, fermant le côté ouest du rectangle
- Continu

#### 2d. Mur est (2 pièces avec entrée)
- Perpendiculaire, fermant le côté est
- **Laisser un trou de 4-5 m** vers le centre — c'est l'**Entrée Est** (sortie Vehicle Road)

#### 2e. Vérification
- Tu dois avoir un rectangle fermé sauf 2 entrées (SO et E)
- Tester en Spartan : peux-tu sauter par-dessus les murs ? Si oui, ajouter des "Wall, Tall" en hauteur
- Le périmètre est-il **lisible** depuis l'extérieur (Sniper Ridge, Approach Center) ? L'arrière est-il fermé ?

### Budget consommé approximatif après Phase 2 : **~25 %**

---

## PHASE 3 — Command Bunker (30 min)

### Position

**Centre exact du FOB**, équidistant des 4 murs.

### Dimensions

~12 m × 8 m × 5 m de haut. Cube fermé, **2 entrées (Nord et Sud)**.

### Pièces

- **Building Block, Sml** → 4-6 unités (sols, plafonds)
- **Wall, Brace Lrg** → 4 unités (murs latéraux)
- **CTF Flag Stand** → 1 unité (objet game-specific)
- **Ammo Crate** ou **Crate, Sml** → 2 unités (déco + cover)
- **Health Pack (Equipment)** → 1 unité (au mur intérieur)

### Procédure

#### 3a. Sol & murs
1. Poser un **Building Block, Sml** comme sol
2. 4 **Wall, Brace Lrg** verticaux pour les côtés (laisser 2 trous N et S de ~3 m chacun)
3. **Building Block, Sml** comme toit (peut être rendu transparent ou ouvert si tu veux que les grenades passent — c'est plus tactique)

> Astuce : laisse une **ouverture de toit de 2×2m** côté centre. Permet aux grenades de passer (RP = "lucarne d'aération") et casse la simplicité défensive.

#### 3b. Le flag (objectif principal)
1. **Y → Game-Specific → CTF Flag Stand** → spawn
2. Le poser **au centre du bunker, au sol**
3. **A → Game-Specific Edit** :
   - Label : automatique pour One Flag CTF
   - **Team Affiliation** : Defender (UNSC)
4. Vérifier que le drapeau apparaît au-dessus du stand (effet visuel rouge ou bleu selon team)

#### 3c. Ammo & health
- 2 **Crate, Sml** dans 2 angles intérieurs du bunker (cover + ambiance)
- 1 **Health Pack** sur un mur intérieur, **respawn 45s** :
  - **A → Edit Object → Spawn Time : 45**

#### 3d. Vérification
- Le flag est-il visible depuis les deux entrées ?
- Y a-t-il assez de cover pour 2-3 défenseurs à l'intérieur ?
- Un Spartan peut-il entrer + ramasser le flag + sortir en moins de 5s ? Si <3s, c'est trop accessible — épaissir l'entrée.

---

## PHASE 4 — Spawns (15 min)

### Spawns UNSC primaires (8)

#### Position
Zone sud-est intérieure du FOB, à 2-3 m du Mur Sud, près de l'Entrée Est.

#### Pièces
- **Y → Spawning → Initial Spawn Point** ×4 (les 4 premiers où apparaissent les UNSC au début)
- **Y → Spawning → Respawn Point** ×4 (où ils respawnent après mort)
- **Tous label** : équipe **Defender** (auto si One Flag CTF + équipe assignée)

#### Procédure
1. Spawner 4 Initial Spawn Points en ligne, espacés de ~2 m, orientés vers le nord (regard vers le bunker)
2. Spawner 4 Respawn Points en arc, autour des Initial
3. **A → Edit → Team Affiliation : Defender** sur chacun
4. Optionnel : **A → Edit → Spawn Sequence** (ordre d'utilisation)

### Spawns UNSC fallback (4)

#### Position
Sud du FOB, à l'extérieur du périmètre, à 10-15 m au-delà du Mur Sud (vers Extract Point).

Utile si la zone primaire est "hot" (beaucoup d'ennemis).

#### Procédure
- 4 **Respawn Point**
- **Team : Defender**
- **Edit → Multi-Team : ON** (utilisable si zone primaire saturée)

### Spawns Covenant (4)

#### Position
**Plateau nord du canyon Hemorrhage**, à environ 150 m du FOB, sur l'élévation rocheuse.

#### Procédure
1. Voler au nord du canyon en Monitor
2. Trouver une zone plate sur l'élévation
3. Spawner 4 **Initial Spawn Point** + 4 **Respawn Point**
4. Tous orientés vers le sud (regard vers le FOB)
5. **Team : Attacker**

### Vérification

- Spartan-test : se faire spawn en équipe UNSC → confirmer apparition dans la zone sud du FOB
- Spartan-test : se faire spawn en équipe Covenant → confirmer apparition au plateau nord
- **Test critique** : depuis la zone Covenant Spawn, peut-on **voir** un Spartan UNSC qui spawn ? Si oui → c'est cassé, recommence l'angle.

---

## PHASE 5 — Tours d'observation + sandbags (20 min)

### Tours nord-est et nord-ouest (2)

#### Position
Aux **angles nord** du périmètre du FOB. Hauteur 6-8 m pour vue sur Approach Routes.

#### Pièces
- **Building Block, Lrg** ×2 (1 par tour, base)
- **Brace, Tunnel** ou **Wall, Tall** pour la hauteur
- **Walkway, Cover** pour le toit défensif (avec couverture)

#### Procédure (par tour, ×2)
1. Empiler 2 Building Blocks en hauteur (escalier interne possible avec ramp)
2. Au sommet, poser une plateforme **Walkway** ou **Building Block, Sml**
3. Murs partiels en haut pour cover (Brace Lrg moitié-hauteur)
4. Accès depuis l'intérieur du FOB via **Ramp, Lrg**

### Sandbags (~20 unités)

#### Position
- Le long des Murs N et E (extérieur)
- Aux 2 entrées (SO et E) — créent des chicanes

#### Pièces
- **Y → UNSC → Sandbag** ou **Y → Decorative → Sandbag**

#### Procédure
- Poser 4-5 sandbags en ligne devant chaque entrée pour casser la ligne droite
- Quelques-uns le long des murs pour le côté visuel

### Décoration

- **Y → UNSC → Flag (UNSC)** ×4 → angles du FOB pour la signature
- **Y → Decorative → Light, Streetlamp** ×4 → ambiance

---

## PHASE 6 — Generator Hut (10 min)

### Position

À **8 m à l'OUEST du Mur Ouest** du FOB, isolée. Visible depuis le FOB et depuis Sniper Ridge.

### Pièces
- **Building Block, Sml** ×3 (cabane fermée, 6×4 m)
- **Crate, Explosive** ×1 (objet destructible — c'est le générateur)

### Procédure
1. Construire une cabane minimaliste : sol, 4 murs, 1 toit, 1 entrée (vers l'est, face au FOB)
2. À l'intérieur : poser une **Crate, Explosive**
3. **A → Game-Specific Edit** sur la Crate :
   - Label : `obj_sabo` (saisir manuellement si possible, sinon laisser default)
4. **Spawn Time** : pas de respawn (perdu = perdu)

### Tactique
- Cible secondaire pour Covenant
- Visible depuis Sniper Ridge → un sniper UNSC peut la défendre à distance
- Mais isolée → un Saboteur Active Camo peut la rejoindre

---

## PHASE 7 — Sniper Ridge ouest (15 min)

### Position

**Crête naturelle ouest du canyon Hemorrhage**, à 30-50 m du Mur Ouest du FOB. Forge World a une vraie corniche rocheuse à cet endroit — l'utiliser !

### Pièces
- **Wall, Brace Sml** ×2-3 (cover bas pour shielder un sniper)
- **Crate, Sml** ×2 (cover supplémentaire, casse la ligne)
- **Sniper Rifle (Weapon)** ×1

### Procédure
1. Voler en Monitor jusqu'à la corniche ouest
2. Sur le terrain naturel, poser 2-3 **Wall, Brace Sml** en arc → ils créent une "tranchée" à hauteur de poitrine pour le sniper
3. Ajouter 2 **Crate, Sml** comme cover supplémentaire
4. **Y → Weapons → Sniper Rifle** → spawner sur la corniche
5. **A → Edit → Spawn Time : 90** (90 secondes respawn)

### Test
- Depuis la position du sniper, peux-tu voir : (a) le FOB Alpha (b) Approach Center (c) la Generator Hut ?
- Réponse attendue : oui aux 3, mais avec angles partiellement masqués (pas full vue) → équilibrage

---

## PHASE 8 — Vehicle Road + véhicules (15 min)

### Position

Côté **est** du canyon, route plate menant du nord (Covenant approach) au sud (FOB Entrée Est).

### Pièces & objets
- **Warthog, Chaingun** ×1
- **Mongoose** ×1
- **Ghost** ×1

### Procédure

#### 8a. Warthog UNSC (intérieur FOB)
1. **Y → Vehicles → Warthog (chaingun)** → spawn dans la zone Warthog Bay (sud-ouest intérieur du FOB)
2. **A → Edit → Spawn Time : Never Respawn** (perdu = perdu)
3. **Team Affiliation** : Defender (optionnel — un attaquant peut le voler s'il entre)

#### 8b. Mongoose UNSC (sortie est)
1. **Y → Vehicles → Mongoose** → spawn juste à l'extérieur de l'Entrée Est du FOB
2. **Spawn Time : 60s**

#### 8c. Ghost Covenant (vehicle road)
1. **Y → Vehicles → Ghost** → spawn au milieu de la Vehicle Road, à mi-chemin entre Covenant Spawn et FOB
2. **Spawn Time : 90s**
3. **Team Affiliation** : Attacker (mais récupérable par UNSC s'il l'atteint)

---

## PHASE 9 — Armes + équipement (15 min)

### Liste & positions

| Arme | Position | Spawn Time |
|---|---|---|
| **Sniper Rifle** | Sniper Ridge ouest (déjà posé Phase 7) | 90s |
| **Shotgun** | Command Bunker, mur ouest intérieur | 60s |
| **Rocket Launcher** | Covenant Spawn rack (plateau nord) | 120s |
| **Plasma Launcher** | Covenant Spawn rack | 120s |
| **Frag Grenades x2** | Approach Center (entre nord canyon et FOB), zone neutre | 30s chacune |
| **Plasma Grenades x2** | Approach West & East (latéraux), zone neutre | 30s chacune |
| **Health Pack** | Command Bunker (déjà posé Phase 3) | 45s |

### Procédure

Pour **chaque arme** :
1. **Y → Weapons → [arme]** → spawner
2. La poser à la position prévue
3. **A → Edit Object** :
   - **Spawn Time** : valeur du tableau
   - **Spare Clips** : default (ou +1 pour Sniper)
4. Vérifier le **respawn timer indicator** (icône horloge sur l'objet)

### Vérification
- Toutes les armes sont-elles visibles à 30 m ?
- Aucune n'est dans une zone "morte" (cachée) ?
- Le Plasma Launcher est-il bien côté Covenant uniquement ?

---

## PHASE 10 — Extract Point Echo (10 min)

### Position

**Sud-ouest du FOB**, à environ **80 m** du Mur Sud-Ouest, sur une zone basse plate.

### Pièces & objets
- **CTF Capture Plate** ×1 (objet game-specific One Flag CTF)
- **Marker (Flag)** ×4 (objets décoratifs visibles, type drapeaux Insurrection ou marqueurs)
- **Wall, Brace Sml** ×2 (couvert minimal pour défendre/attaquer le point)

### Procédure

#### 10a. Capture point
1. **Y → Game-Specific → Capture Plate** (One Flag CTF) → spawn
2. Le poser au sol
3. **A → Game-Specific Edit** :
   - Label : auto pour One Flag CTF Attacker capture
   - **Team Affiliation** : Attacker (Covenant capture leur drapeau là)
4. **Game-Specific → Capture Time** : instantané

#### 10b. Visuel
- 4 **Marker** disposés en carré autour du Capture Plate
- 2 **Wall, Brace Sml** comme couvertures minimales

#### 10c. Test
- Le Capture Plate brille-t-il visuellement dans la couleur attaquant ?
- Est-il visible depuis la sortie ouest du FOB (pour que les défenseurs sachent qu'il existe) ?

---

## PHASE 11 — Test sec + sauvegarde (15 min)

### 11a. Test sec solo

1. **Pause → End Forge Session → Save Map → Save As "FOB Alpha"** (preliminary save)
2. Quitter Forge
3. Custom Games → Map : FOB Alpha → Game Type : `sentinel_defense_test` (variante créée à l'étape 2)
4. **Start Game** avec toi seul

### 11b. Walkthrough solo (5 min)

Vérifie en marchant :
- [ ] Tu spawns dans la zone UNSC (sud du FOB)
- [ ] Le bunker est bien visible et accessible
- [ ] Le flag est dans le bunker, visible
- [ ] Tu peux le ramasser
- [ ] Tu peux marcher jusqu'à Echo Point
- [ ] La zone Echo est bien marquée
- [ ] Quand tu arrives sur la Capture Plate avec le flag, le timer de capture démarre (visuel)
- [ ] Toutes les armes au sol sont accessibles
- [ ] Le Warthog démarre (X pour entrer)
- [ ] Le Sniper Ridge donne une vue sur le FOB

### 11c. Issues constatées → noter

Format de note rapide (post-it ou Discord `#bugs-feedback`) :
```
PHASE: {numéro}
ISSUE: {description courte}
SEVERITY: low / med / high
```

### 11d. Sauvegarde finale

1. Retour Forge sur la map FOB Alpha
2. Corriger les issues bloquantes
3. **Save Map → Overwrite "FOB Alpha"**
4. **Export Map Variant** :
   - Onglet Forge → Export → File Share
   - Localement : `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\Map_Variants\fob_alpha.mvar`
5. **Backup** : copier ce fichier dans `HaloRP_MVP/gamepacks/halo_reach_mvp_v0.1/forge_maps/fob_alpha.mvar`

---

## Budget Forge — point de contrôle

| Phase | Budget cumulé approx. |
|---|---|
| Phase 2 (périmètre) | 25 % |
| Phase 3 (bunker) | 35 % |
| Phase 4 (spawns) | 38 % |
| Phase 5 (tours + sandbags) | 50 % |
| Phase 6 (generator) | 53 % |
| Phase 7 (sniper ridge) | 57 % |
| Phase 8 (véhicules) | 60 % |
| Phase 9 (armes) | 65 % |
| Phase 10 (extract) | 68 % |
| **Final** | **~70 %** |

→ Reste ~30 % de marge pour itérations / ajouts visuels. Si tu dépasses 90 %, supprimer les sandbags décoratifs en priorité.

---

## Erreurs courantes pendant le build

| Erreur | Solution |
|---|---|
| Le Snap to Grid désaligne mes murs | Désactive temporairement (Start → Options), aligne manuellement, réactive |
| Je ne trouve pas un type d'objet | Vérifier l'onglet — UNSC / Decorative / Game-Specific selon le cas |
| Mon flag n'apparaît pas en jeu | Game Type pas réglé en One Flag CTF, ou Team Affiliation non assignée |
| Spawn dans le mur / sous le sol | "Object Stand Up = ON" dans options, et utiliser Snap to Grid |
| Budget atteint trop vite | Préférer **Wall, Coliseum** (gratuit en hauteur) à **Building Block, Lrg** (cher) |
| Mon Warthog spawn dans le bunker | Repositionner avec Edit Coordinates manuel (XYZ précis) |
| Le Capture Plate ne fait rien | Vérifier que la variante chargée est bien One Flag CTF, pas un Slayer |

---

## Itérations post-build (semaines 3-4)

Après les premiers tests (cf. [08_first_test_checklist.md](../../documentation/08_first_test_checklist.md)) :

### Si Covenant gagne >55 %
- Renforcer cover UNSC autour de l'entrée SO
- Allonger le respawn Covenant à 15s
- Réduire le nombre d'entrées (boucher l'entrée Est partiellement)

### Si UNSC gagne >65 %
- Retirer 1-2 sandbags devant entrée SO (rendre plus exposée)
- Ajouter une 3e entrée (mur ouest, étroite)
- Boost trait dégât Covenant +5%

### Si Sniper Ridge trop dominant
- Bloquer une partie de la vue avec un **Wall, Tall** au sud du Sniper Ridge
- Augmenter Sniper respawn à 120s

---

## Voir aussi

- [design.md](design.md) — design théorique de la map
- [../../variants/sentinel_defense_test/spec.md](../../variants/sentinel_defense_test/spec.md) — variante de test
- [../../variants/sentinel_defense_v1/spec.md](../../variants/sentinel_defense_v1/spec.md) — variante de production
- [../../documentation/08_first_test_checklist.md](../../documentation/08_first_test_checklist.md) — checklist progressive
