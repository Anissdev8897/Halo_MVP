# Première checklist de test — progressif

Tests à exécuter dans l'ordre, du plus simple au plus complexe. **Ne pas passer au test suivant tant que le précédent n'est pas validé.**

> Cette checklist remplace partiellement [07_test_checklist.md](07_test_checklist.md) qui était le plan de test global pour Sprint 1. Celle-ci est focalisée **sur la première session de validation pratique**.

---

## Ordre & timing

| Test | Joueurs | Durée | Quand |
|---|---|---|---|
| 1. Solo (toi) | 1 | 15 min | Juste après build initial |
| 2. Duo (1v1) | 2 | 25 min | Quand tu as 1 ami dispo |
| 3. Reduced (8v4) | 12 | 25 min + 15 brief | Quand tu as 12 personnes |
| 4. Full scale (12v4) | 16 | 25 min + 30 brief/debrief | Cible Sprint 1 finale |

---

## Test 1 — Solo (1 joueur, toi seul)

### Objectif
Valider que la map charge, que les éléments sont en place, que tu peux te déplacer dans toutes les zones sans bug.

### Setup
- Lancer MCC en AC OFF
- Custom Games → Halo Reach → **Map: FOB Alpha** + **Variant: sentinel_defense_test**
- 1 joueur (toi), équipe Defender (UNSC)
- Démarrer la partie

### Checklist

#### Spawn
- [ ] Tu apparais dans la zone UNSC Spawn (sud du FOB)
- [ ] Tu apparais en Spartan (modèle bleu UNSC)
- [ ] Loadout par défaut chargé (AR + Magnum)
- [ ] HUD affiche "Defender"
- [ ] Pas de glitch visuel (texture manquante, fall-through-floor)

#### Objectifs visibles
- [ ] Tu peux voir le **flag stand** dans le Command Bunker
- [ ] Le drapeau s'affiche au-dessus (visuel rouge)
- [ ] Tu peux ramasser le flag (B ou X selon binding)

#### Walkthrough zones
- [ ] Tu peux marcher du UNSC Spawn → Command Bunker (pas d'obstacle imprévu)
- [ ] Tu peux sortir du FOB par l'**Entrée Sud-Ouest**
- [ ] Tu peux sortir du FOB par l'**Entrée Est**
- [ ] Tu peux atteindre le **Sniper Ridge** (corniche ouest) en marchant
- [ ] Tu peux atteindre la **Generator Hut** (cabane ouest)
- [ ] Tu peux atteindre l'**Extract Point Echo** (sud-ouest, ~80m)
- [ ] Tu peux marcher jusqu'au **Plateau Covenant Spawn** (nord du canyon)
- [ ] Tu peux remonter sur les **tours d'observation** via la rampe interne

#### Test capture
- [ ] Ramasser le flag
- [ ] Marcher jusqu'à Echo Point
- [ ] **Le Capture Plate déclenche-t-il un timer de capture ?**
- [ ] La capture aboutit-elle (victoire Attacker simulée) ?

#### Test armes & véhicules
- [ ] Sniper Rifle accessible sur Sniper Ridge
- [ ] Shotgun accessible dans Command Bunker
- [ ] Rocket Launcher accessible au Covenant Spawn rack
- [ ] Plasma Launcher accessible au Covenant Spawn rack
- [ ] Frag grenades x2 visibles à Approach Center
- [ ] Plasma grenades x2 visibles aux Approach W/E
- [ ] Health Pack se respawn après ramassage (attendre 45s)
- [ ] Warthog démarre (X pour entrer, accélérer)
- [ ] Mongoose démarre
- [ ] Ghost démarre

#### Issues à noter
- [ ] Aucun spawn dans une zone "morte" (sous le sol, dans un mur)
- [ ] Aucun objet en lévitation (sandbag flottant)
- [ ] Aucun trou par lequel un joueur peut tomber hors-map
- [ ] Pas de "stuck spot" où on reste bloqué sans pouvoir sortir

### Critère de validation Test 1
- ✅ Toutes les cases ✅ → passer Test 2
- ⚠️ 1-3 cases ❌ mineures → corriger en Forge, retest
- ❌ 4+ cases ❌ ou bug bloquant → revoir build, ré-itérer phase concernée

---

## Test 2 — Duo (1 vs 1)

### Objectif
Valider la mécanique asymétrique Spartan vs Élite, vérifier que le combat fonctionne, valider la capture par un joueur réel.

### Setup
- Toi en UNSC Defender (Spartan)
- 1 ami en Covenant Attacker (Élite)
- 25 min, sentinel_defense_test
- Pas de briefing élaboré, on teste juste la mécanique

### Checklist

#### Asymétrie visuelle
- [ ] Toi : Spartan en armure bleue
- [ ] Ami : **Élite Sangheili** (modèle 3D différent, plus grand)
- [ ] Loadouts différents (UNSC = humain, Covenant = plasma)
- [ ] HUD distinct par faction

#### Engagement
- [ ] Vous pouvez vous voir, vous tirer dessus
- [ ] Friendly fire : OFF (vous ne pouvez pas vous endommager si même équipe — non testé ici, 1v1)
- [ ] Pas de glitch d'hitbox (Élite est plus grand → tu touches bien sa silhouette)
- [ ] Mêlée fonctionne (CQC)
- [ ] Grenades fonctionnent

#### Mécanique CTF
- [ ] L'Élite peut entrer dans le Command Bunker
- [ ] L'Élite peut ramasser le flag
- [ ] Quand l'Élite porte le flag, son **trait Speed** est ajusté (default One Flag CTF : speed -10%)
- [ ] L'Élite peut courir jusqu'à Echo Point avec le flag
- [ ] Si tu tues l'Élite porteur de flag, le flag tombe à l'endroit de la mort
- [ ] Le flag se **return** automatiquement après 30s s'il est laissé
- [ ] Si l'Élite arrive à Echo Point avec le flag, **capture déclenchée** + score Attacker +1

#### Spawns
- [ ] Quand l'Élite meurt et respawn, il revient au Plateau Covenant Spawn (nord)
- [ ] Quand toi UNSC meurs et respawn, tu reviens dans la zone UNSC (sud FOB)
- [ ] Pas de spawn dans la ligne de vue immédiate de l'adversaire

#### Durée
- [ ] Le timer décompte de 25:00 → 0:00
- [ ] Si capture avant 25:00 → match termine, victoire Attacker
- [ ] Si timer atteint 0 sans capture → match termine, victoire Defender

### Critère de validation Test 2
- ✅ Validé → passer Test 3 (recruter 12 testeurs)
- ⚠️ Asymétrie pas affichée correctement → vérifier paramètres team Élite vs Spartan dans variante

---

## Test 3 — Reduced scale (8 vs 4)

### Objectif
Valider que l'asymétrie 2:1 fonctionne avec une équipe complète. Détecter les problèmes de spawn collectif, sightlines, équilibrage.

### Setup
- 8 UNSC vs 4 Covenant
- 25 min, sentinel_defense_test
- Briefing rapide en Discord (5 min) : "défense FOB, pas de respawn rush ennemi spawn"
- Pas de loadouts custom encore, tout default

### Checklist

#### Spawn collectif
- [ ] 8 UNSC apparaissent en même temps sans collision (pas de "spawn dans un autre joueur")
- [ ] 4 Covenant idem
- [ ] Personne spawn dans la ligne de vue d'un ennemi
- [ ] Respawns suivants (après mort) : pas de spawn-kill (ni en équipe primaire ni fallback)

#### Lisibilité des zones
- [ ] Les UNSC comprennent où est le flag (sans qu'on leur dise)
- [ ] Les Covenant comprennent leur objectif (capture flag → Echo Point)
- [ ] Echo Point est trouvable visuellement par un attaquant qui débarque pour la 1ère fois
- [ ] Generator Hut visible (pour les sabotages futurs)
- [ ] Sniper Ridge identifiable

#### Combat & équilibrage
- [ ] 4 Covenant peuvent réellement menacer 8 UNSC (pas wipe instantané)
- [ ] 8 UNSC peuvent défendre sans être totalement passifs
- [ ] **Outcome** : la session finit en moins de 25 min OU au timer (pas de "match nul ridicule à T+5")
- [ ] Sniper Ridge : utilisé par les deux camps (peut être contesté)
- [ ] Warthog : utilisé par UNSC, pas trop OP (tué au moins une fois pendant le match)

#### Absence de spawn-kill
- [ ] **Aucun joueur ne signale "j'ai été tué dans ma zone de spawn directement après respawn"** > 2 fois
- [ ] Si signalé : noter la zone exacte et corriger en Forge avant Test 4

#### Durée correcte
- [ ] Le match a duré entre 12 et 25 min (pas terminé en 3 min, pas figé après 25)
- [ ] Si terminé en <8 min : variante trop déséquilibrée Covenant
- [ ] Si terminé à 25 min sans tentative de capture : Covenant trop bridé

#### Discipline RP (light)
- [ ] Les joueurs UNSC ont essayé de se coordonner (rôles improvisés : 1 sniper, 1 conducteur Warthog, etc.)
- [ ] Les Covenant ont tenté un mouvement coordonné (pas full 4 rush central)
- [ ] Pas de team-kill intentionnel (en mode default, FF off, mais on regarde l'attitude)

#### XP rules manuelles
- [ ] Le SL (un volontaire) a noté en post-match : présence min, victoire 1/0, kill notable, comportement RP
- [ ] Les valeurs notées correspondent à ce que la table XP prédirait (cf. [../configs/xp_rewards_unsc.json](../configs/xp_rewards_unsc.json))
- [ ] Personne n'a contesté l'attribution

### Critère de validation Test 3
- ✅ 80%+ ✅, équilibrage tient → passer Test 4
- ⚠️ Équilibrage très en faveur d'un camp (>70/30) → ajuster traits dans variante avant Test 4 (passer à `sentinel_defense_v1` qui a les player traits)
- ❌ Bug technique majeur (déco massive, spawn cassé) → diagnostic + correction

---

## Test 4 — Full scale (12 vs 4)

### Objectif
Valider la cible MVP : Op à 16 joueurs sur la variante de production complète.

### Setup
- 12 UNSC vs 4 Covenant
- **Variante : sentinel_defense_v1** (la version avec player traits, loadouts custom — voir [../variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md))
- Briefing complet 15 min en Discord
- Roles assignés (1 SL, 1 Marksman, 1 driver Warthog, etc.)
- Discord vocal séparé par squad
- Debriefing 15 min post-match

### Checklist

#### Tout ce qui est dans Test 3
*(à revérifier à l'échelle 16)*

#### Spécifique 12v4
- [ ] 12 UNSC ne se gênent pas dans le FOB (pas de queue dans le bunker)
- [ ] 4 Covenant peuvent se faufiler sans être instantanément spotted (asymétrie tient)
- [ ] Player traits asymétriques visibles (Covenant plus rapide, UNSC plus résistant)
- [ ] Loadouts custom appliqués (Marksman a DMR, Saboteur a Active Camo, etc.)

#### Discipline RP
- [ ] Communications IC respectées (callsigns utilisés sur 80% du vocal)
- [ ] Squad Leader donne des ordres tactiques cohérents
- [ ] Pas de hors-sujet pendant le match
- [ ] Pseudos conformes en jeu (`[GRADE] Callsign`)

#### XP & sheet
- [ ] SL produit le rapport `MatchResults` dans les 24h
- [ ] Tous les XP estimés sont dans la fourchette [0 ; 600]
- [ ] Le système niveau / rang est expliqué et compris (joueurs ne demandent pas "pourquoi j'ai pas été promu si j'ai gagné ?")
- [ ] Le Field Commander (ou substitut) signe les éventuelles promotions

#### Équilibrage cible
- [ ] **Outcome** : ni UNSC ni Covenant ne wipe l'autre. Match disputé sur 5 dernières minutes.
- [ ] **Ratio victoire cible (cumulatif sur 5 sessions)** : Covenant 35-55%, UNSC 45-65%
- [ ] Si la 1ère session est ratio 100/0, c'est OK pour cette session unique. C'est sur la moyenne 5 sessions qu'on juge.

#### Réseau & technique
- [ ] Aucune déco massive
- [ ] Latence acceptable (host avec NAT Open, pas Wi-Fi instable)
- [ ] FPS host stable (>60 fps)
- [ ] Pas de crash MCC

### Critère de validation Test 4
- ✅ 80%+ ✅, communauté satisfaite (sondage rapide post-Op) → **MVP validé, ouverture publique**
- ⚠️ Quelques problèmes mineurs → corriger sur 1-2 sessions, valider sur la 3e
- ❌ Communauté insatisfaite ou bug majeur → diagnostic, possiblement extension Sprint 1 de 2 semaines

---

## Reporting

Pour chaque test, produire un **rapport court** dans `#bugs-feedback` Discord :

```
TEST {1/2/3/4} — {date}
Participants : {nb}
Durée : {min}
Outcome : {UNSC / COV / forfait / N/A}

VALIDATIONS :
✅ {liste cases cochées qui valident}

ISSUES BLOQUANTES :
❌ {liste cases ❌}

NOTES QUALITATIVES :
- {retour 1}
- {retour 2}

DÉCISION :
[✅ pass | ⚠️ fix-then-retry | ❌ block]

ACTION ITEMS :
- {action 1}
- {action 2}
```

---

## Que faire si Test bloque

| Test bloqué | Action immédiate |
|---|---|
| Test 1 | Retour Forge, corrige issue, retest dans la session |
| Test 2 | Si bug variante : refaire la variante stock. Si bug map : retour Phase Forge concernée |
| Test 3 | Souvent issue d'équilibrage / spawn → ajuster, ne pas avancer en Test 4 sans réussite |
| Test 4 | Si échec : pas de drame, c'est l'objet du test. Itérer 1 semaine sur 2 sessions test, puis re-valider |

---

## Voir aussi

- [07_test_checklist.md](07_test_checklist.md) — plan de test global du Sprint 1 (cadre plus large)
- [../forge_maps/fob_alpha/build_guide.md](../forge_maps/fob_alpha/build_guide.md) — guide construction
- [../variants/sentinel_defense_test/spec.md](../variants/sentinel_defense_test/spec.md) — variante de test
- [../variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md) — variante de production
