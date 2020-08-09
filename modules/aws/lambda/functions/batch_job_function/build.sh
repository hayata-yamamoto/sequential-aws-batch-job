#!/usr/bin/env bash

if [ -d build ]; then
  rm -rf build
fi

if [ -e "function.zip" ]; then 
  rm function.zip
fi 

# Recreate build directory
mkdir -p build/function/

# Copy source files
echo "Copy source files"
cp -r src build/function/

# Pack python libraries
# echo "Pack python libraries"
# pip3 install -r requirements.txt -t build/layer/python

# find build -type f | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm

zip -rj function.zip build/function/src/
