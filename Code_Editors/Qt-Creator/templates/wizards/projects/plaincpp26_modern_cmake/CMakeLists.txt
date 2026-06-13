cmake_minimum_required(VERSION 3.25 FATAL_ERROR)

project(%{ProjectName} LANGUAGES CXX)

set(PROGRAM_NAME %{ProjectName})

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) 

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include")
    include_directories(include)
endif()

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src")
    file(GLOB SOURCES src/*.cpp)
else()
    set(SOURCES main.cpp)
endif()

set(RESOURCE_FILES
# image.png # example
)

add_executable(\${PROGRAM_NAME} \${SOURCES})

set(EXTERNAL_LIBRARIES
# Lua # example
)

function(find_and_link_library LIBRARY_NAME)
    set(PACKAGE_NAME \${LIBRARY_NAME})
    string(TOUPPER \${LIBRARY_NAME} LIBRARY_UPPER)
    set(INCLUDE_DIR "\${LIBRARY_UPPER}_INCLUDE_DIR")
    set(LIBRARIES "\${LIBRARY_UPPER}_LIBRARIES")

    find_package(\${PACKAGE_NAME} REQUIRED)
    if(\${PACKAGE_NAME}_FOUND)
        message(STATUS "\${LIBRARY_NAME} found:")
        message(STATUS "  Include Directory: \${\${INCLUDE_DIR}}")
        message(STATUS "  Libraries: \${\${LIBRARIES}}")
        include_directories(\${\${INCLUDE_DIR}})
        target_link_libraries(\${PROGRAM_NAME} PUBLIC \${\${LIBRARIES}})

    else()
        message(FATAL_ERROR "\${LIBRARY_NAME} not found. Please ensure the \${LIBRARY_NAME} library is installed on your system.")
    endif()
endfunction()

foreach(LIB \${EXTERNAL_LIBRARIES})
    find_and_link_library(\${LIB})
endforeach()

foreach(FILE \${RESOURCE_FILES})
  file(COPY \${FILE} DESTINATION \${CMAKE_BINARY_DIR}/Resources)
endforeach()

install(TARGETS \${PROGRAM_NAME} LIBRARY DESTINATION \${CMAKE_INSTALL_LIBDIR})
