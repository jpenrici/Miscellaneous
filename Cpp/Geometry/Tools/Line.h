#ifndef __Line_H__
#define __Line_H__

#include "Geometry.h"

#define Point Vector3D
typedef vector<Vector3D> Points;

class Line
{
public:

    Line(float length, float angle) : m_length(length), m_angle(angle) {}

    Line(Point origin, float length, float angle) : m_origin(origin),
        m_length(length), m_angle(angle) {}

    Line(Point p0, Point p1) 
    {
        m_origin = p0;
        m_length = p0.distance(p1);
        m_angle = atan2(p1.getY() - p0.getY(), p1.getX() - p0.getX()) * 180 / PI;
    }

    ~Line() {}

    float length() { return m_length; }

    Points points()
    {
        return points(1.0);
    }

    Points points(float step)
    {
        Points p;

        for (float r = 0; r < m_length; r += step)
        {
            p.push_back(m_origin.polar(r, m_angle));
        }

        return p;
    }

    string str()
    {   
        string values = "\npoints:";
        for (auto i : points())
            values += i.str();
        
        return (
            "\nlength: " + to_string(m_length) + 
            "\nangle : " + to_string(m_angle) +
            "\nm_origin: " + m_origin.str() +
            values
        );
    }

    void show()
    {
        cout << str() << endl;
    }   

private:

    Point m_origin;

    float m_angle;
    float m_length;

};

class Lines
{
public:

    Lines(Points points) : m_points(points) {}
    ~Lines() {}

    Points points()
    {
        if (m_points.empty())
            return {/* Empty */};

        if (m_points.size() == 1)
            return points();

        Points p;
        for (int i = 0; i < m_points.size() - 1; ++i)
            for (auto p1 : Line(m_points[i], m_points[i + 1]).points())
                p.push_back(p1);

        return p;
    }

private:

    Points m_points;

};

#endif // __Line_H__
