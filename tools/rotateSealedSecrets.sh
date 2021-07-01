#!/usr/bin/env bash

SEARCH_DIR=$1

if [ -z "$SEARCH_DIR" ]
then
    SEARCH_DIR="."
fi

find $SEARCH_DIR -name '*sealed-secret.json' -type f | while read FILE
do
    FILE_PATH=$(dirname "${FILE}")
    FILE_NAME=$(basename "${FILE}")
    echo "$FILE_PATH"
    echo "$FILE_NAME"
    cat "$FILE" | kubeseal --recovery-unseal --recovery-private-key secrets/old/alphabravo-tls.key > $FILE_PATH/unsealed-$FILE
    kubeseal --cert secrets/current/alphabravo-tls.crt < $FILE_PATH/unsealed-$FILE > $FILE_PATH/$FILE
    rm $FILE_PATH/unsealed-$FILE

done