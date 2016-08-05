FROM greg0ire/php:release-2.0.1

ENV DEBIAN_FRONTEND noninteractive

# Install packages that are specific to our stack
RUN apt-get update && \
    apt-get install --yes \
    php5-fpm && \
    rm --recursive --force /var/lib/apt/lists/*

# Sanctify (the opposite of daemonize :D ) php-fpm
RUN sed -i -e 's/;daemonize\s*=\s*yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

ADD www.conf /etc/php5/fpm/pool.d/www.conf
ADD php-fpm.ini /etc/php5/fpm/php.ini

COPY entrypoint.sh /

RUN chmod u+x /entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php5-fpm", "--nodaemonize"]
