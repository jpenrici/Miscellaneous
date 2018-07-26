#!/bin/bash

PATH_WALLPAPERS="~/WALLPAPER"
cd $PATH_WALLPAPERS

TIME_STEP=10m
DATE=$(date +%Y-%m-%d)
LOG="/tmp/feh_wallpaper-log"

echo "feh_wallpaper.sh : $DATE" > $LOG
wallpapers=($(ls | grep '.jpg$'))

while [[ true ]]; do
    for ((i = 0; i < ${#wallpapers[@]}; ++i))
    do
        j=$(( ${#wallpapers[@]} - $i - 1))
        echo "${wallpapers[$i]} ---- ${wallpapers[$j]}" >> $LOG

        #   wallpepar ->        Monitor 1        Monitor 2      #
        exec feh --bg-scale ${wallpapers[$i]} ${wallpapers[$j]} &
        
        sleep $TIME_STEP
    done
done

# Debian 9 - OpenBox
# apt install feh
# chmod +x ~/filename.sh
# add in .config/openbox/autostart
# bash ~/filename.sh &
