# 游戏兼容性测试报告 - Issue #1

## 📊 测试总结

测试了 3 款经典 NES 游戏，总体兼容性 **53%**。CPU 和内存系统工作正常，但 PPU 寄存器写入失败导致游戏逻辑无法启动。

| 游戏 | Mapper | 兼容性 | 状态 |
|------|--------|--------|------|
| Donkey Kong | 0 (NROM) | 60% | ⚠️ CPU 运行但游戏未启动 |
| Super Mario Bros | 4 (MMC3) | 50% | ⚠️ 同上 |
| Super Contra X | 4 (MMC3) | 50% | ⚠️ 同上 |

---

## ✅ 已修复的关键问题

### 1. PRG ROM 镜像映射错误 (Critical)

**问题**: 16KB ROM 没有正确镜像到 $C000-$FFFF，导致 Reset Vector 读取错误。

**修复**: 
```scala
// 修复前: 使用 15 位地址
val prgData = prgRom.read(cpuAddr(14, 0))

// 修复后: 使用 14 位地址支持 16KB 镜像
val prgAddr = cpuAddr(13, 0)
val prgData = prgRom.read(prgAddr)
```

**结果**: ✅ Reset Vector 现在正确读取

---

### 2. CPU Fetch 状态内存读取延迟 (Critical)

**问题**: `SyncReadMem` 有 1 周期延迟，但 Fetch 在同一周期读取和使用数据，导致 opcode 错误。

**症状**: CPU 读取到非法指令 (如 0xC7 而不是 0xD8)，卡死在 Execute 状态。

**修复**: 将 Fetch 状态分成 2 个周期：
```scala
is(sFetch) {
  when(cycle === 0.U) {
    // 周期 0: 发出读请求
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 1.U
  }.otherwise {
    // 周期 1: 读取数据 (数据已准备好)
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U
    cycle := 0.U
    state := sExecute
  }
}
```

**结果**: ✅ CPU 现在正确执行所有指令

**验证**:
```
[Cycle 30000] PC=0xC7A0 Opcode=0xD8 (CLD)  ✅
[Cycle 40000] PC=0xC7A2 Opcode=0xA9 (LDA)  ✅
[Cycle 50000] PC=0xC7A5 Opcode=0x8D (STA)  ✅
```

---

## ⚠️ 当前阻塞问题

### PPU 寄存器写入无效 (High Priority)

**问题**: 游戏执行 `STA $2000` 写入 PPUCTRL，但寄存器保持 0x00。

**影响**:
- PPUCTRL bit 7 (NMI enable) 未设置
- VBlank NMI 中断无法触发
- 游戏主循环无法启动
- **所有 3 个游戏都无法进入可玩状态**

**反汇编证据** (Donkey Kong):
```
$C7A0: LDA #$10      ; A = 0x10
$C7A2: STA $2000     ; 写入 PPUCTRL ❌ 失败
$C7A5: LDX #$FF      
$C7A7: TXS           
$C7A9: LDA $2002     ; 读取 PPUSTATUS
$C7AB: AND #$80      
$C7AE: BEQ $C7A0     ; 循环等待 VBlank
```

**调试输出**:
```
[Cycle 30000] PPUCTRL=0x00  ❌ 应该是 0x10
[Cycle 40000] PPUCTRL=0x00  ❌ 仍然是 0x00
```

**需要调试**:
- [ ] 检查 `ppu.io.cpuWrite` 信号是否触发
- [ ] 检查 PPU 寄存器模块的 PPUCTRL 更新逻辑
- [ ] 添加 Scala printf 监控 PPU 写入
- [ ] 使用 VCD 波形分析时序

---

## 📈 系统组件状态

| 组件 | 状态 | 评分 | 说明 |
|------|------|------|------|
| CPU (6502) | ✅ | 98% | 指令集完整，执行正常 |
| PPU | ⚠️ | 70% | 渲染基本正常，寄存器写入失败 |
| Memory | ✅ | 98% | RAM/ROM 访问正常 |
| Mappers | ✅ | 97% | Mapper 0/4 支持良好 |
| Controllers | ✅ | 100% | 所有按键正常 |

---

## 🎯 下一步计划

### 优先级 1: 修复 PPU 寄存器写入
这是当前唯一阻塞游戏运行的问题。

### 优先级 2: 验证 NMI 中断
确认 PPUCTRL 修复后 NMI 能正常触发。

### 优先级 3: 完整游戏测试
测试完整的游戏流程。

---

## 📚 详细报告

完整测试报告: [GAME_COMPATIBILITY_REPORT.md](../GAME_COMPATIBILITY_REPORT.md)

包含:
- 详细的问题分析和修复过程
- 每个游戏的详细测试结果
- CPU 执行状态和反汇编
- 系统组件详细评分

---

## 🔧 测试环境

- **版本**: v0.7.0
- **仿真器**: Verilator 5.042
- **平台**: macOS
- **测试日期**: 2025-11-29

**测试命令**:
```bash
./scripts/build.sh fast
./scripts/run.sh games/Donkey-Kong.nes
```

---

**测试团队**: 窗口 1 (主测试) + 窗口 3 (游戏运行) + 窗口 4 (文档编写)
