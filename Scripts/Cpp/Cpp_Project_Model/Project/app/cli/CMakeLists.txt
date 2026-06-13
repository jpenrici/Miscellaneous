# app/cli/CMakeLists.txt

message(
  STATUS "Configuring CLI Executable: ${CLI_NAME} (linked to ${LIBRARY_NAME})")

add_executable(${CLI_NAME} cli.cpp)

set_target_properties(${CLI_NAME} PROPERTIES INSTALL_RPATH "$ORIGIN/../lib"
                                             BUILD_WITH_INSTALL_RPATH TRUE)

target_link_libraries(${CLI_NAME} PRIVATE ${LIBRARY_NAME})

install(TARGETS ${CLI_NAME} RUNTIME DESTINATION bin)
