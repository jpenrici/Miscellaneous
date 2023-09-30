cmake_minimum_required(VERSION 3.25)

project(ProjectName LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB SOURCES
    "*.h"
    "*.cpp"
)

# file(GLOB RESOURCE_FILES
#      "resources/images/*.png"
# )

add_executable(
    ${PROJECT_NAME}
    ${SOURCES}
)

target_link_libraries (
    ${PROJECT_NAME} PUBLIC
)

# file(COPY ${RESOURCE_FILES} DESTINATION ${CMAKE_BINARY_DIR}/resources)

install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})


# Doc: https://cmake.org/
#
# Steps to compile:
# mkdir build
# cmake -B build -S .
# make -C build
# ./build/ProjectName