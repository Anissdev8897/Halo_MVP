# Game Pack — halo_reach_mvp v0.1

Premier Game Pack du framework HaloRP. Contient les fichiers nécessaires pour jouer **Op. Sentinel** sur **FOB Alpha** avec la variante **Sentinel-Defense v1**.

---

## ⚠️ Pré-requis

- Halo: The Master Chief Collection installé légalement (Steam, Microsoft Store ou Game Pass)
- Pack Halo Reach + Multiplayer téléchargé dans MCC
- MCC lancé en mode **Anti-Cheat OFF** (voir [01_installation.md](../../documentation/01_installation.md))

---

## Installation

### Étape 1 : Localiser le dossier UserContent MCC

```
%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\
```

(Sur Windows : `Win+R` → tape `%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\` → Enter)

Si les sous-dossiers `Map_Variants` et `Game_Variants` n'existent pas, lance `tools/diagnose.ps1` pour les créer auto, ou crée-les manuellement.

### Étape 2 : Extraire le pack

Téléchargez `gamepack-haloreach-mvp-v0.1.0.zip` depuis `#patch-notes` sur Discord.

Le ZIP contient :
- `fob_alpha.mvar` → à placer dans `Map_Variants/`
- `sentinel_defense_v1.bin` → à placer dans `Game_Variants/`

Structure finale attendue :
```
%USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\
├── Map_Variants\
│   └── fob_alpha.mvar
└── Game_Variants\
    └── sentinel_defense_v1.bin
```

### Étape 3 : Vérifier dans MCC

1. Lance MCC en **Anti-Cheat OFF**
2. **Multiplayer → Custom Games → Halo Reach**
3. Sélectionne **Game Variant** : `Sentinel-Defense v1` doit apparaître
4. Sélectionne **Map** : `FOB Alpha` doit apparaître

✅ Si les deux sont visibles, l'install est OK.

---

## Désinstallation

Supprime les `.mvar` et `.bin` que tu as ajoutés dans `Map_Variants/` et `Game_Variants/`. MCC retrouve son état standard sans toucher au reste.

---

## Contenu du pack

| Fichier | Description |
|---|---|
| `variants/sentinel_defense_v1.bin` | Variante Custom Game asymétrique 12v4, 25 min, basée sur One Flag CTF |
| `maps/fob_alpha.mvar` | Map Forge custom (Forge World, Hemorrhage canyon) avec FOB UNSC fortifié |
| `briefings/op_sentinel.md` | Briefing IC pour l'Op |

---

## Restrictions de redistribution

- ❌ **Ne partage PAS** ce pack hors de la communauté HaloRP
- ❌ **Ne le revends pas**
- ✅ **Tu peux** mentionner le projet sur tes réseaux (sans lien direct vers le pack)
- ✅ **Tu peux** le supprimer / le re-télécharger autant que tu veux

Sanction en cas de leak : ban communauté permanent.

---

## Bugs / problèmes ?

Discord canal `#bugs-feedback`.

Format de signalement :
```
Pack version : v0.1.0-alpha
MCC build : {voir dans options MCC}
Comportement attendu : {ce qui devrait arriver}
Comportement constaté : {ce qui arrive}
Reproduction : {étapes}
Screenshot/vidéo : {lien si possible}
```

---

## Licence

CC-BY-NC 4.0 — usage non-commercial, attribution, pas de modification dérivée commerciale.

Aucun asset 343 Industries / Microsoft inclus. MCC requis légalement.

---

## Voir aussi

- [manifest.md](manifest.md) — manifest technique
- [../../documentation/01_installation.md](../../documentation/01_installation.md)
- [../../documentation/04_join_session.md](../../documentation/04_join_session.md)
