#ifndef __Triangle_H__
#define __Triangle_H__

#include "Geometry.h"
#include "Line.h"

#define Point Vector3D
typedef vector<Vector3D> Points;

class Triangle
{
public:

    Triangle(float base, float height) : m_base(base), m_height(height)
    {
        m_p2 = Point(base, 0, 0);
        m_p3 = Point(base / 2, height, 0);
    }

    Triangle(Point origin, float base, float height) : m_p1(origin),
        m_base(base), m_height(height)
    {
        m_p2 = m_p1 + Point(base, 0, 0);
        m_p3 = m_p1 + Point(base / 2, height, 0);
    }

    Triangle(Point p1, Point p2, Point p3) : m_p1(p1), m_p2(p2), m_p3(p3) {}

    ~Triangle() {}

    float area() { return m_base * m_height * 0.5; }

    Points points() { return { m_p1, m_p2, m_p3 }; }
    Points lines() { return Lines(points()).points(); }

    Points polygon()
    {
        Points p = points();
        p.push_back(p.front());

        return Lines(p).points();
    }    

    string str()
    {   
        string values = "\npoints:";
        for (auto i : points())
            values += i.str();

        return (
            "\nm_base:   " + to_string(m_base) + 
            "\nm_height: " + to_string(m_height) + 
            "\narea:     " + to_string(area()) +
            values
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    Point m_p1;
    Point m_p2;
    Point m_p3;

    float m_base;
    float m_height;
};

#endif // __Triangle_H__
