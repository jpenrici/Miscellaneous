/*
 *   Compile:
 *      g++ test_"NAME".cpp -o Test -I./Tools/
 *
 *   Run:
 *      ./Test
*/
#include "Rectangle.h"

int main()
{
    Rectangle r1(10, 10);
    r1.show();

    Rectangle r2(Point(10, 10, 10), 10, 10);
    r2.show();

    return 0;
}