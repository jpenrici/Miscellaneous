# bindings/python/CMakeLists.txt

message(STATUS "Setting up the environment for Python integration...")

if(EXISTS "${DIST_DIR}")
  message(STATUS "Make Python subdirectory: ${DIST_DIR}")
  file(MAKE_DIRECTORY "${DIST_DIR}/bindings/python")
  set(VENV_DIR "${DIST_DIR}/bindings/python/.venv")
endif()

add_subdirectory(cli)
add_subdirectory(gui)
