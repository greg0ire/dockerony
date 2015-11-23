FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# Install packages that are specific to our stack
RUN apt-get update && \
    apt-get install --yes \
    imagemagick \
    php-apc \
    php5-cli \
    php5-curl \
    php5-gd \
    php5-imagick \
    php5-intl \
    php5-ldap \
    php5-mcrypt \
    php5-memcache \
    php5-memcached \
    php5-pgsql \
    php5-mysql \
    php5-xdebug \
    ruby-sass && \
    rm --recursive --force /var/lib/apt/lists/*

RUN php5enmod mcrypt

ADD xdebug.ini /etc/php5/mods-available/xdebug.ini
