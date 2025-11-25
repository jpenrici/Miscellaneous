# Main CMakeLists.txt
cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(Project_Name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE True) # For shared libraries

# Standard Installation Options
include(GNUInstallDirs)

# Compilation Options
option(BUILD_CLI      "Build the Command Line Interfaces" ON)
option(BUILD_GUI      "Build the Graphical User Interfaces" ON)
option(BUILD_BINDINGS "Build integrations with other languages (Bindings)." ON)
option(BUILD_TESTS    "Build the tests" ON)

# Add Subdirectories

# 1. Main Library
set(LIBRARY_NAME library)
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/lib")
    add_subdirectory(lib)
else()
    message(FATAL_ERROR "The 'lib' directory was not found, so we cannot proceed!")
endif()

# 2. Command Line Interfaces (CLI)
set(CLI_NAME cli)
if(BUILD_CLI)
    add_subdirectory(app/cli)
endif()

# 3. Graphical Interfaces (GUI)
if(BUILD_GUI)
    add_subdirectory(app/gui)
endif()

# 4. Bindings
if(BUILD_BINDINGS)
    add_subdirectory(bindings/cli)
    add_subdirectory(bindings/gui)
endif()

# 5. Tests
set(TEST_NAME test)
if(BUILD_TESTS)
    # enable_testing() # CTest
    add_subdirectory(tests)
endif()

# Build and install
#
# mkdir build
# cd build
# cmake ..
# cmake .. -DBUILD_CLI=ON -DBUILD_GUI=ON -DBUILD_TESTS=OFF
# cmake --build .
#
# cmake --install . --prefix ./install_dir
