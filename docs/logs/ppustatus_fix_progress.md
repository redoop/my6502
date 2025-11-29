# PPUSTATUS 修复进度

**日期**: 2025-11-29 20:00  
**状态**: 🔍 调试中

## 单元测试专家的发现 ✅

- CPU 指令: ✅ 完全正常
- PPU PPUSTATUS: ❌ 始终返回 0x00
- 根本原因: vblankFlag 和 regs.vblank 不同步

## 调试发现

### 1. VBlank 信号正常
```
[PPU Regs] setVBlank triggered, vblank=1
[PPU Regs] clearVBlank triggered, vblank=0
```
✅ setVBlank/clearVBlank 正常触发

### 2. PPU 读取未触发
```
[PPU Read] Addr=$2002 RegAddr=2
```
❌ 没有这个输出！

### 3. LDA $2002 读取到 0x00
```
PC=0xC7AB A=0x00 ... Opcode=0xAD
```
❌ A 应该是 0x80 (VBlank=1)

## 根本原因

**SyncReadMem 延迟问题 (again!)**

LDA $2002 的执行：
- Cycle 0: 读取地址低字节
- Cycle 1: 读取地址高字节
- Cycle 2: 发出读请求 (memRead=true)
- Cycle 3: 数据准备好，读取 memDataIn

但是 PPU 读取检测在 Cycle 2：
```scala
when(cpu.io.memRead && isPpuReg) {
  // 这在 Cycle 2 触发
}
```

而 PPURegisterControl 的读取检测：
```scala
when(io.cpuRead && io.cpuAddr === 2.U) {
  // 这也在 Cycle 2 触发
  // 但是 memDataIn 还没准备好！
}
```

## 问题

**时序不匹配**:
1. Cycle 2: memRead 信号发出，PPU 检测到读取
2. Cycle 2: PPU 返回 PPUSTATUS (但是基于旧的 vblank 值)
3. Cycle 3: CPU 读取 memDataIn (但是是 Cycle 2 的数据)

## 解决方案

### 方案 1: 修改 PPU 读取时序 ❌
- 在 Cycle 3 才检测读取
- 问题: 需要延迟 cpuRead 信号

### 方案 2: 修改 LDA 指令 ❌
- 在 Cycle 2 就读取数据
- 问题: 违反 SyncReadMem 的延迟要求

### 方案 3: 使用组合逻辑 ✅
- PPUSTATUS 使用组合逻辑，立即反映 vblank
- 不需要等待周期
- 符合 6502 的行为

## 下一步

实施方案 3：
1. 修改 PPURegisterControl，PPUSTATUS 使用组合逻辑
2. 确保 vblank 立即反映到 PPUSTATUS
3. 测试验证

---

**报告人**: 研发主程  
**更新时间**: 2025-11-29 20:00
