#!/bin/bash


filename='env.yaml'
n=-1 #blank line at the end
deps=0
errCode=0

while read line; do
    # reading each line
    var=$line
    if [[ $deps == 1 ]];then
    	n=$((n+1))
    fi   
    if [[ "$var" == "dependencies:" ]];then
    	deps=1
    fi

done < $filename


# folder

conda_path="$(dirname $(dirname "$CONDA_EXE"))"/envs/"$(basename $PWD)"/conda-meta/""
n_folder=$(ls $conda_path | wc -l)

if ! [[ $n == $n_folder ]];then
	exitCode=1
	echo "env.yaml is not up to date"
fi

exit $errCode
