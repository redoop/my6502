# NES 模拟器快速调试指南

## 快速诊断

```bash
# 1. 快速检查当前状态
./scripts/diagnose_current_stage.sh

# 2. 根据诊断结果运行对应的调试脚本
```

## 调试脚本列表

### 阶段 1: CPU 基础（通常自动通过）
- 无需手动调试

### 阶段 2: CPU 循环
```bash
./scripts/debug_cpu_loop.sh
```
**问题**: 游戏卡在内存清零循环  
**检查**: DEX 指令和 BNE 分支是否正确

### 阶段 3: PPU 寄存器
```bash
./scripts/monitor_ppu_registers.sh
```
**问题**: 游戏不启用渲染  
**检查**: PPUMASK 何时被写入

### 阶段 4: PPU 内存
```bash
./scripts/verify_chr_rom.sh      # 验证 CHR ROM
./scripts/monitor_vram.sh         # 监控 VRAM 写入
```
**问题**: 画面全黑或显示错误  
**检查**: VRAM 和 CHR ROM 是否正确

### 阶段 5: PPU 渲染
```bash
./scripts/test_full_frame.sh
```
**问题**: 渲染逻辑错误  
**检查**: 背景和精灵渲染

## 常见问题

### Q: 游戏一直卡在初始化
**A**: 运行 `./scripts/diagnose_current_stage.sh` 查看卡在哪个阶段

### Q: 画面全黑
**A**: 检查 PPUMASK 是否启用渲染（bit 3 或 4）

### Q: 显示重复图案
**A**: 可能是 VRAM 未初始化，或渲染逻辑有问题

### Q: 仿真速度太慢
**A**: 这是正常的，Verilator 硬件仿真约 2-5 FPS

## 完整调试流程

```bash
# 步骤 1: 诊断
./scripts/diagnose_current_stage.sh

# 步骤 2: 根据阶段运行对应脚本
# 如果在阶段 2:
./scripts/debug_cpu_loop.sh

# 如果在阶段 3:
./scripts/monitor_ppu_registers.sh

# 步骤 3: 等待游戏完成初始化
# 或手动在 SDL 窗口按 Enter（Start 键）

# 步骤 4: 运行游戏
./scripts/play_donkey_kong.sh
```

## 详细文档

参见 [debugging-strategy.md](debugging-strategy.md) 了解完整的分阶段调试策略。
