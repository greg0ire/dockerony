#!/bin/sh

# Stolen from https://raw.githubusercontent.com/partlab/docker/master/ubuntu-elasticsearch/run

. /lib/lsb/init-functions

PATH=/bin:/usr/bin:/sbin:/usr/sbin
DEFAULT=/etc/default/elasticsearch
ES_HOME=/usr/share/elasticsearch
# Heap Size (defaults to 256m min, 1g max)
#ES_HEAP_SIZE=2g
# Heap new generation
#ES_HEAP_NEWSIZE=
# max direct memory
#ES_DIRECT_SIZE=
# ElasticSearch log directory
LOG_DIR=/var/log/elasticsearch
# ElasticSearch data directory
DATA_DIR=/var/lib/elasticsearch
# ElasticSearch work directory
WORK_DIR=/tmp/elasticsearch
# ElasticSearch configuration directory
CONF_DIR=/etc/elasticsearch
# ElasticSearch configuration file (elasticsearch.yml)
CONF_FILE=$CONF_DIR/elasticsearch.yml
# Maximum number of VMA (Virtual Memory Areas) a process can own
MAX_MAP_COUNT=65535
PID_FILE=/var/run/$NAME.pid
DAEMON=$ES_HOME/bin/elasticsearch
DAEMON_OPTS="-p $PID_FILE -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR"

JDK_DIRS="/usr/lib/jvm/java-7-openjdk /usr/lib/jvm/java-7-openjdk-amd64/ /usr/lib/jvm/java-7-openjdk-armhf /usr/lib/jvm/java-7-openjdk-i386/ /usr/lib/jvm/default-java"

# Look for the right JVM to use
for jdir in $JDK_DIRS; do
    if [ -r "$jdir/bin/java" -a -z "${JAVA_HOME}" ]; then
        JAVA_HOME="$jdir"
    fi
done
export JAVA_HOME

# overwrite settings from default file
if [ -f "$DEFAULT" ]; then
    . "$DEFAULT"
fi

export ES_HEAP_SIZE
export ES_HEAP_NEWSIZE
export ES_DIRECT_SIZE

# Check DAEMON exists
test -x $DAEMON || exit 0

checkJava() {
    if [ -x "$JAVA_HOME/bin/java" ]; then
        JAVA="$JAVA_HOME/bin/java"
    else
        JAVA=`which java`
    fi

    if [ ! -x "$JAVA" ]; then
        echo "Could not find any executable java binary. Please install java in your PATH or set JAVA_HOME"
        exit 1
    fi
}

checkJava

log_daemon_msg "Starting ElasticSearch Server"

# Prepare environment
mkdir -p "$LOG_DIR" "$DATA_DIR" "$WORK_DIR" && chown elasticsearch:elasticsearch "$LOG_DIR" "$DATA_DIR" "$WORK_DIR"
touch "$PID_FILE" && chown elasticsearch:elasticsearch "$PID_FILE"

if [ -n "$MAX_MAP_COUNT" ]; then
    sysctl -q -w vm.max_map_count=$MAX_MAP_COUNT
fi

# Start Daemon
exec sudo -u elasticsearch $DAEMON $DAEMON_OPTS

