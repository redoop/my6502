# 游戏测试结果

**日期**: 2025-11-29 19:25  
**测试环境**: Verilator 仿真器 (快速模式)

## 测试游戏列表

### 1. Donkey Kong (Mapper 0)
- **ROM 大小**: 24 KB
- **Mapper**: 0 (NROM)
- **状态**: 🟡 部分工作
- **现象**: 
  - ✅ CPU 正常启动
  - ✅ 读取 Reset Vector
  - ✅ 执行指令
  - ✅ PPU 寄存器写入正常
  - ❌ 卡在等待循环 (0xC79F-0xC7AE)
- **循环代码**:
  ```
  $C7A9: LDA $2002    ; 读取 PPUSTATUS
  $C7AC: AND #xx
  $C7AE: BEQ $C7A0    ; 如果 Z=1，跳回
  ```
- **运行时间**: 60 秒，98,320,000 个周期
- **问题**: 游戏在等待 PPUSTATUS 的某个条件

### 2. Super Mario Bros (Mapper 4)
- **ROM 大小**: 384 KB (262 KB PRG + 131 KB CHR)
- **Mapper**: 4 (MMC3)
- **状态**: ❌ 无法启动
- **现象**:
  - ❌ CPU 卡死在 Reset 状态
  - PC = 0x0000
  - State = Reset(0)
  - Opcode = 0x00
- **问题**: Mapper 4 (MMC3) 未正确实现或 ROM 加载问题

### 3. Super Contra X (Mapper 4)
- **ROM 大小**: 512 KB
- **Mapper**: 4 (MMC3)
- **状态**: 未测试 (预计与 Super Mario Bros 相同)

## 问题分析

### Donkey Kong 问题

**等待循环分析**:
- 游戏读取 PPUSTATUS ($2002)
- 得到 0x40 或 0x10
- AND 后结果为 0x00
- BEQ 跳转回循环开始

**可能原因**:
1. **PPUSTATUS 位定义错误**
   - Bit 7: VBlank
   - Bit 6: Sprite 0 Hit
   - Bit 5: Sprite Overflow
   - 游戏可能在等待某个特定的位组合

2. **PPU 时序问题**
   - VBlank 时序可能不正确
   - Sprite 0 Hit 可能未实现
   - 读取 PPUSTATUS 后应该清除 VBlank 标志

3. **游戏逻辑**
   - 这可能是正常的启动等待
   - 需要更多的 PPU 功能才能继续

### Super Mario Bros 问题

**Mapper 4 (MMC3) 问题**:
- Reset Vector 读取失败
- PC 保持在 0x0000
- 可能的原因：
  1. Mapper 4 的 bank switching 未正确实现
  2. Reset Vector 在错误的 bank
  3. ROM 加载到错误的地址

## 执行的指令统计

### Donkey Kong
- 0x00: BRK
- 0x29: AND #imm ✅
- 0x8D: STA abs ✅
- 0x9A: TXS ✅
- 0xA2: LDX #imm ✅
- 0xA9: LDA #imm ✅
- 0xAD: LDA abs ✅
- 0xD8: CLD ✅
- 0xF0: BEQ ✅

**总计**: 9 种指令，全部实现

## 系统功能状态

### CPU
- ✅ 基本指令执行
- ✅ 寄存器操作
- ✅ 内存读写
- ✅ 分支跳转
- ✅ Reset Vector 读取 (Mapper 0)
- ❌ Reset Vector 读取 (Mapper 4)

### PPU
- ✅ PPUCTRL 写入
- ✅ PPUSTATUS 读取
- ✅ VBlank 标志
- ❓ Sprite 0 Hit (未确认)
- ❓ Sprite Overflow (未确认)
- ❓ 读取 PPUSTATUS 清除 VBlank (未确认)

### Memory Mapper
- ✅ Mapper 0 (NROM) - 基本工作
- ❌ Mapper 4 (MMC3) - 不工作

## 下一步调试

### 优先级 1: 修复 Donkey Kong 等待循环
- [ ] 分析 AND 的操作数
- [ ] 检查 PPUSTATUS 的实现
- [ ] 确认读取 PPUSTATUS 是否清除 VBlank
- [ ] 实现 Sprite 0 Hit (如果需要)

### 优先级 2: 修复 Mapper 4
- [ ] 检查 MMC3 实现
- [ ] 确认 bank switching
- [ ] 测试 Super Mario Bros

### 优先级 3: 创建测试 ROM
- [ ] 创建简单的测试 ROM
- [ ] 验证基本功能
- [ ] 隔离问题

## 建议

1. **专注于 Donkey Kong**
   - 这是唯一能启动的游戏
   - 问题相对简单
   - 修复后可以验证基本功能

2. **暂时跳过 Mapper 4 游戏**
   - Mapper 4 实现复杂
   - 需要更多时间
   - 先确保 Mapper 0 完全工作

3. **添加更多调试信息**
   - 监控 PPUSTATUS 的所有位
   - 记录 AND 的操作数
   - 追踪 PPU 状态变化

## 总结

✅ **Mapper 0 (Donkey Kong)**: 部分工作，卡在等待循环  
❌ **Mapper 4 (Mario/Contra)**: 无法启动  
🎯 **下一步**: 修复 Donkey Kong 的等待循环问题

---

**测试人**: 主研发窗口  
**测试时间**: 2025-11-29 19:25
