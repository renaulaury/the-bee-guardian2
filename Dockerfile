# version: "3.8"
 
# services:
#   ### MySQL ###
#   database:
#     image: mysql:${MYSQL_VERSION:-8.0}
#     environment:
#       MYSQL_DATABASE: ${MYSQL_DATABASE:-app}
#       MYSQL_USER: ${MYSQL_USER:-app}
#       MYSQL_PASSWORD: ${MYSQL_PASSWORD:-!ChangeMe!}
#       MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:-root}
#     healthcheck:
#       test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
#       timeout: 5s
#       retries: 5
#       start_period: 10s
#     volumes:
#       - database_data:/var/lib/mysql
#     ports:
#       - "3306:3306" # optionnel (utile uniquement depuis l’hôte)
 
#   ### ⚙️ Symfony App ###
#   app:
#     build:
#       context: .
#       dockerfile: Dockerfile
#     depends_on:
#       database:
#         condition: service_healthy
#       mailpit:
#         condition: service_started
#     volumes:
#       - .:/var/www/html
#       - /var/www/html/vendor
#       - /var/www/html/var
#     ports:
#       - "8000:8000"
#     environment:
#       APP_ENV: dev
#       DATABASE_URL: "mysql://${MYSQL_USER:-app}:${MYSQL_PASSWORD:-!ChangeMe!}@database:3306/${MYSQL_DATABASE:-app}?serverVersion=8.0&charset=utf8mb4"
#       MAILER_DSN: smtp://mailpit:1025
#     command: php -S 0.0.0.0:8000 -t public
 
#   ### 📬 Mailpit ###
#   mailpit:
#     image: axllent/mailpit
#     ports:
#       - "1025:1025"
#       - "8025:8025"
 
# volumes:
#   database_data:

# ------------------------ OLD ---------------------------- #
# On part d'une image PHP avec Apache
FROM php:8.3-apache

# 1. Installer les outils système nécessaires (Git, Zip, Unzip)
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

# 2. Activer le module Apache "rewrite" (indispensable pour Symfony)
RUN a2enmod rewrite

# 3. Changer la racine du serveur vers le dossier /public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf
RUN sed -ri -e 's!AllowOverride None!AllowOverride All!g' /etc/apache2/apache2.conf

# 4. Installer Composer directement dans ce conteneur
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 5. On définit le dossier de travail
WORKDIR /var/www/html

# Note : On reste en utilisateur root pour éviter les soucis de permissions 
# sur Windows lors de l'installation des paquets.