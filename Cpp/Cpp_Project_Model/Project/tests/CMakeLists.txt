add_executable(${TEST_NAME} test.cpp)

target_link_libraries(${TEST_NAME} PRIVATE ${LIBRARY_NAME})

add_test(NAME ${TEST_NAME} COMMAND tests)
