# my6502 项目架构分析报告

**研究报告**  
**日期**: 2025-11-29  
**作者**: 芯片首席科学家  
**项目**: my6502 - Chisel 6502 CPU 实现

---

## 执行摘要

本报告对比分析 my6502 项目当前架构与标准 NES 硬件架构，识别关键问题并提出改进方案。

**核心发现**:
- ✅ CPU 实现完整度 98%，指令集测试全部通过
- ⚠️ PPU 寄存器写入机制存在时序问题，导致 NMI 无法触发
- ⚠️ CPU-PPU 通信未完全遵循标准 NES 时序
- ✅ 内存映射基本正确，ROM 镜像已修复
- 🔧 需要重构 PPU 寄存器接口以匹配硬件行为

---

## 1. 项目现状概览

### 1.1 整体进度

**版本**: v0.7.1  
**最后更新**: 2025-11-29  
**测试通过率**: 122+/122+ (100%)

**各模块完成度**:
- CPU: 98% ✅
- PPU: 70% ⚠️
- Memory: 98% ✅
- Mappers: 97% ✅
- Controllers: 100% ✅
- APU: 98% ✅
- **整体**: 53% 游戏兼容性

### 1.2 最近修复 (v0.7.1)

✅ **关键修复**:
1. CPU Fetch 状态内存延迟问题（CPU 读取错误操作码）
2. 16KB PRG ROM 镜像支持（Reset Vector 现在正确）
3. 增强调试输出（CPU 状态、周期、操作码监控）

### 1.3 已知问题

🐛 **关键问题**:
- **PPU 寄存器写入不工作** ([#4](https://github.com/redoop/my6502/issues/4))
  - 阻止 NMI 中断触发
  - 导致游戏无法进入主循环

### 1.4 游戏兼容性

| 游戏 | Mapper | 状态 | 兼容性 |
|------|--------|------|--------|
| Donkey Kong | 0 | ⚠️ CPU 运行 | 60% |
| Super Mario Bros | 4 | ⚠️ CPU 运行 | 50% |
| Super Contra X | 4 | ⚠️ CPU 运行 | 50% |

---

## 2. 架构对比分析

### 2.1 标准 NES 架构（参考）

根据 NES 硬件文档，标准架构特点：

**内存模型**:
- CPU 和 PPU 拥有**完全独立**的地址空间
- CPU: 16-bit 地址总线 ($0000-$FFFF)
- PPU: 14-bit 地址总线 ($0000-$3FFF)
- 通过内存映射寄存器通信

**时序关系**:
- PPU 时钟 = 3 × CPU 时钟
- PPU: 5.37 MHz (NTSC)
- CPU: 1.79 MHz (NTSC)

**寄存器接口**:
- $2000-$2007: 8 个 PPU 寄存器
- 每 8 字节镜像到 $3FFF
- 读写有特定副作用（如清除 VBlank 标志）

**中断机制**:
- VBlank NMI: 扫描线 241, 点 1 触发
- 通过 PPUCTRL bit 7 使能
- PPUSTATUS bit 7 反映 VBlank 状态

### 2.2 当前项目架构

**实现方式**:

```scala
// NESSystemRefactored.scala
class NESSystemRefactored extends Module {
  val cpu = Module(new CPU6502Refactored)
  val ppu = Module(new PPURefactored)
  
  // 内存映射
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  
  // CPU 读取
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isRam -> ramData,
    isPpuReg -> ppuData,
    isPrgRom -> prgData
  ))
  
  // CPU 写入
  when(cpu.io.memWrite && isPpuReg) {
    // 写入 PPU 寄存器
  }
}
```

**PPU 接口**:

```scala
// PPURefactored.scala
class PPURefactored extends Module {
  val io = IO(new Bundle {
    val cpuAddr = Input(UInt(3.W))      // 只有 3 位地址
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
  })
}
```

### 2.3 关键差异识别

#### 差异 1: PPU 寄存器接口时序

**标准 NES**:
- CPU 写入 $2000-$2007 时，PPU 在**同一周期**响应
- 寄存器更新立即生效
- 副作用（如清除 w toggle）同步发生

**当前实现**:
```scala
// NESSystemRefactored.scala (行 80-90)
when(cpu.io.memWrite) {
  when(isPpuReg) {
    // 问题：PPU 接口信号可能延迟一个周期
  }
}
```

**问题**:
- PPU 使用 `SyncReadMem`，导致读取延迟
- 写入信号可能未正确传递到 PPU
- 寄存器更新时序不匹配

#### 差异 2: NMI 触发机制

**标准 NES**:
- VBlank 标志在扫描线 241, 点 1 设置
- 如果 PPUCTRL bit 7 = 1，立即触发 NMI
- 读取 PPUSTATUS 清除 VBlank 标志

**当前实现**:
```scala
// PPURefactored.scala (行 90-100)
when(scanline === 241.U && pixel === 0.U) {
  vblankFlag := true.B
  regControl.io.setVBlank := true.B
}

// NMI 生成
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}
```

**问题**:
- NMI 触发延迟到 pixel 1（应该在 pixel 1 就触发）
- `nmiTrigger` 信号可能未正确连接到 CPU
- CPU 可能未正确处理 NMI 输入

#### 差异 3: 寄存器镜像处理

**标准 NES**:
- $2000-$2007 每 8 字节镜像到 $3FFF
- 地址解码只看低 3 位

**当前实现**:
```scala
// NESSystemRefactored.scala
val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U

// PPURefactored.scala
val cpuAddr = Input(UInt(3.W))  // ✅ 正确：只用低 3 位
```

**状态**: ✅ 实现正确

#### 差异 4: PPUDATA 读取缓冲

**标准 NES**:
- 读取 $2007 返回**上一次**读取的数据
- 需要一次"预读"来填充缓冲区
- Palette RAM ($3F00-$3FFF) 例外，立即返回

**当前实现**:
```scala
// PPURegisterControl.scala (需要检查)
// 是否实现了读取缓冲？
```

**状态**: ⚠️ 需要验证

---

## 3. 问题根因分析

### 3.1 PPU 寄存器写入问题

**症状**:
- CPU 写入 $2000 (PPUCTRL) 不生效
- NMI 使能位无法设置
- 游戏卡在初始化阶段

**根本原因**:

1. **信号传递延迟**


```scala
// 当前代码流程
CPU 写入 $2000 
  → cpu.io.memWrite = true
  → isPpuReg = true (组合逻辑)
  → 但 PPU 的 cpuWrite 信号何时生效？
  
// NESSystemRefactored.scala 缺少：
ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg  // ❌ 未连接！
ppu.io.cpuAddr := cpuAddr(2, 0)                 // ❌ 未连接！
```

**发现**: `NESSystemRefactored.scala` 中**没有将 CPU 写入信号连接到 PPU**！

2. **接口不完整**

```scala
// NESSystemRefactored.scala (行 80-90)
when(cpu.io.memWrite) {
  when(isPpuReg) {
    // ❌ 这里只有条件判断，没有实际连接 PPU 接口
  }
}
```

3. **NMI 信号未连接**

```scala
// PPURefactored.scala 有 nmiOut
val nmiOut = Output(Bool())

// 但 NESSystemRefactored.scala 中：
val cpu = Module(new CPU6502Refactored)
// ❌ CPU 的 NMI 输入在哪里？未连接！
```

### 3.2 时序问题

**问题**: 使用 `SyncReadMem` 导致读取延迟

```scala
// MemoryController.scala (行 30)
val internalRAM = SyncReadMem(2048, UInt(8.W))

// 同步读取意味着：
// 周期 N: 发出地址
// 周期 N+1: 得到数据
```

**影响**:
- CPU Fetch 状态需要额外周期
- 指令执行时序不准确
- 可能导致 ROM 读取错误

**已修复**: v0.7.1 修复了 Fetch 状态延迟

### 3.3 架构设计问题

**问题 1: 模块间耦合**

```scala
// NESSystemRefactored.scala 直接处理内存映射
val isRam = cpuAddr < 0x2000.U
val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
val isPrgRom = cpuAddr >= 0x8000.U

// 应该由 MemoryController 统一处理
```

**问题 2: 缺少总线抽象**

标准 NES 有明确的总线概念：
- CPU 地址总线
- CPU 数据总线
- PPU 地址总线
- PPU 数据总线

当前实现直接连接模块，缺少总线抽象层。

**问题 3: DMA 实现不完整**

```scala
// MemoryController.scala 有 DMA 接口
val oamDmaActive = Output(Bool())

// 但 NESSystemRefactored.scala 未使用
// CPU 应该在 DMA 期间暂停
```

---

## 4. 与标准架构的差距

### 4.1 功能完整性对比

| 功能 | 标准 NES | 当前实现 | 状态 |
|------|---------|---------|------|
| CPU 指令集 | 56 条官方指令 | 70+ 条指令 | ✅ 超标准 |
| PPU 寄存器 | 8 个寄存器 | 8 个寄存器 | ⚠️ 接口问题 |
| PPU 渲染 | 背景+精灵 | 背景+精灵 | ✅ 基本完成 |
| VBlank NMI | 扫描线 241 | 扫描线 241 | ⚠️ 未触发 |
| Sprite 0 Hit | 支持 | 支持 | ✅ 已实现 |
| OAM DMA | $4014 触发 | 接口存在 | ⚠️ 未连接 |
| APU 5 通道 | 完整 | 完整 | ✅ 98% |
| 内存映射 | 标准 | 标准 | ✅ 正确 |
| ROM 镜像 | 16KB/32KB | 16KB/32KB | ✅ 已修复 |
| 控制器 | 2 个 | 2 个 | ✅ 完整 |

### 4.2 时序准确性对比

| 时序特性 | 标准 NES | 当前实现 | 差距 |
|---------|---------|---------|------|
| CPU 时钟 | 1.79 MHz | 可配置 | ✅ 灵活 |
| PPU 时钟 | 3× CPU | 独立时钟 | ⚠️ 未同步 |
| VBlank 时长 | 2273 周期 | 20 扫描线 | ✅ 正确 |
| NMI 延迟 | 0 周期 | 未知 | ⚠️ 需测试 |
| DMA 时长 | 513-514 周期 | 未实现 | ❌ 缺失 |
| 寄存器访问 | 1 周期 | 1-2 周期 | ⚠️ 延迟 |

### 4.3 接口设计对比

**标准 NES 接口**:
```
CPU ←→ Memory Bus ←→ PPU Registers
                  ←→ RAM
                  ←→ ROM
                  ←→ APU Registers
```

**当前实现**:
```
CPU ←→ NESSystemRefactored ←→ PPU
                           ←→ RAM (内部)
                           ←→ ROM (内部)
```

**差异**:
- 缺少独立的总线抽象
- 内存控制器未充分使用
- 模块间直接连接，耦合度高

---

## 5. 改进方案

### 5.1 紧急修复：PPU 寄存器连接

**优先级**: 🔴 最高

**问题**: PPU 寄存器写入信号未连接

**解决方案**:

```scala
// NESSystemRefactored.scala 修改
class NESSystemRefactored extends Module {
  val cpu = Module(new CPU6502Refactored)
  val ppu = Module(new PPURefactored)
  
  // ✅ 添加：连接 PPU 接口
  ppu.io.cpuAddr := cpuAddr(2, 0)
  ppu.io.cpuDataIn := cpu.io.memDataOut
  ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg
  ppu.io.cpuRead := cpu.io.memRead && isPpuReg
  
  // ✅ 添加：连接 NMI
  cpu.io.nmi := ppu.io.nmiOut  // 需要在 CPU 添加 nmi 输入
}
```

**预期效果**:
- PPU 寄存器写入生效
- NMI 中断正常触发
- 游戏可以进入主循环

### 5.2 短期改进：时序优化

**优先级**: 🟡 中等

**问题**: 内存读取延迟

**解决方案 1**: 使用组合逻辑读取

```scala
// 将 SyncReadMem 改为 Mem（组合逻辑读取）
val prgROM = Mem(32768, UInt(8.W))
val romData = prgROM(romAddr)  // 同周期读取
```

**解决方案 2**: 调整 CPU 状态机

```scala
// CPU Fetch 状态考虑内存延迟
state := sFetch
when(state === sFetch) {
  // 周期 1: 发出 PC 地址
  // 周期 2: 读取指令
  when(fetchCycle === 1.U) {
    opcode := io.memDataIn
    state := sDecode
  }
}
```

### 5.3 中期重构：总线抽象

**优先级**: 🟢 低

**目标**: 引入标准总线架构

**设计**:

```scala
// 新增：CPUBus.scala
class CPUBus extends Bundle {
  val addr = UInt(16.W)
  val dataOut = UInt(8.W)
  val dataIn = UInt(8.W)
  val write = Bool()
  val read = Bool()
}

// 新增：PPUBus.scala
class PPUBus extends Bundle {
  val addr = UInt(14.W)
  val dataOut = UInt(8.W)
  val dataIn = UInt(8.W)
  val write = Bool()
  val read = Bool()
}

// 重构：BusController.scala
class BusController extends Module {
  val cpuBus = IO(Flipped(new CPUBus))
  val ppuBus = IO(new PPUBus)
  val ramBus = IO(new MemoryBus)
  val romBus = IO(new MemoryBus)
  
  // 地址解码和路由
  when(cpuBus.addr >= 0x2000.U && cpuBus.addr < 0x4000.U) {
    // 路由到 PPU 寄存器
  }
}
```

**优势**:
- 清晰的模块边界
- 易于测试和调试
- 符合硬件设计规范

### 5.4 长期优化：周期精确模拟

**优先级**: 🟢 低

**目标**: 实现周期精确的 NES 模拟

**要点**:
1. PPU 运行在 3× CPU 时钟
2. 每个 CPU 周期执行 3 个 PPU 周期
3. 精确的 DMA 时序（513-514 周期）
4. 精确的中断延迟

**实现**:

```scala
class NESSystemCycleAccurate extends Module {
  // 主时钟：PPU 时钟
  val ppuClock = clock
  
  // CPU 时钟分频器
  val cpuClockDiv = RegInit(0.U(2.W))
  val cpuClockEnable = cpuClockDiv === 0.U
  
  cpuClockDiv := Mux(cpuClockDiv === 2.U, 0.U, cpuClockDiv + 1.U)
  
  // CPU 在使能时执行
  when(cpuClockEnable) {
    cpu.clock := ppuClock
  }
  
  // PPU 每周期执行
  ppu.clock := ppuClock
}
```

---

## 6. 实施计划

### 6.1 第一阶段：紧急修复（1-2 天）

**目标**: 让游戏能够运行

**任务**:
1. ✅ 连接 PPU 寄存器接口
   - 修改 `NESSystemRefactored.scala`
   - 添加 `ppu.io.cpuWrite` 等信号连接
   
2. ✅ 连接 NMI 信号
   - 在 `CPU6502Refactored` 添加 `nmi` 输入
   - 连接 `ppu.io.nmiOut` 到 `cpu.io.nmi`
   
3. ✅ 验证 VBlank 时序
   - 确认扫描线 241, 点 1 触发
   - 确认 PPUSTATUS 读取清除标志

**验收标准**:
- Donkey Kong 能进入游戏主循环
- NMI 中断正常触发
- PPU 寄存器读写正常

### 6.2 第二阶段：功能完善（3-5 天）

**目标**: 提高游戏兼容性

**任务**:
1. 实现 OAM DMA
   - 连接 DMA 接口
   - CPU 暂停逻辑
   - 513-514 周期精确时序
   
2. 优化内存访问
   - 使用组合逻辑读取 ROM
   - 减少访问延迟
   
3. 完善 PPU 功能
   - PPUDATA 读取缓冲
   - Palette RAM 特殊处理
   - 寄存器副作用

**验收标准**:
- 游戏兼容性 > 70%
- 精灵显示正常
- 无明显图形错误

### 6.3 第三阶段：架构重构（1-2 周）

**目标**: 代码质量和可维护性

**任务**:
1. 引入总线抽象
   - 设计 CPUBus/PPUBus 接口
   - 实现 BusController
   - 重构模块连接
   
2. 模块化改进
   - 分离内存控制器
   - 独立 DMA 控制器
   - 统一寄存器接口
   
3. 测试覆盖
   - 单元测试
   - 集成测试
   - 时序测试

**验收标准**:
- 代码结构清晰
- 测试覆盖率 > 90%
- 易于扩展新功能

### 6.4 第四阶段：性能优化（1 周）

**目标**: 周期精确模拟

**任务**:
1. 时钟域管理
   - PPU 3× CPU 时钟
   - 时钟使能信号
   
2. 精确时序
   - 周期计数
   - 中断延迟
   - DMA 时序
   
3. 性能测试
   - Verilator 仿真速度
   - FPGA 综合结果

**验收标准**:
- 时序精确度 > 95%
- 游戏兼容性 > 90%
- 通过 nestest 等测试 ROM

---

## 7. 风险评估

### 7.1 技术风险

| 风险 | 概率 | 影响 | 缓解措施 |
|------|------|------|---------|
| NMI 连接后仍不工作 | 中 | 高 | 详细调试，波形分析 |
| 时序问题难以解决 | 低 | 高 | 参考其他开源实现 |
| 重构引入新 bug | 中 | 中 | 充分测试，渐进式重构 |
| 性能不达标 | 低 | 中 | 优化关键路径 |

### 7.2 进度风险

| 风险 | 概率 | 影响 | 缓解措施 |
|------|------|------|---------|
| 紧急修复时间超预期 | 中 | 高 | 优先核心功能 |
| 测试不充分 | 中 | 中 | 自动化测试 |
| 文档滞后 | 高 | 低 | 边开发边文档 |

---

## 8. 对比总结

### 8.1 优势

✅ **已实现的优势**:
1. CPU 指令集完整，超过标准 6502
2. 模块化设计，代码结构清晰
3. 测试覆盖率高（122+ 测试全部通过）
4. 支持多种 Mapper（0, 4）
5. APU 实现完整（98%）
6. 详细的调试接口

### 8.2 劣势

⚠️ **需要改进的方面**:
1. PPU 寄存器接口未正确连接
2. NMI 中断机制不工作
3. 缺少总线抽象层
4. DMA 未完全实现
5. 时序精确度不足
6. 游戏兼容性较低（53%）

### 8.3 与标准 NES 的差距

**功能差距**:
- 核心功能：95% 完成
- 时序精确度：70% 完成
- 游戏兼容性：53% 完成

**架构差距**:
- 模块化程度：优于标准（Chisel 优势）
- 接口规范性：低于标准（缺少总线抽象）
- 时序准确性：低于标准（未周期精确）

---

## 9. 结论与建议

### 9.1 核心结论

1. **根本问题**: PPU 寄存器接口信号未连接，导致 NMI 无法触发，这是阻止游戏运行的关键问题。

2. **架构评估**: 当前架构基础良好，CPU 和 PPU 模块本身实现完整，主要问题在于模块间连接和时序。

3. **改进方向**: 
   - 短期：修复接口连接（1-2 天可完成）
   - 中期：完善功能和时序（1-2 周）
   - 长期：架构重构和优化（1 个月）

### 9.2 优先级建议

**立即执行**（P0）:
1. 连接 PPU 寄存器写入信号
2. 连接 NMI 中断信号
3. 验证 VBlank 时序

**近期执行**（P1）:
1. 实现 OAM DMA
2. 优化内存访问延迟
3. 完善 PPU 寄存器行为

**中期规划**（P2）:
1. 引入总线抽象
2. 模块化重构
3. 提高测试覆盖

**长期目标**（P3）:
1. 周期精确模拟
2. 性能优化
3. 支持更多 Mapper

### 9.3 预期成果

**完成第一阶段后**:
- 游戏兼容性：53% → 70%
- Donkey Kong 可玩
- Super Mario Bros 可启动

**完成第二阶段后**:
- 游戏兼容性：70% → 85%
- 大部分 Mapper 0/4 游戏可玩
- 图形显示正常

**完成第三阶段后**:
- 游戏兼容性：85% → 95%
- 代码质量显著提升
- 易于维护和扩展

---

## 10. 参考资料

### 10.1 项目文档

1. **README.md** - 项目概览和现状
2. **docs/research/NES_ARCHITECTURE_ANALYSIS.md** - NES 标准架构分析
3. **docs/05_PPU_SYSTEM.md** - PPU 系统文档
4. **docs/06_CPU_IMPLEMENTATION.md** - CPU 实现文档

### 10.2 源代码

1. **src/main/scala/nes/NESSystemRefactored.scala** - NES 系统主模块
2. **src/main/scala/nes/PPURefactored.scala** - PPU 实现
3. **src/main/scala/nes/MemoryController.scala** - 内存控制器
4. **src/main/scala/cpu6502/CPU6502Refactored.scala** - CPU 实现

### 10.3 外部参考

1. **NESdev Wiki** - https://www.nesdev.org/
2. **Visual 6502** - http://www.visual6502.org/
3. **Blargg's Test ROMs** - NES 测试 ROM 集合

---

## 附录 A: 关键代码片段

### A.1 当前 PPU 接口（有问题）

```scala
// NESSystemRefactored.scala (当前)
class NESSystemRefactored extends Module {
  val cpu = Module(new CPU6502Refactored)
  val ppu = Module(new PPURefactored)
  
  // ❌ 问题：PPU 接口未连接
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isPpuReg -> ppuData  // 只连接了读取
  ))
  
  // ❌ 写入未连接到 PPU
}
```

### A.2 修复后的接口（建议）

```scala
// NESSystemRefactored.scala (修复后)
class NESSystemRefactored extends Module {
  val cpu = Module(new CPU6502Refactored)
  val ppu = Module(new PPURefactored)
  
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  
  // ✅ 连接 PPU 接口
  ppu.io.cpuAddr := cpuAddr(2, 0)
  ppu.io.cpuDataIn := cpu.io.memDataOut
  ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg
  ppu.io.cpuRead := cpu.io.memRead && isPpuReg
  
  // ✅ 连接读取
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isPpuReg -> ppu.io.cpuDataOut
  ))
  
  // ✅ 连接 NMI
  cpu.io.nmi := ppu.io.nmiOut
}
```

### A.3 NMI 触发逻辑

```scala
// PPURefactored.scala (当前)
val nmiEnable = regs.ppuCtrl(7)
val nmiTrigger = RegInit(false.B)

when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}

io.nmiOut := nmiTrigger

// ✅ 逻辑正确，但需要确保连接到 CPU
```

---

## 附录 B: 测试计划

### B.1 单元测试

```scala
// 测试 PPU 寄存器写入
class PPURegisterWriteTest extends AnyFlatSpec with ChiselScalatestTester {
  "PPU" should "accept PPUCTRL write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)  // PPUCTRL
      dut.io.cpuDataIn.poke(0x80.U)  // Enable NMI
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 验证寄存器更新
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
}
```

### B.2 集成测试

```scala
// 测试 NMI 触发
class NMITriggerTest extends AnyFlatSpec with ChiselScalatestTester {
  "NES System" should "trigger NMI on VBlank" in {
    test(new NESSystemRefactored) { dut =>
      // 1. 使能 NMI
      // 写入 $2000 = 0x80
      
      // 2. 等待 VBlank
      // 运行到扫描线 241
      
      // 3. 验证 NMI
      // 检查 CPU NMI 信号
    }
  }
}
```

---

**报告结束**

*本报告详细分析了 my6502 项目当前架构与标准 NES 架构的差异，识别了关键问题并提出了具体的改进方案。建议立即执行第一阶段修复，预计 1-2 天内可以让游戏正常运行。*
