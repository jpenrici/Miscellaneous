#!/bin/bash
#
# H and Cpp generator from template.
#
# use: ./hcpp_generator3.sh [options] dir="destination" filename1 filename2 ... filenameN
#
#       Attention: 
#           The destination path syntax will not be checked!
#           Use of double quotes mandatory!
#
# options:
#           --pragma    : uses #pragma once when constructing the header.
#           --main      : main.cpp file is included.
#           --cmakelist : CMakeLists.txt file is included.
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
#           filename.h                filename.cpp
#
#           #ifndef FILENAME_H_       #include "filename.h"
#           #define FILENAME_H_
#                                     // model code
#           // model code             
#
#           #endif
#
# example: ./hcpp_generator3.sh --pragma --main --cmakelist dir="Project Cpp" filename1 filename2
#

echo "H Cpp - Generator 3"

args=$@
output="./Source"
models=( \
  "./models/model_2.h" \
  "./models/model_2.cpp" \
  "./models/model_main.cpp" \
  "./models/CMakeLists.txt" \
)

if [[ "$args" = "" ]]; then
  echo "Empty argument!"
  echo "Finished!"
  exit 0
fi

for model in ${models[@]}; do
  echo "Load: $model"
  if [[ ! -f $model ]]; then
    echo "Error: Model files not found!"
    echo "Finished!"
    exit 0
  fi
done

useCmakeFile=0
useMainFile=0
usePragmaOnce=0

directory=""
filenames=""
for args; do
  if [[ "$args" =~ --pragma\.* ]]; then
    usePragmaOnce=1
    echo "Use: #pragma once"
  elif [[ "$args" =~ --main\.* ]]; then
    useMainFile=1
    echo "Use: main.cpp"
  elif [[ "$args" =~ --cmakelist\.* ]]; then
    useCmakeFile=1
    echo "Use: CMakeLists.txt"
  elif [[ "$args" =~ dir=\.* ]]; then
    directory=$(echo "$args"      | sed  -e "s/dir=//g")
    directory=$(echo "$directory" | sed  -e "s/\"//g")
    directory=$(echo "$directory" | sed  -e "s/ /\\ /g")
  else
    filenames="$filenames $args"
  fi
done

if [[ "$directory" == "" ]]; then
  directory="$output"
  echo "Directory argument was not found. Use default!"
fi

echo "Directory: \"$directory\""
echo "Files: \"$filenames\""
if [[ ! -d $directory ]]; then
  echo "Create: \"$directory\""
  mkdir -p "$directory"
fi

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

  echo "Create \"$filename\": $hfile $cfile"
    
  # copy model
  echo -e $header     >  "$directory/$hfile"
  cat ${models[0]}    >> "$directory/$hfile"
  echo -e "\n$footer" >> "$directory/$hfile"
  cat ${models[1]}    >  "$directory/$cfile"
  
  # replace important snippets
  sed -i "s/ModelClass/$str/g"      "$directory/$hfile"
  sed -i "s/ModelHeader.h/$hfile/g" "$directory/$cfile"
  sed -i "s/ModelClass/$str/g"      "$directory/$cfile"
done

# main.cpp
if [[ $useMainFile -eq 1 ]]; then
  cat ${models[2]} > "$directory/main.cpp"
  sed -i "s/DEPENDENCIES/$dependencies/g" "$directory/main.cpp"
  echo "Main: main.cpp"
fi

# CMakeLists.txt
if [[ $useCmakeFile -eq 1 ]]; then
  cat ${models[3]} > "$directory/CMakeLists.txt"
  echo "Cmake: CMakeLists.txt"
fi

echo "Finished!"
exit 0