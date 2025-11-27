# app/gui/qt6/CMakeLists.txt

message(STATUS "Configuring GUI Executable: Qt6 (linked to ${LIBRARY_NAME})")

set(QTGUI_EXEC_NAME gui_qt6)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(QT_MIN_VERSION "6.5.0")
find_package(
  Qt6 ${QT_MIN_VERSION}
  COMPONENTS Widgets
  REQUIRED)

set(QT_PROJECT_SOURCES main.cpp mainwindow.cpp mainwindow.h mainwindow.ui)

qt_add_executable(${QTGUI_EXEC_NAME} ${QT_PROJECT_SOURCES})

target_link_libraries(${QTGUI_EXEC_NAME} PRIVATE Qt6::Widgets ${LIBRARY_NAME})

install(
  TARGETS ${QTGUI_EXEC_NAME}
  BUNDLE DESTINATION .
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

add_custom_target(
  run_qtgui
  COMMAND ${QTGUI_EXEC_NAME}
  DEPENDS ${QTGUI_EXEC_NAME}
  WORKING_DIRECTORY ${DIST_DIR})

set_target_properties(${QTGUI_EXEC_NAME}
                      PROPERTIES BUILD_RPATH lib RUNTIME_OUTPUT_DIRECTORY bin)
