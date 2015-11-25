FROM greg0ire/php

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

ADD php-cli.ini /etc/php5/cli/conf.d/30-dockerony.ini

RUN php5dismod xdebug

VOLUME /home/developer

COPY entrypoint.sh /

RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "--follow", "/var/log/dmesg"]
