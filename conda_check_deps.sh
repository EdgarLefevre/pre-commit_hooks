#!/bin/bash


filename='environment.yml'

n=0 #blank line at the end
deps=0
errCode=0

if [[ -f $filename ]]; then

    while read line; do
        # reading each line
        var=$line
        
        if [[ $deps == 1 ]] && [[ $line != "" ]];then
        	n=$((n+1))
        fi   
        
        if [[ "$var" == "dependencies:" ]];then
        	deps=1
        fi
        if [[ $var == *"prefix"* ]]; then
                  IFS=' ' read -ra line_array2 <<< "$var"
                  ENV_PATH=${line_array2[1]}
              fi

    done < $filename


    # folder

    conda_path=$ENV_PATH"/conda-meta/"
    n_folder=$(ls $conda_path | grep json | wc -l)

    if ! [[ ($n -1) == $n_folder ]];then
    	errCode=1
    	echo "environment.yml is not up to date, run: conda env export > environment.yml"
    fi
else
    errCode=1
    echo "environment.yml does not exist"
fi
echo "lib in environment.yml: "$n
echo "lib in conda-meta folder: "$n_folder
exit $errCode
