# Checklist de test MVP

Tests à exécuter avant la **première Op publique** (cible : fin Sprint 1, semaine 4).

---

## Test 0 — Validation install (semaine 1)

### Pré-requis
- 1 testeur (mapper ou Operations Officer)
- MCC + Reach installés
- Mod Tools optionnels

### Checks
- [ ] Lancement MCC en AC OFF fonctionne (bandeau visible)
- [ ] Custom Games → Halo Reach accessible
- [ ] Forge accessible avec map de base (Forge World)
- [ ] Pas de crash au démarrage
- [ ] Steam invites fonctionnent (test avec un 2ème compte ami)

### Critère de passage
Tous les checks ✅. Sinon : diagnostic technique avant d'avancer.

---

## Test 1 — Build map FOB Alpha (semaine 2)

### Pré-requis
- 1 mapper
- Spec [forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)

### Checks
- [ ] Map ouverte dans Forge sur Forge World, zone Hemorrhage
- [ ] Périmètre FOB (4 murs + 2 entrées) construit
- [ ] Command Bunker (avec flag stand) construit
- [ ] Sniper Ridge ouest construit avec spawn arme
- [ ] Vehicle road est avec Warthog spawn
- [ ] Generator Hut séparé (sabotage objectif)
- [ ] Extract Point Echo marqué (hill marker)
- [ ] 8 spawn points UNSC posés (label `spawn_def`)
- [ ] 4 spawn points UNSC fallback (label `spawn_def_fb`)
- [ ] 4 spawn points Covenant posés (label `spawn_atk`)
- [ ] Armes posées avec timers (Sniper, Shotgun, Rocket)
- [ ] Véhicules placés (Warthog, Mongoose, Ghost capturé)
- [ ] Map sauvegardée comme `fob_alpha.mvar`
- [ ] Budget Forge < 90% (marge restante pour itérations)

### Critère de passage
Map complète + sauvegardée + chargeable en customs.

---

## Test 2 — Configuration variante Sentinel-Defense (semaine 2)

### Pré-requis
- 1 designer
- Spec [variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)

### Checks
- [ ] Variante créée à partir de One Flag CTF
- [ ] Round time = 25 min, 1 round, 1 capture
- [ ] Player traits asymétriques UNSC vs Covenant entrés
- [ ] 4 loadouts UNSC créés (Rifleman, Marksman, Spec, Heavy)
- [ ] 4 loadouts Covenant créés (Militia/Warrior, Saboteur, Designated, Heavy)
- [ ] Restrictions par grade renseignées
- [ ] Respawn UNSC = 8s, Covenant = 12s
- [ ] Friendly fire OFF
- [ ] Variante sauvegardée comme `sentinel_defense_v1.bin`
- [ ] Test chargement variante + map FOB Alpha → fonctionne

### Critère de passage
Variante chargeable, paramètres conformes spec.

---

## Test 3 — Sightlines & équilibre map (semaine 2-3)

### Pré-requis
- 6–8 testeurs minimum
- 1 host avec Game Pack v0.1 alpha

### Procédure
1. Charger FOB Alpha + Slayer stock (pas la variante Sentinel — neutre pour tester sightlines)
2. Match 4v4 Slayer 10 min
3. Observer :
   - Y a-t-il des angles trop ouverts ?
   - Des spawns trop exposés ?
   - Des zones où les joueurs se perdent ?
   - Le Sniper Ridge est-il dominant au point d'être OP ?

### Checks
- [ ] Aucun spawn vu/tiré dans les 5 secondes après respawn (test 10 morts)
- [ ] Pas de spot "invisible" / hors-map (Forge bug)
- [ ] Sniper Ridge contrebalancé par couvert / contre-position
- [ ] Vehicle road ne permet pas de "drive-by" tout-le-FOB sans risque
- [ ] FPS stable (>60 fps en partie 8v8 alpha) — important pour host

### Critère de passage
3 testeurs sur 4 jugent l'équilibre **acceptable**. Sinon → itération map (v0.1.1).

---

## Test 4 — Op Sentinel grandeur réduite (semaine 3)

### Pré-requis
- 8–10 testeurs (réduction du 12v4 → 8v3 ou 6v3)
- Game Pack v0.1
- Spec briefing prête

### Procédure
1. Briefing complet en vocal Discord
2. Match Sentinel-Defense réduit
3. Suivre **toute la procédure d'une vraie Op** (briefing, vocaux séparés par squad, debriefing)
4. SL prend des notes pour reporting Sheet

### Checks
- [ ] Briefing fluide, compréhensible
- [ ] Vocaux squad fonctionnent (pas de leak vers autres canaux)
- [ ] Match terminé sans crash
- [ ] Outcome reproductible (Insurrection peut gagner, UNSC peut tenir — pas de win automatique)
- [ ] Durée match = 25 min effectifs (ou fin par capture)
- [ ] Système de respawn ne casse pas l'expérience
- [ ] SL a réussi à tracker XP en temps réel
- [ ] Debriefing vocal a eu lieu, retours positifs

### Critère de passage
- Au moins 70% des testeurs trouvent l'expérience "engaging"
- Pas de bug bloquant
- SL valide la faisabilité du tracking XP

---

## Test 5 — Op Sentinel pleine échelle (semaine 4)

### Pré-requis
- 16 testeurs whitelistés (12 UNSC + 4 Covenant)
- Game Pack v0.1.x stabilisé
- Discord structure complète

### Procédure
**Op test grandeur nature**, comme une vraie Op publique. Toute la chaîne :
1. Annonce dans `#unsc-mission-board` 24h avant
2. Inscriptions par réaction ✅
3. Briefing 15 min avant
4. Lobby ouvert 5 min avant
5. Steam invites
6. Match
7. Debriefing
8. SL remplit Sheet sous 24h
9. Lundi soir : Command Staff revue + promotions

### Checks
- [ ] 16/16 inscrits présents à l'heure
- [ ] Tous les pseudos conformes
- [ ] Tous ont le Game Pack v0.1.x
- [ ] Briefing terminé en moins de 12 min
- [ ] Steam invites = 0 raté
- [ ] Lobby plein en moins de 5 min
- [ ] Match jusqu'à fin sans incident
- [ ] Outcome (UNSC ou Covenant) accepté par les deux camps
- [ ] Debriefing serein, retours collectés
- [ ] Sheet rempli sous 24h
- [ ] Promotions traitées le lundi suivant

### Critère de passage
- 80%+ des testeurs satisfaits
- 0 incident technique majeur
- Système RP "tient" (au moins 30 messages IC dans `#unsc-comms` ou `#cov-canal-crypté` durant la semaine)

→ **Si critère atteint : on entre en Sprint 2 (ouverture publique limitée).**

---

## Test 6 — Stress test (semaine 4-5)

### But
Valider que la formule "16 joueurs en P2P" tient quand on n'a pas que des amis proches.

### Procédure
- 2 Ops dans la même semaine, avec 30% de nouveaux joueurs (recrutés via réseau perso étendu)
- Tester différents hosts (3 hosts différents sur 2 sessions)
- Tester par jeudi soir + dimanche après-midi (créneaux différents)

### Checks
- [ ] Au moins 14/16 présents par Op (taux de no-show < 15%)
- [ ] 3 hosts différents testés sans dégradation majeure
- [ ] Aucune déco massive (>3 joueurs simultanément)
- [ ] Pas de "désert ping" (latency >150ms pour <20% des joueurs)

### Critère de passage
2 Ops consécutives sans incident majeur → réseau valide pour ouverture publique.

---

## Tests post-MVP (Sprint 2+)

À planifier mais hors checklist MVP v0.1 :
- Test variante v1.1 si rééquilibrage nécessaire
- Test 2e map (Powerhouse stock pour Op Skirmish)
- Test Firefight comme Op alternative
- Test stabilité multi-hosts sur durée 4 semaines

---

## Reporting des tests

Chaque test doit produire un **rapport court** dans Notion ou Discord `#bugs-feedback` :

```
TEST {N} — {date}
Participants : {nb}
Durée : {min}
Bugs rencontrés :
  - {bug 1}
  - {bug 2}
Retours qualitatifs :
  - {retour SL}
  - {retour joueur 1}
  - {retour joueur 2}
Décision :
  - [✅ pass | ⚠️ retry | ❌ block]
Action items :
  - {action 1}
  - {action 2}
```

---

## Voir aussi

- [00_vision.md](00_vision.md)
- [03_host_session.md](03_host_session.md)
- [04_join_session.md](04_join_session.md)
- [../forge_maps/fob_alpha/design.md](../forge_maps/fob_alpha/design.md)
- [../variants/sentinel_defense_v1/spec.md](../variants/sentinel_defense_v1/spec.md)
