#!/bin/bash

# Location where the images will be located.
PATH_WALLPAPERS="$HOME/WALLPAPER/"
cd $PATH_WALLPAPERS

# Transition interval between images in minutes.
TIME_STEP=8m

# Log
DATE=$(date +%Y-%m-%d)
HOURS=$(date +%H:%M:%S)
LOG="/tmp/feh_wallpaper-log"

# Start
echo "feh_wallpaper.sh : $DATE $HOURS" > $LOG
wallpapers=($(ls | grep '.jpg$'))
elements=${#wallpapers[@]}

# Loop
while [[ true ]]; do

	i=$(( $RANDOM % $elements ))
	j=$(( $elements - $i ))

    echo "${wallpapers[$i]} ---- ${wallpapers[$j]}" >> $LOG

    #   wallpepar ->        Monitor 1        Monitor 2      #
    exec feh --bg-scale ${wallpapers[$i]} ${wallpapers[$j]} &
    # exec feh --bg-scale ${wallpapers[$i]} &
        
    sleep $TIME_STEP
done

# Debian - OpenBox
# apt install feh
# chmod +x ~/filename.sh
# add in .config/openbox/autostart
# bash ~/filename.sh &
