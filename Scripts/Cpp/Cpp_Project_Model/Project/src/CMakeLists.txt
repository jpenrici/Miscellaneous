# src/CMakeLists.txt

message(STATUS "Setting up a Shared Library: ${LIBRARY_NAME}")

add_library(${LIBRARY_NAME} SHARED src/lib.cpp)

# Include configuration
target_include_directories(
  ${LIBRARY_NAME} PUBLIC $<INSTALL_INTERFACE:include>
                         $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

# Header Installation
install(
  DIRECTORY include/
  DESTINATION include
  FILES_MATCHING
  PATTERN "*.hpp")

# Binary Installation and Export Configuration
install(
  TARGETS ${LIBRARY_NAME}
  EXPORT ${LIBRARY_NAME}Targets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin)

# Installation of the Configuration File (find_package)
install(
  EXPORT ${LIBRARY_NAME}Targets
  FILE ${LIBRARY_NAME}Config.cmake
  NAMESPACE ${LIBRARY_NAME}::
  DESTINATION lib/cmake/${LIBRARY_SRC_DIR})
