# CPU 死锁问题分析

**日期**: 2025-11-29  
**问题**: CPU 在执行第二条指令后卡死

## 问题现象

1. **Reset Vector 正确**: $C79E (从 ROM 正确读取)
2. **第一条指令执行成功**: $C79E: SEI (0x78) ✅
3. **第二条指令卡死**: $C79F: CLD (0xD8) ❌
4. **PC 不再变化**: 一直停留在 $C79F
5. **NMI 从未触发**: PPUCTRL = 0x00, NMI_EN = 0

## 已修复的问题

### ✅ 1. PRG ROM 镜像映射
**问题**: 16KB ROM 没有正确镜像到 $C000-$FFFF  
**修复**: 使用 `cpuAddr(13, 0)` 而不是 `cpuAddr(14, 0)`  
**结果**: Reset Vector 现在正确读取为 $C79E

### ✅ 2. 控制器输入
**问题**: 控制器状态只在 `handleInput()` 中更新  
**修复**: 在每个 `tick()` 中更新控制器状态  
**结果**: 控制器输入现在每个周期都传递给 DUT

### ✅ 3. 调试输出
**问题**: 缺少 PPUCTRL 和 NMI 状态  
**修复**: 添加详细的 CPU 状态日志  
**结果**: 可以看到 PPUCTRL = 0x00, NMI = 0

## 当前问题

### ❌ CPU 在第二条指令后卡死

**症状**:
- PC 从 $C79E (SEI) 正确前进到 $C79F (CLD)
- 但是 CLD 指令执行后 PC 不再变化
- 所有寄存器 (A/X/Y) 都是 0x00

**可能原因**:

#### 1. 内存读取延迟问题
- Chisel 的 `SyncReadMem` 有 1 个周期的延迟
- CPU 可能在读取指令时没有等待足够的周期

#### 2. 状态机卡在 Execute 状态
- `execResult.done` 可能没有正确设置
- 或者状态机没有正确转换回 Fetch

#### 3. Fetch 状态的内存读取
- Fetch 状态可能没有正确读取下一条指令
- `io.memDataIn` 可能不是最新的值

## 调试步骤

### 下一步调试

1. **添加状态机状态输出**
   - 导出 CPU 的 state 和 cycle 到 debug bundle
   - 查看 CPU 卡在哪个状态

2. **添加指令执行日志**
   - 在 Verilator testbench 中打印每条指令
   - 查看 CLD 是否真的被执行

3. **检查内存读取时序**
   - 添加内存读取日志
   - 确认 `io.memDataIn` 的值是否正确

4. **单步调试**
   - 使用 VCD 波形查看详细时序
   - 确认状态机转换

## 测试命令

```bash
# 重新编译
./scripts/build.sh fast

# 运行测试
timeout 5 ./build/verilator/VNESSystemRefactored games/Donkey-Kong.nes

# 查看日志
grep "Cycle.*PPUCTRL" output.log
```

## 相关文件

- CPU 核心: `src/main/scala/cpu/core/CPU6502Core.scala`
- Flag 指令: `src/main/scala/cpu/instructions/Flag.scala`
- NES 系统: `src/main/scala/nes/NESSystemRefactored.scala`
- Testbench: `verilator/testbench_main.cpp`
