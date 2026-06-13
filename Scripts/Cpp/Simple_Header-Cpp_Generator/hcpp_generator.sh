#!/bin/bash
#
# H and Cpp file generator.
#
# use: ./hcpp_generator.sh filename1 filename2 ... filenameN
#
# result:
#           filename.h          filename.cpp
#
#           # pragma once       #include "filename.h"
#
#           // code             // code
#

filenames="$@"

echo "H Cpp - Generator"

if [[ "$filenames" = "" ]]; then
    echo "Empty argument!"
    echo "Finished!"
    exit 0
fi

for filenames
do
    echo "$filenames: $filenames.h $filenames.cpp"
    printf "#pragma once\n\n// Code" > $filenames.h
    printf "#include \"$filenames.h\"\n\n// Code" > $filenames.cpp
done

echo "Finished!"