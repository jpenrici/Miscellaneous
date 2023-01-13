#!/bin/bash
#
# H and Cpp generator from template.
#
# use: ./hcpp_generator2.sh filename1 filename2 ... filenameN
#
# result:
#           filename.h          filename.cpp
#
#           # pragma once       #include "filename.h"
#
#           // code             // code
#

filenames="$@"
models=("model.h" "model.cpp")

echo "H Cpp - Generator 2"

if [[ "$filenames" = "" ]]; then
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

for filenames
do
    hfile="$filenames.h"
    cfile="$filenames.cpp"
    str=${filenames^}

    echo "$filenames: $hfile $cfile"
    
    cat model.h > $hfile
    cat model.cpp > $cfile
    
    sed -i "s/ModelClass/$str/g" $hfile
    sed -i "s/ModelHeader.h/$hfile/g" $cfile
    sed -i "s/ModelClass/$str/g" $cfile
done

echo "Finished!"