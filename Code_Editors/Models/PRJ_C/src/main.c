// Modern C23

#include <stdio.h>

int main(void)
{
    auto message = "Hello, Modern C23 world!";
    bool status = false;

    if (message != nullptr) {
        printf("%s\n", message);
        status = true;
    }

    return status;
}

/*
 * cmake -B build
 * cmake --build build
 * ./build/test
 */
