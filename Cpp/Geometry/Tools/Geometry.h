#ifndef __Geometry_H__
#define __Geometry_H__

#include <math.h>
#include <vector>
#include <iostream>

using namespace std;

#define PI  3.14159265359
static inline float Radians(float angle) { return (angle * PI) / 180.00; }

class Vector3D
{
public:

    Vector3D(): m_x(0), m_y(0), m_z(0), m_label("") {}
    Vector3D(float x, float y) : m_x(x), m_y(y), m_z(0), m_label("") {}
    Vector3D(float x, float y, float z) : m_x(x), m_y(y), m_z(z), m_label("") {}

    Vector3D(string label): m_x(0), m_y(0), m_z(0), m_label(label) {}
    Vector3D(string label, float x, float y) : m_x(x), m_y(y), m_z(0), m_label(label) {}
    Vector3D(string label, float x, float y, float z) : m_x(x), m_y(y), m_z(z), m_label(label) {}

    Vector3D(string label, Vector3D vector3D) : m_label(label)
    {
        m_x = vector3D.getX();
        m_y = vector3D.getY();
        m_z = vector3D.getZ();
    }

    ~Vector3D() {}

    float getX() { return m_x; }
    float getY() { return m_y; }
    float getZ() { return m_z; }
    string getLabel() { return m_label; }

    void setX(float x) { m_x = x; }
    void setY(float y) { m_y = y; }
    void setZ(float z) { m_z = z; }
    void setLabel(string m_label) { this->m_label = m_label; }

    float length() { return sqrt(m_x * m_x + m_y * m_y + m_z * m_z); }

    bool isEqual(const Vector3D& v2)
    {
        return  (m_x == v2.m_x) && (m_y == v2.m_y) && (m_z == v2.m_z);
    }

    float distance(const Vector3D& v2)
    {
        return sqrt((m_x - v2.m_x) * (m_x - v2.m_x) + (m_y - v2.m_y) * (m_y - v2.m_y) +
            (m_z - v2.m_z) * (m_z - v2.m_z));
    }

    Vector3D polar(float radius) // 2D
    {
        return polar(radius, 0);
    }   

    Vector3D polar(float radius, float angle) // 2D
    {
        if (angle > 360) angle = int(angle) % 360 + angle - int(angle);
        if (radius < 0)  radius = 0; 

        return Vector3D(
            m_x + radius * cos(Radians(angle)),
            m_y + radius * sin(Radians(angle)),
            m_z
        );
    }

    Vector3D spherical(float radius, float anglem_z, float anglem_xm_y) // 3D
    {
        if (radius < 0)  radius = 0;
        
        return Vector3D(
            m_x + radius * sin(Radians(anglem_z)) * cos(Radians(anglem_xm_y)),
            m_y + radius * sin(Radians(anglem_z)) * sin(Radians(anglem_xm_y)),
            m_z + radius * cos(Radians(anglem_z))
        );
    }

    Vector3D negative() { return Vector3D(-m_x, -m_y, -m_z); }

    Vector3D& operator=(const Vector3D& v2)
    {
        m_x = v2.m_x;
        m_y = v2.m_y;
        m_z = v2.m_z;

        return *this;
    }

    Vector3D operator+(const Vector3D& v2) const
    {
        return Vector3D(m_x + v2.m_x, m_y + v2.m_y, m_z + v2.m_z);
    }
    
    Vector3D& operator+=(const Vector3D& v2)
    {
        m_x += v2.m_x;
        m_y += v2.m_y;
        m_z += v2.m_z;
        
        return *this;
    }
    
    Vector3D operator-(const Vector3D& v2) const
    {
        return Vector3D(m_x - v2.m_x, m_y - v2.m_y, m_z - v2.m_z);
    }
    
    Vector3D& operator-=(const Vector3D& v2)
    {
        m_x -= v2.m_x;
        m_y -= v2.m_y;
        m_z -= v2.m_z;
        
        return *this;
    }

    Vector3D operator*(float scalar)
    {
        return Vector3D(m_x * scalar, m_y * scalar, m_z * scalar);
    }

    Vector3D& operator*=(float scalar)
    {
        m_x *= scalar;
        m_y *= scalar;
        m_z *= scalar;
        
        return *this;
    }
    
    Vector3D operator/(float scalar)
    {
        return Vector3D(m_x / scalar, m_y / scalar, m_z / scalar);
    }

    Vector3D& operator/=(float scalar)
    {
        m_x /= scalar;
        m_y /= scalar;
        m_z /= scalar;
        
        return *this;
    }
    
    void normalize()
    {
        float l = length();
        if(l > 0)
        {
            (*this) *= 1 / l;
        }
    }

    string str()
    {     
        return m_label + "(" + csv() + ")";
    }

    string csv()
    {
        return to_string(m_x) + "," + to_string(m_y) + "," + to_string(m_z);
    }

    void show()
    {
        cout << str() << endl;
    }

private:

    float m_x;
    float m_y;
    float m_z;

    string m_label;

};

#endif // __Geometry_H__
