#!/bin/bash
#
# Simple script to help reinstall packages.
#
#   1. list installed packages.
#   2. analyze dependencies.
#   3. generate recovery list.
#

script=$(basename $0)
today=$(date '+%Y-%m-%d')
echo "Run $script ..."

packageList="packageList"
dependencyList="dependencyList"

# List of all Installed Packages
packages=($(dpkg-query --show --showformat='${binary:Package} '))

# List of dependencies for each package
echo "" > $packageList
echo "" > $dependencyList
for package in "${packages[@]}"; do
 echo "$package ..."
 echo "$package" >> $packageList
 dependencies=$(dpkg-query -f='${Depends}' -W $package)
 dependencies=$(echo $dependencies | sed -r "s/\(([^)]+)\)//g")
 dependencies=($(echo $dependencies | sed -r "s/[\|,\,]//g"))
 for dependency in "${dependencies[@]}"; do
    echo "$dependency" >> $dependencyList
 done
done

# Clean
packages=($(sort -u $packageList))
dependencies=($(sort -u $dependencyList))
echo ""
echo "Wait a minute ..."
echo "apt install \\" > $packageList
for package in "${packages[@]}"; do
    flag=0
    for dependency in "${dependencies[@]}"; do
        if [[ $dependency == $package ]]; then
            flag=1
            break
        fi
    done
    if [[ flag -eq 0 ]]; then
        echo "$package \\" >> $packageList
    fi
done

# Finished
echo "Saved in : $packageList"

exit 0
