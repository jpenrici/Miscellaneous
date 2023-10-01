#include <iostream>
#include <vector>
#include <string>


class ModelClass {

public:
    ModelClass() = default;
    ModelClass(const ModelClass &) = delete;
    ModelClass(ModelClass &&) = delete;
    ~ModelClass() = default;

    auto operator=(const ModelClass &) -> ModelClass & = delete;
    auto operator=(ModelClass &&) -> ModelClass & = delete;

    auto getText() -> std::string;
    void setText(std::string newText);

private:
    std::string text;

};
