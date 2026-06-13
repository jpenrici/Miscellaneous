#!/bin/bash
#
# Script auxilia a preparar arquivo Menu para uso no Xfce Panel e Openbox.
#
# Referências:
#   https://docs.xfce.org/xfce/xfce4-panel/start
#   https://specifications.freedesktop.org/menu-spec/menu-spec-latest.html

script=$(basename $0)
today=$(date +%Y-%m-%d)

# Application Path
app_path=("/usr/share/applications/" "$HOME/.local/share/applications/")

# Output
output="categories.menu"

# XML
header=\
"<!DOCTYPE Menu PUBLIC \"-//freedesktop//DTD Menu 1.0//EN\"
  \"http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd\">

<Menu>
    <!-- Menu for xfce4-panel -->
    <Name>Openbox</Name>

    <!-- Read standard .directory and .desktop file locations -->
    <DefaultAppDirs/>
    <DefaultDirectoryDirs/>

    <!-- Read in overrides and child menus from applications-merged/ -->
    <DefaultMergeDirs/>
"

# Log
echo "Started [ $(date '+%Y-%m-%d %H:%M:%S') ]." > /tmp/"log-$script-$today"

# Prepare
list=()
key="Categories="
echo "Script: $script ..."
echo "Reading files '.desktop' ..."
for path in ${app_path[@]}; do
    files=$(ls $path | grep '.desktop')
    for file in ${files[@]}; do
        tmp=$(grep "^$key" $path$file)
        tmp=$(echo "$tmp" | sed "s/"$key"/""/g")
        list+=($(echo "$tmp" | tr ';' " "))
    done
done
categories=($(for item in "${list[@]}"; do echo "${item}"; done | sort -u))

# Select
all=1
read -p "${#categories[@]} categories were found, would you like to select? Yes or No [y/n]? " yn
case $yn in
    [Yy]* ) all=0;;
    * ) echo "Do not select categories. Building menu ...";;
esac

# Menu
echo "$header" > $output    # open
for category in ${categories[@]}; do
    if [ $all -eq 0 ]; then
        read -p "$category : Yes or No [Enter key/n]? " yn
        case $yn in
            [Nn]* ) echo "$category not included ..."; continue;;
            # * ) echo "$category included ...";;
        esac
    fi
    # Category
    echo "    <Menu>" >> $output
    echo "        <Name>$category</Name>" >> $output
    echo "        <Include>" >> $output
    echo "            <Category>$category</Category>" >> $output
    echo "        </Include>" >> $output
    echo "    </Menu>" >> $output
    echo "" >> $output    
done
echo "</Menu>" >> $output   # close
echo "Saved in \"$output\""

echo "Finished [ $(date '+%Y-%m-%d %H:%M:%S') ]." >> /tmp/"log-$script-$today"
exit 0
