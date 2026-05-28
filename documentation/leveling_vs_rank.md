# Niveau vs Rang militaire

Document central du système de progression HaloRP. À lire avant toute promotion ou candidature à un rôle de commandement.

---

## Le principe en une phrase

> **Le niveau prouve ton activité. Le rang prouve la confiance qu'on te donne.**

Les deux **ne sont pas liés mécaniquement**. Tu peux avoir un niveau très haut et un rang très bas. L'inverse est aussi possible (rare).

---

## Définitions

### Niveau (level)
- **Automatique** : calculé depuis ton XP cumulée dans la Google Sheet
- **Indépendant** de ton grade militaire
- **Ne diminue pas** : une fois acquis, conservé
- **Indique** : ton activité, ton expérience cumulée, ta participation
- **Débloque** : des rôles in-game spécifiques (Sniper, Heavy, Saboteur…) en COMBINAISON avec ton grade
- **Échelle** : 1 à 50, distribué en tiers Bronze/Silver/Gold/Platinum/Diamond/Onyx
- **Source de référence** : [`configs/leveling.json`](../configs/leveling.json)

### Rang militaire (rank / grade)
- **Manuel** : attribué uniquement par les chefs de faction
- **Indépendant** du niveau (pas de seuil automatique de niveau qui te promeut)
- **Peut diminuer** : rétrogradation possible sur sanction
- **Indique** : la confiance qu'on te donne, ton autorité dans la chaîne de commandement
- **Donne** : l'autorité de donner des ordres, l'accès à des rôles de commandement, la signature des récompenses RP
- **Échelle UNSC** : Recruit → Captain (6 grades)
- **Échelle Covenant** : Minor → Field Marshal (6 grades)
- **Source de référence** : [`configs/grades.md`](../configs/grades.md), [`configs/promotion_rules.json`](../configs/promotion_rules.json)

---

## Pourquoi cette séparation ?

### Le problème qu'on évite
Si grade = niveau automatique, tu obtiens des "Captains" qui sont juste des grinders sans aucune compétence RP, leadership ou jugement tactique. Toxique pour la communauté.

### Ce qu'on gagne avec la séparation
1. **Le niveau motive le grind individuel** sans corrompre la chaîne de commandement
2. **Le rang reste un signal social fort** : un Captain a été *choisi*, pas *automatisé*
3. **Les chefs de faction gardent leur autorité** sur la composition de leur faction
4. **Les joueurs peu actifs mais excellents en RP/leadership** peuvent monter en grade sans grinder
5. **Les joueurs très actifs mais moins matures** peuvent satisfaire leur ambition via le niveau sans bloquer la hiérarchie

---

## Trois scénarios pour comprendre

### Scénario A — "Le grinder respecté"
- Joueur **niveau 25** (très actif)
- Grade **Recruit**
- **Pourquoi ?** Il joue beaucoup mais préfère le combat individuel, pas le leadership. Il décline les promotions ou n'a pas validé les conditions RP.
- **Acceptable ?** ✅ Oui. Il accumule de l'XP, débloque des rôles in-game (Sniper, Heavy), et reste utile en première ligne.
- **Bloquage potentiel** : il ne pourra jamais accéder aux rôles Squad Leader / Operation Commander tant qu'il n'aura pas Sergeant+. Et c'est sain — leadership = confiance manuelle.

### Scénario B — "L'officier rapide"
- Joueur **niveau 8** (peu actif)
- Grade **Sergeant**
- **Pourquoi ?** Excellent jugement tactique observé sur ses 5 premières Ops. Le Battalion Commander a vu son potentiel de leader et l'a promu rapidement.
- **Acceptable ?** ✅ Oui. La promotion est manuelle, le niveau ne bloque pas.
- **Bloquage potentiel** : à grade Sergeant, le rôle Sniper exige aussi niveau 10 (intersection). Donc il ne peut pas prendre Sniper malgré son grade. Il devra grind un peu pour le débloquer.

### Scénario C — "Le hyperactif sanctionné"
- Joueur **niveau 50** (top farmer)
- Grade **Recruit** (rétrogradé)
- **Pourquoi ?** Comportemental problématique malgré l'activité. Le Field Commander a refusé toute promotion ou l'a rétrogradé suite à un incident.
- **Acceptable ?** ✅ Oui. Le niveau ne lui donne aucun droit. Il peut continuer à jouer mais sans autorité.
- **Évolution possible** : si comportement s'améliore sur 60 jours, le chef de faction peut envisager une réintégration progressive.

---

## Intersection : déblocage des rôles in-game

Un rôle in-game (Sniper, Heavy, Saboteur, etc.) requiert **DEUX conditions simultanées** :

```
rôle_accessible = (level >= level_min_role) ET (grade >= grade_min_role)
```

### Exemple : rôle "Sniper"
- `level_min_role` = 10
- `grade_min_role` = Corporal

| Joueur | Level | Grade | Sniper accessible ? |
|---|---|---|---|
| A | 25 | Recruit | ❌ (grade insuffisant) |
| B | 8 | Sergeant | ❌ (level insuffisant) |
| C | 12 | Corporal | ✅ |
| D | 30 | Captain | ✅ |

### Pourquoi cette double barrière ?

- **Level** garantit que le joueur sait jouer (a accumulé l'expérience pour utiliser le rôle correctement)
- **Grade** garantit que le joueur a la confiance pour le rôle (pas un bleu qui prend le seul Sniper de l'équipe)

---

## Tableau de référence rapide

### UNSC

| Grade | XP recommandée min | Niveau recommandé min | Promotion par |
|---|---|---|---|
| Recruit | 0 | 1 | (entrée) |
| Private | 200 | 2 | Fire Team Cmdr+ |
| Corporal | 1280 | 5 | Battalion Cmdr+ |
| Sergeant | 4680 | 10 | Battalion Cmdr+ |
| Lieutenant | 15800 | 20 | Field Commander |
| Captain | 29100 | 30 | Field Cmdr + Command Staff (unanime) |

### Covenant

| Grade | XP recommandée min | Niveau recommandé min | Promotion par |
|---|---|---|---|
| Minor | 0 | 1 | (entrée) |
| Major | 200 | 2 | Strike Team Leader+ |
| Ultra | 1280 | 5 | Council Zealot+ |
| Spec Ops Officer | 4680 | 10 | Council Zealot+ |
| Zealot | 18280 | 22 | High Council Member |
| Field Marshal | 36240 | 35 | High Council + Command Staff (unanime) |

> Ces niveaux/XP sont **recommandés**, pas conditionnels. Un chef de faction peut promouvoir avant ou refuser après.

---

## Que se passe-t-il quand je level up ?

Au franchissement d'un seuil de niveau (cf. [`configs/leveling.json`](../configs/leveling.json)) :

1. La cellule du Roster Google Sheet recalcule ton niveau (formule auto)
2. Si le niveau t'a fait passer un tier (Bronze → Silver, etc.), un Operations Officer poste un message dans `#unsc-quartier-général` ou `#cov-cellule-mère` :
   > *"[CPL] Hawk-Reed atteint le niveau 10 (Silver tier). Rôles Sniper et Pilot Warthog désormais accessibles si grade le permet."*
3. **Aucun changement de grade automatique.** Si tu veux monter en grade, tu en parles à ton Battalion Commander.

---

## Que se passe-t-il quand on me promeut ?

1. Un chef de faction (selon le niveau de promotion) initie la procédure
2. Décision validée par les autorités requises (cf. [`configs/promotion_rules.json`](../configs/promotion_rules.json))
3. Inscription dans Onglet 4 `PromotionsLog` du Google Sheet (avec signature)
4. Le rôle Discord est mis à jour (lundi soir, batch hebdomadaire par Command Staff)
5. Annonce officielle dans `#annonces` :
   > *"Promotion : [PVT] Hawk-Reed → [CPL] Hawk-Reed. Validé par [LT] Reed-117. Félicitations Caporal."*

---

## Voir aussi

- [../configs/leveling.json](../configs/leveling.json) — table des niveaux
- [../configs/grades.md](../configs/grades.md) — table des grades
- [../configs/promotion_rules.json](../configs/promotion_rules.json) — règles de promotion
- [../configs/xp_rewards_unsc.json](../configs/xp_rewards_unsc.json)
- [../configs/xp_rewards_covenant.json](../configs/xp_rewards_covenant.json)
- [faction_leader_rules.md](faction_leader_rules.md)
