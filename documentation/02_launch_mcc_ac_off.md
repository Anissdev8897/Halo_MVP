# Lancer MCC en mode Anti-Cheat OFF

Toutes les sessions HaloRP utilisent le **mode Anti-Cheat OFF**, prévu officiellement par 343 Industries pour les mods.

> **Important** : ce mode n'est **pas** un bypass. C'est un mode officiel, fourni avec MCC, qui désactive EAC pour permettre les mods. Il interdit en contrepartie l'accès au matchmaking et à la progression de compte officiel. C'est le bon mode pour HaloRP.

---

## Ce que fait le mode AC OFF

| Aspect | AC ON (défaut) | AC OFF (mod mode) |
|---|---|---|
| EasyAntiCheat chargé | ✅ | ❌ |
| Matchmaking officiel | ✅ | ❌ |
| Progression compte officiel | ✅ | ❌ |
| Custom Games | ✅ | ✅ |
| Forge | ✅ | ✅ |
| Custom maps / variantes mods | ❌ | ✅ |
| Steam invites | ✅ | ✅ |
| LAN | ✅ | ✅ |

---

## Procédure (Steam — la voie standard)

### Étape 1 — Lancer MCC

1. Ouvre **Steam** → bibliothèque
2. Clique-droit sur **"Halo: The Master Chief Collection"** → **Jouer**

### Étape 2 — Le launcher MCC apparaît

C'est la fenêtre 343i qui apparaît avant le jeu. Tu y trouveras un sélecteur de mode.

### Étape 3 — Choisir le mode AC OFF

Selon la version de MCC, l'option apparaît sous l'un de ces noms (les versions récentes l'ont placée dans un onglet) :
- **"Disable Anti-Cheat"**
- **"Anti-Cheat Disabled Mode"**
- **"Mod Mode"**
- Onglet **"Mods"** avec checkbox

Coche / clique sur l'option, puis **lance le jeu**.

### Étape 4 — Confirmation

Au démarrage de MCC en mode AC OFF, un **bandeau visible** indique l'état :
- "Anti-Cheat is disabled" ou bandeau rouge en haut/bas de l'écran
- Dans les menus, certaines options de matchmaking sont **grisées** (c'est normal)

→ Tu es prêt pour les Ops.

---

## Procédure alternative (ligne de commande Steam)

Si tu veux scripter le lancement (rare, uniquement pour automation) :

1. Steam → bibliothèque → clic-droit MCC → **Propriétés**
2. Dans **Options de lancement**, ajoute :
   ```
   -anticheatoff
   ```
   ou (selon version)
   ```
   -mods
   ```
3. Lance MCC normalement → il démarre directement en mode AC OFF

> Si l'argument ne fonctionne pas, retire-le et utilise la procédure standard. 343i a changé le flag entre versions.

---

## Erreurs fréquentes

### "Anti-Cheat error" au démarrage
→ Tu as démarré en AC ON par erreur. Quitte MCC, relance via le launcher en cochant AC OFF.

### Pas d'option AC OFF visible
→ Mets MCC à jour (Steam : clic-droit → Updates). L'option a été ajoutée fin 2020.

### Custom Games refuse de charger ma variante mod
→ Tu n'es pas en AC OFF. Vérifie le bandeau au démarrage.

### "Cannot join matchmaking"
→ Normal, désactivé en AC OFF. Pour MM officiel, relance en AC ON.

### Le launcher se relance en boucle
→ Bug occasionnel, redémarrer Steam (pas Windows). Sinon vérifier l'intégrité des fichiers MCC dans Steam.

---

## Revenir en mode AC ON

Pour rejouer du matchmaking officiel après une Op :
1. Quitte MCC
2. Relance via le launcher
3. **Décoche** l'option AC OFF
4. Joue normalement, EAC se rechargera

→ Aucun reset de progression. Les modes sont étanches mais coexistent.

---

## Sécurité du mode AC OFF

Le mode AC OFF :
- ✅ Est **officiel** et documenté par 343i
- ✅ Ne **bannit pas** ton compte (pas de matchmaking → pas de tentative anti-cheat)
- ✅ Ne **modifie pas** tes saves officielles (sandboxées)
- ❌ Mais ne te donne **aucune progression** sur ton compte Halo officiel
- ❌ Ne **partage pas** de stats avec Halo Waypoint

→ HaloRP utilise sa propre persistance (Google Sheet). C'est cohérent.

---

## Voir aussi

- [01_installation.md](01_installation.md)
- [03_host_session.md](03_host_session.md)
- [04_join_session.md](04_join_session.md)
