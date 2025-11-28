# Stage 3 性能优化

## 优化成果

### 性能提升
- **优化前**: 0.7 FPS
- **优化后**: 27.6 FPS
- **提升倍数**: ~40x

## 优化措施

### 1. C++ Testbench 优化

#### 减少调试输出频率
- 状态报告从每秒改为每 3 秒
- 详细调试信息从每 5 秒改为每 30 秒
- 简化 framebuffer 统计，移除颜色分布计算

#### 批量处理优化
```cpp
const int BATCH_SIZE = 1000;  // 每批处理 1000 个周期
int batch_counter = 0;

// 每批次只处理一次输入
if (batch_counter == 0) {
    handleInput();
}
```

### 2. Verilator 编译优化

#### 编译器优化选项
```bash
-O3                          # 最高优化级别
--x-assign fast              # 快速 X 赋值
--x-initial fast             # 快速 X 初始化
--noassert                   # 禁用断言
--inline-mult 10000          # 增加内联限制
```

#### C++ 编译优化
```bash
-O3                          # 最高优化级别
-march=native                # 针对本机 CPU 优化
-mtune=native                # 针对本机 CPU 调优
-flto                        # 链接时优化
-DNDEBUG                     # 禁用调试代码
-ffast-math                  # 快速数学运算
```

### 3. SDL2 配置优化
- 使用 pkg-config 自动获取 SDL2 编译选项
- 正确配置包含路径和链接库

## 使用方法

### 快速编译
```bash
bash scripts/verilator_build_optimized.sh
```

### 快速测试（30秒）
```bash
bash scripts/quick_performance_test.sh
```

### 扩展测试（2分钟）
```bash
bash scripts/extended_performance_test.sh
```

## 当前状态

### CPU 执行
- CPU 正常运行在初始化循环中
- PC 在 0xf1a0-0xf1a7 之间循环
- 执行 INY/DEX 延迟指令

### 下一步
以 27.6 FPS 的速度，预计需要：
- 约 3600 帧才能完成初始化（约 2 分钟）
- 然后游戏会启用渲染（PPUMASK 设置为 0x18）
- 开始显示游戏画面

## 技术细节

### 性能瓶颈分析
1. **I/O 操作**: 频繁的 cout 输出严重影响性能
2. **SDL 事件处理**: 每个周期都处理输入事件
3. **编译优化不足**: 未使用 LTO 和本机优化

### 优化效果
- 减少 I/O 操作：~10x 提升
- 批量处理输入：~2x 提升
- 编译器优化：~2x 提升
- **总计**: ~40x 提升

## 文件清单

### 优化脚本
- `scripts/verilator_build_optimized.sh` - 优化编译脚本
- `scripts/quick_performance_test.sh` - 快速性能测试
- `scripts/extended_performance_test.sh` - 扩展性能测试

### 源代码
- `verilator/nes_testbench.cpp` - 优化后的 testbench

### 文档
- `docs/stage3-optimization.md` - 本文档
- `docs/performance-optimization.md` - 性能优化指南


## 测试结果

### 2 分钟扩展测试
- **总帧数**: ~3403 帧
- **平均 FPS**: 28-29.3
- **CPU 状态**: 仍在初始化循环 (PC: 0xf1a0-0xf1a7)
- **PPUMASK 变化**: 从 0x00 → 0x06
  - 0x06 = 显示左侧 8 像素（但背景和精灵未启用）
  - 需要 0x18 才能启用完整渲染

### PPUMASK 位定义
```
Bit 0: 灰度模式
Bit 1: 显示左侧 8 像素的背景
Bit 2: 显示左侧 8 像素的精灵
Bit 3: 显示背景 ← 需要这个
Bit 4: 显示精灵 ← 需要这个
Bit 5-7: 颜色强调
```

### 下一步
游戏初始化比预期更长，可能需要：
- 5-10 分钟才能看到 PPUMASK = 0x18
- 或者需要进一步优化性能（目标 60 FPS）

详细的 PPU 寄存器说明见：`docs/ppu-registers.md`
