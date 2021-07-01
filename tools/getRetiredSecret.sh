#!/usr/bin/env bash

RETIRED_DIR=$1

if [ -z "$RETIRED_DIR" ]
then
    RETIRED_DIR="secrets/retired"
fi

basename $(ls -t1 $RETIRED_DIR/*.gpg) | head -n1 | awk -F "." {' print $1 '} 