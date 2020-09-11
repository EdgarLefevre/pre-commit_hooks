#!/usr/bin/env bash

FILE=environment.yml
errCode=0
if ! [[ -f "$FILE" ]]; then
    errCode=1
    echo "$FILE does not exist, to create it, run: conda env export > environment.yml"
fi
exit $errCode
