# Stolen from https://github.com/akretion/docker-mailcatcher

FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --yes sqlite3 libsqlite3-dev build-essential ruby2.0 ruby2.0-dev && \
    rm /usr/bin/ruby && sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby && \
    rm -fr /usr/bin/gem && sudo ln -s /usr/bin/gem2.0 /usr/bin/gem && \
    gem install mailcatcher --no-rdoc --no-ri && \
    apt-get remove --purge --yes libsqlite3-dev ruby2.0-dev build-essential && \
    apt-get autoremove --yes && \
    apt-get autoclean && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
EXPOSE 25

ENTRYPOINT ["mailcatcher", \
    "--smtp-ip=0.0.0.0", \
    "--smtp-port=25", \
    "--http-ip=0.0.0.0", \
    "--http-port=80", \
    "--foreground" \
]
