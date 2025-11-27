# NES Verilator 仿真器 - 当前状态

## ✅ 已完成

1. **Verilator 编译成功** - 硬件设计可以编译为 C++ 仿真器
2. **SDL 显示初始化** - 窗口和渲染器创建成功
3. **ROM 加载** - 可以正确加载 iNES 格式的 ROM 文件
4. **CPU Reset** - CPU 可以从 reset vector 正确启动
5. **FPS 计算修复** - 基于 VBlank 信号正确计算帧率（约 4 FPS）
6. **大 ROM 支持** - 对于超过 32KB 的 ROM，自动加载最后 32KB

## ⚠️ 当前问题

### 1. CPU 卡住 (PC = 0xc9ca)
- **原因**: Super Contra X 使用 MMC3 mapper，需要 bank switching
- **现象**: CPU 执行到某个地址后停止，可能在等待硬件响应
- **影响**: 游戏无法正常运行

### 2. 屏幕灰色
- **原因**: PPU 可能没有正确初始化或渲染
- **可能原因**:
  - PPU 寄存器没有正确实现
  - CHR ROM 映射有问题
  - 调色板没有初始化

### 3. 性能低 (4 FPS)
- **原因**: Verilator 仿真速度慢，每个时钟周期都需要 C++ 函数调用
- **目标**: NES 应该运行在 60 FPS
- **差距**: 当前只有 6.7% 的目标速度

## 🎯 解决方案

### 方案 A: 测试简单 ROM（推荐）

使用不需要 mapper 的简单游戏测试基本功能：

**推荐测试 ROM:**
- **Donkey Kong** - 16KB PRG, 8KB CHR, 无 mapper
- **Pac-Man** - 16KB PRG, 8KB CHR, 无 mapper  
- **Super Mario Bros** - 32KB PRG, 8KB CHR, 无 mapper

这些游戏可以验证：
- CPU 指令执行
- PPU 渲染
- 控制器输入
- 基本游戏逻辑

### 方案 B: 实现 MMC3 Mapper

如果要运行 Super Contra X，需要实现 MMC3 mapper：

**MMC3 特性:**
- PRG ROM bank switching (8KB 或 16KB banks)
- CHR ROM bank switching (1KB 或 2KB banks)
- IRQ 计数器（用于扫描线中断）
- Mirroring 控制

**实现步骤:**
1. 在 `MemoryController.scala` 中添加 bank 寄存器
2. 实现 bank switching 逻辑 (0x8000-0x9FFF 写入)
3. 扩展 PRG ROM 大小到 256KB
4. 扩展 CHR ROM 大小到 256KB
5. 实现 IRQ 计数器

### 方案 C: 优化性能

提升仿真速度到接近实时：

**优化方向:**
1. **减少 tick() 调用** - 批量执行多个周期
2. **使用 Verilator 优化选项** - `-O3`, `--x-assign fast`
3. **多线程** - 使用 `--threads` 选项
4. **减少调试输出** - 只在必要时打印状态
5. **使用 VCD 波形** - 用于调试而不是实时显示

## 📊 性能分析

当前配置：
- **CPU 频率**: 1.789773 MHz (NTSC)
- **每帧周期数**: ~29780 cycles
- **目标 FPS**: 60
- **当前 FPS**: 4
- **仿真速度**: 约 0.12 MHz (6.7% 实时速度)

## 🔧 调试建议

### 1. 检查 CPU 状态
```bash
# 运行仿真并查看 CPU 寄存器
./scripts/verilator_run.sh <rom> 2>&1 | grep "PC:"
```

### 2. 生成 VCD 波形
修改 testbench 启用 VCD 跟踪：
```cpp
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
dut->trace(tfp, 99);
tfp->open("nes.vcd");
```

### 3. 单步调试
在 testbench 中添加断点，每执行一条指令暂停：
```cpp
if (cycle_count % 1000 == 0) {
    std::cout << "PC: 0x" << std::hex << dut->io_debug_regPC << std::endl;
    std::cin.get();  // 等待用户输入
}
```

## 📝 下一步行动

1. **立即**: 找一个简单的 ROM 测试（Donkey Kong 或 Pac-Man）
2. **短期**: 修复 PPU 渲染问题，让屏幕显示内容
3. **中期**: 实现 MMC3 mapper 支持更多游戏
4. **长期**: 优化性能到接近实时（60 FPS）

## 🎮 测试命令

```bash
# 编译
./scripts/verilator_build.sh

# 运行（会打开 SDL 窗口）
./scripts/verilator_run.sh games/<rom文件>.nes

# 限时运行（5秒后自动退出）
timeout 5 ./scripts/verilator_run.sh games/<rom文件>.nes
```

## 📚 参考资料

- [NES Dev Wiki](https://www.nesdev.org/wiki/)
- [MMC3 Mapper](https://www.nesdev.org/wiki/MMC3)
- [Verilator Manual](https://verilator.org/guide/latest/)
- [6502 Instruction Set](https://www.nesdev.org/obelisk-6502-guide/)
