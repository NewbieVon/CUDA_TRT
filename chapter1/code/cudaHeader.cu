#include"cudaHeader.h"
#include<iostream>

//核函数，计算a+b
__global__ void add(int a,int b,int *c)
{
    //保存a+b的计算结果
    *c=a+b;
}


//cuda测试函数的实现
void cudaTest()
{
    int c;
    //在gpu上开辟一个相同的内存
    int *deviceC;
    cudaMalloc((void**)&deviceC,sizeof(int));
    //调用核函数
    add<<<1,1>>>(2,7,deviceC);
    //把计算结果复制到cpu上
    cudaMemcpy(&c,deviceC,sizeof(int),cudaMemcpyDeviceToHost);
    //展示计算结果
    std::cout<<c<<std::endl;
    //释放内存
    cudaFree(deviceC);
}