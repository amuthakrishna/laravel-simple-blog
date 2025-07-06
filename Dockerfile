# Use the official Ubuntu 22.04 image as the base image
FROM ubuntu:22.04

# Set environment variables
ENV COMPOSER_VERSION=2.2.25

# Set environment variable to make apt-get non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Configure time zone data to avoid interactive prompt
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Add PHP 7.3 repository (since Ubuntu 22.04 does not include PHP 7.3 by default)
#RUN add-apt-repository ppa:ondrej/php \
#    && apt-get update

# Install PHP 7.3 and required extensions
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && apt-get install -y \
    php7.3 \
    php7.3-fpm \
    php7.3-bcmath \
    php7.3-cgi \
    php7.3-cli \
    php7.3-common \
    php7.3-curl \
    php7.3-dba \
    php7.3-dev \
    php7.3-json \
    php7.3-mbstring \
    php7.3-mcrypt \
    php7.3-mysql \
    php7.3-opcache \
    php7.3-xml \
    php7.3-xsl \
    php7.3-zip \
    php7.3-bz2 \
    php7.3-gd \
    php7.3-intl \
    php7.3-soap \
    libapache2-mod-php7.3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# Set the working directory
WORKDIR /var/www/html

COPY laravel-simple-blog .

RUN composer update --prefer-dist --no-interaction
RUN composer dump-autoload 
RUN php artisan config:clear \
    && php artisan config:cache \
    && php artisan route:clear \
    && php artisan route:cache \
    && php artisan optimize

# Expose port 8000 for Laravel development server
EXPOSE 8000


# Start the Laravel development server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]