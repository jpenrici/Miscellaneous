cmake_minimum_required(VERSION 3.15)

project(example_app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(example_app src/main.cpp src/calculator.cpp src/shape.cpp
                           src/logger.cpp)

target_include_directories(example_app PRIVATE include)
