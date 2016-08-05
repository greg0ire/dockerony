FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main' > /etc/apt/sources.list.d/ondrej-php-trusty.list
RUN gpg --keyserver pool.sks-keyservers.net --recv E5267A6C
RUN gpg --export --armor E5267A6C | apt-key add -

# Install packages that are specific to our stack
RUN apt-get update && \
    apt-get install --yes \
    imagemagick \
    php7.0-apc \
    php7.0-bcmath \
    php7.0-cli \
    php7.0-curl \
    php7.0-gd \
    php7.0-imagick \
    php7.0-intl \
    php7.0-ldap \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-memcache \
    php7.0-memcached \
    php7.0-pgsql \
    php7.0-mysql \
    php7.0-soap \
    php7.0-xdebug \
    php7.0-xml \
    php7.0-zip \
    ruby-sass && \
    rm --recursive --force /var/lib/apt/lists/*

RUN phpenmod mcrypt

ADD xdebug.ini /etc/php/mods-available/xdebug.ini
