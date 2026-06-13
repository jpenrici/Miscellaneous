# tests/CMakeLists.txt

message(STATUS "Setting up the environment for C++ testing....")

add_executable(${TEST_NAME} test.cpp)

add_test(NAME ${TEST_NAME} COMMAND tests)

set_target_properties(${TEST_NAME} PROPERTIES INSTALL_RPATH "$ORIGIN/../lib"
                                             BUILD_WITH_INSTALL_RPATH TRUE)

target_link_libraries(${TEST_NAME} PRIVATE ${LIBRARY_NAME})

install(TARGETS ${TEST_NAME} RUNTIME DESTINATION bin)
