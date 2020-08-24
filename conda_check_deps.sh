#!/bin/bash


filename='environment.yml'

n=-1 #blank line at the end
deps=0
errCode=0
first_line=0

if [[ -f $filename ]]; then

    while read line; do
        # reading each line
        var=$line
        
        if [[ $first_line == 0 ]]; then
            IFS=' ' read -ra line_array <<< "$var"
            ENV_NAME= $line_array[1]
            echo $ENV_NAME

        if [[ $deps == 1 ]];then
        	n=$((n+1))
        fi   
        
        if [[ "$var" == "dependencies:" ]];then
        	deps=1
        fi

    done < $filename


    # folder

    if [[ -z "${CONDA_EXE}" ]]; then
      conda_var="${_CONDA_EXE}"
    else
      conda_var="${CONDA_EXE}"
    fi

    conda_path="$(dirname $(dirname "$conda_var"))"/envs/"$ENV_NAME"/conda-meta/""
    n_folder=$(ls $conda_path | wc -l)

    if ! [[ $n == $n_folder ]];then
    	errCode=1
    	echo "environment.yml is not up to date"
    fi
else
    errCode=1
    echo "environment.yml does not exist"
fi
exit $errCode
