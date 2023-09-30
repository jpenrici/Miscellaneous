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

echo "Game Project"
if [[ ! -d $resources ]]; then
  echo "Create: $resources"
  mkdir -p "$resources"
fi

exec ./hcpp_generator3.sh --main --cmakelist dir="$source" $filenames

exit 0