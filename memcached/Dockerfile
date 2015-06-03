FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --yes memcached && \
    rm --recursive --force /var/lib/apt/lists/*

EXPOSE 11211

USER memcache

ENTRYPOINT ["memcached"]
