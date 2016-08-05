FROM greg0ire/php:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --yes \
    curl \
    make \
    git-core \
    nodejs-legacy \
    npm \
    zsh && \
    rm --recursive --force /var/lib/apt/lists/*

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install php-cs-fixer
RUN curl --silent --show-error http://get.sensiolabs.org/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
RUN chmod a+x /usr/local/bin/php-cs-fixer

ADD php-cli.ini /etc/php/cli/conf.d/30-dockerony.ini

RUN phpdismod xdebug

VOLUME /home/developer

COPY entrypoint.sh /

RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "--follow", "/var/log/dmesg"]
