# Donkey Kong 测试报告 v2

**测试时间**: 2025-11-29 18:30  
**测试窗口**: 窗口 3 - 游戏运行窗口  
**测试状态**: ❌ 不可玩 - 问题已确认

## 问题确认

**根本原因**: PPUCTRL = 0x00，NMI 中断未启用

### CPU 状态
- ✅ CPU 正在执行代码
- ✅ PC 在循环: 0xC7A0 → 0xC7AE (等待 VBlank)
- ✅ VBlank 正常触发 (VBlank=1)
- ❌ **PPUCTRL = 0x00** (NMI 未启用)
- ❌ **NMI = 0** (中断未触发)

### 代码分析

游戏在 0xC7A0-0xC7AE 循环等待：
```
0xC7A0: CLD (0xD8)
0xC7A2: LDA #0xA9
0xC7A5: STA (0x8D)
0xC7A7: LDX #0xA2
0xC7A9: LDA (0xAD) - 读取某个状态
0xC7AB: LDA (0xAD)
0xC7AE: BEQ 0xC7A0 (0xF0) - 如果为0则循环
```

这是典型的 VBlank 等待循环，但因为 NMI 未启用，游戏逻辑永远不会执行。

## 需要修复

**窗口 1 任务**:
1. 确保 PPUCTRL 写入正常工作
2. 检查游戏是否写入了 PPUCTRL
3. 如果没写入，检查 Reset 初始化代码

**关键**: 游戏应该在初始化时写入 PPUCTRL $2000，设置 bit 7 启用 NMI。

## 画面状态

- 有静止图形 ✅
- 绿色背景 ✅  
- 但完全不动 ❌

## 结论

系统基本正常，但 NMI 机制有问题，导致游戏逻辑无法执行。
