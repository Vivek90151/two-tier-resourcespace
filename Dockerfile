FROM php:8.2-apache

WORKDIR /var/www/html

# System packages
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    && docker-php-ext-install zip mysqli pdo pdo_mysql \
    && a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy project
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --no-dev || true

EXPOSE 80

CMD ["apache2-foreground"]
