# Système XP

XP gagnée **par session d'Op**, comptabilisée et calculée dans une **Google Sheet partagée** (Mode B — pas de backend).

---

## Formule

```
XP_session = XP_présence + XP_victoire + XP_objectifs + XP_rôle + XP_discipline − XP_pénalités
```

Plafond : `[0 ; 600]` par session.

---

## Composants

### XP de présence
`8 × minutes effectivement présent`
- Op de 25 min → max 200 XP de présence
- Si déco > 5 min : décompte pause (pas de bonus pour ce temps)
- Si déco > 50 % : `XP_session = 0` (anti-AFK)

### XP de victoire
| Issue | XP |
|---|---|
| Faction gagnante | +100 |
| Défaite "honorable" (objectifs secondaires partiels) | +30 |
| Défaite sèche | 0 |
| Forfait du camp adverse | +50 (gain non glorieux) |

### XP d'objectifs secondaires
Voir fiche d'Op pour le détail. Standards :
| Objectif type | XP |
|---|---|
| Sabotage générateur (Op Sentinel) | +75 par membre du camp Covenant |
| Tenir un territoire entier (Op Stronghold) | +50 par défenseur |
| 0 véhicule perdu (UNSC) | +30 par défenseur |
| 5 min sans détection (infiltration Covenant) | +50 par attaquant |
| 0 friendly fire d'équipe | +25 par membre |

### XP de rôle
Voir [roles.md](roles.md) pour la table complète.
| Rôle | XP bonus |
|---|---|
| Operation Commander | +100 |
| Squad Leader / Strike Team Leader | +75 |
| Sniper / Saboteur / Marksman | +30 à +60 |
| Pilot véhicule lourd | +40 |
| Rifleman / Warrior (standard) | 0 |

### XP de discipline
- +50 si **0 violation RP** signalée par le SL
- +25 si **comm radio respectée** (vocal IC, format respecté)
- 0 sinon

### Pénalités
| Faute | XP |
|---|---|
| Team-kill intentionnel | −200 |
| Méta-gaming (vocal autre squad utilisé) | XP × 0.5 |
| AFK > 50 % | XP_session = 0 |
| Insubordination grossière | −100 (+ rétrogradation possible) |
| Insulte dans le chat | −50 |

---

## Bonus spéciaux

### Première Op du joueur
**XP × 1.5** sur sa toute première Op (incite onboarding).

### "MVP" de l'Op
Vote anonyme post-Op (1 par joueur, pas pour soi-même). Le joueur le plus voté gagne **+100 XP**. En cas d'égalité, +50 chacun, max 2 MVPs.

### Streak de présence
Présence à **5 Ops consécutives en 14 jours** → +200 XP bonus (cumulatif possible une seule fois par mois).

### Mentor d'une recrue
Si tu es Sergeant+ et tu mentors un Recruit pendant sa première Op (rôle assigné par le SL), +50 XP.

---

## Structure Google Sheet (rappel)

### Onglet 1 — `Roster`
| Col | Champ |
|---|---|
| A | Discord Tag |
| B | SteamID |
| C | Faction |
| D | Division |
| E | Grade actuel (formule auto) |
| F | XP cumulée (somme onglet 3) |
| G | Score promotion (XP − seuil grade) |
| H | Dernière Op (formule MAX) |
| I | Statut |
| J | Notes |

### Onglet 2 — `Operations`
| Col | Champ |
|---|---|
| A | Op ID |
| B | Date |
| C | Nom |
| D | Type |
| E | Map |
| F | Variante |
| G | Host |
| H | Effectif UNSC |
| I | Effectif Covenant |
| J | Outcome |
| K | Durée |
| L | Lien rapport Discord |

### Onglet 3 — `MatchResults` (saisie SL post-Op)
| Col | Champ |
|---|---|
| A | Op ID |
| B | Discord Tag joueur |
| C | Faction |
| D | Division |
| E | Rôle assigné |
| F | Loadout |
| G | Minutes présent |
| H | Victoire (1/0) auto |
| I | Objectifs sec. (count) |
| J | Discipline OK (1/0) |
| K | Bonus spéciaux (texte) |
| L | Pénalités |
| M | XP final (formule) |

### Onglet 4 — `PromotionsLog`
| Col | Champ |
|---|---|
| A | Date |
| B | Discord Tag |
| C | Faction |
| D | Ancien grade |
| E | Nouveau grade |
| F | XP au moment |
| G | Validé par |
| H | Notes |

---

## Workflow hebdomadaire

| Jour | Étape | Acteur |
|---|---|---|
| Avant Op | Création ligne `Operations` | Ops Officer |
| Pendant Op | Notes | SL |
| Post-Op (≤24h) | Saisie `MatchResults` | SL |
| Lundi soir | Revue + promotions | Command Staff |
| Lundi soir | Sync rôles Discord | Command Staff |
| Lundi soir | Annonce promotions `#annonces` | Command Staff |

---

## Anti-triche / intégrité

- Sheet en **lecture pour tous**, écriture restreinte aux SL et Command Staff
- **Historique Google Drive activé** (rollback possible)
- Promotion sans signature `G` rempli = annulée
- Sanctions sur SL qui falsifie les résultats

---

## Voir aussi

- [grades.md](grades.md)
- [roles.md](roles.md)
- [operations_types.md](operations_types.md)
- [discord_structure.md](discord_structure.md)
