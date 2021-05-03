#ifndef __Rectangle_H__
#define __Rectangle_H__

#include "Geometry.h"

class Rectangle
{
public:

    Rectangle(float length, float width) : length(length), width(width) {}
    Rectangle(Point origin, float length, float width) : origin(origin),
        length(length), width(width) {}

    ~Rectangle() {}

    float area() { return length * width; }
    float perimeter() { return 2 * length + 2 * width; }

    Points points()
    {
        return {
            Point("P1", origin),
            Point("P2", origin + Point(0, width, 0)),
            Point("P3", origin + Point(length, 0, 0)),
            Point("P4", origin + Point(length, width, 0)),
        };
    }

    string str()
    {   
        Points p = points();
        
        return (
            "\nlength:    " + to_string(length) + 
            "\nwidth:     " + to_string(width)  +
            "\narea:      " + to_string(area()) +
            "\nperimeter: " + to_string(perimeter()) +
            "\npoints: " + p[0].str() + "," + p[1].str() + "," + p[2].str() + "," + p[3].str()
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    Point origin;

    float width;
    float length;
};

#endif // __Rectangle_H__