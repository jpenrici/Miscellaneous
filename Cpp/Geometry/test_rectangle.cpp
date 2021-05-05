/*
 *   Compile:
 *      g++ test_rectangle.cpp -o Test -I./Tools/
 *
 *   Run:
 *      ./Test
*/
#include "Rectangle.h"

int main()
{
	// Basic
    Rectangle r1(10, 10);
    r1.show();

    Rectangle r2(Point(10, 10, 10), 10, 10);
    r2.show();

    // Contains Points
    Points points {
    	Point(10, 10, 10),	// True
    	Point(10, 20, 10),	// True
    	Point(20, 10, 10),	// True
    	Point(20, 20, 10),	// True
    	Point(10, 10,  0),	// False
    	Point(10,  0, 10),  // False
    };
    for (auto p : points)
    	cout << p.str() << " " << boolalpha << r2.contains(p) << '\n';

    // Contais Rectangle
    cout << boolalpha << r1.contains(Rectangle(5, 5)) << '\n'		// True
    	<< r2.contains(Rectangle(Point(10, 10, 10), 5, 5)) << '\n'; // True

    // Join
    Rectangle r3(Point(10, 10), 10, 10);
	vector<Rectangle> rectangles {    
	    Rectangle(5, 5), 	            // disjoint
	    Rectangle(Point(10, 10), 5, 5), // case 0
	    Rectangle(Point(13, 17), 5, 5), // case 1
	    Rectangle(Point(13,  8), 5, 5), // case 2
	    Rectangle(Point(17, 13), 5, 5), // case 3
	    Rectangle(Point( 8, 13), 5, 5), // case 4
	    Rectangle(Point( 8,  8), 5, 5), // case 5   
	    Rectangle(Point( 8, 17), 5, 5), // case 6
	    Rectangle(Point(17, 17), 5, 5), // case 7
	    Rectangle(Point(17,  8), 5, 5), // case 8
	};
	for (auto r : rectangles)
	{
		for (auto p : r3.join(r))
			cout << p.str();
		cout << endl;
	}

    return 0;
}