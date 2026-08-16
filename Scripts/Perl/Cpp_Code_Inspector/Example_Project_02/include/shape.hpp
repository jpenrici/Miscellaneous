#pragma once

#include <string>

// Abstract base class for geometric shapes.
class Shape {
public:
    virtual ~Shape() = default;

    virtual double area() const = 0;
    virtual void describe() const;

protected:
    explicit Shape(std::string name);

    std::string name_;
};

class Circle : public Shape {
public:
    explicit Circle(double radius);

    double area() const override;
    void describe() const override;

private:
    double radius_;
};

class Rectangle : public Shape {
public:
    Rectangle(double width, double height);

    double area() const override;
    void describe() const override;

private:
    double width_;
    double height_;
};
