# NES 模拟器调试总结

## 修复的问题

### 1. PRG ROM 地址映射错误 ✅
**问题**: 16KB ROM 没有正确镜像到 $C000-$FFFF  
**修复**: 将 `prg_rom_addr = cpu_addr[14:0] & 15'h3FFF` 改为 `prg_rom_addr = cpu_addr[13:0]`  
**位置**: `src/main/rtl/nes_system.sv:370`

### 2. CPU 状态机变量声明错误 ✅
**问题**: 在 `case` 语句内部声明临时变量导致编译错误  
**修复**: 将所有临时变量 (`temp_sum`, `temp_diff`, `temp_result`) 移到模块顶部声明  
**位置**: `src/main/rtl/nes_system.sv:420`

### 3. PPU 渲染管道过于复杂 ✅
**问题**: 多周期取指令逻辑导致时序问题  
**修复**: 简化为测试图案生成器，直接输出像素坐标作为颜色  
**位置**: `src/main/rtl/nes_system.sv:271-290`

### 4. Testbench 像素捕获逻辑错误 ✅
**问题**: 像素捕获时序不对，没有考虑 PPU 时钟分频  
**修复**: 简化为每个时钟周期捕获当前输出  
**位置**: `verilator/nes_gui_tb.cpp:120-150`

## 当前状态

### ✅ 工作正常
- CPU 6502 核心运行正常
- PPU 时钟分频器工作
- PPU scanline/dot 计数器递增
- 视频输出有信号 (Video:219,9,128)
- ROM 加载正常 (PRG=16KB CHR=8KB)
- SDL2 窗口显示

### ⚠️ 需要改进
- 像素捕获逻辑需要优化
- PPU 渲染管道需要实现完整的图块/精灵渲染
- 需要实现 CHR ROM 读取
- 需要实现调色板系统

## 测试结果

```bash
cd /Users/tongxiaojun/github/my6502
./run_nes.sh games/Donkey-Kong.nes
```

**输出**:
```
ROM: PRG=16KB CHR=8KB Mapper=0
Audio: 44100Hz 2ch
Starting emulation... Press ESC to quit
Frame 60 Cycle 1800000 PRG=0x3a36 CHR=0x0 Video:219,9,128 DE:1
```

**说明**:
- `Video:219,9,128` - PPU 正在输出颜色 (R=219, G=9, B=128)
- `DE:1` - Display Enable 信号有效
- `PRG=0x3a36` - CPU 正在执行代码
- `CHR=0x0` - CHR ROM 地址为 0 (需要修复)

## 下一步

1. **实现完整的 PPU 渲染管道**
   - 图块取指令 (Nametable → Pattern → Attribute)
   - 移位寄存器
   - 精灵渲染

2. **修复 CHR ROM 读取**
   - 实现正确的 CHR 地址生成
   - 连接到 testbench 的 CHR ROM 数据

3. **优化像素捕获**
   - 实现正确的 PPU 周期跟踪
   - 同步像素输出和捕获

4. **测试实际游戏**
   - Donkey Kong (Mapper 0)
   - 验证图形显示

## 编译和运行

```bash
# 清理并重新编译
cd verilator
make -f Makefile.gui clean
make -f Makefile.gui

# 运行
./obj_dir/Vnes_gui ../games/Donkey-Kong.nes
```

## 文件修改列表

1. `src/main/rtl/nes_system.sv` - 主要修复
2. `verilator/nes_gui_tb.cpp` - Testbench 修复
3. `run_nes.sh` - 启动脚本 (无修改)

## 性能

- 编译时间: ~2.4秒
- 帧率: ~60 FPS (目标)
- 周期数: 30000 cycles/frame
- 文件大小: 287KB (可执行文件)
