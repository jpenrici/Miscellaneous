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

    // Contains Points
    Points points {
    	Point(10, 10, 10),	// True
    	Point(10, 20, 10),	// True
    	Point(20, 10, 10),	// True
    	Point(10,  0, 10),  // True
    	Point(20, 20, 10),	// False
    	Point(10, 10,  0),	// False
    	Point(10, -1, 10),  // False
    };
    for (auto p : points)
    	cout << p.str() << " " << boolalpha << c2.contains(p) << '\n';

    // Contais Circle
    cout << boolalpha << c1.contains(Circle(5)) << '\n'			// True
    	<< c2.contains(Circle(Point(10, 10, 10), 5)) << '\n'; 	// True

    return 0;
}