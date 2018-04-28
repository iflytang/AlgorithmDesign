cmake_minimum_required(VERSION 3.7)
project(AlgorithmDesign)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES test_module_code.cpp Rectangle.cpp)
add_executable(AlgorithmDesign ${SOURCE_FILES})