#include "lib.hpp"

#include <filesystem>

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
