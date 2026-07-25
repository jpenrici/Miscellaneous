cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(Project_Name VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ========== Global Variables ==========
set(PROGRAM_NAME "program_name")
set(LIBRARY_NAME "program_lib")
set(TEST_EXECUTABLE_NAME "test")

# ========== Dependencies ==========
find_package(Boost 1.70 REQUIRED COMPONENTS sys)
if (NOT Boost_FOUND)
    message(FATAL_ERROR "The Boost library could not be found.")
fi

# ========== Core Library ==========
include_directories(include)

add_library(${LIBRARY_NAME} SHARED
  src/code.cpp
)

set_target_properties(${LIBRARY_NAME} PROPERTIES
    OUTPUT_NAME ${LIBRARY_NAME}
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/lib"
)

# ========== CLI Executable ==========
add_executable(${PROGRAM_NAME} cli/main.cpp)
target_link_libraries(${PROGRAM_NAME} PRIVATE ${LIBRARY_NAME})
set_target_properties(${PROGRAM_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/cli
)

# ========== Tests ==========
add_executable(${PROGRAM_NAME}_test tests/test.cpp)
target_link_libraries(${PROGRAM_NAME}_test ${LIBRARY_NAME})
add_custom_target(test_run
    COMMAND ${PROGRAM_NAME}_test
    DEPENDS ${PROGRAM_NAME}_test
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
set_target_properties(${PROGRAM_NAME}_test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/tests
)

# ========== Copy Resources ==========
file(COPY resources DESTINATION ${CMAKE_BINARY_DIR}/resources)

# ========== Default Build Type ==========
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the build type" FORCE)
endif()

# ========== Custom Clean Target ==========
add_custom_target(deep_clean
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}
    COMMENT ">>> Completely cleaning the build directory: ${CMAKE_BINARY_DIR}"
)