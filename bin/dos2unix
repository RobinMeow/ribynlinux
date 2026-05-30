#!/bin/bash

find . -type f -name "*.cs" -exec dos2unix {} +
find . -type f -name "*.csproj" -exec dos2unix {} +
find . -type f -name "*.sln" -exec dos2unix {} +
find . -type f -name "*.slnx" -exec dos2unix {} +

echo "Conversion to Unix line endings complete!"
