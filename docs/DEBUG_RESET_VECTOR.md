# Reset Vector 调试记录

## 问题描述

CPU 在 reset 后无法正确跳转到 reset vector 指定的地址。

## 测试结果

### Donkey Kong
- **ROM 信息**: 16KB PRG, 8KB CHR, 无 mapper
- **Reset Vector (ROM)**: 0xFFF0 (地址 0x3FFC-0x3FFD: F0 FF)
- **实际 PC**: 0x0001 -> 0x0002
- **问题**: PC 应该是 0xFFF0，但实际是 0x0001

### Super Contra X  
- **ROM 信息**: 256KB PRG, 256KB CHR, MMC3 mapper
- **Reset Vector (ROM)**: 0x802A (最后 32KB 的 0x3FFC-0x3FFD: 2A 80)
- **实际 PC**: 0xC9CA
- **问题**: PC 应该是 0x802A，但实际是 0xC9CA

## 分析

### 1. 内存映射
- CPU 地址 0x8000-0xFFFF 映射到 PRG ROM
- 对于 16KB ROM: 0x8000-0xBFFF 和 0xC000-0xFFFF 都映射到同一个 ROM (镜像)
- 对于 32KB ROM: 0x8000-0xFFFF 直接映射

当前实现：
```scala
val romAddr = (io.cpuAddr - 0x8000.U)(14, 0)  // 取低 15 位
```

这应该是正确的：
- 0xFFFC - 0x8000 = 0x7FFC，取低 15 位 = 0x3FFC ✓
- 0x802A - 0x8000 = 0x002A，取低 15 位 = 0x002A ✓

### 2. Reset 时序

当前 CPU reset 逻辑（5 个周期）：
```
周期 0: 设置地址 0xFFFC，发起读取
周期 1: 等待 SyncReadMem 延迟
周期 2: 保存低字节到 operand，设置地址 0xFFFD
周期 3: 等待 SyncReadMem 延迟  
周期 4: 读取高字节，组合 reset vector，设置 PC
```

### 3. 字节序

6502 是小端序（Little Endian）：
- 地址 0xFFFC 存储低字节
- 地址 0xFFFD 存储高字节
- Reset vector = (高字节 << 8) | 低字节

当前实现：
```scala
val resetVector = Cat(io.memDataIn, operand(7, 0))  // 高字节 | 低字节
```

这应该是正确的。

### 4. 可能的问题

#### 问题 A: SyncReadMem 时序
`SyncReadMem` 是同步读取内存，读取操作在下一个时钟周期完成。但是我们的等待周期可能不够，或者时序不对。

#### 问题 B: ROM 加载
ROM 加载时可能没有正确写入数据。需要验证：
1. ROM 数据是否正确加载到内存
2. 地址映射是否正确

#### 问题 C: Reset 状态机
Reset 状态机可能在某个周期读取了错误的数据，或者状态转换有问题。

## 下一步调试

### 方案 1: 添加波形跟踪
启用 VCD 波形输出，查看：
- 内存地址和数据信号
- CPU 状态机状态
- PC 寄存器变化

### 方案 2: 简化测试
创建一个最小的测试 ROM：
- 只有 16 字节
- Reset vector 指向 0x8000
- 0x8000 处是一个简单的循环

### 方案 3: 添加调试输出
在 Scala 代码中添加 `printf` 语句，输出：
- Reset 状态机的每个周期
- 读取的内存数据
- PC 的设置值

### 方案 4: 检查生成的 Verilog
直接查看生成的 Verilog 代码，确认逻辑是否正确。

## 临时解决方案

如果无法快速修复 reset vector 问题，可以：
1. 在 testbench 中手动设置 PC 到正确的地址
2. 跳过 reset 状态，直接进入 fetch 状态
3. 使用一个已知工作的 ROM 测试其他功能

## 参考

- [NES Dev Wiki - CPU Power Up State](https://www.nesdev.org/wiki/CPU_power_up_state)
- [6502 Reset Sequence](https://www.pagetable.com/?p=410)
- [Chisel SyncReadMem](https://www.chisel-lang.org/chisel3/docs/explanations/memories.html)
