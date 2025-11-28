# 🛠️ 开发指南

**最后更新**: 2025-11-27

## 📋 目录

1. [快速开始](#快速开始)
2. [测试指南](#测试指南)
3. [使用指南](#使用指南)
4. [重构总结](#重构总结)

---

## 快速开始

### 环境要求

- Java 8 或更高版本
- SBT (Scala Build Tool)
- (可选) Verilator for simulation

### 编译项目

```bash
# 编译
sbt compile

# 运行所有测试
sbt test

# 生成 Verilog
sbt "runMain cpu6502.GenerateBoth"
```

### 项目结构

```
.
├── build.sbt                    # SBT 配置
├── src/
│   ├── main/scala/
│   │   ├── cpu/                # CPU 实现
│   │   └── nes/                # NES 系统
│   └── test/scala/
│       ├── cpu/                # CPU 测试
│       └── nes/                # NES 测试
├── generated/                   # 生成的 Verilog
└── docs/                        # 文档
```

---

## 测试指南

### 测试统计

```
总测试数: 110+
通过: 110+
失败: 0
成功率: 100%
```

### CPU 测试 (78 个)

#### 指令模块测试 (65 个)

```bash
# 标志位指令 (8 个)
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec"

# 算术指令 (8 个)
sbt "testOnly cpu6502.instructions.ArithmeticInstructionsSpec"

# 传输指令 (8 个)
sbt "testOnly cpu6502.instructions.TransferInstructionsSpec"

# 逻辑指令 (7 个)
sbt "testOnly cpu6502.instructions.LogicInstructionsSpec"

# 移位指令 (8 个)
sbt "testOnly cpu6502.instructions.ShiftInstructionsSpec"

# 比较指令 (7 个)
sbt "testOnly cpu6502.instructions.CompareInstructionsSpec"

# 分支指令 (10 个)
sbt "testOnly cpu6502.instructions.BranchInstructionsSpec"

# 加载/存储 (6 个)
sbt "testOnly cpu6502.instructions.LoadStoreInstructionsSpec"

# 栈操作 (3 个)
sbt "testOnly cpu6502.instructions.StackInstructionsSpec"

# 跳转指令 (2 个)
sbt "testOnly cpu6502.instructions.JumpInstructionsSpec"
```

#### 集成测试 (7 个)

```bash
# CPU 核心测试
sbt "testOnly cpu6502.core.CPU6502CoreSpec"
```

#### 兼容性测试 (6 个)

```bash
# 原版 CPU 测试
sbt "testOnly cpu6502.CPU6502Test"
```

### PPU 测试 (22 个)

```bash
# PPUv3 测试 (10 个)
sbt "testOnly nes.PPUv3Test"

# 渲染管线测试 (12 个)
sbt "testOnly nes.PPURendererTest"
```

### NES 系统测试 (10+ 个)

```bash
# NES 系统 v2
sbt "testOnly nes.NESSystemv2Test"

# Contra 快速测试
sbt "testOnly nes.ContraQuickTest"

# ROM 加载器测试
sbt "testOnly nes.ROMLoaderTest"
```

### 运行所有测试

```bash
# 所有测试
sbt test

# 特定包的测试
sbt "testOnly cpu6502.*"
sbt "testOnly nes.*"
```

### 测试覆盖率

| 组件 | 测试数 | 覆盖率 |
|------|--------|--------|
| CPU 指令 | 65 | 100% |
| CPU 核心 | 7 | 100% |
| PPU 渲染 | 12 | 100% |
| PPUv3 | 10 | 100% |
| NES 系统 | 10+ | 95% |

---

## 使用指南

### CPU 使用

#### 基础使用

```scala
import cpu6502._

// 使用重构版 (推荐)
val cpu = Module(new CPU6502Refactored)

// 连接内存
cpu.io.memAddr <> memory.io.addr
cpu.io.memDataIn <> memory.io.dataOut
cpu.io.memDataOut <> memory.io.dataIn
cpu.io.memWrite <> memory.io.write
cpu.io.memRead <> memory.io.read

// 时钟和复位
cpu.clock := clock
cpu.reset := reset
```

#### 调试接口

```scala
// 读取寄存器
val regA = cpu.io.debug.regA
val regX = cpu.io.debug.regX
val regY = cpu.io.debug.regY
val pc = cpu.io.debug.pc
val sp = cpu.io.debug.sp

// 读取标志位
val flagC = cpu.io.debug.flagC
val flagZ = cpu.io.debug.flagZ
val flagN = cpu.io.debug.flagN
val flagV = cpu.io.debug.flagV
```

### PPU 使用

#### PPUv3 基础设置

```scala
import nes._

val ppu = Module(new PPUv3)

// 连接 CHR ROM
ppu.io.chrAddr <> chrRom.io.addr
ppu.io.chrData <> chrRom.io.data

// CPU 接口
ppu.io.cpuAddr := cpuAddr(2, 0)
ppu.io.cpuDataIn := cpuDataOut
cpuDataIn := ppu.io.cpuDataOut
ppu.io.cpuWrite := ppuWrite
ppu.io.cpuRead := ppuRead

// 视频输出
val pixelX = ppu.io.pixelX
val pixelY = ppu.io.pixelY
val pixelColor = ppu.io.pixelColor
val vblank = ppu.io.vblank

// NMI 输出
val nmi = ppu.io.nmiOut
```

#### 写入 Nametable

```scala
// 设置 PPUADDR ($2006)
ppu.io.cpuAddr := 6.U
ppu.io.cpuDataIn := 0x20.U  // 高字节
ppu.io.cpuWrite := true.B
// ... 写入低字节

// 写入 tile 数据 ($2007)
ppu.io.cpuAddr := 7.U
ppu.io.cpuDataIn := tileIndex
ppu.io.cpuWrite := true.B
```

#### 写入调色板

```scala
// 设置 PPUADDR 到 $3F00
ppu.io.cpuAddr := 6.U
ppu.io.cpuDataIn := 0x3F.U
ppu.io.cpuWrite := true.B
// ... 写入 $00

// 写入调色板数据
ppu.io.cpuAddr := 7.U
ppu.io.cpuDataIn := colorValue
ppu.io.cpuWrite := true.B
```

#### 写入精灵 (OAM)

```scala
// 设置 OAMADDR ($2003)
ppu.io.cpuAddr := 3.U
ppu.io.cpuDataIn := 0.U
ppu.io.cpuWrite := true.B

// 写入精灵数据 ($2004)
ppu.io.cpuAddr := 4.U
ppu.io.cpuDataIn := spriteY      // Y 坐标
ppu.io.cpuWrite := true.B
// ... tile, attributes, x
```

#### 启用渲染

```scala
// 写入 PPUMASK ($2001)
ppu.io.cpuAddr := 1.U
ppu.io.cpuDataIn := 0x1E.U  // 显示背景和精灵
ppu.io.cpuWrite := true.B
```

### NES 系统使用

#### 初始化系统

```scala
val nes = Module(new NESSystemv2)

// 配置 Mapper
nes.io.mapperType := 4.U  // MMC3

// 加载 ROM
nes.io.romLoadEn := true.B
nes.io.romLoadPRG := true.B
nes.io.romLoadAddr := addr
nes.io.romLoadData := data

// 控制器输入
nes.io.controller1 := controllerState
```

#### 读取视频输出

```scala
val x = nes.io.pixelX
val y = nes.io.pixelY
val color = nes.io.pixelColor
val vblank = nes.io.vblank
```

### 生成 Verilog

```bash
# 生成 CPU Verilog
sbt "runMain cpu6502.GenerateCPU6502Refactored"

# 生成 NES 系统 Verilog
sbt "runMain nes.GenerateNESVerilog"

# 生成所有
sbt "runMain cpu6502.GenerateBoth"
```

生成的文件位于 `generated/` 目录。

---

## 重构总结

### 重构目标

1. ✅ 提高代码可读性
2. ✅ 增强可测试性
3. ✅ 改善可维护性
4. ✅ 保持功能兼容

### 重构成果

#### 代码质量改进

| 指标 | 重构前 | 重构后 | 改进 |
|------|--------|--------|------|
| 单文件行数 | 1097 | 200 (最大) | ↓ 82% |
| 模块数量 | 1 | 15 | 模块化 |
| 测试用例 | 6 | 78 | +1200% |
| 测试覆盖率 | 部分 | 100% | 完整 |
| Verilog 大小 | 134 KB | 124 KB | ↓ 7.5% |

#### 模块化设计

**重构前**:
```
CPU6502.scala (1097 行)
└── 所有功能在一个文件
```

**重构后**:
```
CPU6502Refactored/
├── core/
│   ├── CPU6502Core.scala (主控制器)
│   ├── Registers.scala (寄存器)
│   └── MemoryInterface.scala (内存接口)
└── instructions/ (10 个指令模块)
    ├── FlagInstructions.scala
    ├── ArithmeticInstructions.scala
    └── ... (每个 < 200 行)
```

### 关键修复

1. **LSR 指令 bug** 🔧
   - 问题: Chisel 右移产生 7 位结果
   - 修复: 正确处理为 8 位

2. **完整指令集** ✅
   - 实现 70+ 条 6502 指令
   - 支持所有寻址模式

3. **中断处理** ✅
   - NMI, IRQ, BRK
   - Reset Vector 支持

### 测试驱动开发

```
1. 编写测试 → 2. 实现功能 → 3. 重构优化
     ↑                                  ↓
     └──────────────────────────────────┘
```

每个指令模块都有对应的测试套件，确保功能正确。

---

## 最佳实践

### 代码风格

1. **命名规范**
   - 模块: PascalCase
   - 信号: camelCase
   - 常量: UPPER_CASE

2. **注释**
   - 每个模块有文档注释
   - 复杂逻辑有行内注释
   - 寄存器位有说明

3. **组织**
   - 相关功能组织在一起
   - 按逻辑分组
   - 保持文件简短

### 测试策略

1. **单元测试**
   - 每个指令独立测试
   - 测试边界条件
   - 测试错误情况

2. **集成测试**
   - 测试完整程序
   - 测试模块交互
   - 测试实际场景

3. **回归测试**
   - 保持所有测试通过
   - 新功能添加测试
   - 修复 bug 添加测试

### 性能优化

1. **减少延迟**
   - 优化关键路径
   - 使用流水线
   - 并行处理

2. **减少资源**
   - 共享逻辑
   - 优化状态机
   - 减少寄存器

3. **提高频率**
   - 减少组合逻辑深度
   - 添加流水线寄存器
   - 优化时序

---

## 常见问题

### Q: 如何添加新指令？

1. 在对应的指令模块中添加实现
2. 在 CPU6502Core 中添加解码
3. 编写测试用例
4. 运行测试验证

### Q: 如何调试硬件？

1. 使用调试接口读取寄存器
2. 生成 VCD 波形文件
3. 使用 ChiselTest 的 peek/poke
4. 添加 printf 调试输出

### Q: 如何提高性能？

1. 分析关键路径
2. 添加流水线阶段
3. 优化状态机
4. 减少内存访问

### Q: 如何添加新功能？

1. 设计接口
2. 实现模块
3. 编写测试
4. 集成到系统
5. 更新文档

---

## 参考资料

### Chisel 资源
- [Chisel 官方文档](https://www.chisel-lang.org/)
- [Chisel Bootcamp](https://github.com/freechipsproject/chisel-bootcamp)
- [Chisel Cheatsheet](https://github.com/freechipsproject/chisel-cheatsheet)

### 6502 资源
- [6502 指令集](http://www.6502.org/tutorials/6502opcodes.html)
- [6502 编程手册](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)
- [Visual 6502](http://www.visual6502.org/)

### NES 资源
- [NesDev Wiki](https://www.nesdev.org/wiki/)
- [PPU Reference](https://www.nesdev.org/wiki/PPU)
- [APU Reference](https://www.nesdev.org/wiki/APU)

---

**版本**: v3.0
**最后更新**: 2025-11-27
