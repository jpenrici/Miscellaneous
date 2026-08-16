#include "shape.hpp"

#include <cmath>
#include <sstream>

#include "logger.hpp"

Shape::Shape(std::string name)
    : name_(std::move(name))
{
}

void Shape::describe() const
{
    std::ostringstream oss;
    oss << name_ << " has area " << area();
    Logger::log(oss.str());
}

Circle::Circle(double radius)
    : Shape("Circle")
    , radius_(radius)
{
}

double Circle::area() const
{
    return M_PI * radius_ * radius_;
}

void Circle::describe() const
{
    Shape::describe();
    Logger::log("Circle radius is " + std::to_string(radius_));
}

Rectangle::Rectangle(double width, double height)
    : Shape("Rectangle")
    , width_(width)
    , height_(height)
{
}

double Rectangle::area() const
{
    return width_ * height_;
}

void Rectangle::describe() const
{
    Shape::describe();
    Logger::log("Rectangle dimensions are " + std::to_string(width_) + " x " + std::to_string(height_));
}
