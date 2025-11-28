# NES 旧版本代码归档

本目录包含重构前的 NES 实现代码，已被新的模块化版本替代。

## 归档文件

### PPU 实现 (5个文件)
- **PPU.scala** (13K) - 原始 PPU 实现
- **PPUv2.scala** (6.8K) - PPU 第二版
- **PPUv3.scala** (7.2K) - PPU 第三版
- **PPUSimplified.scala** (11K) - 简化版 PPU
- **PPURenderer.scala** (15K) - PPU 渲染器

### APU 实现 (1个文件)
- **APU.scala** (24K) - 原始 APU 实现

### NES 系统 (2个文件)
- **NESSystem.scala** (2.5K) - NES 系统 v1
- **NESSystemv2.scala** (5.2K) - NES 系统 v2

### 工具类 (4个文件)
- **BackgroundRenderer.scala** (0B) - 空文件
- **TerminalEmulator.scala** (16K) - 终端模拟器
- **TerminalEmulatorOutline.scala** (9K) - 终端模拟器大纲
- **TextDisplay.scala** (4.9K) - 文本显示

## 替代方案

这些文件已被以下模块化实现替代：

### 核心模块
- `nes/core/PPURegisters.scala` - PPU 寄存器定义和控制
- `nes/core/APURegisters.scala` - APU 寄存器定义和控制

### 顶层模块
- `nes/PPURefactored.scala` - 模块化 PPU 实现
- `nes/APURefactored.scala` - 模块化 APU 实现
- `nes/NESSystemRefactored.scala` - 集成 NES 系统

## 重构优势

1. **模块化设计** - 清晰的职责分离
2. **统一接口** - 与测试用例无缝衔接
3. **代码精简** - 从 80K+ 减少到 20K
4. **测试覆盖** - 52 tests, 100% passing
5. **可维护性** - 易于理解和扩展

## 归档原因

- 多个版本并存，功能重复
- 缺乏模块化，难以维护
- 测试覆盖不足
- 接口不统一

## 参考文档

- [NES_REFACTORING_SUMMARY.md](../../../../../docs/NES_REFACTORING_SUMMARY.md) - 重构总结
- [PPU_APU_TEST_GUIDE.md](../../../../../docs/PPU_APU_TEST_GUIDE.md) - 测试指南

## 注意

这些文件保留用于参考，但不再维护。新功能应基于重构后的模块实现。

---

归档日期: 2025-11-29
