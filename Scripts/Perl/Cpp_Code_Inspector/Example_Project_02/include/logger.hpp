#pragma once

#include <string>

// Simple static logger used across the example project.
// Kept intentionally small so that call relationships are easy to trace
// with ctags/cscope (every log call becomes an edge in the call graph).
class Logger {
public:
    static void log(const std::string& message);
    static void log_error(const std::string& message);
};
