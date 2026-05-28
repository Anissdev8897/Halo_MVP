# Vision du projet

## Pitch

**HaloRP** est un framework Military RP communautaire bâti sur **Halo: The Master Chief Collection** (Halo Reach prioritairement), où les joueurs incarnent des soldats UNSC ou des guerriers Covenant pendant la chute de Reach.

Pas un nouveau jeu. Pas une copie de FiveM. Pas une recréation Unreal.

Une **plateforme RP** qui exploite **Halo MCC déjà installé légalement** par chaque joueur, organise des **Operations militaires** (12–16 joueurs en sessions custom), et persiste les grades/XP/factions via Discord + Google Sheet.

---

## Ce que ce projet est

- ✅ Un framework de règles RP, fiches de mission, designs de cartes Forge, configurations de variantes
- ✅ Une communauté Discord structurée avec hiérarchie militaire stricte
- ✅ Des Game Packs (variantes Custom Game + maps Forge custom) **construits avec les outils 343i officiels**
- ✅ Un projet **gratuit, non-commercial**, partagé en CC-BY-NC

## Ce que ce projet n'est PAS

- ❌ Un jeu standalone (les joueurs lancent Halo MCC)
- ❌ Un mod qui injecte du code dans MCC
- ❌ Une plateforme avec backend / VPS au démarrage
- ❌ Un projet qui contourne EAC ou modifie l'exécutable
- ❌ Une redistribution d'assets Halo

---

## Principes directeurs

1. **Chaque joueur possède MCC légalement.** Pas d'exception.
2. **Mode AC OFF officiel** uniquement. Pas de bypass.
3. **Mod Tools 343i** uniquement pour les modifications de tags/cartes.
4. **Commencer minuscule** — première session jouable en 4 semaines.
5. **Le contenu prime sur l'infra** — investir le temps dans les Forge maps + Megalo, pas dans un backend.
6. **La communauté avant la plateforme** — 16 joueurs engagés > 0 joueur sur un site magnifique.
7. **Itération rapide** — un patch d'équilibrage par semaine, pas un grand refactor.

---

## Mode B confirmé — pourquoi pas de backend

| Question | Réponse |
|---|---|
| Pourquoi pas de VPS ? | Time-to-MVP de 4 semaines vs 4 mois ; coût 0€ vs 20€/mois ; aucun risque infra |
| Pourquoi pas Unreal ? | On utilise **Halo Reach existant** comme base de gameplay — pas la peine de recréer un FPS sci-fi |
| Comment on persiste alors ? | Google Sheet (XP, grades, roster). Discord pour la coordination. |
| Comment on scale ? | On ne scale pas tout de suite. On valide d'abord à 16. Migration vers Mode A possible plus tard. |

---

## Faction principale & angle narratif

**UNSC vs Covenant** sur **Reach**, chronologie 2552. La planète tombe sous l'invasion. Les forces UNSC en place tentent de tenir des positions clés pendant que l'évacuation civile s'organise. Les Covenant déploient leurs Spec Ops pour saboter l'effort de défense.

Pourquoi ce choix vs Insurrection :
- Asymétrie visuelle native (Spartans bleus vs Élites rouges)
- Mode **Invasion** officiel = scénario asymétrique préfait
- **Firefight** PvE possible (Covenant AI built-in)
- Lore Reach iconique et bien connu

---

## Roadmap globale

### Sprint 1 — Foundations (semaines 1–4)
- Discord créé, règles RP rédigées, Google Sheet en place
- FOB Alpha buildée sur Forge World (1 map)
- Variante Sentinel-Defense v1 configurée
- Game Pack v0.1 publié sur Discord
- 16 testeurs whitelistés
- 2 Ops test internes

### Sprint 2 — Première Op publique (semaines 5–8)
- Ouverture publique limitée (whitelist sur candidature)
- Op Sentinel jouable régulièrement
- 2e map (Op type Skirmish — Powerhouse stock)
- Système de promotions activé

### Sprint 3 — Diversification (semaines 9–12)
- Op type Invasion (Boneyard / Spire) ajouté
- Op type Firefight (PvE entraînement) ajouté
- 2e Forge map custom (Op. Hammer — escorte de convoi)
- 1ère vague de promotions Lieutenant

### Sprint 4+ — Maturité (semaines 13+)
- Variante Megalo custom (Sentinel v2 avec scoring multi-objectifs)
- Op type Stronghold
- Saisons RP / campagne narrative
- Évaluation migration vers Mode A si la communauté > 30 actifs

---

## Critères de succès du MVP (semaine 6)

- ✅ 16 joueurs whitelistés actifs
- ✅ 2 Ops par semaine en moyenne
- ✅ Système de grades fonctionnel (au moins 5 promotions Recruit→Private)
- ✅ FOB Alpha jouable, équilibrée (35–55 % de victoires Covenant sur 5 sessions)
- ✅ 0 incident technique majeur (déco massive, exploit gamebreaking)
- ✅ Discord structuré et actif (≥ 50 messages RP/semaine en `#unsc-comms` ou `#cov-canal-crypté`)

Si ces 6 critères sont atteints en semaine 6 → on entre en Sprint 2.
Si l'un échoue → diagnostic + ajustement + 2 semaines supplémentaires.

---

## Voir aussi

- [../README.md](../README.md)
- [01_installation.md](01_installation.md)
- [05_rp_rules.md](05_rp_rules.md)
- [../configs/factions.md](../configs/factions.md)
