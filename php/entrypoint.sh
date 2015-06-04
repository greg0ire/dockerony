#!/bin/bash
set -e

if [ $USERNAME ]; then

    if [ -z $UNIX_UID ]; then
        UNIX_UID=1001
    fi

    # Create user
    useradd -u$UNIX_UID -d /home/developer $USERNAME

    chown $USERNAME:$USERNAME /home/developer

    # Replace www-data by $USERNAME
    sed -i -e "s/www-data/$USERNAME/g" /etc/php5/fpm/pool.d/www.conf

fi

exec "$@"
