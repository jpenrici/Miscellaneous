#!/bin/bash

SOURCE_FILE=("MAINPROG.cbl" "SUBCALC.cbl")
BUILD_DIR="./build"

EXE_NAME="main"
EXE_PATH="$BUILD_DIR/$EXE_NAME"

if [[ ! -d "$BUILD_DIR" ]]; then
    mkdir -p "$BUILD_DIR"
fi

if cobc -x -free "${SOURCE_FILE[@]}" -o "$EXE_PATH"; then
    echo "Successfully built: $EXE_PATH"
else
    echo "Build failed!"
    exit 1
fi

if [[ -f "$EXE_PATH" ]]; then
    "$EXE_PATH"
    EXIT_CODE=$?
    echo "Execution finished (Code: $EXIT_CODE)"
else
    echo "Error: Binary $EXE_PATH not found."
    exit 1
fi
