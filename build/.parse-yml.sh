#!/bin/bash

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cat ${CWD}/../.travis.yml \
    | grep "$1" \
    | cut -d = -f 2
