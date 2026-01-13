#!/bin/bash

# ============================================
# Script de déploiement pour Render.com
# ============================================

echo "============================================"
echo "Déploiement du projet TAF sur Render.com"
echo "============================================"

# Étape 1: Vérification des prérequis
echo ""
echo "📋 Étape 1: Vérification des prérequis..."

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi
echo "✅ Docker est installé"

# Vérifier Git
if ! command -v git &> /dev/null; then
    echo "❌ Git n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi
echo "✅ Git est installé"

# Étape 2: Construction de l'image Docker locale
echo ""
echo "🏗️ Étape 2: Construction de l'image Docker..."
docker build -t taf-app:latest .

if [ $? -eq 0 ]; then
    echo "✅ Image Docker construite avec succès"
else
    echo "❌ Erreur lors de la construction de l'image Docker"
    exit 1
fi

# Étape 3: Test local (optionnel)
echo ""
echo "🧪 Étape 3: Test local (optionnel)..."
echo "Pour tester localement, exécutez:"
echo "  docker run -p 8080:10000 -e DATABASE_HOST=localhost taf-app:latest"
echo ""
echo "Ou avec docker-compose:"
echo "  docker-compose up -d"

# Étape 4: Instructions de déploiement
echo ""
echo "🚀 Étape 4: Instructions de déploiement sur Render"
echo "=================================================="
echo ""
echo "1. Poussez votre code sur GitHub:"
echo "   git add ."
echo "   git commit -m 'Add Docker configuration for Render'"
echo "   git push origin main"
echo ""
echo "2. Connectez-vous sur https://render.com"
echo ""
echo "3. Créez un nouveau Web Service:"
echo "   - Connectez votre repository GitHub"
echo "   - Name: taf-app"
echo "   - Environment: Docker"
echo "   - Region: Frankfurt (ou proche de vous)"
echo "   - Plan: Free"
echo ""
echo "4. Configurez les variables d'environnement:"
echo "   - DATABASE_HOST: (votre host MySQL)"
echo "   - DATABASE_PORT: 3306"
echo "   - DATABASE_NAME: (nom de la base)"
echo "   - DATABASE_USER: (utilisateur)"
echo "   - DATABASE_PASSWORD: (mot de passe)"
echo ""
echo "5. (Optionnel) Créez une base de données PostgreSQL:"
echo "   - Créez un nouveau 'PostgreSQL' dans Render"
echo "   - Notez les informations de connexion"
echo "   - Mettez à jour TafConfig.php pour utiliser PostgreSQL"
echo ""
echo "6. Deploy!"
echo ""
echo "============================================"
echo "✅ Configuration terminée!"
echo "============================================"

