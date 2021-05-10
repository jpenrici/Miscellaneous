#ifndef __Circle_H__
#define __Circle_H__

#include "Geometry.h"

#define Point Vector3D
typedef vector<Vector3D> Points;

class Circle
{
public:

    Circle(float radius) : m_radius(radius) {}
    Circle(Point center, float radius) : m_center(center), m_radius(radius) {}

    ~Circle() {}

    Point center() { return m_center; }

    float radius() { return m_radius; }
    float area() { return m_radius * PI * PI; }
    float circumference() { return 2 * PI * m_radius; }

    Points points() { return points(0, 360, 1.0); }
    Points points(float angle) { return {Point(m_center.polar(m_radius, angle))}; }

    Points points(float angle0, float angle1)
    {
        return points(angle0, angle1, 1.0);
    }
    
    Points points(float angle0, float angle1, float step)
    {
        Points p;

        for (float angle = angle0; angle <= angle1; angle += step)
            p.push_back(m_center.polar(m_radius, angle));

        return p;
    }

    bool contains(Point point)
    {
        return m_center.getZ() == point.getZ() &&
               m_center.distance(point) <= radius();
    }

    bool contains(Circle c2)
    {
        if (m_center.getZ() != c2.center().getZ())
            return false;

        if (m_center.isEqual(c2.center()) && radius() >= c2.radius())
            return true;

        return (m_center.distance(c2.center()) + c2.radius()) < radius();
    }

    Points join(Circle c2)
    {
        if (m_center.getZ() != c2.center().getZ())
            return {/* Empty */};

        // Case 0 - circle inside current circle
        if (contains(c2))
            return points();

        // Case 1 - current circle inside circle
        if (c2.contains(*this))
            return c2.points();
        
        float d = m_center.distance(c2.center());

        // Case 2 - disjoint sets 
        if (d > (radius() + c2.radius()))
            return {/* Empty */};

        // Case 3 - Two circles intersect in two distinct points
        Points p;

        float a1 = 0;
        float a2 = 0;
        while (a1 + a2 < 720)
        {
            while(a1 < 360)
            {
                Point p1 = m_center.polar(m_radius, a1++);
                if (c2.contains(p1)) break;
                p.push_back(p1);
            }

            while(a2 < 360)
            {
                Point p1 = c2.center().polar(c2.radius(), a2++);
                if (contains(p1)) break;
                p.push_back(p1);
            }    
        }
       
        return p;
    }    

    string str()
    {
        string values = "\npoints:";
        for (auto i : points())
            values += i.str();
        
        return (
            "\nm_radius: " + to_string(m_radius) + 
            "\narea:   " + to_string(area()) +
            "\ncircumference: " + to_string(circumference()) +
            values
        );
    }

    void show()
    {
        cout << str() << endl;
    }   
   
private:

    Point m_center;
    
    float m_radius;
};

#endif // __Circle_H__
