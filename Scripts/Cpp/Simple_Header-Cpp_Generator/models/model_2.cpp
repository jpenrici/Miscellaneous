#include "ModelHeader.h"


// ModelClass::ModelClass() {}

// ModelClass::~ModelClass() {}

auto ModelClass::getText() -> std::string
{
  return text;
}

void ModelClass::setText(std::string newText)
{
  text = newText;
}