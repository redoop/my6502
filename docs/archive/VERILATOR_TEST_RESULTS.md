# Verilator 仿真测试结果

## 测试日期
2025-11-28

## 测试环境
- 系统: macOS
- Verilator: 5.042
- SDL2: 已安装
- sbt: 已安装

## 编译状态
✅ **成功** - Verilator 编译通过，生成可执行文件 `build/verilator/VNESSystem`

## 测试 ROM
- **Donkey Kong** (16KB PRG ROM, 8KB CHR ROM)
  - NMI 向量: 0xc85f
  - Reset 向量: 0xc79e

## 当前问题

### 1. CPU Reset 问题 ❌
**症状:**
- CPU 在 reset 后 PC 停留在 0x0-0x2
- 应该跳转到 reset vector (0xc79e)，但没有发生
- CPU 状态机在循环: State 0 (Reset) → State 1 (Fetch) → State 2 (Execute)

**观察到的行为:**
```
周期 0: state=0 cycle=0 PC=0x0 opcode=0x0
周期 1: state=0 cycle=1 PC=0x0 opcode=0x0
周期 2: state=0 cycle=2 PC=0x0 opcode=0x0
周期 3: state=0 cycle=3 PC=0x0 opcode=0x0
周期 4: state=1 cycle=0 PC=0x0 opcode=0x0
周期 5: state=2 cycle=0 PC=0x1 opcode=0x0
周期 6: state=2 cycle=1 PC=0x2 opcode=0x0
...循环...
```

**根本原因:**
CPU6502Refactored 的 reset 逻辑没有正确实现 6502 的 reset 序列：
1. 6502 在 reset 时应该从地址 0xFFFC 读取 reset vector 低字节
2. 从地址 0xFFFD 读取 reset vector 高字节
3. 将 PC 设置为该地址
4. 当前实现直接从 PC=0 开始执行

### 2. 内存读取问题 ⚠️
**症状:**
- Opcode 始终读取为 0x0 (BRK 指令)
- 这导致 CPU 不断触发中断，SP 不断减少

**可能原因:**
- `SyncReadMem` 有一个周期的读取延迟
- CPU 可能在错误的时钟周期读取数据

### 3. PPU 渲染 ⚠️
**观察:**
- PPU 在运行（VBlank 信号正常）
- 有 22080/61440 非零像素（约 36%）
- PPUCTRL 和 PPUMASK 都是 0x0（渲染未启用）

## 需要修复的问题

### 优先级 1: CPU Reset 序列
修改 `CPU6502Refactored` 的 reset 逻辑：
- 在 reset 状态下，从 0xFFFC/0xFFFD 读取 reset vector
- 正确设置 PC 寄存器
- 初始化 SP 为 0xFD（6502 规范）
- 设置中断禁止标志

### 优先级 2: 内存时序
检查并修复：
- `MemoryController` 的 `SyncReadMem` 时序
- CPU 读取指令的时序
- 确保 CPU 在正确的周期读取数据

### 优先级 3: 测试验证
创建简单的测试 ROM：
- 只包含几条简单指令
- 验证 CPU 能正确执行基本操作
- 逐步增加复杂度

## 脚本状态
✅ `scripts/verilator_build.sh` - 工作正常
✅ `scripts/verilator_run.sh` - 工作正常
✅ SDL2 窗口创建 - 工作正常
✅ ROM 加载 - 工作正常

## 修复尝试记录

### 尝试 1: 增加 reset 序列周期
- 修改了 CPU6502Core 的 reset 序列，增加等待周期
- 结果：PC 仍然停留在 0x0-0x2

### 尝试 2: 修复地址映射
- 修复了 MemoryController 的 ROM 地址映射，支持 16KB 镜像
- 使用 `(io.cpuAddr - 0x8000.U)(14, 0)` 来支持 16KB ROM 镜像
- 结果：PC 仍然停留在 0x0-0x2

### 根本问题分析
CPU reset 序列执行了（state=0, cycle 0→1→2→3），但读取的 reset vector 数据不正确。
可能的原因：
1. Verilator 仿真中，Mem 的读取时序与 Chisel 仿真不同
2. 需要使用 VCD 波形文件来调试实际的信号值
3. 可能需要在 testbench 中直接设置 PC 来绕过 reset 问题

## ✅ 问题已解决！

### 最终修复
**根本原因：** ROM 地址映射和 CPU reset 序列的时序问题

1. **ROM 地址映射错误**
   - 错误：使用 `(io.cpuAddr - 0x8000.U)(14, 0)` 取 15 位
   - 正确：使用 `(io.cpuAddr - 0x8000.U)(13, 0)` 取 14 位
   - 这样 16KB ROM 可以正确镜像到 0x8000-0xBFFF 和 0xC000-0xFFFF

2. **Reset 序列时序**
   - 问题：在同一周期内读取数据并改变地址，导致读取到错误的数据
   - 解决：分离数据采样和地址改变到不同周期
   - 最终序列：
     - Cycle 0: 设置地址 0xFFFC
     - Cycle 1: 读取并保存低字节到 operand 寄存器
     - Cycle 2: 设置地址 0xFFFD
     - Cycle 3: 等待数据稳定
     - Cycle 4: 读取高字节，组合成 reset vector，设置 PC

### 测试结果 ✅
**Donkey Kong 成功运行！**
- CPU 正确跳转到 reset vector (0xC79E)
- PC 在代码中执行 (0xC7AF)
- 寄存器正常工作 (A=0x80, X=0xFF, Y=0x0, SP=0xFF)
- PPU 已配置 (PPUCTRL=0x10)
- 有图像输出 (23040/61440 非零像素)
- FPS ≈ 2 (仿真速度较慢，但功能正常)

## 下一步
1. ✅ CPU reset 序列 - 已修复
2. ✅ ROM 地址映射 - 已修复
3. ✅ 基本执行验证 - 通过
4. 🔄 优化仿真速度
5. 🔄 测试更多 ROM (Super Mario Bros, Contra)
6. 🔄 验证 PPU 渲染是否正确
