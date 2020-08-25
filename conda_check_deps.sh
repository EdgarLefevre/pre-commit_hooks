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
