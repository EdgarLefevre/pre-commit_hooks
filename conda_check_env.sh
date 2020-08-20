#!/usr/bin/env bash

echo "The hook is running"
FILE=env.yaml
errCode=0
if ! [[ -f "$FILE" ]]; then
    echo "$FILE does not exist, run conda env export > env.yaml to create it !"
    errCode=1
fi
exit $errCode
