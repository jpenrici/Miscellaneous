#!/bin/bash
#
# Simple script to help reinstall packages.
# Run when it is necessary to remember installed packages.
# 
# Script
#   1. list installed packages.
#   2. analyze dependencies.
#   3. generate and save recovery list.
#

script=$(basename $0)
today=$(date '+%Y-%m-%d')
echo "Run $script ..."

packageList="packageList"
dependencyList="dependencyList"
recoveryList="recoveryList-$today"

# List of all Installed Packages
packages=($(dpkg-query --show --showformat='${Status;7}:${Package} '))

# List of dependencies for each package
counter=0
echo -n "" > $packageList
echo -n "" > $dependencyList
for package in "${packages[@]}"; do
    if [[ ${package:0:8} == "install:" ]]; then
        package=${package:8}
        counter=$((counter+1))
        echo "$counter : $package  ... "
        echo "$package" >> $packageList
        dependencies=$(dpkg-query -f='${Depends}' -W $package)
        dependencies=$(echo $dependencies | sed -r "s/\(([^)]+)\)//g")
        dependencies=($(echo $dependencies | sed -r "s/[\|,\,]//g"))
        for dependency in "${dependencies[@]}"; do
            echo "$dependency" >> $dependencyList
        done
    fi
done

echo ""
echo "Wait a minute ..."
echo "apt install \\" > $recoveryList
echo -ne "\t" >> $recoveryList

# Clean and save
packages=($(sort -u $packageList))
dependencies=($(sort -u $dependencyList))
counter=0; limit=10
for package in "${packages[@]}"; do
    flag=0
    for dependency in "${dependencies[@]}"; do
        if [[ $dependency == $package ]]; then
            flag=1
            break
        fi
    done
    counter=$((counter+1))
    if [[ flag -eq 0 ]]; then
        echo -n "$package " >> $recoveryList
        if [[ counter -ge limit ]]; then
            counter=0
            echo "\\" >> $recoveryList
            echo -ne "\t">> $recoveryList
        fi
    fi
done

# Finished
echo "Saved in : $recoveryList"

exit 0
