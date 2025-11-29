# 更新日志 / Changelog

所有重要的项目变更都会记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
版本号遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

---

## [Unreleased]

### 待修复
- PPU 寄存器写入无效问题 (#4)

---

## [0.7.1] - 2025-11-29

### 🔧 修复

#### Critical: CPU Fetch 状态内存读取延迟
**问题**: CPU 在 Fetch 状态读取到错误的 opcode，导致执行非法指令并卡死。

**原因**: Chisel 的 `SyncReadMem` 有 1 个时钟周期的读取延迟，但原始实现在同一周期内读取和使用数据。

**症状**:
- CPU 读取到非法指令 (如 0xC7 而不是 0xD8)
- CPU 卡死在 Execute 状态
- PC 不再变化

**修复**: 将 Fetch 状态分成 2 个周期
```scala
is(sFetch) {
  when(cycle === 0.U) {
    // 周期 0: 发出读请求
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 1.U
  }.otherwise {
    // 周期 1: 读取数据 (数据已准备好)
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U
    cycle := 0.U
    state := sExecute
  }
}
```

**影响**: CPU 从完全卡死恢复到正常执行所有指令

**文件**: `src/main/scala/cpu/core/CPU6502Core.scala`

---

#### Critical: PRG ROM 镜像映射错误
**问题**: 16KB PRG ROM 没有正确镜像到 $C000-$FFFF 地址空间。

**原因**: 使用 15 位地址 (32KB) 而不是 14 位 (16KB)。

**症状**:
- Reset Vector ($FFFC-$FFFD) 读取错误
- CPU 启动地址错误 (如 $0002 而不是 $C79E)
- Donkey Kong 等 16KB ROM 游戏无法启动

**修复**: 使用 14 位地址支持 16KB 镜像
```scala
// 修复前
val prgData = prgRom.read(cpuAddr(14, 0))  // 15 位 = 32KB

// 修复后
val prgAddr = cpuAddr(13, 0)  // 14 位 = 16KB
val prgData = prgRom.read(prgAddr)
```

**影响**: Reset Vector 现在正确读取，CPU 能正确启动

**文件**: `src/main/scala/nes/NESSystemRefactored.scala`

---

### ✨ 新增

#### 增强的调试输出
- 添加 CPU 状态机状态输出 (Reset/Fetch/Execute/NMI/Done)
- 添加 CPU 周期计数
- 添加当前 Opcode 显示
- 添加 PPUCTRL 值和 NMI 使能位监控
- 添加 PPUCTRL 变化实时监控

**文件**:
- `src/main/scala/nes/NESSystemRefactored.scala`
- `verilator/testbench_main.cpp`

---

### 📊 测试结果

#### 游戏兼容性测试
测试了 3 款经典 NES 游戏：

| 游戏 | Mapper | 兼容性 | 状态 |
|------|--------|--------|------|
| Donkey Kong | 0 (NROM) | 60% | ⚠️ CPU 运行但游戏未启动 |
| Super Mario Bros | 4 (MMC3) | 50% | ⚠️ 同上 |
| Super Contra X | 4 (MMC3) | 50% | ⚠️ 同上 |

**总体兼容性**: 53% (从 10% 提升)

**详细报告**: `docs/GAME_COMPATIBILITY_REPORT.md`

**GitHub Issue**: #4

---

### 📝 文档

#### 新增文档
- `docs/GAME_COMPATIBILITY_REPORT.md` - 完整的游戏兼容性测试报告
- `docs/logs/cpu_fix_summary.md` - CPU 修复总结
- `docs/logs/cpu_deadlock_analysis.md` - CPU 死循环问题分析
- `docs/logs/session_summary_2025-11-29.md` - 工作总结

---

## [0.7.0] - 2025-11-27

### ✨ 新增

#### Verilator 硬件仿真环境
- 完整的 Verilator C++ testbench
- SDL2 图形输出 (256x240)
- 实时控制器输入
- FPS 监控
- 性能优化 (批量处理)

**文件**: `verilator/testbench_main.cpp`

#### NES 系统 v2
- 完整的 NES 系统集成
- CPU + PPU + Memory + Controllers
- ROM 加载支持 (iNES 格式)
- Mapper 0 (NROM) 支持
- Mapper 4 (MMC3) 支持 (95%)

**文件**: `src/main/scala/nes/NESSystemRefactored.scala`

#### PPU v3
- 集成渲染管线
- 背景渲染
- 精灵渲染
- Sprite 0 Hit 检测
- VBlank 支持

**文件**: `src/main/scala/nes/PPURefactored.scala`

---

### 🔧 修复

- 修复 PPU 扫描线计数
- 修复 VBlank 标志设置
- 修复控制器读取逻辑
- 修复内存映射

---

### 📊 测试

- ✅ 110+ 单元测试通过
- ✅ CPU 指令集测试 (122+ tests)
- ✅ PPU 渲染测试
- ✅ 系统集成测试

---

## [0.6.0] - 2025-11-20

### ✨ 新增

#### CPU 重构完成
- 模块化架构 (15 个独立模块)
- 完整的指令集实现 (70+ 指令)
- 13 种寻址模式
- NMI/IRQ 中断支持
- Reset 向量支持

**文件**: `src/main/scala/cpu/core/CPU6502Core.scala`

#### 指令模块
- Flag 指令 (CLC, SEC, CLD, SED, CLI, SEI, CLV, NOP)
- Transfer 指令 (TAX, TAY, TXA, TYA, TSX, TXS)
- Arithmetic 指令 (ADC, SBC, INC, DEC, INX, INY, DEX, DEY)
- Logic 指令 (AND, ORA, EOR, BIT)
- Shift 指令 (ASL, LSR, ROL, ROR)
- Compare 指令 (CMP, CPX, CPY)
- Branch 指令 (BEQ, BNE, BCS, BCC, BMI, BPL, BVS, BVC)
- Load/Store 指令 (LDA, LDX, LDY, STA, STX, STY)
- Stack 指令 (PHA, PHP, PLA, PLP)
- Jump 指令 (JMP, JSR, RTS, BRK, RTI)

**文件**: `src/main/scala/cpu/instructions/`

---

### 📊 测试

- ✅ 78 个单元测试通过
- ✅ 100% 指令覆盖率
- ✅ 集成测试通过

---

## [0.5.0] - 2025-11-15

### ✨ 新增

#### 原始 CPU 实现
- 基本的 6502 CPU 实现
- Fetch-Decode-Execute 状态机
- 主要指令支持
- 内存接口

**文件**: `src/main/scala/cpu/CPU6502.scala`

---

### 📊 测试

- ✅ 6 个基本测试通过

---

## [0.4.0] - 2025-11-10

### ✨ 新增

#### Verilog 生成
- 支持生成 Verilog HDL
- 综合工具支持
- 晶体管计数分析

**文件**: `generated/cpu6502_refactored/CPU6502Refactored.v`

---

## [0.3.0] - 2025-11-05

### ✨ 新增

#### 项目初始化
- Chisel 项目结构
- SBT 构建配置
- 基本文档

---

## 版本说明

### 版本号格式: MAJOR.MINOR.PATCH

- **MAJOR**: 重大架构变更或不兼容的 API 变更
- **MINOR**: 新功能添加，向后兼容
- **PATCH**: Bug 修复，向后兼容

### 标签说明

- 🔧 **修复** (Fixed): Bug 修复
- ✨ **新增** (Added): 新功能
- 🔄 **变更** (Changed): 现有功能的变更
- 🗑️ **移除** (Removed): 移除的功能
- 🔒 **安全** (Security): 安全相关的修复
- 📊 **测试** (Tests): 测试相关
- 📝 **文档** (Docs): 文档更新
- ⚡ **性能** (Performance): 性能优化

---

## 链接

- [项目主页](https://github.com/redoop/my6502)
- [问题追踪](https://github.com/redoop/my6502/issues)
- [文档](docs/INDEX.md)

---

**最后更新**: 2025-11-29
