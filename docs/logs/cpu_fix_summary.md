# CPU 死循环问题修复总结

**日期**: 2025-11-29  
**状态**: ✅ 部分修复，发现新问题

## 已修复的问题

### ✅ 1. PRG ROM 镜像映射错误
**问题**: 16KB ROM 没有正确镜像到 $C000-$FFFF  
**原因**: 使用 `cpuAddr(14, 0)` (15 位) 访问 32KB 空间  
**修复**: 改为 `cpuAddr(13, 0)` (14 位) 支持 16KB 镜像  
**文件**: `src/main/scala/nes/NESSystemRefactored.scala`  
**结果**: Reset Vector 现在正确读取为 $C79E ✅

### ✅ 2. Fetch 状态内存读取延迟
**问题**: CPU 在 Fetch 状态读取错误的 opcode  
**原因**: `SyncReadMem` 有 1 个周期延迟，但 Fetch 在同一周期读取和使用数据  
**症状**: Opcode 总是错误的值 (如 0xC7 而不是 0xD8)  
**修复**: Fetch 状态分成 2 个周期：
  - 周期 0: 发出读请求
  - 周期 1: 读取数据并进入 Execute
**文件**: `src/main/scala/cpu/core/CPU6502Core.scala`  
**结果**: CPU 现在正确执行指令 ✅

### ✅ 3. 调试输出增强
**添加**: 
- CPU 状态机状态 (Reset/Fetch/Execute/NMI/Done)
- CPU 周期计数
- 当前 Opcode
- PPUCTRL 值和 NMI 使能位

**文件**: 
- `src/main/scala/nes/NESSystemRefactored.scala`
- `verilator/testbench_main.cpp`

## 当前状态

### ✅ CPU 正常运行
- PC 正确递增: $C7A0 → $C7A2 → $C7A5 → ...
- Opcode 正确: 0xD8 (CLD), 0xA9 (LDA), 0x8D (STA), ...
- 寄存器正常: X=0xA2, A 在变化
- VBlank 正常工作

### ❌ 新问题：PPUCTRL 写入无效

**现象**:
```
$C7A0: LDA #$10      ; A = 0x10
$C7A2: STA $2000     ; 写入 PPUCTRL
```

游戏代码明确写入 PPUCTRL = 0x10，但是 debug 输出显示 PPUCTRL = 0x00

**可能原因**:
1. PPU 寄存器写入逻辑有问题
2. 内存映射不正确
3. CPU 写入信号没有正确传递

## 下一步调试

1. **检查 PPU 寄存器写入**
   - 查看 `NESSystemRefactored` 的 PPU 写入逻辑
   - 确认 `isPpuReg` 条件是否正确
   - 确认 CPU 的 `memWrite` 信号

2. **添加写入日志**
   - 在 testbench 中监控所有 $2000 的写入
   - 确认写入是否真的发生

3. **检查 PPU 寄存器模块**
   - 确认 PPUCTRL 寄存器是否正确更新
   - 检查 `PPURefactored` 的寄存器连接

## 测试命令

```bash
# 编译
./scripts/build.sh fast

# 运行测试
timeout 10 ./build/verilator/VNESSystemRefactored games/Donkey-Kong.nes

# 查看 PPUCTRL 变化
timeout 30 ./build/verilator/VNESSystemRefactored games/Donkey-Kong.nes 2>&1 | grep "PPUCTRL"
```

## 相关代码

**CPU Fetch 修复**:
```scala
is(sFetch) {
  when(nmiPending) {
    cycle := 0.U
    state := sNMI
  }.otherwise {
    when(cycle === 0.U) {
      // 周期 0: 发出读请求
      io.memAddr := regs.pc
      io.memRead := true.B
      cycle := 1.U
    }.otherwise {
      // 周期 1: 读取数据
      opcode := io.memDataIn
      regs.pc := regs.pc + 1.U
      cycle := 0.U
      state := sExecute
    }
  }
}
```

**PRG ROM 镜像修复**:
```scala
val prgAddr = cpuAddr(13, 0)  // 14 位 = 16KB
val prgData = prgRom.read(prgAddr)
```
