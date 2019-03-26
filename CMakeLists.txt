cmake_minimum_required(VERSION 3.7)
project(CLionProject)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES c_test/test_fork.c)
add_executable(CLionProject ${SOURCE_FILES})