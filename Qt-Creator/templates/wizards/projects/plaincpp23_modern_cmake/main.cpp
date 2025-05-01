#include "example.hpp"

#include <print>

auto main() -> int {
  std::println("Modern C++ 23 : Hello World!");

  if (test()) {
    std::println("Example is working!");
  } else {
    std::println("Example is not working!");
  }

  return 0;
}
