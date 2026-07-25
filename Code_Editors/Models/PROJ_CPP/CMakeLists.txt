cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(
  Project_Name
  VERSION 1.0.0
  LANGUAGES CXX)

set(PROGRAM_NAME "program_name")

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(SOURCES src/main.cpp)

add_executable(${PROGRAM_NAME} ${SOURCES})

install(
  TARGETS ${PROGRAM_NAME}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

target_compile_options(${PROGRAM_NAME} PRIVATE -Wall -Wextra -Wpedantic -Wconversion)

#add_custom_command(
#  TARGET ${PROGRAM_NAME} POST_BUILD
#  COMMAND ${CMAKE_COMMAND} -E copy_directory
#          ${CMAKE_CURRENT_SOURCE_DIR}/resources
#          $<TARGET_FILE_DIR:${PROGRAM_NAME}>/resources
#  COMMENT "Copying assets to build directory...")
