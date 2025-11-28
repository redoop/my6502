# 性能优化指南

## 当前状态
- 仿真速度: ~2 FPS
- 瓶颈: Verilator 硬件级仿真

## 优化方案

### 1. Verilator 编译优化 ⭐⭐⭐

#### 方案 A: 启用最高优化级别
```bash
# 修改 Verilator 命令，添加优化选项
verilator --cc --exe --build \
  -O3 \                    # 最高优化
  --x-assign fast \        # 快速 X 赋值
  --x-initial fast \       # 快速 X 初始化
  --noassert \             # 禁用断言
  --trace \
  NESSystem.v \
  nes_testbench.cpp
```

预期提升: 2-3x

#### 方案 B: 多线程编译
```bash
verilator --cc --exe --build \
  --threads 4 \            # 使用 4 线程
  -O3 \
  NESSystem.v \
  nes_testbench.cpp
```

预期提升: 1.5-2x

### 2. C++ 编译优化 ⭐⭐

修改 Makefile 的 CXXFLAGS:
```makefile
CXXFLAGS = -O3 -march=native -flto
```

预期提升: 1.5x

### 3. 减少调试输出 ⭐

当前 testbench 每 5 秒输出一次调试信息，可以减少频率：
```cpp
if (debug_elapsed >= 30000) {  // 改为 30 秒
```

预期提升: 1.2x

### 4. 使用 FST 而非 VCD ⭐

FST 格式更快：
```bash
verilator --trace-fst  # 而不是 --trace
```

预期提升: 1.3x

### 5. 禁用波形追踪 ⭐⭐⭐

如果不需要波形调试：
```bash
# 完全移除 --trace 选项
```

预期提升: 2-3x

## 综合优化方案

### 快速优化（推荐）

修改 `scripts/verilator_build.sh`，应用以下优化：

1. 添加 `-O3 --x-assign fast --x-initial fast --noassert`
2. C++ 编译使用 `-O3 -march=native`
3. 减少调试输出频率

**预期总提升: 4-6x (从 2 FPS 到 8-12 FPS)**

### 激进优化

如果需要更快：

1. 禁用波形追踪
2. 使用多线程
3. 减少 SDL 更新频率

**预期总提升: 10-15x (从 2 FPS 到 20-30 FPS)**

## 实施步骤

见 `scripts/optimize_verilator.sh`
