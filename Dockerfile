# ============================================
# Dockerfile pour projet PHP TAF
# Compatible avec Render.com
# ============================================

# Image de base PHP avec Apache
FROM php:8.2-apache

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install zip pdo pdo_mysql mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Configuration du timezone
RUN echo "date.timezone=UTC" >> /etc/php/8.2/apache2/php.ini

# Activation du mod_headers pour CORS
RUN a2enmod headers

# Définition du répertoire de travail
WORKDIR /var/www/html

# Copie des fichiers de l'application
COPY --chown=www-data:www-data . /var/www/html/

# Configuration Apache
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html|g' \
    /etc/apache2/sites-available/000-default.conf && \
    sed -i 's|<Directory /var/www/html>|<Directory /var/www/html>|g' \
    /etc/apache2/sites-available/000-default.conf

# Activation du site par défaut
RUN a2ensite 000-default.conf

# Permissions pour les dossiers d'upload
RUN chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/taf_assets && \
    chmod -R 777 /var/www/html/taf_docs && \
    chmod -R 777 /var/www/html/user_documents && \
    chmod -R 777 /var/www/html/bien_images && \
    chmod -R 777 /var/www/html/zones

# Ports exposés (Render utilise le port 10000)
EXPOSE 10000

# Variable d'environnement pour le port
ENV PORT=10000

# Commande de démarrage
CMD ["apache2-foreground"]

