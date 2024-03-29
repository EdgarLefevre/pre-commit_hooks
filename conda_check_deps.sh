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
        if [[ $var == *"prefix"* ]];then
            IFS=' ' read -ra line_array2 <<< "$var"
            ENV_PATH=${line_array2[1]}
            IFS="/" read -ra env_name <<< $ENV_PATH
            ENV_NAME=${env_name[-1]}
        fi
        if [[ $line == *"pip:" ]];then
            deps=2
        fi

    done < $filename
# grep "=" $filename | grep -v "==" | wc -l 

    # folder

    conda_path=$CONDA_PREFIX_1"/envs/"$ENV_NAME"/conda-meta/"
    n_folder=$(ls $conda_path | grep json | wc -l)
    n=$((n-1))
    if ! [[ $n == $n_folder ]];then
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
