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

if(EXISTS "${VENV_DIR}")
  message(STATUS "Checking for PySide6 in .venv...")

  execute_process(
    COMMAND ${PYTHON_EXECUTABLE} -m pip show PySide6
    RESULT_VARIABLE PYSIDE_INSTALLED_RESULT
    OUTPUT_QUIET ERROR_QUIET)

  if(NOT PYSIDE_INSTALLED_RESULT EQUAL 0)
    message(STATUS "PySide6 not found. Installing...")

    # Install PySide6 inside .venv
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -m pip install --upgrade pip
      COMMAND ${PYTHON_EXECUTABLE} -m pip install PySide6
      RESULT_VARIABLE INSTALL_RESULT
      ERROR_VARIABLE INSTALL_ERROR)

    if(NOT INSTALL_RESULT EQUAL 0)
      message(WARNING "Failed to install PySide6: ${INSTALL_ERROR}")
    endif()
    message(STATUS "PySide6 installed successfully.")
  else()
    message(STATUS "PySide6 found. No installation needed.")
  endif()
else()
  message(
    WARNING
      "The Python Virtual Environment is required to run PySide6, but ${VENV_DIR} does not exist."
  )
endif()
