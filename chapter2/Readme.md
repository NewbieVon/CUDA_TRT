# 第二章 矩阵乘法的GPU基础实现

## 1.时间计算

不同方法实现不同维度的矩阵乘法运算时间比较
</br>

显卡型号 NVIDIA 3070 Laptop

CPU型号 i7-11800H 2.3GHz x 16

CUDA 11.4

编译方式 nvcc -lcubls -lcudart matrixMultiple.cu mulgpu

时间单位为s

|  | 64*64 | 512*512 |
| ------ | ------ | ------ |
| CPU | 0.001589 | 0.318057 |
| GPU | 0.000032 | 0.004747 |
| GPU(shared) | 0.000016 | 0.002372 |
| memcpy | 0.000428 | 0.000853 |

可见GPU提速显著， 利用共享内存进一步提速50%， 拷贝数据的耗时不可忽略

## 2.改变BLOCK_SIZE
测试条件为计算512*512, 时间单位为秒

|  | 效果 |
| ------ | ------|
| 2 | GPU shared runtime 0.0104 |
| 4 | GPU shared runtime 0.0045 |
| 8 | GPU shared runtime 0.0028 |
| 16 | GPU shared runtime 0.0024 |
| 32 | GPU shared runtime 0.0023 |
| 48 | GPU shared runtime 0.0023 |
| 64 | GPU shared runtime 0.0022  |
| 70 | GPU shared runtime 0.0034  |
| 128 | ptxas error uses too much shared data |

结论： 过小的blocksize达不到加速效果， 过大的blocksize同样，并且可能会超过共享内存上限导致无法编译。测试结果发现blocksize在32-64范围内加速效果最好

运行/usr/local/cuda-11.4/samples/bin/x86_64/deviceQuery | grep shared

  Total amount of shared memory per block:       49152 bytes

  Total shared memory per multiprocessor:        102400 bytes

48KB的共享内存