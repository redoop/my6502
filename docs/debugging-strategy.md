# NES 模拟器分阶段调试策略

## 概述
通过分阶段验证 CPU 和 PPU，逐步确保游戏能正常运行。

## 阶段 1: CPU 基础验证 ✅
**目标**: 确认 CPU 能正确执行指令

### 验证项
- [x] CPU 能从 reset vector 启动
- [x] 基本指令执行（LDA, STA, JMP 等）
- [x] 内存读写正常
- [x] 程序计数器（PC）正确递增

### 当前状态
✅ CPU 正在执行代码（PC 在 0xf19f-0xf1a8 循环）
✅ 寄存器正常变化（X, Y, A 都在更新）

### 问题
⚠️ 游戏卡在内存清零循环，可能原因：
1. 循环次数太多（需要很长时间）
2. 循环条件判断有问题
3. 标志位设置不正确

---

## 阶段 2: CPU 循环和分支验证 ⬅️ 当前阶段
**目标**: 确认循环和分支指令正确工作

### 验证项
- [ ] DEX/INX/INY/DEY 正确更新寄存器
- [ ] BNE/BEQ 等分支指令正确判断零标志
- [ ] 循环能正常退出
- [ ] 标志位（Z, N, C, V）正确设置

### 调试方法
```bash
# 1. 验证 DEX 指令和零标志
./scripts/debug_cpu_loop.sh

# 2. 跟踪循环执行
./scripts/trace_loop.sh

# 3. 检查标志位变化
./scripts/check_flags.sh
```

### 预期结果
- X 寄存器从初始值递减到 0
- 当 X = 0 时，零标志（Z）设置为 1
- BNE 指令不跳转，退出循环

---

## 阶段 3: PPU 寄存器访问验证
**目标**: 确认 CPU 能正确读写 PPU 寄存器

### 验证项
- [ ] PPUCTRL (0x2000) 写入正常
- [ ] PPUMASK (0x2001) 写入正常
- [ ] PPUSTATUS (0x2002) 读取正常
- [ ] PPUADDR (0x2006) 地址锁存正常
- [ ] PPUDATA (0x2007) 数据读写正常

### 调试方法
```bash
# 监控 PPU 寄存器写入
./scripts/monitor_ppu_registers.sh
```

### 预期结果
- 游戏写入 PPUCTRL 设置 NMI 和背景图案表
- 游戏写入 PPUMASK 启用渲染
- PPUSTATUS 的 VBlank 标志正常工作

---

## 阶段 4: PPU 内存访问验证
**目标**: 确认 PPU 能正确访问 VRAM 和 CHR ROM

### 验证项
- [ ] CHR ROM 加载正确
- [ ] VRAM (nametable) 读写正常
- [ ] 调色板 (palette) 读写正常
- [ ] OAM (精灵) 读写正常

### 调试方法
```bash
# 1. 验证 CHR ROM 内容
./scripts/verify_chr_rom.sh

# 2. 监控 VRAM 写入
./scripts/monitor_vram.sh

# 3. 检查调色板
./scripts/check_palette.sh
```

### 预期结果
- CHR ROM 包含图案数据（非全零）
- 游戏写入 nametable 数据
- 调色板被正确初始化

---

## 阶段 5: PPU 渲染验证
**目标**: 确认 PPU 能正确渲染画面

### 验证项
- [ ] 背景渲染正常
- [ ] 精灵渲染正常
- [ ] 滚动功能正常
- [ ] 颜色输出正确

### 调试方法
```bash
# 1. 强制启用渲染测试
./scripts/test_forced_rendering.sh

# 2. 渲染单个图案
./scripts/test_single_tile.sh

# 3. 完整画面测试
./scripts/test_full_frame.sh
```

### 预期结果
- 屏幕显示非零像素
- 图案正确显示
- 颜色符合调色板

---

## 阶段 6: NMI 和时序验证
**目标**: 确认 NMI 中断和时序正确

### 验证项
- [ ] VBlank 时触发 NMI
- [ ] CPU 响应 NMI 中断
- [ ] NMI 处理程序正确执行
- [ ] 帧率稳定

### 调试方法
```bash
# 监控 NMI 触发
./scripts/monitor_nmi.sh
```

### 预期结果
- 每帧触发一次 NMI
- CPU 跳转到 NMI 向量 (0xc85f)
- 游戏逻辑在 NMI 中更新

---

## 阶段 7: 完整游戏运行
**目标**: 游戏完整运行

### 验证项
- [ ] 标题画面显示
- [ ] 控制器输入响应
- [ ] 游戏逻辑正常
- [ ] 音效（可选）

### 运行方法
```bash
./scripts/play_donkey_kong.sh
```

---

## 快速诊断工具

### 当前问题诊断
```bash
# 检查当前卡在哪个阶段
./scripts/diagnose_current_stage.sh
```

### 输出示例
```
阶段 1: CPU 基础 ✅
阶段 2: CPU 循环 ⚠️ (卡在 0xf1a0)
阶段 3: PPU 寄存器 ⏸️ (未到达)
```

---

## 下一步行动

### 立即行动：解决阶段 2 问题
1. 创建 CPU 循环调试脚本
2. 验证 DEX 和零标志
3. 确认循环能退出

### 工具创建优先级
1. ✅ `scripts/debug_cpu_loop.sh` - 调试当前循环问题
2. `scripts/monitor_ppu_registers.sh` - 为阶段 3 准备
3. `scripts/diagnose_current_stage.sh` - 快速诊断工具
