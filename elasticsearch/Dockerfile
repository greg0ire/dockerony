FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --yes wget && \
	wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add - && \
	echo 'deb http://packages.elasticsearch.org/elasticsearch/1.5/debian stable main' \
	  | tee /etc/apt/sources.list.d/elasticsearch.list && \
	apt-get update && \
	apt-get install --yes --no-install-recommends openjdk-7-jre-headless elasticsearch && \
	/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head && \
	rm --recursive --force /var/lib/apt/lists/*

RUN /usr/share/elasticsearch/bin/plugin --install elasticsearch/marvel/latest

ADD run.sh /usr/local/bin/run.sh

EXPOSE 9200 9300

ENTRYPOINT ["/usr/local/bin/run.sh"]
