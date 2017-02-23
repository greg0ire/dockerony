FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main' > /etc/apt/sources.list.d/ondrej-php-trusty.list
RUN gpg --keyserver pool.sks-keyservers.net --recv E5267A6C
RUN gpg --export --armor E5267A6C | apt-key add -

# Install packages that are specific to our stack
RUN apt-get update && \
    apt-get install --yes \
    imagemagick \
    php7.1-apc \
    php7.1-bcmath \
    php7.1-cli \
    php7.1-curl \
    php7.1-gd \
    php7.1-imagick \
    php7.1-intl \
    php7.1-ldap \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-memcache \
    php7.1-memcached \
    php7.1-pgsql \
    php7.1-mysql \
    php7.1-soap \
    php7.1-xdebug \
    php7.1-xml \
    php7.1-zip \
    ruby-sass && \
    rm --recursive --force /var/lib/apt/lists/*

RUN phpenmod mcrypt

ADD xdebug.ini /etc/php/mods-available/xdebug.ini
