#include "lib.hpp"

#include <print>

auto main() -> int {

  std::println("Test ...");

  std::println("{}", MyLib::path());

  return 0;
}
