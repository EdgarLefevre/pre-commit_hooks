#!/usr/bin/env bash

FILE=env.yaml
errCode=1
if [[ -f "$FILE" ]]; then
    errCode=0
fi
echo "$FILE does not exist, run conda env export > env.yaml to create it !"
exit $errCode
