# Guide Host — Comment lancer une session

Pour les **Operations Officers** désignés comme host d'une Op.

> Le host est la personne dont la machine fait tourner la session P2P. Sa connexion détermine la qualité réseau pour tous. Choisir un bon host est crucial.

---

## Critères pour être host

| Critère | Minimum | Recommandé |
|---|---|---|
| Connexion | 20 Mbps up | 50 Mbps up + filaire |
| NAT | Modéré | **Open** |
| CPU | i5/Ryzen 5 récent | i7/Ryzen 7 |
| RAM | 16 GB | 16+ GB |
| GPU | RTX 1660 / RX 5600 | RTX 3060 / RX 6600 |
| Stabilité | aucun crash récent | testé sur la map de l'Op |
| Rôle Discord | `⚙ Operations Officer` | Operations Officer + Captain en jeu |

→ Pas de host depuis Wi-Fi instable, 4G/5G, ou VPN.

---

## Préparation 24h avant l'Op

### 1. Confirmation rôle host
- Le Command Staff te désigne via DM Discord ou ping dans `#strategic-planning`
- Vérifie ta dispo, confirme par message

### 2. Vérifier le Game Pack
- Télécharge la **dernière version** depuis `#patch-notes`
- Installe (`%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\`)
- Lance MCC en AC OFF
- Vérifie que la map et la variante apparaissent en Custom Games
- **Test rapide solo** : charger la map en solo Forge ou customs vide pour confirmer qu'elle se lance

### 3. Brief le SL
- Coordonne avec le **Squad Leader** désigné de l'Op
- Confirmez l'heure précise de lancement
- Confirmez la composition (qui est dans quelle escouade)

---

## J−1h avant l'Op

### 1. Annonces
Le **Operations Officer** (toi-même ou un autre) poste dans `#xxx-mission-board` :
```
🎯 OP {NOM} | {DATE} {HEURE}
Host : @{ton_pseudo}
Map : {map}
Variante : {variante}
Briefing : {heure de briefing} en vocal {nom du canal}
Lancement : {heure de lancement}
Effectifs : {comp UNSC} vs {comp COV}
Inscriptions : ✅ pour valider
```

### 2. Préparer ton MCC
- Lance MCC en **AC OFF** (vérifier bandeau)
- Va dans **Custom Games** → **Halo Reach**
- Pré-charge la map et la variante (sans lancer le match encore)

---

## J−15min : briefing

1. Tous les inscrits rejoignent le canal vocal **`#unsc-briefing-ops`** ou **`#cov-briefing-ops`**
2. Le **SL** ou **OC** présente :
   - Contexte IC (briefing narratif)
   - Objectifs primaires + secondaires
   - Composition fire-team / strike team
   - Position initiale, RoE
   - Code radio (callsigns, signaux)
3. Questions / clarifications — 5 min max
4. Tous se déplacent dans leur **canal vocal squad** correspondant

---

## J−5min : ouverture du lobby

### 1. Créer le lobby Custom Game
- MCC → **Multiplayer** → **Custom Games** → **Halo Reach**
- **Charger la variante** : sélectionne `sentinel_defense_v1` (ou nom de la variante)
- **Charger la map** : sélectionne `fob_alpha` (ou nom de la map)
- Confirmer settings (effectif, équipes UNSC/Covenant)

### 2. Régler le lobby
- **Privacy** : `Friends Only` (recommandé pour MVP) ou `Invite Only`
- **Teams** : UNSC = Defender, Covenant = Attacker (ou suivre la spec de la variante)
- **Player slots** : assigne les slots si spécifique

### 3. Inviter les joueurs
- Steam friends list → clic-droit sur chaque participant → **Inviter à jouer**
- Confirmer dans le canal Discord vocal que les invites sont parties
- Les joueurs acceptent dans Steam → ils rejoignent le lobby

> Astuce : avoir la liste écrite des participants à côté de toi pour ne pas en oublier.

---

## J : lancement

### 1. Vérification finale
- Tous les slots remplis ?
- Tous les joueurs sur la bonne équipe ?
- Tous les pseudos conformes (`[GRADE] Callsign`) ?
- Nombre de joueurs attendu confirmé ?

### 2. Démarrer
- Bouton **Start Game**
- Le match charge la map + variante

### 3. Pendant le match
- **Toi (host)** : tu joues normalement, tu n'as PAS de privilège in-game (pas de god mode, pas de teleport)
- **Tu surveilles** : déconnexions, crashes, signalements
- **Tu coupes la game** uniquement en cas d'incident grave (exploit, harcèlement)

---

## Post-match : debriefing

1. **Vocal Discord** rassemblé : tous reviennent dans `#xxx-briefing-ops`
2. **Tour de table 30s par joueur** : impression, frustrations, highlights
3. **SL fait un debrief tactique** : ce qui a marché, ce qui a foiré
4. **Tout le monde retourne** à ses canaux normaux

### Reporting
Le **Squad Leader** remplit l'onglet `MatchResults` du Google Sheet dans les 24h.

Le **host** poste un court rapport dans `#unsc-briefing-ops` ou équivalent :
```
RAPPORT OP {NOM} | {DATE}
Outcome : {UNSC / Covenant / Forfait}
Durée : {min}
Incidents : {liste, ou "RAS"}
Score / objectifs : {résumé}
```

---

## Gestion des incidents

### Joueur déconnecté
- S'il revient en <2 min : on continue
- S'il ne revient pas : le match continue, son XP est calculé prorata temps présent

### Crash du host
- Le match s'arrête. **Tu relances** un nouveau lobby si possible (objectif : <5 min)
- Si trop tard : Op annulée, à reprogrammer

### Comportement abusif
- **Pas de kick in-game arbitraire**. Si problème grave, tu coupes la game et reportes au Command Staff.
- Sanctions = décision du Command Staff post-match.

### Exploit gamebreaking découvert
- Tu coupes la game, tu signales dans `#bugs-feedback`
- Game Pack patché en urgence par les designers

---

## Checklist host avant lancement

- [ ] MCC en mode AC OFF (bandeau confirmé)
- [ ] Game Pack vX.X.X installé et vérifié
- [ ] Connexion stable (filaire, pas de DL/upload en arrière-plan)
- [ ] Discord vocaux fonctionnels
- [ ] Tous les inscrits ont confirmé présence
- [ ] Lobby créé avec bonne variante + bonne map
- [ ] Briefing vocal fait
- [ ] Invites Steam envoyées et acceptées
- [ ] Compositions équipe vérifiées
- [ ] Pseudos conformes

→ Si une case n'est pas cochée, on attend.

---

## Voir aussi

- [02_launch_mcc_ac_off.md](02_launch_mcc_ac_off.md)
- [04_join_session.md](04_join_session.md)
- [05_rp_rules.md](05_rp_rules.md)
- [07_test_checklist.md](07_test_checklist.md)
