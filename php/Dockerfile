FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# Install packages that are specific to our stack
RUN apt-get update && \
    apt-get install --yes \
    curl \
    git-core \
    imagemagick \
    make \
    php-apc \
    php5-cli \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-imagick \
    php5-intl \
    php5-ldap \
    php5-mcrypt \
    php5-memcache \
    php5-memcached \
    php5-pgsql \
    php5-xdebug \
    ruby-sass  && \
    rm --recursive --force /var/lib/apt/lists/*

RUN php5enmod mcrypt

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Sanctify (the opposite of daemonize :D ) php-fpm
RUN sed -i -e 's/;daemonize\s*=\s*yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

ADD www.conf /etc/php5/fpm/pool.d/www.conf
ADD php-fpm.ini /etc/php5/fpm/php.ini
ADD xdebug.ini /etc/php5/mods-available/xdebug.ini

COPY entrypoint.sh /

RUN chmod u+x /entrypoint.sh

RUN mkdir /home/developer

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php5-fpm", "--nodaemonize"]