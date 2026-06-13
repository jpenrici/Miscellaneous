// lib.cpp
#include "lib.hpp"

#include <filesystem>

// Libraries C
// #include <cstdlib>
// #include <cstring>

namespace MyLib {

auto path() -> std::string {
  std::string response;
  try {
    std::filesystem::path current_path = std::filesystem::current_path();
    response = current_path.string();
  } catch (const std::filesystem::filesystem_error &e) {
    response = std::format("\033[31m[ERROR]\033[0m : {}", e.what());
  }
  return response;
}

} // namespace MyLib

// ----- Extern "C" -----

const char *path() {

  std::string str = MyLib::path();

  size_t len = str.length();
  char *str_ptr = new (std::nothrow) char[len + 1];

  if (str_ptr == nullptr) {
    return nullptr;
  }

  // std::memcpy(str_ptr, str.c_str(), len);
  std::ranges::copy(str, str_ptr);
  str_ptr[len] = '\0'; // Ensures the null terminator

  return str_ptr;
}

void free_string(char *str_ptr) {
  if (str_ptr != nullptr) {
    delete[] str_ptr;
  }
}
