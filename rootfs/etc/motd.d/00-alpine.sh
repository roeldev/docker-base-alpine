#!/bin/sh

echo "Linux version: $( cat /proc/version | cut -d' ' -f 3- | cut -d' ' -f -2 )"
echo "Alpine version: $( alpine_version )"
