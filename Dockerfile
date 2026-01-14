# ============================================
# Dockerfile PHP + Apache pour Render (FINAL RÉEL)
# ============================================

FROM php:8.2-apache

# ----------------------------
# Dépendances système + PHP
# ----------------------------
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install zip pdo pdo_mysql mysqli \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Timezone PHP
# ----------------------------
RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini

# ----------------------------
# Apache : port Render + ServerName
# ----------------------------
RUN sed -i 's/Listen 80/Listen 10000/' /etc/apache2/ports.conf && \
    sed -i 's/:80/:10000/' /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

# ----------------------------
# Répertoire de travail
# ----------------------------
WORKDIR /var/www/html

# ----------------------------
# COPY CORRECT (racine du repo)
# ----------------------------
COPY --chown=www-data:www-data . /var/www/html

# ----------------------------
# DocumentRoot RÉEL
# ----------------------------
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/taf|g' \
    /etc/apache2/sites-available/000-default.conf && \
    sed -i 's|<Directory /var/www/html>|<Directory /var/www/html/taf>|g' \
    /etc/apache2/sites-available/000-default.conf

# ----------------------------
# Permissions nécessaires
# ----------------------------
RUN chmod -R 755 /var/www/html && \
    chmod -R 777 \
        /var/www/html/taf_assets \
        /var/www/html/taf_docs \
        /var/www/html/user_documents \
        /var/www/html/bien_images \
        /var/www/html/zones || true

# ----------------------------
# Port Render
# ----------------------------
EXPOSE 10000
ENV PORT=10000

# ----------------------------
# Démarrage Apache
# ----------------------------
CMD ["apache2-foreground"]
