#!/usr/bin/with-contenv bash

echo "
DISPLAY_MOTD: ${DISPLAY_MOTD}
VERBOSE_INIT: ${VERBOSE_INIT}"

# display info about the system and installed software etc.
if ${DISPLAY_MOTD:-true}
then

echo "
-------------------------------------
$( /etc/motd )
-------------------------------------
"

fi

# this will copy all config files, keeping ownership and permissions intact
cp \
    --archive \
    --no-clobber \
    $( if ${VERBOSE_INIT:-false}; then echo '--verbose'; fi ) \
    /etc/default-configs/. /app/config/
