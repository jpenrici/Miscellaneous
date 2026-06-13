// lib.hpp
#pragma once

#include <string>

namespace MyLib {

auto path() -> std::string;

}

#ifdef __cplusplus
extern "C" {
#endif

// Code that will be exposed for linking with C.

/**
 * @brief path
 * Returns the current path as a string.
 *
 * @return const char*
 */
const char* path();

/**
 * @brief free_string
 * Free the memory allocated by the string.
 *
 * @param string pointer
 */
void free_string(char* str_ptr);

#ifdef __cplusplus
}
#endif
