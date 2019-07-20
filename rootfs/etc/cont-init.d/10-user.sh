#!/usr/bin/with-contenv bash

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod --non-unique --gid "$PGID" abc
usermod --non-unique --uid "$PUID" abc

echo "
-------------------------------------
User uid:  $( id -u abc )
User gid:  $( id -g abc )
-------------------------------------
"

chown \
    $( if ${VERBOSE_INIT:-false}; then echo '--changes'; fi ) \
    --recursive \
    abc:abc /app
