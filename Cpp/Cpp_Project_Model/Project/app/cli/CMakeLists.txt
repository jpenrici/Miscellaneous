add_executable(${CLI_NAME} cli.cpp)

target_link_libraries(${CLI_NAME} PRIVATE ${LIBRARY_NAME})

install(TARGETS ${CLI_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
