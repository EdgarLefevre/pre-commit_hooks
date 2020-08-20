#!/usr/bin/env bash

FILE=env.yaml
errCode=0
if ! [[ -f "$FILE" ]]; then
    errCode=1
    conda activate CI
    conda env export > env.yaml
    conda deactivate
    echo "$FILE does not exist, run conda env export > env.yaml to create it !"
fi
exit $errCode
