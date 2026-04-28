#include <stdio.h>

int main()
{
    auto message = "Hello, Modern C23 world!";

    if (message != nullptr) {
        printf("%s\n", message);
    }

    return 0;
}

/*
 * cmake -B build
 * cmake --build build
 * ./build/test
 */
