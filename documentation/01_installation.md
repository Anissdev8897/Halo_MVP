# Installation — Pré-requis joueur

Ce qu'il faut installer pour participer à une Op HaloRP.

---

## 1. Halo: The Master Chief Collection (obligatoire)

- **Source légale uniquement** : Steam (`App ID 976730`), Microsoft Store, ou Game Pass PC
- **Prix** : ~40 € sur Steam, ou inclus Game Pass
- **Configuration min** : Win10/11, 16 GB RAM, GTX 1060 / RX 580 (l'install MCC fait ~150 GB tous titres, ~30 GB pour Reach seul)

### Activer le pack Halo Reach
MCC vend les titres séparément en téléchargement (l'achat couvre tout) :
1. Lancer MCC une fois
2. Dans le launcher → onglet **"Customize Install"** ou équivalent
3. Cocher **Halo: Reach** + **Multiplayer**
4. Laisser télécharger (~30 GB)

### Vérifier l'install
Dans `D:\steam\steamapps\common\Halo The Master Chief Collection\` (ou ton chemin équivalent), tu dois voir :
- `mcclauncher.exe`
- `MCC/`
- `haloreach/` avec sous-dossiers `maps/`, `game_variants/`, etc.
- `easyanticheat/`

→ Si `haloreach/` est absent ou vide, le pack Reach n'est pas téléchargé.

---

## 2. Discord (obligatoire)

- Compte Discord (gratuit)
- Rejoindre le serveur communautaire (lien fourni au moment de la candidature)
- Application desktop fortement recommandée (vocaux meilleurs)

### Configurer Discord pour Op
- **Vocal en push-to-talk** recommandé pour les canaux d'Op (évite les bruits de fond)
- **Notifications activées** pour les canaux `#xxx-mission-board`
- **Pseudo** au format `[GRADE] Callsign` (voir [../configs/discord_structure.md](../configs/discord_structure.md))

---

## 3. Steam (obligatoire pour les invites)

- Compte Steam, en ami avec le **host** de la session
- ⚠️ Le host changera à chaque Op. Pour faciliter, **ajoute en ami tous les Operations Officers** dès l'arrivée.
- Vérifie que ton compte permet les **invites de jeu Steam** (Settings > Friends & Chat > Allow joining games via invite)

---

## 4. Game Pack HaloRP (selon Op)

À installer **AVANT** chaque session, en suivant les notes de version.

### Distribution
- ZIP publié dans `#patch-notes` Discord
- Format : `gamepack-haloreach-rp-vX.Y.Z.zip`
- ⚠️ **Ne jamais re-partager hors de la communauté** (voir contraintes ci-dessous)

### Installation
1. Télécharge le ZIP
2. Extrais le contenu dans le bon sous-dossier de UserContent :
   - Les `.mvar` (Forge maps) → `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\Map_Variants\`
   - Les `.bin` (Custom Game variants) → `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\Game_Variants\`
3. Si les sous-dossiers n'existent pas, lancer `tools/diagnose.ps1` pour les créer auto
4. Vérifie que tu as :
   - `Game_Variants/sentinel_defense_v1.bin`
   - `Map_Variants/fob_alpha.mvar`
5. Conserve le ZIP en backup local

### Désinstallation
Supprime simplement les fichiers `.mvar` et `.bin` que tu as ajoutés dans `Map_Variants/` et `Game_Variants/`. MCC retrouve son état standard.

---

## 5. Mod Tools (optionnel, pour mappers / SL avancés)

Uniquement nécessaire si tu veux :
- Construire des Forge maps custom contributives
- Ajuster les variantes
- Participer au design de Game Packs

### Installation
- Sur Steam, chercher **"Halo MCC – Mod Tools"** (gratuit, App ID 1695790 environ)
- Télécharger (~5 GB)
- Lance via Steam → MCC Mod Tools

→ Si tu n'es pas mapper, tu n'as pas besoin de ça.

---

## 6. Config réseau (recommandé)

Reach customs sont en **P2P**. Pour réduire les déconnexions :
- Connexion filaire si possible (Ethernet > Wi-Fi)
- **NAT Open ou Modéré** (vérifiable dans les options Xbox Live de MCC)
- Si tu es **derrière un CGNAT** (4G/5G box, certains FAI) → tu peux jouer mais **pas host**
- Désactiver VPN pendant les sessions

---

## Contraintes & règles

- ✅ Posséder MCC légalement — vérifié au moment de la candidature
- ❌ Pas de partage de Game Pack hors communauté → **ban communauté**
- ❌ Pas de mods tiers (autres que ceux validés par Command Staff) pendant les Ops
- ❌ Pas de tentative de rejoindre une session officielle MCC en mode AC OFF (impossible techniquement, pas tenter)

---

## Voir aussi

- [02_launch_mcc_ac_off.md](02_launch_mcc_ac_off.md) — comment lancer MCC en mode mods
- [04_join_session.md](04_join_session.md) — comment rejoindre une session
- [05_rp_rules.md](05_rp_rules.md) — règles RP générales
