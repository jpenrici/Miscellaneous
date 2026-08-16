#pragma once

#include <memory>

#include "shape.hpp"

// Small utility class used to demonstrate cross-file function calls:
// Calculator methods call into the Shape hierarchy defined elsewhere.
class Calculator {
public:
    double add(double a, double b) const;
    double multiply(double a, double b) const;

    // Builds a Circle internally and returns its area, so that
    // Calculator::compute_circle_area -> Circle::area is a traceable edge.
    double compute_circle_area(double radius) const;

private:
    static std::unique_ptr<Circle> make_circle(double radius);
};
