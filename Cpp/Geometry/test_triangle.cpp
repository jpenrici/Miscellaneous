/*
 *   Compile:
 *      g++ test_"NAME".cpp -o Test -I./Tools/
 *
 *   Run:
 *      ./Test
*/
#include "Triangle.h"

int main()
{
    Triangle t1(10, 10);
    t1.show();

    return 0;
}