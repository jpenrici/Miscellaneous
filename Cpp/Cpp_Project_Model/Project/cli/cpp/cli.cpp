#include "lib.hpp"

#include <print>

auto main() -> int {

  std::println("Command Line Interfaces (CLI) ...");

  std::println("{}", MyLib::path());

  return 0;
}
