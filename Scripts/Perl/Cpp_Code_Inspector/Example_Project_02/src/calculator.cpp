#include "calculator.hpp"

#include "logger.hpp"

double Calculator::add(double a, double b) const
{
    Logger::log("Calculator::add called");
    return a + b;
}

double Calculator::multiply(double a, double b) const
{
    Logger::log("Calculator::multiply called");
    return a * b;
}

std::unique_ptr<Circle> Calculator::make_circle(double radius)
{
    return std::make_unique<Circle>(radius);
}

double Calculator::compute_circle_area(double radius) const
{
    auto circle = make_circle(radius);
    return circle->area();
}
