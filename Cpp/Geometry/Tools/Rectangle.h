#ifndef __Rectangle_H__
#define __Rectangle_H__

#include "Geometry.h"
#define Point Vector3D
typedef vector<Vector3D> Points;

class Rectangle
{
public:

    Rectangle(float length, float width) : length(length), width(width) {}

    Rectangle(Point origin, float length, float width) : origin(origin),
        length(length), width(width) {}

    ~Rectangle() {}

    float area() { return length * width; }
    float perimeter() { return 2 * length + 2 * width; }
    float diagonal() { return sqrt(length * length + width * width); }

    Point center() { return origin + Point(length / 2, width / 2, 0); }

    Points points()
    {
        return {
            origin,
            origin + Point(0, width, 0),
            origin + Point(length, width, 0),
            origin + Point(length, 0, 0)
        };
    }

    bool contains(Point point)
    {
        float Ox = origin.getX();
        float Oy = origin.getY();
        float Oz = origin.getZ();

        float Px = point.getX();
        float Py = point.getY();
        float Pz = point.getZ();

        return (Px >= Ox && Py >= Oy && Pz == Oz) &&
               (Px <= (Ox + width) && Py >= Oy && Pz == Oz) &&
               (Px >= Ox && Py <= (Oy + length) && Pz == Oz) &&
               (Px <= (Ox + width) && Py <= (Oy + length) && Pz == Oz);
    }

    bool contains(Rectangle rectangle)
    {
        Points P = rectangle.points();

        return contains(P[0]) && contains(P[1]) && contains(P[2]) && contains(P[3]);
    }

    Points join(Rectangle rectangle)
    {
        // Case 0 - rectangle inside current rectangle
        if (contains(rectangle))
            return points();

        // Current rectangle
        Points O = points();
        float z = O[0].getZ();

        // Other rectangle
        Points P = rectangle.points();
        
        // Case 1 - two points inside, top
        if (contains(P[0]) && contains(P[3]) && !contains(P[1]) && !contains(P[2]))
        {
            return { O[0], O[1], Point(P[1].getX(), O[1].getY(), z), P[1],
                P[2], Point(P[2].getX(), O[1].getY(), z), O[2], O[3] };
        }

        // Case 2 - two points inside, bottom
        if (contains(P[1]) && contains(P[2]) && !contains(P[0]) && !contains(P[3]))
        {
            return { O[0], O[1], O[2], O[3], Point(P[3].getX(), O[0].getY(), z),
                P[3], P[0], Point(P[0].getX(), O[0].getY(), z) };
        }

        // Case 3 - two points inside, right
        if (contains(P[0]) && contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return { O[0], O[1], O[2], Point(O[2].getX(), P[2].getY(), z), P[2],
                P[3], Point(O[2].getX(), P[3].getY(), z), O[3] };
        }

        // Case 4 - two points inside, left
        if (contains(P[2]) && contains(P[3]) && !contains(P[0]) && !contains(P[1]))
        {
            return { O[0], Point(O[0].getX(), P[0].getY(), z), P[0], P[1],
                Point(O[0].getX(), P[1].getY(), O[0].getZ()), O[1], O[2], O[3] };
        }

        // Case 5 - one point inside, bottom, left
        if (!contains(P[0]) && !contains(P[1]) && contains(P[2]) && !contains(P[3]))
        {
            return { Point(O[0].getX(), P[1].getY(), z), O[1], O[2], O[3],
                Point(P[3].getX(), O[0].getY(), z), P[3], P[0], P[1] };
        }

        // Case 6 - one point inside, top, left
        if (!contains(P[0]) && !contains(P[1]) && !contains(P[2]) && contains(P[3]))
        {
            return { O[0], Point(O[0].getX(), P[0].getY(), z), P[0], P[1], P[2],
                Point(P[2].getX(), O[1].getY(), z), O[2], O[3] };
        }              

        // Case 7 - one point inside, top, right
        if (contains(P[0]) && !contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return { O[0], O[1], Point(P[1].getX(), O[1].getY(), z), P[1], P[2],
                P[3], Point(O[2].getX(), P[3].getY(), z), O[3] };
        }

        // Case 8 - one point inside, bottom, right
        if (!contains(P[0]) && contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return { O[0], O[1], O[2], Point(O[3].getX(), P[2].getY(), z), P[2],
                P[3], P[0], Point(P[0].getX(), O[3].getY(), z) };
        }

        // Case 9 - disjoint sets
        return {/* Empty */};
    }

    string str()
    {   
        Points P = points();
        
        return (
            "\nlength:    " + to_string(length) + 
            "\nwidth:     " + to_string(width)  +
            "\narea:      " + to_string(area()) +
            "\nperimeter: " + to_string(perimeter()) +
            "\ndiagonal:  " + to_string(diagonal()) +
            "\ncenter:    " + center().str() +
            "\npoints: " + P[0].str() + "," + P[1].str() + "," + P[2].str() + "," + P[3].str()
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