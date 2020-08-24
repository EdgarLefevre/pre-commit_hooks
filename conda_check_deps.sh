#!/bin/bash


filename='environment.yml'
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

if [[ -z "${CONDA_EXE}" ]]; then
  conda_var="${_CONDA_EXE}"
else
  conda_var="${CONDA_EXE}"
fi

conda_path="$(dirname $(dirname "$conda_var"))"/envs/"$(basename $PWD)"/conda-meta/""
n_folder=$(ls $conda_path | wc -l)

if ! [[ $n == $n_folder ]];then
	errCode=1
	echo "environment.yml is not up to date"
fi

exit $errCode
