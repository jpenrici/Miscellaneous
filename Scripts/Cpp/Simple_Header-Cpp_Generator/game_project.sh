#!/bin/bash

# Simple script for automatically generating game project scope.

# Game Project
projectName="Game Project"

# Structure
root="./$projectName"
source="$root/source"
resources="$root/resources"

# Files
filenames="game gameobject scene level player enemy obstacle common config"

echo $projectName
if [[ ! -d $resources ]]; then
  echo "Create: $resources"
  mkdir -p "$resources/"{fonts,sounds,sprites,textures}
fi

# Generate
./hcpp_generator3.sh --main dir="$source" $filenames 

cmakelist="models/CMakeLists.txt"
if [[ -f $cmakelist ]]; then
  cp  $cmakelist "$root/"
  echo "Copy: $cmakelist"
  sed -i "s/\"\*\./\"source\/\*\./g" "$root/CMakeLists.txt"
fi

echo "Check: $root"

exit 0