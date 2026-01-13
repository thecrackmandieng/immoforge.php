# ============================================
# Dockerfile PHP + Apache pour Render
# ============================================

FROM php:8.2-apache

# Dépendances système + extensions PHP
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install zip pdo pdo_mysql mysqli \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

# Timezone
RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini

# Apache doit écouter le port Render (10000)
RUN sed -i 's/Listen 80/Listen ${PORT}/' /etc/apache2/ports.conf && \
    sed -i 's/:80/:${PORT}/' /etc/apache2/sites-available/000-default.conf

# Répertoire de travail
WORKDIR /var/www/html

# Copier le projet
COPY --chown=www-data:www-data . /var/www/html/

# Si ton entrypoint est public/, décommente ceci
# RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' \
#     /etc/apache2/sites-available/000-default.conf

# Permissions (attention : 777 uniquement si nécessaire)
RUN chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/taf_assets \
                   /var/www/html/taf_docs \
                   /var/www/html/user_documents \
                   /var/www/html/bien_images \
                   /var/www/html/zones || true

# Render fournit PORT automatiquement
ENV PORT=10000

CMD ["apache2-foreground"]
