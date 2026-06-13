#!/bin/bash
#
# H and Cpp generator from template.
#
# use: ./hcpp_generator2.sh dir=destination filename1 filename2 ... filenameN
#
#       Attention: the destination path syntax will not be checked! 
#
# result:
#           filename.h          filename.cpp
#
#           # pragma once       #include "filename.h"
#
#           // model code       // model code
#

dir="."
args="$@"
models=("./models/model_1.h" "./models/model_1.cpp")

echo "H Cpp - Generator 2"

if [[ "$args" = "" ]]; then
    echo "Empty argument!"
    echo "Finished!"
    exit 0
fi

for model in ${models[@]}; do
    if [[ ! -f $model ]]; then
        echo "Error: Model files not found!"
        echo "Finished!"
        exit 0
    fi
done

filenames=($args)
str="${filenames[0]}"
if [[ $str = "dir="* ]]; then
    dir=${str:4}
    filenames=("${filenames[@]:1}")
    if [[ ! -d $dir ]]; then
        echo "Create: $dir"
        mkdir -p $dir
    fi   
fi

echo "Directory: $dir"

for filename in ${filenames[@]}
do
    hfile="$filename.h"
    cfile="$filename.cpp"
    str=${filename^}

    echo "$filename: $hfile $cfile"

    # copy model
    cat ${models[0]} > "$dir/$hfile"
    cat ${models[1]} > "$dir/$cfile"
    
    # replace important snippets
    sed -i "s/ModelClass/$str/g"      "$dir/$hfile"
    sed -i "s/ModelHeader.h/$hfile/g" "$dir/$cfile"
    sed -i "s/ModelClass/$str/g"      "$dir/$cfile"
done

echo "Finished!"