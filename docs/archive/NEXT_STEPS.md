# NES Verilator 仿真器 - 下一步行动

## 当前进展

✅ **已完成：**
- Verilator 编译成功
- SDL 窗口和渲染器初始化
- ROM 加载功能
- CPU 执行代码（PC 和 SP 在变化）
- FPS 计算修复（从 0.2 提升到 3.8）
- 异步 ROM 实现（使用 Mem 而不是 SyncReadMem）

❌ **待解决：**
- Reset vector 读取不正确（PC 从 0x0001 开始而不是 0xFFF0）
- 屏幕灰色（PPU 未渲染）
- 性能较低（4 FPS vs 60 FPS 目标）

## Reset Vector 问题分析

### 症状
- CPU 从 0x0001 开始执行而不是 0xFFF0
- 异步 ROM 实现后仍然存在
- 问题可能在 ROM 加载或地址映射

### 可能的原因
1. **ROM 加载地址映射错误** - testbench 加载时使用 0-0x3FFF，但硬件读取时使用 0xFFFC
2. **内存读取时序** - 即使使用异步 ROM，可能仍有时序问题
3. **CPU reset 状态机** - reset 逻辑可能有 bug

### 建议的解决方案

#### 方案 1：绕过 Reset Vector（快速）
在 testbench 中手动设置初始 PC：
- 修改 CPU 设计添加外部 PC 设置接口
- 在 reset 后立即设置 PC 到正确的地址
- 这样可以继续测试其他功能

#### 方案 2：调试 ROM 加载（中等）
- 添加 VCD 波形跟踪
- 查看内存读写信号
- 验证 ROM 数据是否正确加载

#### 方案 3：重新设计 Reset 逻辑（复杂）
- 使用组合逻辑直接读取 reset vector
- 避免状态机的时序问题
- 可能需要重新设计内存接口

## 建议的优先级

### 立即（今天）
1. 实现方案 1（绕过 reset vector）
2. 测试 PPU 渲染
3. 测试控制器输入

### 短期（本周）
1. 修复 PPU 渲染问题
2. 实现基本的游戏画面显示
3. 测试简单游戏（Donkey Kong）

### 中期（下周）
1. 调试 reset vector 问题
2. 实现 MMC3 mapper
3. 优化性能到 60 FPS

## 技术建议

### 快速测试 PPU
即使 CPU 从错误的地址开始，PPU 仍然可能工作。可以：
1. 手动设置 PPU 寄存器
2. 加载 CHR ROM 数据
3. 查看屏幕是否显示内容

### 性能优化
- 减少 tick() 调用频率
- 使用 Verilator 的 `--threads` 选项
- 批量执行多个周期

### 调试工具
- VCD 波形跟踪
- Printf 调试输出
- 内存检查器

## 文件参考

- `docs/DEBUG_RESET_VECTOR.md` - 详细的 reset vector 分析
- `docs/VERILATOR_STATUS.md` - 完整的状态报告
- `verilator/nes_testbench.cpp` - 仿真器主程序
- `src/main/scala/nes/MemoryController.scala` - 内存控制器
- `src/main/scala/cpu/core/CPU6502Core.scala` - CPU 核心

## 总结

你的 NES Verilator 仿真器已经非常接近工作了。主要问题是 reset vector 读取，但这不会阻止你测试其他功能。建议先绕过这个问题，继续开发 PPU 和其他组件，然后再回来修复 reset vector。

这样可以更快地看到成果，也能更好地理解整个系统的工作原理。
