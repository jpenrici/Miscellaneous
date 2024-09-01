cmake_minimum_required(VERSION 3.28)

project(%{ProjectName} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SOURCES
    ./src/%{LibraryName}.cpp
)

set(LIBRARY_NAME %{LibraryName})

add_library(\${LIBRARY_NAME} SHARED \${SOURCES})

set_target_properties(\${LIBRARY_NAME} PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY "\${PROJECT_SOURCE_DIR}/lib"
)

# Doc: https://cmake.org/
#
# Steps to compile:
# mkdir build
# cmake -B build -S .
# make -C build
