#!/bin/bash
#
# H and Cpp generator from template.
#
# use: ./hcpp_generator3.sh [options] dir=destination filename1 filename2 ... filenameN
#
#       Attention: 
#           The destination path syntax will not be checked!
#           Be careful with paths that include whitespace. Use double quotes.
#
# options:
#           --pragmaOnce : uses #pragma once when constructing the header.
#           --main       : main.cpp file is included.
#           --cmake      : CMakeLists.txt file is included.
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
#
# example: ./hcpp_generator3.sh --pragmaOnce --main --cmake dir=source filename1 filename2
#

dir="."
args="$@"
models=("./models/model_2.h" "./models/model_2.cpp" "./models/model_main.cpp" "./models/CMakeLists.txt")

echo "H Cpp - Generator 3"

if [[ "$args" = "" ]]; then
    echo "Empty argument!"
    echo "Finished!"
    exit 0
fi

for model in ${models[@]}; do
    echo -n "Load $model ... "
    if [[ ! -f $model ]]; then
        echo "error: Model files not found!"
        echo "Finished!"
        exit 0
    fi
    echo "Ok!"
done

arr=($args)
filenames=""
usePragmaOnce=0
includeMainFile=0
includeCmakeFile=0
for arg in "${arr[@]}"; do
    if [[ "$arg" =~ --pragmaOnce\.* ]]; then
        usePragmaOnce=1
        echo "Use in header file '#pragma once'."
    elif [[ "$arg" =~ --main\.* ]]; then
        includeMainFile=1
    elif [[ "$arg" =~ --cmake\.* ]]; then
        includeCmakeFile=1
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
dependencies="Dependencies\n"
for filename in ${arr[@]}
do
    hfile="$filename.h"
    cfile="$filename.cpp"
    str=${filename^}
    
    # ignore
    if [[ "$filename" == "main" ]]; then
        continue
    fi

    # dependencies
    dependencies="$dependencies""#include \"$hfile\"\n"

    # header
    header="#pragma once\n"
    footer=""
    if [[ $usePragmaOnce -eq 0 ]]; then
        name=$(echo $filename | tr '[:lower:]' '[:upper:]')
        header="#ifndef "$name"_H_\n#define "$name"_H_\n"
        footer="#endif"
    fi

    echo "$filename: $hfile $cfile"
    
    # copy model
    echo -e $header     >  "$dir/$hfile"
    cat ${models[0]}    >> "$dir/$hfile"
    echo -e "\n$footer" >> "$dir/$hfile"
    cat ${models[1]}    >  "$dir/$cfile"
    
    # replace important snippets
    sed -i "s/ModelClass/$str/g"      "$dir/$hfile"
    sed -i "s/ModelHeader.h/$hfile/g" "$dir/$cfile"
    sed -i "s/ModelClass/$str/g"      "$dir/$cfile"
done

# main.cpp
if [[ $includeMainFile -eq 1 ]]; then
    cat ${models[2]} > "$dir/main.cpp"
    sed -i "s/DEPENDENCIES/$dependencies/g" "$dir/main.cpp"
    echo "Include main.cpp"
fi

# CMakeLists.txt
if [[ $includeCmakeFile -eq 1 ]]; then
    cat ${models[3]} > "$dir/CMakeLists.txt"
    echo "Include CMakeLists.txt"
fi

echo "Finished!"