# VCD 波形追踪使用指南

**日期**: 2025-11-29  
**工具**: Verilator + GTKWave

---

## 快速开始

### 1. 生成 VCD 文件

```bash
# 方法 1: 使用脚本（推荐）
./scripts/trace.sh games/Donkey-Kong.nes 1

# 方法 2: 手动运行
./scripts/build.sh trace
timeout 1 build/verilator/VNESSystemRefactored games/Donkey-Kong.nes --trace --quiet
```

**输出**: `nes_trace.vcd` (约 6MB/秒)

### 2. 查看波形

```bash
# macOS
open nes_trace.vcd

# 或手动启动 GTKWave
gtkwave nes_trace.vcd
```

---

## 重要信号

### CPU 信号

| 信号 | 说明 |
|------|------|
| `TOP.io_debug_cpuPC` | 程序计数器 (16-bit) |
| `TOP.io_debug_cpuA` | 累加器 (8-bit) |
| `TOP.io_debug_cpuX` | X 寄存器 (8-bit) |
| `TOP.io_debug_cpuY` | Y 寄存器 (8-bit) |
| `TOP.io_debug_cpuState` | CPU 状态机 |
| `TOP.io_debug_cpuOpcode` | 当前指令 |

### PPU 信号

| 信号 | 说明 |
|------|------|
| `TOP.io_vblank` | VBlank 标志 |
| `TOP.io_debug_nmi` | NMI 中断信号 |
| `TOP.io_debug_ppuCtrl` | PPUCTRL 寄存器 |
| `TOP.io_debug_ppuMask` | PPUMASK 寄存器 |
| `TOP.io_pixelX` | 当前像素 X 坐标 |
| `TOP.io_pixelY` | 当前像素 Y 坐标 (扫描线) |

### 内存信号

| 信号 | 说明 |
|------|------|
| `TOP.io_debug_cpuMemAddr` | CPU 内存地址 |
| `TOP.io_debug_cpuMemDataIn` | CPU 读取的数据 |
| `TOP.io_debug_cpuMemRead` | CPU 读取信号 |

---

## GTKWave 使用技巧

### 添加信号

1. 左侧 SST 窗口展开 `TOP`
2. 选择信号
3. 点击 `Insert` 或拖拽到波形窗口

### 推荐信号组

**调试 VBlank 问题**:
```
TOP.io_pixelY          (扫描线)
TOP.io_vblank          (VBlank 标志)
TOP.io_debug_ppuCtrl   (PPUCTRL bit 7 = NMI 使能)
TOP.io_debug_nmi       (NMI 信号)
TOP.io_debug_cpuPC     (CPU 位置)
```

**调试 CPU 执行**:
```
TOP.io_debug_cpuPC
TOP.io_debug_cpuState
TOP.io_debug_cpuOpcode
TOP.io_debug_cpuA
TOP.io_debug_cpuX
TOP.io_debug_cpuY
```

**调试内存访问**:
```
TOP.io_debug_cpuMemAddr
TOP.io_debug_cpuMemDataIn
TOP.io_debug_cpuMemRead
```

### 时间导航

- **Zoom In**: `Ctrl + +`
- **Zoom Out**: `Ctrl + -`
- **Zoom Fit**: `Alt + F`
- **跳转到时间**: `Ctrl + G`

### 查找事件

1. 右键信号 → `Search`
2. 选择条件（上升沿、下降沿、值变化）
3. 点击 `Next` 查找

---

## 常见问题诊断

### 问题 1: VBlank 不触发

**查看信号**:
- `TOP.io_pixelY` - 应该从 0 → 240 → 241
- `TOP.io_vblank` - 在 scanline 241 应该变为 1

**预期行为**:
```
pixelY = 240 → 241 时
vblank: 0 → 1
```

### 问题 2: NMI 不触发

**查看信号**:
- `TOP.io_debug_ppuCtrl` - bit 7 应该是 1
- `TOP.io_vblank` - 应该是 1
- `TOP.io_debug_nmi` - 应该变为 1

**预期行为**:
```
当 ppuCtrl[7] = 1 且 vblank = 1 时
nmi: 0 → 1
```

### 问题 3: CPU 卡住

**查看信号**:
- `TOP.io_debug_cpuPC` - 是否一直不变
- `TOP.io_debug_cpuState` - 是否卡在某个状态
- `TOP.io_debug_cpuOpcode` - 当前执行什么指令

**常见原因**:
- 等待 VBlank (PC 在循环)
- 等待中断 (NMI 未触发)
- 死循环 (BEQ/BNE 跳转到自己)

---

## 高级用法

### 1. 限制追踪时间

```bash
# 只追踪前 100,000 个周期
timeout 0.1 build/verilator/VNESSystemRefactored game.nes --trace
```

### 2. 追踪特定事件

修改 `testbench_main.cpp`:

```cpp
// 只在特定条件下追踪
if (dut->io_pixelY >= 240 && dut->io_pixelY <= 242) {
    if (tfp) tfp->dump(cycle_count * 2);
}
```

### 3. 减小 VCD 文件大小

```cpp
// 降低追踪深度
dut->trace(tfp, 2);  // 只追踪 2 层

// 或只追踪顶层信号
dut->trace(tfp, 0);
```

---

## 性能影响

| 模式 | 速度 | VCD 大小 |
|------|------|----------|
| 无追踪 | 100% | 0 |
| 追踪 (深度 99) | ~10% | 6 MB/秒 |
| 追踪 (深度 2) | ~30% | 2 MB/秒 |

**建议**: 
- 调试时使用追踪
- 正常运行时关闭追踪

---

## 脚本参考

### trace.sh

```bash
./scripts/trace.sh <rom文件> <时长秒数>

# 示例
./scripts/trace.sh games/Donkey-Kong.nes 1
./scripts/trace.sh games/Super-Mario.nes 2
```

### 手动控制

```bash
# 构建
./scripts/build.sh trace

# 运行（带追踪）
build/verilator/VNESSystemRefactored game.nes --trace

# 运行（不追踪）
build/verilator/VNESSystemRefactored game.nes
```

---

## 故障排除

### GTKWave 无法打开

```bash
# 检查安装
brew info --cask gtkwave

# 重新安装
brew reinstall --cask gtkwave

# 手动启动
/Applications/gtkwave.app/Contents/MacOS/gtkwave nes_trace.vcd
```

### VCD 文件太大

```bash
# 限制时间
timeout 0.5 build/verilator/VNESSystemRefactored game.nes --trace

# 或压缩
gzip nes_trace.vcd
gtkwave nes_trace.vcd.gz
```

### 追踪警告

```
Warning: previous dump at t=X, requesting t=Y
```

**原因**: 时间戳倒退（通常无害）  
**解决**: 忽略或修复 tick() 中的时间戳计算

---

## 总结

VCD 波形追踪是**最强大的调试工具**：

✅ **优势**:
- 看到所有信号的精确时序
- 可以回溯查看历史
- 发现时序问题

⚠️ **劣势**:
- 速度慢 (~10%)
- 文件大 (6 MB/秒)
- 需要额外工具

**使用场景**:
- 调试时序问题
- 验证状态机
- 分析信号关系
- 定位 bug

**不适合**:
- 长时间运行
- 性能测试
- 正常游戏

---

**工具链**:
- Verilator: 生成 VCD
- GTKWave: 查看波形
- trace.sh: 一键追踪

**下一步**: 使用 GTKWave 分析 VBlank 和 NMI 时序！
