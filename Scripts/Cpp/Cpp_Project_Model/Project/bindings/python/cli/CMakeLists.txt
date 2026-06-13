# bindings/python/cli/CMakeLists.txt

message(STATUS "Setting up the environment for Python CLI integration...")

# Configure enviroment
include(../PythonEnvSetup.cmake)

# pybind11 library
find_package(pybind11 CONFIG REQUIRED)

if(NOT pybind11_FOUND)
  message(
    WARNING
      "Library pybind11 not found! Some Python code may not work correctly.")
endif()

set(PY_CLI_SOURCES
  cli_ctypes.py
)

if(EXISTS "${DIST_DIR}/bindings/python")
  message(STATUS "Copy Python files to ${DIST_DIR}/bindings/python")
  file(COPY ${PY_CLI_SOURCES} DESTINATION "${DIST_DIR}/bindings/python")
endif()
