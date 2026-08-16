#include "logger.hpp"

#include <iostream>

void Logger::log(const std::string& message)
{
    std::cout << "[INFO] " << message << '\n';
}

void Logger::log_error(const std::string& message)
{
    std::cerr << "[ERROR] " << message << '\n';
}
