# Variante TEST — sentinel_defense_test

Variante minimaliste de **validation MCC**. Pas la variante de production (qui est `sentinel_defense_v1`). Cette variante sert UNIQUEMENT à vérifier que :
- Custom Games en AC OFF fonctionnent
- One Flag CTF charge correctement
- L'asymétrie Spartan vs Élite affiche bien
- Le timer 25 min tourne
- Le flag peut être pris et capturé

**Aucune subtilité d'équilibrage.** On garde tout au maximum stock. Si ça marche, on passe à la v1 ; si ça plante, on diagnostique avant de complexifier.

---

## Méta

| Champ | Valeur |
|---|---|
| Nom in-game | sentinel_defense_test |
| Base | One Flag CTF (variante stock Reach) |
| Map | **Hemorrhage** (preset Forge World stock — pas FOB Alpha encore) |
| Effectif | 1–8 par équipe selon test |
| Durée | 25 min |
| Objectif | Validation MCC, pas balance RP |

> On utilise **Hemorrhage stock** comme map ici. C'est la version pré-faite de Forge World qu'on sélectionne directement dans le menu maps. Pas besoin d'avoir construit FOB Alpha pour ce test. **On valide la chaîne MCC d'abord, on construit la map après.**

---

## Procédure de création (15 minutes)

### 1. Lancer MCC en AC OFF
- Steam → MCC → Jouer → cocher Anti-Cheat OFF
- Vérifier le bandeau "Anti-Cheat is disabled" au démarrage

### 2. Aller dans Custom Games
- Multiplayer → Custom Games → Halo Reach

### 3. Charger Hemorrhage
- **Map** : sélectionner `Hemorrhage` (preset stock Forge World)
- Confirmer le chargement

### 4. Sélectionner One Flag CTF
- **Game Type** : One Flag CTF
- Cliquer sur **Edit Game Type**

### 5. Configurer (paramètres minimaux)

| Onglet | Réglage | Valeur |
|---|---|---|
| **General** | Round time | 25:00 |
| | Score limit | 1 |
| | Number of rounds | 1 |
| | Sudden death | Off |
| | Friendly fire | Off |
| **Respawn** | Lives per round | Infinite |
| | Respawn time (Defender) | 8s |
| | Respawn time (Attacker) | 12s |
| **Teams** | Defender team | Bleu, **Spartan** model, label "UNSC" (si dispo en custom) |
| | Attacker team | Rouge, **Élite** model, label "Covenant" |
| **Loadouts** | Tier | Tier 1 (default Reach loadouts, on touche pas) |
| **Player traits** | Default ✓ | (pas de modif pour le test) |

→ **Tout le reste : laisser par défaut.** Pas de player traits custom, pas de loadouts custom. On veut tester que le moteur fonctionne avec One Flag CTF + Hemorrhage + asymétrie d'espèce.

### 6. Sauvegarder
- **Save Game Type** → nommer `sentinel_defense_test`
- Confirmer

### 7. Vérifier dans la liste
- Retour menu Custom Games → la variante doit apparaître dans la liste
- Si oui → ✅ MCC custom + AC OFF + variante validés

---

## Test solo immédiat (5 minutes)

Avant d'inviter qui que ce soit :

1. Lancer la variante avec **1 joueur (toi seul)**
2. Choisir équipe **UNSC (Defender)**
3. Vérifier :
   - [ ] Tu spawns avec un loadout par défaut (AR + Magnum)
   - [ ] Le HUD affiche "Defender" ou "UNSC"
   - [ ] Le flag est visible quelque part sur la map (Hemorrhage Red Base normalement)
   - [ ] Le timer compte 25:00 → 24:59 → ...
   - [ ] Tu peux te déplacer librement, prendre des armes, tirer

4. Quitter le match (End Game)
5. Relance, choisir équipe **Covenant (Attacker)**
6. Vérifier :
   - [ ] Tu apparais en **Élite Sangheili** (modèle 3D différent)
   - [ ] Loadout Covenant par défaut (Plasma Pistol / Plasma Repeater)
   - [ ] HUD affiche "Attacker" ou "Covenant"
   - [ ] Tu peux récupérer le flag (Defender side) et le porter

→ Si tout ✅ : la chaîne MCC + custom + asymétrie est validée. Tu peux passer à la construction de FOB Alpha.

---

## Si ça ne marche pas

| Symptôme | Diagnostic |
|---|---|
| Variante disparaît du menu | Pas sauvegardée correctement → recommencer Save Game Type |
| Pas d'option "Élite" pour Attacker | Vérifier que le Reach pack est complet (pas juste le base game) |
| Crash au chargement de Hemorrhage | Vérifier intégrité MCC dans Steam |
| Le flag n'apparaît pas | One Flag CTF mal sélectionné, ou Hemorrhage stock corrompu — re-télécharger |
| AC OFF refuse de charger | Steam Update MCC, redémarrer |

---

## Étape suivante

Une fois `sentinel_defense_test` validée et fonctionnelle sur Hemorrhage stock :
1. Construire **FOB Alpha** dans Forge (voir [../../forge_maps/fob_alpha/build_guide.md](../../forge_maps/fob_alpha/build_guide.md))
2. Sauvegarder comme `fob_alpha.mvar`
3. Charger `sentinel_defense_test` + `fob_alpha` ensemble pour valider que la map custom fonctionne aussi
4. Itérer vers `sentinel_defense_v1` (variante de production avec player traits, loadouts custom, etc. — voir [../sentinel_defense_v1/spec.md](../sentinel_defense_v1/spec.md))

---

## Voir aussi

- [../sentinel_defense_v1/spec.md](../sentinel_defense_v1/spec.md) — variante de production complète
- [../../forge_maps/fob_alpha/build_guide.md](../../forge_maps/fob_alpha/build_guide.md) — guide construction
- [../../documentation/08_first_test_checklist.md](../../documentation/08_first_test_checklist.md) — checklist progressive
