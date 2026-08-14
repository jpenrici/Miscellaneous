// src/hello.cpp

#include "hello.hpp"
#include <iostream>

Greeter::Greeter(const std::string& name)
    : name_(name)
{
    // Constructor
}

void Greeter::say_hello() const
{
    std::cout << "Hello, " << name_ << " from C++!" << std::endl;
}
