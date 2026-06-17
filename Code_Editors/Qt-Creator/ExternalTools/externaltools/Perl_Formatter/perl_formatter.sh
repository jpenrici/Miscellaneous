#!/bin/bash
# perl_formatter.sh

if [[ $EUID -eq 0 ]]; then
 echo "It is not recommended to run this script in root mode!"
 exit 1
fi

file="$1"

script=$(basename $0)
today=$(date +%Y-%m-%d)
now=$(date +%Y-%m-%d-%H:%M:%S)

echo "Running: $script"
echo "$now"

if [[ -z "$file" || ! -f "$file" ]]; then
  echo "The file was not indicated."
  exit 1
fi

/usr/bin/perltidy -b "$file"

if [[ -f "$file.bak" ]]; then
  echo "Remove: $file.bak"
  rm "$file.bak"
fi