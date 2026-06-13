#!/bin/bash
# install.sh - Project Build and Installation Script (Flexible Component Build)

# --- Configuration Variables ---

# Determine the absolute path of the directory containing the script.
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="build"
DIST_DIR="dist" # Installation directory for binaries, libraries, and resources.
BUILD_TYPE="Debug"
# Initialize component flags to OFF by default. User must specify which to build.
BUILD_CLI_FLAG="OFF"
BUILD_GUI_FLAG="OFF"
BUILD_TESTS_FLAG="OFF"
BUILD_BINDINGS_FLAG="OFF"
CACHE_ENTRY="" # Will be constructed dynamically

# Calculate the number of parallel jobs for building.
NPROC_AVAILABLE=$(nproc)
NPROC_JOBS=$(( NPROC_AVAILABLE / 2 ))
if [[ NPROC_JOBS -eq 0 ]]; then
    NPROC_JOBS=1
fi

# --- Functions ---

# Displays script usage information.
use_project() {
    echo "Usage: ./install.sh [Mode Option] [Build Component Options]"
    echo ""
    echo "Mode Options (mutually exclusive):"
    echo "  --help     : Displays this usage information."
    echo "  --debug    : Configures and builds in Debug mode (default if only components are specified)."
    echo "  --release  : Configures and builds in Release (optimized) mode."
    echo "  --install  : Installs the built project to the '$DIST_DIR' directory (uses last successful configuration)."
    echo "  --clean    : Removes the build ('$BUILD_DIR') and install ('$DIST_DIR') directories (REQUIRED to change build components)."
    echo "  --all      : Cleans, configures, builds, and installs ALL components (--cli, --gui, etc.)."
    echo ""
    echo "Build Component Options (can be combined):"
    echo "  --cli      : Enables -DBUILD_CLI=ON."
    echo "  --gui      : Enables -DBUILD_GUI=ON."
    echo "  --tests    : Enables -DBUILD_TESTS=ON."
    echo "  --bindings : Enables -DBUILD_BINDINGS=ON."
    echo ""
    echo "Examples:"
    echo "1. Build only the CLI (in Debug mode):"
    echo "   ./install.sh --cli"
    echo ""
    echo "2. Change from CLI build to GUI build (requires cleaning):"
    echo "   ./install.sh --clean"
    echo "   ./install.sh --gui"
    echo ""
    echo "3. Full Build, Clean, and Install of ALL components (in Release mode):"
    echo "   ./install.sh --release --all"
    echo ""
    echo "4. Full Build of CLI and Bindings, then Install (in Release mode):"
    echo "   ./install.sh --release --cli --bindings"
    echo "   ./install.sh --install"
    echo ""
    exit 1
}

# Removes specified directories (typically build and dist).
clean_project() {
    for dir in "$@"; do
        FULL_PATH="$PROJECT_DIR/$dir"
        echo "Checking directory: $FULL_PATH"

        if [[ -d "$FULL_PATH" ]]; then
            echo "Removing directory: $FULL_PATH"
            rm -rf "$FULL_PATH"
        else
            echo "The directory ($FULL_PATH) was not found. Nothing to do."
        fi
    done
}

# Configures and builds the project using CMake.
build_project() {
    BUILD_PATH="$PROJECT_DIR/$BUILD_DIR"

    # 1. Construct the CACHE_ENTRY dynamically
    cache_entry="-DBUILD_CLI=$BUILD_CLI_FLAG -DBUILD_GUI=$BUILD_GUI_FLAG"
    cache_entry="$cache_entry -DBUILD_TESTS=$BUILD_TESTS_FLAG -DBUILD_BINDINGS=$BUILD_BINDINGS_FLAG"

    echo "--- Build Configuration ---"
    echo "BUILD TYPE: $BUILD_TYPE"
    echo "CMAKE OPTIONS: $cache_entry"
    echo "---------------------------"

    if [[ ! -d "$BUILD_PATH" ]]; then
        echo "Creating the build directory: $BUILD_PATH"
        mkdir -p "$BUILD_PATH"
    fi

    cd "$BUILD_PATH" || exit 1

    echo "Setting up the CMake project..."
    cmake "$PROJECT_DIR" \
          -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
          -DBUILD_CLI="$BUILD_CLI_FLAG" \
          -DBUILD_GUI="$BUILD_GUI_FLAG" \
          -DBUILD_TESTS="$BUILD_TESTS_FLAG" \
          -DBUILD_BINDINGS="$BUILD_BINDINGS_FLAG" \
           -G "Unix Makefiles"

    if [[ $? -ne 0 ]]; then
        echo "CMake configuration failed. Exiting."
        cd "$PROJECT_DIR"
        exit 1
    fi

    echo "Building the project with $NPROC_JOBS parallel jobs..."
    cmake --build . -- -j"$NPROC_JOBS"

    if [[ $? -ne 0 ]]; then
        echo "Build error. Please check the errors above."
        cd "$PROJECT_DIR"
        exit 1
    fi

    echo "Build completed successfully!"
    cd "$PROJECT_DIR"
}

# Installs the built project to the distribution directory.
install_project() {
    BUILD_PATH="$PROJECT_DIR/$BUILD_DIR"
    DIST_PATH="$PROJECT_DIR/$DIST_DIR"

    if [[ ! -d "$BUILD_PATH" ]]; then
        echo "Error: The build directory '$BUILD_PATH' does not exist. Build the project first!"
        exit 1
    fi

    cd "$BUILD_PATH" || exit 1

    echo "Installing the project to $DIST_PATH"
    cmake --install . --prefix "$DIST_PATH"

    if [[ $? -ne 0 ]]; then
        echo "Installation failed!"
        cd "$PROJECT_DIR"
        exit 1
    fi

    echo "Installation completed successfully! Executables and libraries are available in $DIST_PATH"
    cd "$PROJECT_DIR"
}

# --- Execution Logic ---

display_header() {
    echo "PROJECT: $PROJECT_DIR"
    echo "PARALLEL JOBS LIMIT: $NPROC_JOBS/$NPROC_AVAILABLE"
}

DIRECTORIES_TO_CLEAN=("$BUILD_DIR" "$DIST_DIR")
MODE_OPTION=""

# --- 1. Process all arguments to identify the main mode and component flags ---
# This loop handles flags independently, allowing: ./install.sh --release --cli
while [[ $# -gt 0 ]]; do
    case "$1" in
        # Mode Options (determine the main action)
        "--clean"|"--release"|"--debug"|"--install"|"--help")
            MODE_OPTION="$1"
            shift # Consume the argument
            ;;
        "--all")
            MODE_OPTION="$1"
            # Ensures all flags are active
            BUILD_CLI_FLAG="ON"
            BUILD_GUI_FLAG="ON"
            BUILD_TESTS_FLAG="ON"
            BUILD_BINDINGS_FLAG="ON"
            shift
            ;;
        # Component Options (set the build flags to ON)
        "--cli")
            BUILD_CLI_FLAG="ON"
            shift
            ;;
        "--gui")
            BUILD_GUI_FLAG="ON"
            shift
            ;;
        "--tests")
            BUILD_TESTS_FLAG="ON"
            shift
            ;;
        "--bindings")
            BUILD_BINDINGS_FLAG="ON"
            shift
            ;;
        *)
            # Stop processing if an unknown argument is found
            break
            ;;
    esac
done


# --- 2. Execute the Main Mode based on the collected options ---
case "$MODE_OPTION" in
    "--help")
        use_project
        exit 1
        ;;
    "--clean")
        display_header
        clean_project "${DIRECTORIES_TO_CLEAN[@]}"
        ;;
    "--release")
        BUILD_TYPE="Release"
        display_header
        build_project
        ;;
    "--debug")
        BUILD_TYPE="Debug"
        display_header
        build_project
        ;;
    "--install")
        display_header
        install_project
        ;;
    "--all")
        display_header
        build_project
        install_project
        ;;
    "")
        if [[ $# -gt 0 ]]; then
            echo "Error: Unknown mode option detected." 1>&2
            use_project
        fi

        # Default action is to build
        BUILD_TYPE="Debug"
        display_header
        build_project
        ;;
esac
