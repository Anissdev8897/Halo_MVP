# HaloRP MVP — Military RP sur Halo Reach (MCC)

Framework communautaire pour Military RP sur **Halo: The Master Chief Collection**, faction **UNSC vs Covenant**, en mode **AC OFF officiel** (sans bypass anti-cheat, sans injection, sans reverse).

> Ce projet ne contient **aucun asset 343 Industries / Microsoft**. Il fournit des spécifications, des designs de cartes Forge, des configurations de variantes, et des règles RP. Chaque joueur doit posséder une copie légale de MCC + le pack Halo Reach.

---

## Mode B : in-game / simple (validé)

- Pas de backend, pas de VPS
- Pas d'Unreal Engine, pas de moteur externe
- 100 % outils officiels Halo MCC : Custom Games, Forge, Mod Tools, Firefight, Invasion
- Discord + Google Sheet pour la coordination & persistance
- Game Packs distribués via Discord, joués en sessions de 12–16 joueurs

---

## Structure du projet

```
HaloRP_MVP/
├── README.md                       ← ce fichier
├── documentation/                  ← guides joueurs / hosts / admins
│   ├── 00_vision.md
│   ├── 01_installation.md
│   ├── 02_launch_mcc_ac_off.md
│   ├── 03_host_session.md
│   ├── 04_join_session.md
│   ├── 05_rp_rules.md
│   ├── 06_ai_npc_capabilities.md
│   ├── 07_test_checklist.md
│   ├── leveling_vs_rank.md         ← niveau ≠ grade
│   ├── ai_xp_system.md             ← XP joueurs vs IA
│   └── faction_leader_rules.md     ← chefs de faction
├── configs/                        ← définitions de référence (faction, grades, etc.)
│   ├── factions.md
│   ├── divisions.md
│   ├── grades.md
│   ├── roles.md
│   ├── operations_types.md
│   ├── maps_catalog.md
│   ├── xp_system.md
│   ├── discord_structure.md
│   ├── leveling.json               ← niveau (auto)
│   ├── xp_rewards_unsc.json        ← table XP UNSC
│   ├── xp_rewards_covenant.json    ← table XP Covenant
│   ├── ai_units_unsc.json          ← catalogue IA UNSC
│   ├── ai_units_covenant.json      ← catalogue IA Covenant
│   ├── faction_leadership.json     ← chefs de faction
│   ├── promotion_rules.json        ← règles de promotion (manuelles)
│   └── map_discovery_xp.json       ← XP exploration
├── gamepacks/                      ← packs distribuables (specs + placeholders)
│   └── halo_reach_mvp_v0.1/
│       ├── manifest.md
│       ├── README.md
│       ├── forge_maps/
│       ├── variants/
│       └── briefings/
├── forge_maps/                     ← designs détaillés des maps Forge custom
│   └── fob_alpha/
│       └── design.md
├── variants/                       ← specs des variantes Custom Game
│   └── sentinel_defense_v1/
│       └── spec.md
└── tools/                          ← scripts/utilitaires (vide pour l'instant)
    └── README.md
```

---

## Pour commencer

| Tu es… | Va lire en premier… |
|---|---|
| Joueur | [documentation/01_installation.md](documentation/01_installation.md) puis [documentation/04_join_session.md](documentation/04_join_session.md) |
| Host de session | [documentation/03_host_session.md](documentation/03_host_session.md) |
| Mappers / designers | [forge_maps/fob_alpha/design.md](forge_maps/fob_alpha/design.md) |
| Command Staff / admin | [documentation/05_rp_rules.md](documentation/05_rp_rules.md) + [configs/](configs/) |
| Curieux | [documentation/00_vision.md](documentation/00_vision.md) |

---

## État du projet

| Composant | État |
|---|---|
| Structure du framework | ✅ initiale |
| Configs UNSC / Covenant | ✅ v0.1 |
| Système niveau (auto) | ✅ leveling.json |
| Système rang (manuel) | ✅ promotion_rules.json |
| XP joueurs vs IA | ✅ xp_rewards_*.json |
| Catalogue IA | ✅ ai_units_*.json |
| Chefs de faction | ✅ faction_leadership.json |
| XP exploration | ✅ map_discovery_xp.json |
| Game Pack v0.1 (specs) | ✅ |
| Map FOB Alpha (design) | ✅ |
| Variante Sentinel-Defense (spec) | ✅ |
| Forge build (.mvar) | ⏳ à construire dans Forge |
| Variante Reach (.bin) | ⏳ à exporter via Custom Game |
| Première session test | ⏳ |

## Principe central — niveau ≠ rang

> **Le niveau prouve ton activité (auto). Le rang prouve la confiance qu'on te donne (manuel).**
>
> Un joueur peut être niveau 30 et rester Recruit. Un joueur peut être Sergeant à niveau 8.  
> Le niveau monte automatiquement avec l'XP cumulée. Le grade est attribué exclusivement par les **chefs de faction**.  
> Voir [documentation/leveling_vs_rank.md](documentation/leveling_vs_rank.md).

---

## Contraintes & règles du projet

- ❌ Aucune redistribution d'assets Halo
- ❌ Aucun bypass d'EAC
- ❌ Aucune injection mémoire / hook process
- ❌ Aucun reverse agressif des protocoles MCC
- ✅ Mode AC OFF officiel uniquement (mode prévu par 343i pour les mods)
- ✅ Mod Tools 343i uniquement pour les modifications de tags
- ✅ Forge & Custom Games standard pour le contenu jouable
- ✅ Projet **gratuit, non-commercial**

---

## Licence

Documents et designs : CC-BY-NC 4.0 (usage non-commercial).
Aucun asset 343i / Microsoft inclus. MCC requis légalement pour exécution.
