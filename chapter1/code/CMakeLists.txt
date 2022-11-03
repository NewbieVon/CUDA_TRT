cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(TEST LANGUAGES CXX)

find_package(CUDA REQUIRED)

cuda_add_executable(test test.cpp cudaHeader.cu)
#add_executable(test test.cpp)
