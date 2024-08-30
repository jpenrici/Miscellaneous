%{Cpp:LicenseTemplate}\
#include <iostream>
#include <print>

auto main() -> int
{
    try {

        // CODE
        std::println("Modern C++ 23 : Hello World!");

    }
    catch (const std::exception &e) {
        std::cerr << "Error: " << e.what() << '\\n';
        return 1;
    }
    catch (...) {
        std::cerr << "Error: Unknown exception.\\n";
        return 1;
    }

    return 0;
}
