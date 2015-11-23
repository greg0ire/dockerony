#!/bin/bash
set -e

if [ "$USERNAME" -a ! "$(id "$USERNAME")" ]; then

    if [ -z "$UNIX_UID" ]; then
        UNIX_UID=1001
    fi

    # Create user
    useradd --uid "$UNIX_UID" "$USERNAME"

    # Replace www-data by $USERNAME
    sed --in-place --expression="s/www-data/$USERNAME/g" /etc/php5/fpm/pool.d/www.conf

fi

exec "$@"
