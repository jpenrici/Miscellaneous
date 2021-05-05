/*
 *   Compile:
 *      g++ test_"NAME".cpp -o Test -I./Tools/
 *
 *   Run:
 *      ./Test
*/
#include "Geometry.h"

int main()
{
    // Basic
    Vector3D v1("v1");
    Vector3D v2("v2",  1,  1);
    Vector3D v3("v3", 10, 10, 10);

    Point p1;
    p1 = v2;
    p1.setLabel("p1");

    Point p2("p2");

    Point p3 = v3;
    p3.setLabel(p3.getLabel() + "'");

    Vertice v4("v4", 10, 20);
    Vertice v5("v5", -1, -1);
    v5 = v2 + v5;
    
    Vertice v6("v6");
    v6 = v3 - p3;

    for(auto item : {v1, v2, v3, p1, p2, p3, v4, v5, v6})
    {
        item.show();
    }

     // Is Equal
    cout << boolalpha << v2.isEqual(p1) << '\n';

    // Distance
    cout << Point(7, 4, 3).distance(Point(17, 6, 2)) << '\n';

    // Polar coordinate 
    cout << Point().polar(100, 0).str() << '\n';

    // Spherical coordinate
    cout << Point().spherical(100, 90, 0).str() << '\n';

    return 0;
}