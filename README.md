# TAF - Table Administration Framework

## Description

TAF (Table Administration Framework) est un framework PHP léger pour générer rapidement des interfaces d'administration pour vos bases de données MySQL/PostgreSQL.

## Installation Locale

### Prérequis
- PHP 8.0+
- MySQL ou PostgreSQL
- Apache avec mod_rewrite

### Installation

1. Clonez le projet:
```bash
git clone <votre-repo>
cd taf-version6.0
```

2. Configurez la base de données dans `TafConfig.php`:
```php
public $database_type = "mysql"; // ou "pgsql"
public $host = "127.0.0.1";
public $port = "3306";
public $database_name = "immoforge";
public $user = "root";
public $password = "votre_mot_de_passe";
```

3. Lancez le serveur PHP内置:
```bash
php -S 0.0.0.0:8080
```

4. Ouvrez http://localhost:8080 dans votre navigateur.

---

## Déploiement sur Render.com avec Docker

### Fichiers créés

Ce projet inclut les fichiers nécessaires pour un déploiement Docker sur Render.com:

| Fichier | Description |
|---------|-------------|
| `Dockerfile` | Configuration de l'image Docker PHP 8.2 avec Apache |
| `.dockerignore` | Fichiers exclus de l'image Docker |
| `render.yaml` | Configuration Render Blueprints |
| `deploy.sh` | Script de déploiement automatisé |

### Déploiement étape par étape

#### Option 1: Déploiement manuel sur Render

1. **Poussez sur GitHub:**
```bash
git add .
git commit -m "Add Docker configuration for Render deployment"
git push origin main
```

2. **Créez un Web Service sur Render:**
   - Allez sur https://render.com et connectez-vous
   - Cliquez sur "New +" → "Web Service"
   - Connectez votre repository GitHub
   - Configurez:
     - Name: `taf-app`
     - Environment: `Docker`
     - Region: `Frankfurt` (ou votre région préférée)
     - Plan: `Free`

3. **Configurez les variables d'environnement:**
   Dans le dashboard Render, allez dans l'onglet "Environment" et ajoutez:
   ```
   DATABASE_HOST=votre_host_mysql
   DATABASE_PORT=3306
   DATABASE_NAME=votre_base
   DATABASE_USER=votre_user
   DATABASE_PASSWORD=votre_mot_de_passe
   PHP_TZ=UTC
   ```

4. **Déployez:**
   - Cliquez sur "Create Web Service"
   - Render construira automatiquement l'image Docker et déploiera

#### Option 2: Utilisation de Blueprints (render.yaml)

1. Allez sur https://dashboard.render.com/blueprints

2. Cliquez sur "New Blueprint Instance"

3. Connectez votre repository GitHub

4. Render lira le fichier `render.yaml` et proposera de créer:
   - Un Web Service Docker
   - Une base de données PostgreSQL (optionnel)

### Déploiement local avec Docker

```bash
# Construire l'image
docker build -t taf-app:latest .

# Lancer le conteneur
docker run -p 8080:10000 \
  -e DATABASE_HOST=localhost \
  -e DATABASE_PORT=3306 \
  -e DATABASE_NAME=votre_base \
  -e DATABASE_USER=votre_user \
  -e DATABASE_PASSWORD=votre_mot_de_passe \
  taf-app:latest
```

L'application sera accessible sur http://localhost:8080

### Script de déploiement automatisé

Un script `deploy.sh` est fourni pour faciliter le déploiement:

```bash
./deploy.sh
```

Ce script:
1. Vérifie les prérequis (Docker, Git)
2. Construit l'image Docker localement
3. Affiche les instructions de déploiement sur Render

---

## Structure du projet

```
taf-version6.0/
├── api/                    # API endpoints
├── biens/                  # Module gestion des biens
├── clients/                # Module gestion des clients
├── taf_assets/            # Assets (CSS, JS, images)
├── TafConfig.php          # Configuration principale
├── TableDocumentation.php # Documentation automatique
├── TableQuery.php         # Requêtes SQL génériques
├── Dockerfile             # Configuration Docker
├── render.yaml            # Configuration Render
└── deploy.sh              # Script de déploiement
```

## Caractéristiques

- ✅ Génération automatique d'interfaces CRUD
- ✅ Support MySQL et PostgreSQL
- ✅ Documentation automatique des tables
- ✅ Authentification intégrée
- ✅ Compatible Docker
- ✅ Déploiement Render prêt

## Support

Pour toute question sur le déploiement, créez une issue sur GitHub.

## Licence

MIT

