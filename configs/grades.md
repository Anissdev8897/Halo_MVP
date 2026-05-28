# Grades — Hiérarchie militaire

Chaque faction a 6 grades. **Les grades sont attribués MANUELLEMENT par les chefs de faction** (voir [faction_leadership.json](faction_leadership.json) et [promotion_rules.json](promotion_rules.json)).

> ⚠️ **Le grade ≠ le niveau.** Le niveau (level) est automatique et indique l'activité. Le grade est manuel et indique la confiance hiérarchique. Les seuils d'XP / niveau ci-dessous sont **recommandés**, pas conditionnels. Voir [../documentation/leveling_vs_rank.md](../documentation/leveling_vs_rank.md) pour le détail.

---

## 🪖 UNSC — Grades

| # | Grade | Abrév. | Niveau recommandé | XP recommandée | Effectif max actif | Rôle in-game |
|---|---|---|---|---|---|---|
| 1 | **Recruit** | RCT | 1 | 0 | illimité | Recrue, suit ordres, loadouts de base |
| 2 | **Private** | PVT | 2+ | 200+ | illimité | Soldat aguerri, loadouts standards UNSC |
| 3 | **Corporal** | CPL | 5+ | 1 280+ | illimité | Sous-officier, fire-team leader éligible, accès véhicules légers |
| 4 | **Sergeant** | SGT | 10+ | 4 680+ | 8 max | **Squad Leader éligible**, accès armes spéciales, donne ordres |
| 5 | **Lieutenant** | LT | 20+ | 15 800+ | 4 max | **Officier / Battalion Commander éligible**, commande 2 squads |
| 6 | **Captain** | CPT | 30+ | 29 100+ | 2 max | **Commandant d'Op / Field Commander éligible**, planifie missions |

### Conditions de promotion supplémentaires (UNSC)

Voir [promotion_rules.json](promotion_rules.json) pour la spec complète. Synthèse :

- **Recruit → Private** : 1 Op + lecture RP rules. Validée par Fire Team Cmdr+.
- **Private → Corporal** : 5 Ops + 1 mission FTL. Validée par Battalion Cmdr+.
- **Corporal → Sergeant** : 10 Ops + recommandation LT/CPT. Validée par Battalion Cmdr+.
- **Sergeant → Lieutenant** : 20 Ops + 5 Ops SL + vote 2 LT/CPT. Validée par Field Commander.
- **Lieutenant → Captain** : 40 Ops + 10 Ops SL + vote unanime Command Staff. Validée par Field Commander + Command Staff.
- **Cooldown 14 jours minimum** entre deux promotions du même joueur.

> ⚠️ Toutes les promotions sont **manuelles**. Atteindre les conditions chiffrées ne déclenche AUCUN automatisme. C'est le chef de faction qui décide.

---

## 👽 Covenant — Grades (Sangheili / Élites)

| # | Grade | Abrév. | Niveau recommandé | XP recommandée | Effectif max actif | Rôle in-game |
|---|---|---|---|---|---|---|
| 1 | **Minor** | MIN | 1 | 0 | illimité | Élite Mineur, loadouts de base Covenant (Plasma Rifle) |
| 2 | **Major** | MAJ | 2+ | 200+ | illimité | Élite Major, accès Needler, Plasma Repeater |
| 3 | **Ultra** | ULT | 5+ | 1 280+ | illimité | Élite Ultra, accès armes lourdes, peut diriger un Strike Team |
| 4 | **Spec Ops Officer** | SOO | 10+ | 4 680+ | 6 max | **Strike Team Leader**, Active Camo, Energy Sword |
| 5 | **Zealot** | ZLT | 22+ | 18 280+ | 3 max | **Officier zélote / Council Zealot éligible** |
| 6 | **Field Marshal** | FMR | 35+ | 36 240+ | 1 max | **Chef de l'invasion / High Council Member éligible** |

### Conditions de promotion supplémentaires (Covenant)

Voir [promotion_rules.json](promotion_rules.json) pour la spec complète. Synthèse :

- **Minor → Major** : 1 Op + cérémonie d'engagement. Validée par STL+.
- **Major → Ultra** : 5 Ops + 1 kill notable. Validée par Council Zealot+.
- **Ultra → Spec Ops Officer** : 10 Ops + 2 missions infiltration + parrainage Zealot. Validée par Council Zealot+.
- **Spec Ops Officer → Zealot** : 22 Ops + 6 victoires STL + serment. Validée par High Council Member.
- **Zealot → Field Marshal** : 45 Ops + dominance martiale + vote unanime Council. Validée par High Council Member + Command Staff.
- **Cooldown 14 jours min**.

> ⚠️ Toutes les promotions sont **manuelles**. Le High Council Member décide en dernier ressort.

---

## Quotas effectifs — pourquoi c'est plafonné

Les grades supérieurs sont **rares** par design pour préserver l'autorité. Si le quota est plein :
- Le candidat reste sur la "promotion list" jusqu'à libération d'un slot
- Libération possible par : départ, transfert de faction, sanction disciplinaire, inactivité (>60 jours)

Cette mécanique force aussi de la **rotation** entre joueurs actifs et préserve l'élitisme RP.

---

## Synchronisation Discord

Le grade Discord doit toujours correspondre au grade in-game. La mise à jour est faite **manuellement** par le Command Staff chaque lundi soir, après revue des sessions de la semaine.

Pseudo Discord obligatoire : `[ABRÉV] CallsignNom`
- Exemple UNSC : `[CPL] Hawk-Reed`
- Exemple Covenant : `[MAJ] Vor 'Tarosee`

---

## Sanctions

| Faute | Sanction |
|---|---|
| Pseudo non conforme | Avertissement, kick si récidive 7 jours |
| Team-kill intentionnel | −200 XP + interdiction Op suivante |
| AFK > 50% d'une Op | XP de la session = 0 |
| Insubordination grossière | Rétrogradation 1 grade |
| Méta-gaming Discord (vocal autre squad) | XP × 0.5 sur la session |
| Triche / exploit | Ban communauté |

---

## Voir aussi

- [factions.md](factions.md)
- [divisions.md](divisions.md)
- [leveling.json](leveling.json) — système de niveau (auto)
- [promotion_rules.json](promotion_rules.json) — règles de promotion (manuelles)
- [faction_leadership.json](faction_leadership.json) — chefs de faction
- [xp_system.md](xp_system.md) — détail du calcul d'XP
- [roles.md](roles.md) — rôles in-game accessibles par grade
- [../documentation/leveling_vs_rank.md](../documentation/leveling_vs_rank.md) — la séparation niveau / grade
- [../documentation/faction_leader_rules.md](../documentation/faction_leader_rules.md) — règles des chefs de faction
