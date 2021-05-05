#ifndef __Circle_H__
#define __Circle_H__

#include "Geometry.h"
#define Point Vector3D
typedef vector<Vector3D> Points;

class Circle
{
public:

    Circle(float radius) : radius(radius) {}
    Circle(Point center, float radius) : center(center), radius(radius) {}

    ~Circle() {}

    float area() { return radius * PI * PI; }
    float circumference() { return 2 * PI * radius; }

    Points points()
    {
        return {
            Point("Angle 0", center.polar(radius, 0)),
            Point("Angle 90", center.polar(radius, 90)),
            Point("Angle 180", center.polar(radius, 180)),
            Point("Angle 270", center.polar(radius, 270)),
        };
    }

    string str()
    {   
        Points p = points();
        
        return (
            "\nradius: " + to_string(radius) + 
            "\narea:   " + to_string(area()) +
            "\ncircumference: " + to_string(circumference()) +
            "\npoints:" + p[0].str() + "," + p[1].str() + "," + p[2].str() + "," + p[3].str()
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    Point center;

    float radius;
};

#endif // __Circle_H__