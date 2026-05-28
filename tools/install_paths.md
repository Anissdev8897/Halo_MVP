# Chemins réels d'install MCC — vérifiés sur cette machine

Constat fait le 2026-05-02 par inspection directe du système. **Ces chemins remplacent ceux indiqués initialement dans la doc** (j'avais écrit `%LOCALAPPDATA%\MCC\` qui est faux ; le vrai dossier est `LocalLow`).

---

## 📍 Install MCC (jeu)

```
D:\steam\steamapps\common\Halo The Master Chief Collection\
```

### Contenu confirmé

| Dossier / fichier | Rôle |
|---|---|
| `mcclauncher.exe` | Launcher 343i (entrée standard, ouvre le sélecteur de mode AC) |
| `MCC\Binaries\Win64\MCC-Win64-Shipping.exe` | Exécutable de jeu (ne pas lancer direct) |
| `easyanticheat\` | EAC config (mode AC OFF disponible) |
| `haloreach\maps\` | 30+ maps officielles `.map` |
| `haloreach\game_variants\` | 30+ variantes officielles `.bin` |
| `haloreach\map_variants\` | 11 map variants officiels `.mvar` (Forge presets, Anniversary remakes) |
| `haloreach\hopper_*\` | Variantes matchmaking (lecture seule, ignorer) |

**Build MCC vérifié** : `2025.08.16.178512.1-Release`

### Maps officielles Halo Reach détectées sur disque

Maps multijoueur principales (extrait des `.map` présents) :
- `35_island.map` → **Forge World** (canvas principal pour FOB Alpha)
- `30_settlement.map` → Powerhouse
- `20_sword_slayer.map` → Sword Base
- `45_aftship.map` → Anchor 9
- `50_panopticon.map` → Reflection
- `52_ivory_tower.map` → Cliffhanger
- `70_boneyard.map` → **Boneyard** (Op type Invasion)
- `condemned.map` → Condemned
- `dlc_invasion.map` → **Spire** (Op type Invasion)
- `dlc_medium.map` → Tempest
- `dlc_slayer.map` → Breakpoint
- `ff*.map` → Maps Firefight (Beachhead, Courtyard, Waterfront, Corvette, Outpost, Holdout, Glacier, Overlook, Unearthed)

### Variantes officielles utiles (extrait)

- `ctf_1flag_054.bin` → **One Flag CTF** (base de notre variante test)
- `ctf_054.bin` → CTF standard
- `assault_one_bomb_054.bin` → Assault asymétrique
- `headhunter_054.bin` → Headhunter
- `hr_ff_classic_1set.bin` → Firefight classique
- `hr_ff_generatorDefense_1set.bin` → **Firefight Generator Defense** (intéressant pour future Op !)

### Forge presets sur Forge World détectés

- `hr_forgeWorld_hemorrhage.mvar` → **Hemorrhage** (notre choix pour FOB Alpha)
- `hr_forgeWorld_paradiso.mvar` → Paradiso (île)
- `hr_forgeWorld_pinnacle.mvar` → Pinnacle (petite île)
- `hr_forgeWorld_asylum.mvar` → Asylum (structure)
- `hr_forgeWorld_theCage.mvar` → The Cage

---

## 📍 Données utilisateur MCC (CRITIQUE — chemin correct)

```
C:\Users\<TON_USER>\AppData\LocalLow\MCC\
```

> ⚠️ **`LocalLow`, pas `Local`.** C'est l'erreur dans mes docs initiales. Voir [01_installation.md](../documentation/01_installation.md) corrigé.

### Variable d'environnement
- ❌ Pas de `%LOCALAPPLOW%` natif
- ✅ Utiliser `%USERPROFILE%\AppData\LocalLow\MCC\` ou `$env:USERPROFILE\AppData\LocalLow\MCC` en PowerShell

### Sous-dossiers MCC LocalLow

| Sous-dossier | Rôle |
|---|---|
| `Config\HaloReach\preferences.dat` | Préférences MCC pour Reach |
| `Config\NetworkSessionLayer\` | Config réseau (sessions custom) |
| `Saved\Logs\cef3.log` | Logs du launcher (CEF) |
| `Saved\Config\WindowsNoEditor\` | Configs UE4 du jeu |
| `Temporary\HaloReach\autosave\` | Saves auto temporaires |
| **`Temporary\UserContent\HaloReach\`** | **DOSSIER CLÉ** → user content custom |

### Structure UserContent (créée le 2026-05-02 par diagnose.ps1)

```
%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\
├── Map_Variants\           ← .mvar Forge maps custom (FOB Alpha sera ici)
├── Game_Variants\          ← .bin Custom Game variants (sentinel_defense_test sera ici)
├── Screenshots\            ← captures in-game
├── Films\                  ← saved replays/films
└── Movie\                  ← cinematics
```

→ **C'est ici que tu places les fichiers du Game Pack à terme.**

---

## 📍 Steam Cloud MCC

```
C:\Program Files (x86)\Steam\userdata\<STEAM_USER_ID>\976730\remote\<XBOX_LIVE_ID>\Saves\
```

### Détecté sur cette machine
- Steam user ID : `293858461`
- 3 Xbox Live IDs liés (différents profils sur le même compte Steam)
- **Halo Reach = `halo6`** dans la nomenclature interne Steam Cloud
- Saves campagne Reach présentes : `halo6/campaign/`
- Saves playlist (matchmaking) Reach : `halo6/playlist/`
- ❌ Pas de Map_Variants / Game_Variants en cloud (toujours en local LocalLow)

---

## 📍 Mod Tools (NON installé sur cette machine)

```
D:\steam\steamapps\common\<MOD_TOOLS_FOLDER>\  ← absent
```

→ Pas installé. À récupérer depuis Steam :
- Recherche : "Halo MCC – Mod Tools"
- App ID : varie selon époque, mais ~5 GB
- **Optionnel pour le MVP** (la variante test + Forge in-game suffisent). Nécessaire seulement pour les variantes Megalo custom (v2, Sprint 3+).

---

## ⚙️ Workflow concret pour le MVP

### Quand tu sauvegardes une map Forge

1. In-game (Forge mode) : `Start → Save Map → Save As "FOB Alpha"`
2. MCC écrit le fichier dans : `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\Map_Variants\`
3. Format : `.mvar`
4. **Pour partager** : copier ce `.mvar` vers `HaloRP_MVP/gamepacks/halo_reach_mvp_v0.1/forge_maps/fob_alpha.mvar`
5. Les autres joueurs : placer ce `.mvar` dans **leur** dossier UserContent\HaloReach\Map_Variants\

### Quand tu sauvegardes une variante de jeu

1. In-game : `Custom Games → Edit Game Type → Save Game Type → Save As`
2. MCC écrit dans : `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\Game_Variants\`
3. Format : `.bin`
4. Partage idem (copier dans `HaloRP_MVP/gamepacks/.../variants/`)

---

## 🔧 Scripts disponibles dans tools/

| Script | But | Comment utiliser |
|---|---|---|
| [diagnose.ps1](diagnose.ps1) | Vérifie l'install + crée les dossiers user nécessaires | Clic droit → Run with PowerShell |
| [launch_mcc.ps1](launch_mcc.ps1) | Lance MCC via Steam (rappel d'activer AC OFF dans launcher) | Clic droit → Run with PowerShell |

→ Si PowerShell refuse d'exécuter, ouvrir PowerShell admin et faire :
```
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

## ✅ État actuel (au 2026-05-02 minuit)

- [x] MCC installé et legit
- [x] Halo Reach + multi packs téléchargés
- [x] EAC présent (mode AC OFF disponible)
- [x] Mod Tools non installé (optionnel pour MVP)
- [x] Dossiers UserContent\HaloReach\Map_Variants\ et Game_Variants\ créés
- [x] Steam Cloud syncé (saves campagne Reach présentes)
- [ ] MCC lancé en mode AC OFF au moins 1 fois → à faire
- [ ] Variante `sentinel_defense_test` créée → étape 2
- [ ] FOB Alpha buildée → étape 3
- [ ] Premier test solo → étape 4

→ **Prochaine action** : lance `tools/launch_mcc.ps1` ou via Steam, coche AC OFF, et fais l'étape 2 (variante test sur Hemorrhage stock).
