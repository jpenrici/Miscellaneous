# CMakeLists.txt

cmake_minimum_required(VERSION 3.14)

project(TestProject CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

add_executable(test_project src/main.cpp src/hello.cpp include/hello.hpp)
