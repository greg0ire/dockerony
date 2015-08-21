FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --yes nginx && \
    rm --recursive --force /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln --symbolic --force /dev/stdout /var/log/nginx/access.log
RUN ln --symbolic --force /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

ADD monitoring.conf /etc/nginx/conf.d/
ADD monitoring.html /usr/share/nginx/html/monitoring.html
ADD coverage.conf /etc/nginx/conf.d/

ADD dev.conf /etc/nginx/conf.d/

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
