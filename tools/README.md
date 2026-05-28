# Tools — Utilitaires du projet

Ce dossier hébergera les utilitaires développés au fil du projet. **Vide pour le MVP v0.1** (Mode B = pas de code, tout vit en Discord/Sheet/Forge).

---

## Rien à coder pour le MVP

Le Mode B est explicitement sans backend, sans launcher custom, sans code exécutable. Les outils utilisés sont :
- **Discord** (gratuit, hébergé)
- **Google Sheet** (gratuit, hébergé)
- **MCC + Forge + Custom Games** (chez le joueur)
- **Mod Tools 343i** (chez les mappers)

→ Pas de `tools/` au sens "scripts à lancer" pour ce sprint.

---

## Idées d'outils pour Sprint 2+

### Petit bot Discord (Sprint 2, optionnel)
Si la communauté grandit (>20 actifs), un bot Node.js léger peut automatiser :
- Création auto canal `#op-XXX-DATE` avant chaque Op
- Sync rôle Discord ↔ grade dans la Sheet (commande `!syncgrade @user`)
- Annonce auto promotions du lundi
- Kick auto Recruit Pending après 30 jours sans validation

Stack envisagée : `discord.js`, hébergé sur petit VPS partagé ou Replit.

### Sheet calculator standalone (Sprint 2)
Un Google Apps Script attaché à la Sheet pour :
- Calcul auto du niveau depuis l'XP (formule polynomiale)
- Auto-fill du grade min recommandé
- Génération du rapport hebdo des promotions à valider

### Migration export → backend Mode A (Sprint 5+)
Si la communauté > 30 actifs et qu'on bascule en Mode A :
- Script de migration Sheet → Postgres
- Bootstrap d'un backend Node/TS
- Génération des comptes auth depuis le Roster

---

## Voir aussi

- [../README.md](../README.md)
- [../documentation/00_vision.md](../documentation/00_vision.md) — pourquoi pas de code en MVP
