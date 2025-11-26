# Configure environment Venv

message(STATUS "Setting up a Python environment to use .venv")

set(VENV_DIR "${CMAKE_SOURCE_DIR}/.venv")

if(UNIX OR APPLE)
  set(PYTHON_BOOTSTRAP "python3")
elseif(WIN32)
  set(PYTHON_BOOTSTRAP "python")
endif()

if(NOT EXISTS "${VENV_DIR}")
  message(STATUS "Creating Python virtual environment .venv ...")

  if(UNIX OR APPLE)
    execute_process(
      COMMAND bash -c "${PYTHON_BOOTSTRAP} -m venv \"${VENV_DIR}\""
      RESULT_VARIABLE VENV_CREATE_RESULT
      ERROR_VARIABLE VENV_CREATE_ERROR)
  elseif(WIN32)
    execute_process(
      COMMAND powershell.exe -Command
              "& { ${PYTHON_BOOTSTRAP} -m venv '${VENV_DIR}' }"
      RESULT_VARIABLE VENV_CREATE_RESULT
      ERROR_VARIABLE VENV_CREATE_ERROR)
  endif()

  if(NOT VENV_CREATE_RESULT EQUAL 0)
    message(FATAL_ERROR "Failed to create .venv: ${VENV_CREATE_ERROR}")
  endif()

  message(STATUS ".venv created successfully.")
else()
  message(STATUS ".venv already exists.")
endif()

# Define paths inside the venv
if(UNIX OR APPLE)
  set(PYTHON_EXECUTABLE "${VENV_DIR}/bin/python")
  set(PIP_EXECUTABLE "${VENV_DIR}/bin/pip")
elseif(WIN32)
  set(PYTHON_EXECUTABLE "${VENV_DIR}/Scripts/python.exe")
  set(PIP_EXECUTABLE "${VENV_DIR}/Scripts/pip.exe")
endif()

# Ensure CMake finds THIS Python, not system
set(Python3_EXECUTABLE "${PYTHON_EXECUTABLE}")

find_package(
  Python3
  COMPONENTS Interpreter Development
  REQUIRED)

# Export Python info to children projects
set(Python3_INCLUDE_DIRS
    "${Python3_INCLUDE_DIRS}"
    CACHE INTERNAL "")
set(Python3_LIBRARIES
    "${Python3_LIBRARIES}"
    CACHE INTERNAL "")
