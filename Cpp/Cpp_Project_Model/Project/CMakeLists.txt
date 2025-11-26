# Main CMakeLists.txt

cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(
  Project_Name
  VERSION 1.0.0
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE True) # For shared libraries

# Standard Installation Options
include(GNUInstallDirs)

# Compilation Options
option(BUILD_CLI "Build the Command Line Interfaces" ON)
option(BUILD_GUI "Build the Graphical User Interfaces" ON)
option(BUILD_BINDINGS "Build integrations with other languages (Bindings)." ON)
option(BUILD_TESTS "Build the tests" ON)

# Add Subdirectories

# 1. Main Library
set(LIBRARY_NAME library)
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src")
  add_subdirectory(src)
else()
  message(
    FATAL_ERROR "The 'src' directory was not found, so we cannot proceed!")
endif()

# 1. Command Line Interfaces (CLI)
set(CLI_NAME cli)
if(BUILD_CLI)
  add_subdirectory(app/cli)
endif()

# 1. Graphical Interfaces (GUI)
if(BUILD_GUI)
  add_subdirectory(app/gui)
endif()

# 1. Bindings
if(BUILD_BINDINGS)
  add_subdirectory(bindings/cli)
  add_subdirectory(bindings/gui)
endif()

# 1. Tests
set(TEST_NAME test)
if(BUILD_TESTS)
  # enable_testing() # CTest
  add_subdirectory(tests)
endif()

# Distribution directory
set(DIST_DIR "${CMAKE_CURRENT_SOURCE_DIR}/dist")
if(NOT EXISTS "${DIST_DIR}")
  message(STATUS "Make directory: ${DIST_DIR}")
  file(MAKE_DIRECTORY "${DIST_DIR}/lib")
  file(MAKE_DIRECTORY "${DIST_DIR}/bin")
  file(MAKE_DIRECTORY "${DIST_DIR}/include")
endif()

set(CMAKE_INSTALL_PREFIX
    "${DIST_DIR}"
    CACHE PATH "Installation directory prefix" FORCE)
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")

#[==[

    Build and install

    1. Setup
      mkdir build
      cd build
      cmake .. [-DBUILD_CLI=ON -DBUILD_GUI=ON -DBUILD_TESTS=OFF -DBUILD_BINDINGS=OFF]

    2. Build
      cmake --build .

    3. Install
      cmake --install . [--prefix <install_dir>]
      (Example: --prefix ../dist)

     4. Run
       ./dist/bin/cli

]==]
