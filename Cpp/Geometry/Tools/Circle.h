#ifndef __Circle_H__
#define __Circle_H__

#include "Geometry.h"
#define Point Vector3D
typedef vector<Vector3D> Points;

class Circle
{
public:

    Circle(float Radius) : Radius(Radius) {}
    Circle(Point Center, float Radius) : Center(Center), Radius(Radius) {}

    ~Circle() {}

    Point center() { return Center; }

    float radius() { return Radius; }
    float area() { return Radius * PI * PI; }
    float circumference() { return 2 * PI * Radius; }

    Points points()
    {
        return {
            Point("Angle 0",   Center.polar(Radius,   0)),
            Point("Angle 90",  Center.polar(Radius,  90)),
            Point("Angle 180", Center.polar(Radius, 180)),
            Point("Angle 270", Center.polar(Radius, 270)),
        };
    }

    string str()
    {
        Points p = points();
        
        return (
            "\nRadius: " + to_string(Radius) + 
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

    Point Center;
    
    float Radius;
};

#endif // __Circle_H__