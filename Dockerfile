FROM php:7.4.27-apache-buster
RUN apt-get update && apt-get install gnupg2 software-properties-common -y;\
    add-apt-repository -y ppa:ondrej/php
RUN apt-get update; \
    apt-get -y install --no-install-recommends curl openssl libmcrypt-dev libcurl4-openssl-dev libevent-dev libfreetype6-dev \
        libicu-dev libjpeg-dev libldap2-dev libmcrypt-dev libmemcached-dev libpng-dev libpq-dev libxml2-dev \
        libmagickwand-dev libzip-dev libwebp-dev libgmp-dev zlib1g-dev zlib1g gcc make libmagickwand-dev autoconf libc-dev pkg-config  

RUN docker-php-ext-install bcmath \
        exif \
        gd \
        intl \
        ldap \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        xml \
        zip \
        gmp \
        curl 
ENV APACHE2_CONFIG_DIR=/etc/apache2/
ENV PROJECT_NAME=laravelapp
ENV DEBIAN_FRONTEND=noninteractive
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer > /dev/null
WORKDIR /var/www/html/
COPY ./laravel.conf ${APACHE2_CONFIG_DIR}/sites-available/
RUN a2ensite laravel.conf; \
    a2enmod rewrite 
RUN apt-get -y autoremove; \
    apt-get clean
COPY ./*.sh /
EXPOSE 80
VOLUME [ "/var/www/html/laravelapp/" ]

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "apache2-foreground" ]
