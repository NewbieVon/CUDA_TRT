### CUDA coding

__global__ 在host调用，在device运行
__device__ 在device调用，在device运行
__host__ 在host调用，在host运行

用nvcc编译链接.cu文件生成二进制可执行文件
用gcc编译链接.cpp文件生成二进制可执行文件

那cmake是干啥的，能不能编译cuda程序

https://www.bookstack.cn/read/CMake-Cookbook/content-chapter1-1.1-chinese.md

cmake也能编译cuda文件，add_executable那里改成cuda_add_executable