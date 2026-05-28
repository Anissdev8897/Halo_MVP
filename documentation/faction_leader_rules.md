# Règles des chefs de faction

Document de référence pour les Field Commanders UNSC et High Council Members Covenant — leur rôle, leurs pouvoirs, leurs devoirs.

---

## Vue d'ensemble

Chaque faction a **un chef** (rôle de leadership occupé par un joueur de grade Captain UNSC ou Field Marshal Covenant). En dessous, plusieurs autorités intermédiaires.

**Important** : ces rôles de leadership s'**ajoutent** au grade, ils ne le remplacent pas. Un Field Commander reste un Captain, plus le rôle. À la fin de son mandat, il redevient simplement Captain.

---

## Hiérarchie de leadership

### UNSC

```
┌────────────────────────────────────┐
│  Command Staff (hors-RP, admin)    │ ← admins community
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  UNSC Field Commander (1 max)      │ ← élu parmi Captains, mandat 3 mois
│  Grade requis : Captain             │
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  UNSC Battalion Commanders (2 max) │ ← désignés, mandat 2 mois
│  Grade requis : Lieutenant         │
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  Fire Team Commanders (per-Op)     │ ← ad hoc par Op
│  Grade requis : Sergeant           │
└────────────────────────────────────┘
```

### Covenant

```
┌────────────────────────────────────┐
│  Command Staff (hors-RP, admin)    │
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  High Council Member (1 max)       │ ← élu parmi Field Marshals, mandat 3 mois
│  Grade requis : Field Marshal       │
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  Council Zealots (2 max)           │ ← désignés, mandat 2 mois
│  Grade requis : Zealot              │
└──────────────┬─────────────────────┘
               │
┌──────────────▼─────────────────────┐
│  Strike Team Leaders (per-Op)      │ ← ad hoc par Op
│  Grade requis : Spec Ops Officer   │
└────────────────────────────────────┘
```

---

## Pouvoirs du chef de faction

### 1. Promotions et rétrogradations

**Pouvoir principal et le plus visible.** Le chef de faction est l'**autorité finale** sur les promotions de sa faction.

#### Ce qu'il peut faire
- Promouvoir un joueur au grade supérieur (selon `promotion_rules.json`)
- Rétrograder un joueur (selon raisons listées)
- Refuser une promotion même si les conditions chiffrées sont remplies
- Promouvoir au-delà des minimums "recommandés" si jugement RP justifié
- Quotas : il peut décider de promouvoir un joueur supplémentaire si quota plein, en exception avec justification

#### Ce qu'il ne peut PAS faire
- Promouvoir au-delà de Captain UNSC / Field Marshal Covenant (cela requiert Command Staff)
- Sauter plus d'un grade en une promotion (Recruit → Sergeant en une fois = interdit, sauf cas exceptionnel validé par Command Staff)
- Promouvoir sans justification écrite dans `PromotionsLog`

### 2. Allocation des points de déploiement IA

Pour les Ops qui supportent les IA (Firefight, Mod Tools custom à terme), le chef de faction décide :
- Combien d'IA déployer
- Quel type d'IA
- Pour quel objectif RP / scénario
- À quel moment de l'événement (si Op multi-phases)

→ Voir [`configs/ai_units_unsc.json`](../configs/ai_units_unsc.json) et [`configs/ai_units_covenant.json`](../configs/ai_units_covenant.json) pour le catalogue.

#### Règle d'équilibrage
Si une faction manque de joueurs (8 au lieu de 12), le chef PEUT déployer des IA pour combler. Mais :
- Il doit le faire **annoncé** publiquement avant l'Op (pas surprise)
- L'autre faction peut demander une compensation symétrique (équilibrage manuel)
- Le Command Staff peut veto si le déséquilibre est jugé injuste

### 3. Validation des transferts de division

Un joueur qui veut changer de division (UNSC : Marines → ODST par exemple) doit avoir :
- 30 jours minimum dans sa division actuelle
- Validation du **chef de faction**
- Si transfert vers division "élite" (SPARTAN-III, Zealot Order, Special Operations Covenant), validation supplémentaire de Battalion Commander / Council Zealot

### 4. Validation des récompenses RP et exploration

- Signe les rapports recon validés (+50 XP pour le joueur qui rapporte)
- Décerne des **badges spéciaux** (cf. plus bas)
- Valide les bonus exploration sur découverte de nouveaux points stratégiques

### 5. Représentation officielle

- Le chef de faction parle au nom de sa faction lors :
  - Des **debriefings cross-faction** (debrief commun post-Op majeure)
  - Des **événements communauté** (annonces patches, votes balance)
  - Des **négociations RP** (cessez-le-feu fictionnel, échange de prisonniers RP, etc.)
- Convoque le **Council UNSC / Conseil Covenant** : réunion hebdomadaire stratégique avec ses Battalion Commanders / Council Zealots

### 6. Veto tactique

- Peut **veto une affectation de Squad Leader** pour une Op (raison : grade insuffisant, comportement passé, incompatibilité avec la mission)
- Peut **réassigner les rôles** in-game si la suggestion du SL ne lui convient pas
- Cette autorité est **rare** et doit être justifiée (pas du caprice)

---

## Devoirs du chef de faction

### 1. Disponibilité

- Présent au moins **1 fois par semaine** dans `#unsc-strategic-planning` ou `#cov-council`
- Réactif aux DMs des joueurs sur questions de promotion / division
- Présent à **au moins 2 Ops majeures par mois** (en tant que joueur, pas spectateur)

### 2. Logging et transparence

- **Toute promotion** loggée dans Onglet `PromotionsLog` Google Sheet avec signature + raison
- **Toute rétrogradation** loggée + raison + appel possible
- **Toute allocation IA** annoncée dans le canal Op concerné

### 3. Encadrement des intermédiaires

- Forme et soutient ses Battalion Commanders / Council Zealots
- Délègue les promotions de bas niveau aux intermédiaires (Recruit → Private = pas son problème)
- Intervient seulement aux décisions importantes (Sergeant+, transferts élite, ban à recommander)

### 4. Équilibrage RP

- Ne favorise pas les amis (audit log → Command Staff peut sanctionner)
- Considère le bien collectif de la faction avant les égos individuels
- Fait remonter les déséquilibres au Command Staff (proposition de patch balance)

---

## Sanctions possibles contre un chef de faction

Le chef de faction n'est pas au-dessus des règles.

| Faute | Sanction |
|---|---|
| Promotion injustifiée | Annulation par Command Staff + warning |
| Favoritisme prouvé | Démission demandée, ou révocation par vote |
| Abus de pouvoir (refus systématique de promotions méritées) | Révocation immédiate par Command Staff |
| Insulte à un joueur | Sanction standard (cf. RP rules) |
| Inactivité > 30 jours | Démission auto, nouveau chef élu |

### Procédure de révocation

1. Plainte adressée au Command Staff (DM ou ticket)
2. Investigation : revue audit log + interview
3. Si justifiée : Command Staff peut révoquer immédiatement, élection anticipée
4. Si non-justifiée : warning au plaignant pour signal infondé

---

## Élection / désignation des chefs

### UNSC Field Commander
- **Quand** : tous les 3 mois OU sur démission/révocation
- **Comment** : vote du Command Staff parmi les Captains actifs
- **Critères** : ancienneté, qualité de leadership en Op, consensus communautaire
- **Renouvellement** : possible illimité

### Covenant High Council Member
- **Quand** : tous les 3 mois OU sur démission/révocation
- **Comment** : vote unanime des Zealots actifs (le Command Staff arbitre si désaccord)
- **Critères** : prouesse martiale, cérémonialité RP, consensus Zealot

### Battalion Commanders / Council Zealots
- **Quand** : désignés par le chef de faction, mandat 2 mois renouvelable
- **Comment** : décision discrétionnaire du chef de faction
- **Critères** : confiance personnelle, complémentarité tactique

---

## Outils du chef de faction

### Google Sheet
- Accès écriture sur `Roster`, `MatchResults`, `PromotionsLog`
- Vue d'ensemble des XP cumulés, des sessions par joueur

### Discord
- Modération sur canaux `#unsc-*` ou `#cov-*`
- Création de canaux d'Op via Operations Officer
- Annonces dans `#annonces` (avec accord Command Staff)

### Récompenses spéciales

Le chef de faction peut décerner :

| Badge / Récompense | Effet | Fréquence |
|---|---|---|
| **🎖 Distinguished Service Cross** (UNSC) / **Sword of Honor** (Covenant) | Badge Discord + +200 XP | rare, max 1× par mois |
| **Letter of Commendation** | Badge Discord + +100 XP | régulier, max 1×/joueur/mois |
| **Combat Action Ribbon** | Badge Discord + +50 XP | post-Op exceptionnelle |
| **Veteran Badge** | Badge Discord (atteint level 50) | unique par joueur |

---

## Voir aussi

- [../configs/faction_leadership.json](../configs/faction_leadership.json)
- [../configs/promotion_rules.json](../configs/promotion_rules.json)
- [../configs/grades.md](../configs/grades.md)
- [leveling_vs_rank.md](leveling_vs_rank.md)
- [05_rp_rules.md](05_rp_rules.md)
