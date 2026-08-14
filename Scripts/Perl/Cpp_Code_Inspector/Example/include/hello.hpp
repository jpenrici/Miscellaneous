// include/hello.hpp
#pragma once

#include <string>

class Greeter {
public:
    Greeter(const std::string& name);
    void say_hello() const;

private:
    std::string name_;
};
