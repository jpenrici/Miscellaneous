#!/bin/bash

filenames=("test_basic.cpp" "test_circle.cpp" "test_rectangle.cpp" "test_triangle.cpp")

echo "Test all ..."

for item in "${filenames[@]}"; do

	echo "Compiling $item ..."
	g++ $item -o Test -I./Tools/
	echo "Run ..."
	./Test

	echo "-------------"
	read -p "Continue (Y/N)?" R
	if [ "$R" = "" ]; then
	    R="Y"
	else
	    if [ `echo "$R" | tr '[:lower:]' '[:upper:]'` != "Y" ]; then
		echo "Exit ..."
		exit 0
	    fi
	fi

done

echo "Finished"
