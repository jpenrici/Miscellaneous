#!/bin/bash
#
# H and Cpp generator from template.
#
# use: ./hcpp_generator3.sh --pragmaOnce dir=destination filename1 filename2 ... filenameN
#
#       Attention: the destination path syntax will not be checked! 
#
# result with --pragmaOnce:
#
#           filename.h                filename.cpp
#
#           # pragma once             #include "filename.h"
#
#           // model code             // model code
#
# else:
#
#           filename.h                filename.cpp
#
#           #ifndef FILENAME_H_       #include "filename.h"
#           #define FILENAME_H_
#                                     // model code
#           // model code             
#
#           #endif

dir="."
args="$@"
models=("model.h" "model.cpp")

echo "H Cpp - Generator 3"

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

arr=($args)
filenames=""
usePragmaOnce=0
for arg in "${arr[@]}"; do
    if [[ "$arg" =~ --pragmaOnce\.* ]]; then
        usePragmaOnce=1
        echo "Use in header file '#pragma once'."
    elif [[ "$arg" =~ dir=\.* ]]; then
        dir=${arg:4}
        if [[ ! -d $dir ]]; then
            echo "Create: $dir"
            mkdir -p $dir
        fi
    else
        filenames="$filenames $arg"
    fi
done

echo "Directory: $dir"

arr=($filenames)
for filename in ${arr[@]}
do
    hfile="$filename.h"
    cfile="$filename.cpp"
    str=${filename^}

    echo "$filename: $hfile $cfile"

    # header
    header="#pragma once\n"
    footer=""
    if [[ $usePragmaOnce -eq 0 ]]; then
        name=$(echo $filename | tr '[:lower:]' '[:upper:]')
        header="#ifndef "$name"_H_\n#define "$name"_H_\n"
        footer="#endif"
    fi
    
    # copy model
    echo -e $header     >  "$dir/$hfile"
    cat model.h         >> "$dir/$hfile"
    echo -e "\n$footer" >> "$dir/$hfile"
    cat model.cpp       >  "$dir/$cfile"
    
    # replace important snippets
    sed -i "s/ModelClass/$str/g"      "$dir/$hfile"
    sed -i "s/ModelHeader.h/$hfile/g" "$dir/$cfile"
    sed -i "s/ModelClass/$str/g"      "$dir/$cfile"
done

echo "Finished!"