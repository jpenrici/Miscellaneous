#!/bin/bash

PATH_WALLPAPERS="$HOME/WALLPAPER"
cd $PATH_WALLPAPERS

TIME_STEP=8m
DATE=$(date +%Y-%m-%d)
HOURS=$(date +%H:%M:%S)
LOG="/tmp/feh_wallpaper-log"

echo "feh_wallpaper.sh : $DATE $HOURS" > $LOG
wallpapers=($(ls | grep '.jpg$'))
elements=${#wallpapers[@]}

while [[ true ]]; do

	i=$(( $RANDOM % $elements ))
	j=$(( $elements - $i ))

    echo "${wallpapers[$i]} ---- ${wallpapers[$j]}" >> $LOG

    #   wallpepar ->        Monitor 1        Monitor 2      #
    exec feh --bg-scale ${wallpapers[$i]} ${wallpapers[$j]} &
        
    sleep $TIME_STEP
done

# Debian 9 - OpenBox
# apt install feh
# chmod +x ~/filename.sh
# add in .config/openbox/autostart
# bash ~/filename.sh &