#ifndef __Rectangle_H__
#define __Rectangle_H__

#include "Geometry.h"
#include "Line.h"

#define Point Vector3D
typedef vector<Vector3D> Points;

class Rectangle
{
public:

    Rectangle(float length, float width) : m_length(length), m_width(width) {}

    Rectangle(Point origin, float length, float width) : m_origin(origin),
        m_length(length), m_width(width) {}

    ~Rectangle() {}

    float area() { return m_length * m_width; }
    float perimeter() { return 2 * m_length + 2 * m_width; }
    float diagonal() { return sqrt(m_length * m_length + m_width * m_width); }

    Point center() { return m_origin + Point(m_length / 2, m_width / 2, 0); }

    Points points()
    {
        return {
            m_origin,                               // P0
            m_origin + Point(0, m_width, 0),        // P1
            m_origin + Point(m_length, m_width, 0), // P2
            m_origin + Point(m_length, 0, 0)        // P3
        };
    }

    Points lines() { return Lines(points()).points(); }

    Points polygon()
    {
        Points p = points();
        p.push_back(p.front());

        return Lines(p).points();
    }

    bool contains(Point point)
    {
        float Ox = m_origin.getX();
        float Oy = m_origin.getY();
        float Oz = m_origin.getZ();

        float Px = point.getX();
        float Py = point.getY();
        float Pz = point.getZ();

        return (Px >= Ox && Py >= Oy && Pz == Oz) &&
               (Px <= (Ox + m_width) && Py >= Oy && Pz == Oz) &&
               (Px >= Ox && Py <= (Oy + m_length) && Pz == Oz) &&
               (Px <= (Ox + m_width) && Py <= (Oy + m_length) && Pz == Oz);
    }

    bool contains(Rectangle r2)
    {
        Points P = r2.points();

        return contains(P[0]) && contains(P[1]) && contains(P[2]) && contains(P[3]);
    }

    Points join(Rectangle r2)
    {
        // Case 0 - rectangle inside current rectangle
        if (contains(r2))
            return polygon();

        // Current rectangle
        Points O = points();
        float z = O[0].getZ();

        // Other rectangle
        Points P = r2.points();
        
        // Case 1 - two points inside, top
        if (contains(P[0]) && contains(P[3]) && !contains(P[1]) && !contains(P[2]))
        {
            return Lines({ O[0], O[1], Point(P[1].getX(), O[1].getY(), z), P[1],
                P[2], Point(P[2].getX(), O[1].getY(), z), O[2], O[3],
                O[0] }).points();
        }

        // Case 2 - two points inside, bottom
        if (contains(P[1]) && contains(P[2]) && !contains(P[0]) && !contains(P[3]))
        {
            return Lines({ O[0], O[1], O[2], O[3], Point(P[3].getX(), O[0].getY(), z),
                P[3], P[0], Point(P[0].getX(), O[0].getY(), z), O[0]} ).points();
        }

        // Case 3 - two points inside, right
        if (contains(P[0]) && contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return Lines({ O[0], O[1], O[2], Point(O[2].getX(), P[2].getY(), z), P[2],
                P[3], Point(O[2].getX(), P[3].getY(), z), O[3], O[3], O[0] }).points();
        }

        // Case 4 - two points inside, left
        if (contains(P[2]) && contains(P[3]) && !contains(P[0]) && !contains(P[1]))
        {
            return Lines({ O[0], Point(O[0].getX(), P[0].getY(), z), P[0], P[1],
                Point(O[0].getX(), P[1].getY(), O[0].getZ()), O[1], O[2], O[3],
                O[0] }).points();
        }

        // Case 5 - one point inside, bottom, left
        if (!contains(P[0]) && !contains(P[1]) && contains(P[2]) && !contains(P[3]))
        {
            return Lines({ Point(O[0].getX(), P[1].getY(), z), O[1], O[2], O[3],
                Point(P[3].getX(), O[0].getY(), z), P[3], P[0], P[1],
                Point(O[0].getX(), P[1].getY(), z) }).points();
        }

        // Case 6 - one point inside, top, left
        if (!contains(P[0]) && !contains(P[1]) && !contains(P[2]) && contains(P[3]))
        {
            return Lines({ O[0], Point(O[0].getX(), P[0].getY(), z), P[0], P[1], P[2],
                Point(P[2].getX(), O[1].getY(), z), O[2], O[3], O[0] }).points();
        }              

        // Case 7 - one point inside, top, right
        if (contains(P[0]) && !contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return Lines({ O[0], O[1], Point(P[1].getX(), O[1].getY(), z), P[1], P[2],
                P[3], Point(O[2].getX(), P[3].getY(), z), O[3], O[0] }).points();
        }

        // Case 8 - one point inside, bottom, right
        if (!contains(P[0]) && contains(P[1]) && !contains(P[2]) && !contains(P[3]))
        {
            return Lines({ O[0], O[1], O[2], Point(O[3].getX(), P[2].getY(), z), P[2],
                P[3], P[0], Point(P[0].getX(), O[3].getY(), z), O[0] }).points();
        }

        // Case 9 - disjoint sets
        return {/* Empty */};
    }

    string str()
    {   
        string values = "\npoints:";
        for (auto i : points())
            values += i.str();
        
        return (
            "\nlength:    " + to_string(m_length) + 
            "\nwidth:     " + to_string(m_width)  +
            "\narea:      " + to_string(area()) +
            "\nperimeter: " + to_string(perimeter()) +
            "\ndiagonal:  " + to_string(diagonal()) +
            "\ncenter:    " + center().str() +
            values
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    Point m_origin;

    float m_width;
    float m_length;

};

#endif // __Rectangle_H__
