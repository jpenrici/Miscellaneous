#!/bin/bash

# Build and install

echo "PROJECT: $PWD"

# 1. Clear
if [[ -d build ]]; then
  echo "Remove build/ ..."
  rm -rf build
fi

if [[ -d dist ]]; then
  echo "Remove dist/ ..."
  rm -rf dist
fi

# 2. Setup
mkdir build
cd build
cmake .. -DBUILD_CLI=ON -DBUILD_GUI=ON -DBUILD_TESTS=ON -DBUILD_BINDINGS=ON

# 3. Build
cmake --build .

# 4. Install
cmake --install .