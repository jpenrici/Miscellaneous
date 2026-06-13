cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(%{ProjectName} VERSION 1.0 LANGUAGES Fortran)

set(EXECUTABLE_NAME %{ProjectName})

set(SOURCE_DIR "app")

file(GLOB SOURCES "\${SOURCE_DIR}/*.f90" "\${SOURCE_DIR}/*.F90" "\${SOURCE_DIR}/*.f")

add_executable(\${EXECUTABLE_NAME} \${SOURCES})

set_target_properties(\${EXECUTABLE_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY
                                                    "\${CMAKE_BINARY_DIR}/bin")

if(CMAKE_Fortran_COMPILER_WORKS)
  target_compile_options(\${EXECUTABLE_NAME} PRIVATE -O3)
  target_compile_options(\${EXECUTABLE_NAME} PRIVATE -std=f2018)
endif()
