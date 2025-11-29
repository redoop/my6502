# Donkey Kong 测试报告

**测试时间**: 2025-11-29 15:36:37  
**测试窗口**: 窗口 3 - 游戏运行窗口

## 运行状态

✅ 程序启动成功
- SDL 初始化: ✅
- ROM 加载: ✅ (PRG: 16KB, CHR: 8KB)
- CPU 启动: ✅ (PC = 0x9)
- FPS: 38.0

## ❌ 问题: 灰屏

**现象**: 窗口打开但显示灰屏（不是黑屏）

**可能原因**:
1. PPU 未正确初始化
2. 调色板未设置
3. 背景渲染未启用
4. CHR ROM 数据未正确加载到 PPU
5. PPUCTRL/PPUMASK 寄存器配置错误

## 调试步骤

### 1. 检查 PPU 寄存器
```bash
# 添加 PPU 寄存器调试输出
./scripts/debug.sh monitor ppu
```

### 2. 检查调色板
灰屏通常意味着：
- 调色板全部是灰色 (0x00)
- 或者 PPUMASK 的灰度模式被启用 (bit 0)

### 3. 检查 CHR ROM 加载
```bash
# 验证 CHR ROM 是否正确加载
sbt "runMain nes.ROMAnalyzer \"games/Donkey-Kong.nes\""
```

### 4. 检查 PPUCTRL/PPUMASK
需要确认：
- PPUCTRL ($2000): 背景图案表地址
- PPUMASK ($2001): 背景显示使能 (bit 3)

## CPU 状态

- PC 在变化: 0x32 → 0x19 → 0x6d → 0xc ✅
- 寄存器: A=0x0, X=0x0, Y=0x0
- CPU 正在执行代码 ✅

## 下一步

1. 添加 PPU 调试输出
2. 检查调色板写入
3. 验证 PPUMASK 配置
