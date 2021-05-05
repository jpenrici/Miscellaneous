#ifndef __Triangle_H__
#define __Triangle_H__

#include "Geometry.h"
#define Point Vector3D
typedef vector<Vector3D> Points;

class Triangle
{
public:

    Triangle(float base, float height) : base(base), height(height) {}

    ~Triangle() {}

    float area() { return base * height * 0.5; }

    string str()
    {   
        return (
            "\nbase:   " + to_string(base) + 
            "\nheight: " + to_string(height) + 
            "\narea:   " + to_string(area())
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    float base;
    float height;
};

#endif // __Triangle_H__