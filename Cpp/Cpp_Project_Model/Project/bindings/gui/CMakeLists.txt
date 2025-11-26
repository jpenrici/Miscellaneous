# bindings/gui/CMakeLists.txt

# Configure enviroment
include(../PythonEnvSetup.cmake)

# pybind11 library
find_package(pybind11 CONFIG REQUIRED)

if(NOT pybind11_FOUND)
  message(
    WARNING
      "Library pybind11 not found! Some Python code may not work correctly.")
endif()
