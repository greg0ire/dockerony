FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get install --yes \
	postgresql-9.3 \
	postgresql-client-9.3 \
	postgresql-common \
	postgresql-contrib-9.3 \
	curl &&\
	rm --recursive --force /var/lib/apt/lists/* \
	&& curl --output /usr/local/bin/gosu --show-error --location "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

RUN apt-get update && apt-get install --yes locales &&\
	rm --recursive --force /var/lib/apt/lists/* && \
	localedef --inputfile=en_US --force --charmap=UTF-8 --alias-file /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/9.3/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432

CMD ["postgres" ]
