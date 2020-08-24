#!/usr/bin/env bash

FILE=environment.yml
errCode=0
if ! [[ -f "$FILE" ]]; then
    errCode=1
    echo "$FILE does not exist, run conda env export > environment.yml to create it !"
fi
exit $errCode
