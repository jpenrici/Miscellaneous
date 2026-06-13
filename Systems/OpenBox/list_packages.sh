#!/bin/bash
#
# Simple script to help reinstall packages.
# Run when it is necessary to remember installed packages.
# 
# Script:
#   1. list installed packages.
#   2. analyze dependencies.
#   3. generate and save recovery list.
#
# Use:
#   ./list_packages.sh <path>

arg="$1"
script=$(basename $0)
today=$(date '+%Y-%m-%d')

packageList="/tmp/packageList"
dependencyList="/tmp/dependencyList"
recoveryList="recoveryList-$today"

echo "Run $script ..."
if [[ "$arg" != "" ]]; then
    if [[ ! -d "$arg" ]]; then
        echo "Path not found!"
        exit 0
    fi
    if [[ ${arg: -1} == "/" ]]; then
        recoveryList="$arg$recoveryList"
    else
        recoveryList="$arg/$recoveryList"
    fi
fi

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

# Clean and save
packages=($(sort -u $packageList))
dependencies=($(sort -u $dependencyList))
for package in "${packages[@]}"; do
    flag=0
    for dependency in "${dependencies[@]}"; do
        if [[ $dependency == $package ]]; then
            flag=1
            break
        fi
    done
    if [[ flag -eq 0 ]]; then
        echo -e "\t$package\t\\" >> $recoveryList
    fi
done
echo "; # recoveryList-$today" >> $recoveryList

# Finished
echo "Saved in : $recoveryList"

exit 0
