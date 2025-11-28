---
inclusion: always
---

# 项目规范

## 文件组织
- **脚本文件**: 所有脚本（.sh）必须放在 `scripts/` 目录
- **测试文件**: 测试代码放在 `tests/` 目录
- **文档文件**: 所有文档（.md）必须放在 `docs/` 目录
- **临时文件**: 避免在根目录创建临时文件

## 代码风格
- Scala: 使用 Chisel3 硬件描述语言
- C++: 用于 Verilator testbench
- Shell: 使用 bash，添加 shebang `#!/bin/bash`

## NES 模拟器项目
- CPU: 6502 处理器实现在 `src/main/scala/cpu/`
- PPU: 图形处理单元在 `src/main/scala/nes/PPUSimplified.scala`
- 内存: 内存控制器在 `src/main/scala/nes/MemoryController.scala`
- Verilator: C++ testbench 在 `verilator/` 目录

## 调试
- 使用 Verilator 进行硬件级仿真
- ROM 文件在 `games/` 目录
