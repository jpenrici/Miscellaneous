#!/bin/bash

# ==============================================================================
# COBOL Build and Run Manager
# Description: Handles arguments dynamically even if filename is omitted.
# ==============================================================================

# --- Variables and Defaults ---
SOURCE_FILE="main.cob"
BUILD_DIR="./build"
VERBOSE=false
DO_BUILD=false
DO_RUN=false
FLAGS_PROVIDED=false

# --- Helper Function: Usage ---
usage() {
    echo "Usage: $0 [filename.cob] [options]"
    echo "Options:"
    echo "  --clean     Remove the build directory"
    echo "  --verbose   Display detailed execution messages"
    echo "  --build     Compile the source file"
    echo "  --run       Execute the binary"
    echo "  --all       Compile and Run"
    exit 1
}

# --- Argument Parsing ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        *.cob)
            SOURCE_FILE="$1"
            shift
            ;;
        --clean)
            if [[ -d "$BUILD_DIR" ]]; then
                [[ "$VERBOSE" = true ]] && echo "Cleaning $BUILD_DIR..."
                rm -rf "$BUILD_DIR"
            fi
            FLAGS_PROVIDED=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --build)
            DO_BUILD=true
            FLAGS_PROVIDED=true
            shift
            ;;
        --run)
            DO_RUN=true
            FLAGS_PROVIDED=true
            shift
            ;;
        --all)
            DO_BUILD=true
            DO_RUN=true
            FLAGS_PROVIDED=true
            shift
            ;;
        --help|-h)
            usage
            ;;
        *)
            echo "Unknown option or invalid file: $1"
            usage
            ;;
    esac
done

# If no action flags (--build, --run, --all, --clean) were provided, default to --all
if [[ "$FLAGS_PROVIDED" = false ]]; then
    DO_BUILD=true
    DO_RUN=true
fi

# --- Check if Source File Exists ---
if [[ "$DO_BUILD" = true && ! -f "$SOURCE_FILE" ]]; then
    echo "Error: Source file '$SOURCE_FILE' not found."
    exit 1
fi

# --- Setup Execution Path ---
EXE_NAME=$(basename "$SOURCE_FILE" .cob)
EXE_PATH="$BUILD_DIR/$EXE_NAME"

# --- 1. Dependency Check ---
if ! command -v cobc &> /dev/null; then
    echo "Error: GnuCOBOL 'cobc' not found."
    exit 1
fi

# --- 2. Environment Setup ---
if [[ "$DO_BUILD" = true && ! -d "$BUILD_DIR" ]]; then
    [[ "$VERBOSE" = true ]] && echo "Creating directory: $BUILD_DIR"
    mkdir -p "$BUILD_DIR"
fi

# --- 3. Compilation Phase ---
if [[ "$DO_BUILD" = true ]]; then
    [[ "$VERBOSE" = true ]] && echo "Compiling $SOURCE_FILE..."
    if cobc -x -free "$SOURCE_FILE" -o "$EXE_PATH"; then
        [[ "$VERBOSE" = true ]] && echo "Successfully built: $EXE_PATH"
    else
        echo "Build failed!"
        exit 1
    fi
fi

# --- 4. Execution Phase ---
if [[ "$DO_RUN" = true ]]; then
    if [[ -f "$EXE_PATH" ]]; then
        [[ "$VERBOSE" = true ]] && echo "Starting execution of $EXE_NAME..."
        [[ "$VERBOSE" = true ]] && echo "--------------------------------------------------"
        "$EXE_PATH"
        EXIT_CODE=$?
        [[ "$VERBOSE" = true ]] && echo "--------------------------------------------------"
        [[ "$VERBOSE" = true ]] && echo "Execution finished (Code: $EXIT_CODE)"
    else
        echo "Error: Binary $EXE_PATH not found."
        exit 1
    fi
fi
