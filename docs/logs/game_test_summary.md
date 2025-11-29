# 游戏兼容性测试总结

**测试日期**: 2025-11-29 18:00-18:02  
**测试窗口**: 窗口 3 - 游戏运行窗口  
**测试游戏**: 3/3

---

## 测试结果

| 游戏 | Mapper | CPU PC | FPS | 画面 | 控制器 | 状态 |
|------|--------|--------|-----|------|--------|------|
| Donkey Kong | 0 | 0x68 | 24-34 | ✅ 绿色背景 | ✅ | ❌ 卡死 |
| Super Mario Bros | 4 | 0xff41 | 7-10 | ⚠️ | ✅ | ❌ 卡死 |
| Super Contra X | 4 | 0xffca | 8-10 | ⚠️ | ✅ | ❌ 卡死 |

---

## 共同问题

### ❌ CPU 死循环

**现象**:
- 所有游戏 CPU 都卡在固定地址
- PC 从不改变
- 寄存器 A/X/Y 都是 0x0
- 按 Start 无反应

**不同的卡死地址**:
- Donkey Kong: 0x68
- Super Mario Bros: 0xff41
- Super Contra X: 0xffca

### ✅ 正常的部分

**系统**: 100%
- ROM 加载正常
- SDL 初始化正常
- PPU 渲染正常
- VBlank 正常

**控制器**: 100%
- 所有按键都能检测到
- 组合键正常

---

## 根本原因分析

### 可能原因 1: NMI 中断未实现或未触发

**证据**:
- VBlank 标志正常 (vblank=1)
- 但 CPU 不响应
- NES 游戏逻辑通常在 NMI 中断中

**需要检查**:
- PPUCTRL bit 7 (NMI enable)
- NMI 中断向量 ($FFFA-$FFFB)
- CPU 的 NMI 处理逻辑

### 可能原因 2: Reset Vector 问题

**证据**:
- 3 个游戏卡在不同地址
- 可能是 Reset Vector 读取错误

**需要检查**:
- Reset Vector ($FFFC-$FFFD)
- 内存映射是否正确

### 可能原因 3: 某条指令未实现

**证据**:
- CPU 卡在固定地址
- 可能遇到未实现的指令

**需要检查**:
- 反汇编卡死地址的指令
- 检查指令实现

---

## 调试步骤

### 1. 检查 Reset Vector
```bash
sbt "runMain nes.ROMAnalyzer \"games/Donkey-Kong.nes\""
```

### 2. 反汇编卡死地址
```bash
# 查看 0x68, 0xff41, 0xffca 的指令
./scripts/debug.sh opcodes games/Donkey-Kong.nes
```

### 3. 添加 CPU 执行日志
在 Verilator testbench 中添加：
- 每条指令的反汇编
- 中断触发日志
- 内存读写日志

### 4. 检查 NMI 实现
查看 CPU6502 的 NMI 处理代码

---

## 兼容性评级

**总体**: ⚠️ 50% - 不可玩

| 项目 | 评分 |
|------|------|
| 系统初始化 | ✅ 100% |
| ROM 加载 | ✅ 100% |
| PPU 渲染 | ✅ 90% |
| 控制器 | ✅ 100% |
| CPU 执行 | ❌ 10% |
| 游戏逻辑 | ❌ 0% |

---

## 下一步

**需要窗口 1（主测试窗口）**:
1. 调试 CPU 死循环
2. 实现/修复 NMI 中断
3. 验证 Reset Vector
4. 添加详细执行日志

**优先级**: 🔴 Critical - 阻塞所有游戏运行

---

**报告位置**:
- Donkey Kong: `docs/logs/game_test_donkey_kong.md`
- 总结: `docs/logs/game_test_summary.md`
