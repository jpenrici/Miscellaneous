/*
 *   Compile:
 *      g++ test_circle.cpp -o Test -I./Tools/
 *
 *   Run:
 *      ./Test
*/
#include "Circle.h"

int main()
{
    Circle c1(10);
    c1.show();

    Circle c2(Point(10, 10, 10), 10);
    c2.show();

    return 0;
}