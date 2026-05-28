# IA & PNJ — Ce qui est possible (et ce qui ne l'est pas)

Document technique sur les options IA / PNJ disponibles dans Halo Reach (MCC) pour le MVP HaloRP.

---

## TL;DR

- ❌ **Forge Reach n'autorise PAS le placement libre d'IA.** C'est une absence du jeu, jamais corrigée par 343i.
- ✅ **Firefight Reach** propose des **vagues d'IA Covenant scriptées** (Grunts, Jackals, Élites, Hunters, Brutes), entièrement paramétrables via les Custom Game Settings.
- ✅ **Campagne Halo Reach co-op** propose des **PNJ humains UNSC** (Marines, ONI, Noble Team) et des **ennemis Covenant** scriptés par mission.
- ⚠️ **Mod Tools 343i** permettent de modifier les comportements IA dans des `.map` custom, mais c'est **complexe**, demande une équipe spécialisée (3–6 mois de travail), et reste expérimental sur Reach MCC.

---

## 1. Forge classique : pas d'IA

### État
Forge Reach (in-MCC) hérite de Forge 2010. **Aucun outil de placement d'IA**, contrairement à Halo CE (avec AI dans Sapien) ou Halo Infinite (Forge IA récent).

### Ce que tu peux faire en Forge
- Placer **objets** (murs, sols, scenery)
- Placer **spawns joueurs** (par équipe, par label)
- Placer **véhicules** (avec respawn timer)
- Placer **armes** (avec respawn timer)
- Placer **labels** pour la variante Megalo (`obj_flag`, `obj_extract`, etc.)
- Placer **objets destructibles** (caisses explosives)
- Pas d'IA, pas d'événements scriptés complexes

### Ce que ça implique pour le MVP
- Les Ops type **Sentinel**, **Skirmish**, **Stronghold**, **Invasion** = **PvP humain uniquement** sur maps Forge.
- Pas de "garnison UNSC IA" qui vient en renfort, pas de "hordes Covenant" Forge-spawned.

---

## 2. Firefight Reach : IA officielle paramétrable

### État
**Firefight** est un mode officiel Reach. Jusqu'à **4 joueurs UNSC** affrontent des **vagues d'IA Covenant** générées par le moteur. Les paramètres sont exposés dans le menu Custom Game.

### Ce que tu peux paramétrer
| Paramètre | Range | Effet |
|---|---|---|
| Set count | 1–3 | Nombre de "sets" (un set = 5 vagues) |
| Wave count par round | 1–5 | Nombre de vagues par round |
| Round count par set | 1–3 | Round = mini-cycle de vagues |
| Bonus round | on/off | Round bonus avec récompenses |
| Skulls | nombreux | Modificateurs de difficulté (Iron, Famine, Tilt, Mythic, etc.) |
| Spawn order | ordered / random | Ordre des escouades Covenant |
| Squad lists | éditable | Choix des escouades Covenant qui apparaissent |
| Loadouts UNSC | éditable | 5 loadouts custom |
| Lives | 0–∞ | Vies disponibles |

### Squads Covenant disponibles
- Grunts (lances de Grunts)
- Jackals
- Skirmishers
- Élites Minor / Major / Ultra
- Hunters (en paire)
- Brutes (post-DLC) — selon la map
- Mix d'escouades pré-définies

### Maps Firefight officielles
Beachhead, Corvette, Courtyard, Outpost, Overlook, Waterfront, Holdout, Glacier (+ DLC).

### Adéquation HaloRP
✅ **Idéal pour Op type "Firefight" / Patrouille PvE**
- 4 UNSC humains formant une fire team
- Vagues Covenant simulent une attaque inattendue lors d'une patrouille
- Bon pour formation des recrues
- Bon pour entraînement tactique
- Permet du RP "patrouille de routine qui dégénère"

⚠️ **Limites**
- 4 joueurs max (pas 12 ni 16)
- Pas de joueurs Covenant simultanés
- Pas modifiable au-delà des sliders Custom Game (sans Mod Tools)

---

## 3. Campagne Reach : IA scriptée par mission

### État
La campagne Reach (8 missions) est jouable en **co-op 4 joueurs**. Toutes les IA (UNSC alliés et Covenant ennemis) sont **scriptées dans la map de campagne**, immuables.

### Ce que tu peux faire avec ça en RP
- **"Reliving the fall of Reach"** : faire une Op type "campaign run" où 4 joueurs jouent une mission canon avec contraintes RP (ex: "Long Night of Solace" en RP intégral)
- **PNJ disponibles** : Noble Team (alliés), Marines, ONI personnel, civils
- **Ennemis** : full roster Covenant + parfois Sentinels

### Adéquation HaloRP
🟡 **Possible mais hors MVP v0.1**
- Demande un encadrement RP fort (les missions sont linéaires, donc le RP doit s'adapter au flow scripté)
- Bon pour Ops "narratives" / "spéciales" (1×/mois max)
- À planifier en Sprint 4+

---

## 4. Mod Tools : modifications IA avancées

### État
Les **Halo MCC Mod Tools** (Steam, gratuit) permettent de :
- Éditer les `.map` campagne / firefight
- Modifier les **scénarios** (placement d'IA, scripts HSC, événements)
- Recompiler en `.map` custom

### Ce que ça permettrait
- Une **map Forge-like avec IA** (placement manuel d'IA Covenant ou UNSC)
- Des **patrouilles PNJ** scénarisées
- Des **objectifs hybrides PvE/PvP** dans la même session

### Pourquoi c'est hors MVP
- Courbe d'apprentissage Mod Tools : 2–3 mois pour un dev
- Les outils Reach sont moins matures que Halo CE / 2 / 3 (Reach a été ajouté à MCC en 2019, modding plus récent)
- Risque de Game Pack lourd à distribuer
- 0 communauté de référence pour les questions techniques

### Quand y revenir ?
**Sprint 5+ (semaine 16+)**, si la communauté est saine et stable. Avant ça, on s'en passe.

---

## 5. PNJ "humains" via RP convention

Sans IA technique, on peut quand même avoir des **PNJ par convention RP** :

### Exemple : "Le commandant" qui briefe via Discord
- Le Captain UNSC (Operations Commander) joue le rôle d'**ONI HQ** dans le briefing
- Il donne les ordres en RP, mais ne participe pas au match
- Présent uniquement en Discord vocal

### Exemple : "Civils en évacuation"
- Quelques joueurs UNSC bas-grade peuvent RP comme **escortés civils** (loadouts faibles, rôle "protégé")
- Le SL doit les ramener sains et saufs en zone d'extraction
- Ce n'est pas vraiment des PNJ — c'est du RP "joueur incarne un rôle non-combatant"

### Exemple : "Officier ennemi en visioconf"
- Lors d'un debriefing, le **Field Marshal Covenant** peut envoyer un "défi" en vocal Discord cross-faction
- Ajoute du flavor narratif

→ **Tout cela est faisable dès le MVP v0.1**, sans aucune modif technique. C'est juste de la mise en scène par les joueurs.

---

## Synthèse des options IA pour HaloRP MVP

| Source d'IA | Disponible MVP v0.1 ? | Effort | Op type compatible |
|---|---|---|---|
| Forge AI | ❌ impossible | n/a | aucun |
| Firefight stock | ✅ oui | 0 effort | **Op type Firefight** |
| Campagne co-op | 🟡 oui (RP-only) | encadrement RP fort | Op spéciale rare |
| Mod Tools custom IA | ❌ hors MVP | 2–3 mois dev | sprint 5+ |
| PNJ par convention RP | ✅ oui | 0 effort | toutes Ops |

---

## Recommandation MVP

### Sprint 1 (semaines 1–4)
- **Pas d'IA technique.** PvP pur sur Op Sentinel.
- **PNJ par convention RP** : utilisé via Discord (commandant briefe, civils RP, etc.)

### Sprint 2 (semaines 5–8)
- **Ajouter Op type Firefight** pour les patrouilles PvE
- Maps : Outpost, Overlook (les deux les plus "Op militaire" thématiquement)

### Sprint 3+ (semaines 9+)
- **Op type "Campaign Run"** mensuelle (co-op campagne avec encadrement RP)

### Sprint 5+ (semaines 16+)
- **Évaluer Mod Tools** si une équipe technique se constitue
- Pas avant — ça représente 2–3 mois de dev pour un retour incertain

---

## Voir aussi

- [../configs/operations_types.md](../configs/operations_types.md)
- [../configs/maps_catalog.md](../configs/maps_catalog.md)
- [../variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)
