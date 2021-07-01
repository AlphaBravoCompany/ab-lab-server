#!/usr/bin/env bash

CURRENT_DIR=$1

if [ -z "$CURRENT_DIR" ]
then
    CURRENT_DIR="secrets/current"
fi

basename $(ls -t1 $CURRENT_DIR/*.gpg) | head -n1 | awk -F "." {' print $1 '} 