#include <memory>
#include <vector>

#include "calculator.hpp"
#include "logger.hpp"
#include "shape.hpp"

namespace {

// Builds a small collection of shapes so main() has several outgoing
// call edges to Shape::describe() through different concrete types.
std::vector<std::unique_ptr<Shape>> build_shapes()
{
    std::vector<std::unique_ptr<Shape>> shapes;
    shapes.push_back(std::make_unique<Circle>(2.0));
    shapes.push_back(std::make_unique<Rectangle>(3.0, 4.0));
    return shapes;
}

} // namespace

int main()
{
    Logger::log("Starting example application");

    Calculator calculator;
    const double sum = calculator.add(2.0, 3.0);
    const double product = calculator.multiply(4.0, 5.0);
    const double circle_area = calculator.compute_circle_area(2.5);

    Logger::log("sum=" + std::to_string(sum) + " product=" + std::to_string(product) + " circle_area=" + std::to_string(circle_area));

    for (const auto& shape : build_shapes()) {
        shape->describe();
    }

    Logger::log("Example application finished");
    return 0;
}
