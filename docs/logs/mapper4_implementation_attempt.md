# Mapper 4 (MMC3) 流水线架构实现尝试

**日期**: 2025-11-30  
**状态**: ❌ 失败 - 需要 CPU 架构重新设计

## 问题描述

尝试为 NES 模拟器实现 Mapper 4 (MMC3) 支持，以运行 Super Mario Bros 和 Super Contra X。

## 根本原因

**组合逻辑反馈环**：
```
CPU地址 → MMC3映射器 → ROM地址 → ROM数据 → CPU数据输入
```

Verilator 错误：
```
%Error: Input combinational region did not converge after 100 tries
```

## 尝试的解决方案

### 1. 流水线寄存器方案 ❌
- 在 NES 系统中添加地址/控制信号寄存器
- 结果：增加了延迟，但没有打破组合逻辑环

### 2. 分离 ROM 实例方案 ❌  
- 为 Mapper 0 和 Mapper 4 创建独立的 ROM
- 结果：仍然有组合逻辑环，因为 MMC3 地址计算依赖 CPU 地址

### 3. MMC3 输入寄存器方案 ❌
- 在 MMC3 内部注册输入信号（cpuAddr, cpuDataIn等）
- 结果：增加了 2 个周期延迟，CPU 无法等待

### 4. MMC3 输出寄存器方案 ❌
- 在 MMC3 输出端注册 prgAddr 和 cpuDataOut
- 结果：增加了 2 个周期延迟，CPU 仍然无法等待

### 5. 异步 ROM 方案 ❌
- 将 SyncReadMem 改为 Mem（异步读取）
- 结果：组合逻辑环依然存在，因为整个路径都是组合逻辑

## 技术分析

### 组合逻辑环的形成

```scala
// CPU 发出地址
val cpuAddr = cpu.io.memAddr  // 组合逻辑

// MMC3 计算 ROM 地址
mmc3.io.cpuAddr := cpuAddr
val prgAddr = mmc3.io.prgAddr  // 依赖 cpuAddr (组合逻辑)

// ROM 读取
val prgData = prgRom.read(prgAddr)  // 异步读取 (组合逻辑)

// MMC3 输出数据
mmc3.io.prgData := prgData
val cpuDataOut = mmc3.io.cpuDataOut  // 依赖 prgData (组合逻辑)

// CPU 接收数据
cpu.io.memDataIn := cpuDataOut  // 反馈到 CPU (组合逻辑环！)
```

### 为什么 Mapper 0 可以工作

Mapper 0 (NROM) 使用简单的地址镜像，没有复杂的 bank switching：

```scala
// Mapper 0: 直接地址映射，没有中间模块
val prgAddr = Mux(cpuAddr(14), cpuAddr(13, 0), cpuAddr(13, 0))
val prgData = prgRom.read(prgAddr)
cpu.io.memDataIn := prgData
```

虽然也是组合逻辑，但路径更短，Verilator 可以收敛。

### 为什么 Mapper 4 无法工作

Mapper 4 (MMC3) 需要复杂的 bank switching 逻辑：

```scala
// Mapper 4: 需要通过 MMC3 模块计算地址
val prgBankNum = switch(cpuAddr(14, 13)) {  // 复杂的 bank 选择
  case 0 => r6  // 可配置的 bank 寄存器
  case 1 => r7
  case 2 => 0xFE
  case 3 => 0xFF
}
val prgAddr = Cat(prgBankNum, cpuAddr(12, 0))  // 19-bit 地址
```

这个路径太长，加上 ROM 读取和数据返回，形成了无法收敛的组合逻辑环。

## 正确的解决方案

需要 **CPU 架构级别的改动**，支持多周期内存访问：

### 方案 A: CPU 等待状态
```scala
class CPU6502 {
  val io = IO(new Bundle {
    val memReady = Input(Bool())  // 新增：内存就绪信号
    // ... 其他信号
  })
  
  // CPU 状态机需要支持等待
  when(state === Fetch && !io.memReady) {
    // 保持当前状态，等待内存
  }
}
```

### 方案 B: 流水线 CPU
```scala
// 5-stage pipeline: Fetch → Decode → Execute → Memory → WriteBack
// Memory 阶段可以等待多个周期
```

### 方案 C: 缓存系统
```scala
// 添加指令缓存和数据缓存
// 缓存命中：1 周期
// 缓存未命中：多周期访问 ROM
```

## 工作量估算

- **方案 A (等待状态)**: 2-3 小时
  - 修改 CPU 状态机
  - 添加 memReady 信号
  - 测试所有指令

- **方案 B (流水线)**: 6-8 小时
  - 完全重新设计 CPU
  - 处理数据冒险
  - 大量测试

- **方案 C (缓存)**: 4-6 小时
  - 实现简单的直接映射缓存
  - 集成到内存系统
  - 性能调优

## 当前决定

**暂时只支持 Mapper 0**，原因：

1. Mapper 4 需要大量架构改动（4-8 小时）
2. 当前 CPU 不支持等待状态
3. 需要先解决 PPU 寄存器写入问题（Issue #4）

## 代码回退

已回退到只支持 Mapper 0 的版本：
- PRG ROM: 32KB (Mapper 0)
- 移除 MMC3 集成
- 恢复简单的地址镜像

## 测试结果

| 游戏 | Mapper | 状态 |
|------|--------|------|
| Donkey Kong | 0 | ✅ 可运行 (60%) |
| Super Mario Bros | 4 | ❌ 需要 Mapper 4 |
| Super Contra X | 4 | ❌ 需要 Mapper 4 |

## 参考资料

- [NES Mapper 4 (MMC3) 规范](https://www.nesdev.org/wiki/MMC3)
- [Verilator 组合逻辑收敛问题](https://verilator.org/guide/latest/warnings.html#UNOPTFLAT)
- [6502 CPU 等待状态实现](http://www.6502.org/tutorials/interrupts.html)

## 下一步

1. ✅ 完成 Mapper 0 支持和测试
2. ⏳ 修复 PPU 寄存器写入问题 (Issue #4)
3. ⏳ 实现 CPU 等待状态支持
4. ⏳ 重新实现 Mapper 4 with 等待状态
