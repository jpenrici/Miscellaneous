# bindings/python/gui/CMakeLists.txt

message(STATUS "Setting up the environment for Python GUI integration...")

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

set(PY_GUI_SOURCES
  gui_pyside6.py
)

if(EXISTS "${DIST_DIR}/bindings/python")
  message(STATUS "Copy Python files to ${DIST_DIR}/bindings/python")
  file(COPY ${PY_GUI_SOURCES} DESTINATION "${DIST_DIR}/bindings/python")
endif()
