#!/bin/bash
set -e

if [ "$USERNAME" ]; then

    if [ -z "$UNIX_UID" ]; then
        UNIX_UID=1001
    fi

    # Create user
    useradd --uid "$UNIX_UID" --home /home/developer "$USERNAME" --shell "$CONTAINER_SHELL"

    chown "$USERNAME:$USERNAME" /home/developer

fi

exec "$@"
