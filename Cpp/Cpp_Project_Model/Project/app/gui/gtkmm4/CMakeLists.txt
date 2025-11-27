# app/gui/gtkmm4/CMakeLists.txt

message(STATUS "Configuring GUI Executable: GTKmm4 (linked to ${LIBRARY_NAME})")

set(GTKMM_EXEC_NAME gui_gtkmm4)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM gtkmm-4.0 REQUIRED)

set(GTKMM_PROJECT_SOURCES main.cpp mainwindow.cpp mainwindow.hpp
                          gtk_mainwindow.ui)

add_executable(${GTKMM_EXEC_NAME} ${GTKMM_PROJECT_SOURCES})

target_include_directories(${GTKMM_EXEC_NAME} PRIVATE ${GTKMM_INCLUDE_DIRS})

target_link_libraries(${GTKMM_EXEC_NAME} PRIVATE ${GTKMM_LIBRARIES}
                                                 ${LIBRARY_NAME})

target_compile_options(${GTKMM_EXEC_NAME} PRIVATE ${GTKMM_CFLAGS_OTHER})

install(
  TARGETS ${GTKMM_EXEC_NAME}
  BUNDLE DESTINATION .
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

add_custom_target(
  run_gtkmm
  COMMAND ${GTKMM_EXEC_NAME}
  DEPENDS ${GTKMM_EXEC_NAME}
  WORKING_DIRECTORY ${DIST_DIR})

set_target_properties(${GTKMM_EXEC_NAME}
                      PROPERTIES BUILD_RPATH lib RUNTIME_OUTPUT_DIRECTORY bin)
