# Game Pack Manifest — halo_reach_mvp_v0.1

| Champ | Valeur |
|---|---|
| **Nom** | halo_reach_mvp |
| **Version** | 0.1.0-alpha |
| **Date** | 2026-05-XX (à fixer à la publication) |
| **Auteur** | HaloRP Community |
| **Licence** | CC-BY-NC 4.0 |
| **Jeu requis** | Halo: The Master Chief Collection (Steam App ID 976730) |
| **Pack requis** | Halo Reach + Multiplayer |
| **Mode requis** | Anti-Cheat OFF (mode officiel) |
| **DLC requis** | Aucun |

---

## Contenu

### Forge maps
| Fichier | Map de base | Nom in-game | Statut |
|---|---|---|---|
| `forge_maps/fob_alpha.mvar` | Forge World | FOB Alpha | ⏳ à construire (voir [forge_maps/fob_alpha/design.md](../../forge_maps/fob_alpha/design.md)) |

### Variantes
| Fichier | Base | Nom in-game | Statut |
|---|---|---|---|
| `variants/sentinel_defense_v1.bin` | One Flag CTF | Sentinel-Defense v1 | ⏳ à configurer (voir [variants/sentinel_defense_v1/spec.md](../../variants/sentinel_defense_v1/spec.md)) |

### Briefings
| Fichier | Op | Statut |
|---|---|---|
| `briefings/op_sentinel.md` | Op. Sentinel | ⏳ à rédiger |

---

## Installation

```
Destination : %USERPROFILE%\AppData\LocalLow\MCC\Temporary\UserContent\HaloReach\

Structure :
├── Map_Variants/
│   └── fob_alpha.mvar
└── Game_Variants/
    └── sentinel_defense_v1.bin
```

Voir [documentation/01_installation.md](../../documentation/01_installation.md) pour la procédure complète.

---

## Vérification d'intégrité

Après installation, le joueur doit voir dans MCC (en mode AC OFF) :
- Custom Games → Halo Reach → Variantes → **Sentinel-Defense v1** disponible
- Custom Games → Halo Reach → Maps → **FOB Alpha** disponible
- Custom Games → Halo Reach → Forge → **FOB Alpha** chargeable en édition

→ Si l'un de ces 3 points est négatif, le pack n'est pas installé correctement.

---

## Aucun asset 343i / Microsoft inclus

- Les fichiers `.mvar` sont des **constructions Forge** réalisées **par les contributeurs** sur les canvas officiels — ce sont des compositions personnelles, pas des cartes 343i.
- Les fichiers `.bin` sont des **configurations de variantes** (paramètres custom de jeu), pas du code ni de l'asset.
- Aucun model, texture, son ou tag d'origine 343i n'est redistribué.
- Le joueur **doit posséder MCC + Reach** pour que ces fichiers soient utilisables.

---

## Compatibilité MCC

| Version MCC | Statut |
|---|---|
| Build récent (2024+) | ✅ supporté |
| Builds antérieurs à 2021 | ⚠️ non testé, probablement OK |
| Versions Game Pass (Microsoft Store) | ✅ supporté (chemins de fichiers identiques) |
| Versions piratées | ❌ non supporté, refus communautaire |

---

## Changements

### v0.1.0-alpha (cible : fin Sprint 1)
- Première publication
- 1 map (FOB Alpha)
- 1 variante (Sentinel-Defense v1)
- 1 briefing (Op. Sentinel)

### v0.1.1 (prévu Sprint 2)
- Patch d'équilibrage variante (selon retours tests)
- Version corrigée FOB Alpha (selon retours map)

### v0.2.0 (prévu Sprint 3)
- Ajout 2e map (TBD)
- Ajout variante Sentinel-Defense v2 (Megalo custom)
- Ajout Op type Firefight

---

## Voir aussi

- [README.md](README.md) — README utilisateur du pack
- [../README.md](../README.md) — README global du projet
