# Level 6 调试发现

**日期**: 2025-12-01 23:47  
**问题**: 游戏初始化卡住，无PPU写入

## 🔍 调试过程

### 1. 添加PC追踪

添加了CPU程序计数器追踪，发现游戏执行流程：

```
PC=c7ab: 读取PPUSTATUS (第一个VBlank)
PC=c7ac-c7ae: 执行几条指令
PC=c7a8-c7ab: 跳回VBlank等待循环 (第二个VBlank)
PC=c7ac-c7b8: 继续执行
PC=c7b9-c7bd: **卡在这个循环中**
```

### 2. 发现RAM清零循环

游戏卡在 `c7b9-c7bd` 的5字节循环中：

```asm
c7b9: STA ($00),Y    ; 写入RAM
c7bb: DEY            ; Y递减
c7bc: BNE c7b9       ; 如果Y!=0，跳回c7b9
```

这是标准的NES初始化 - 清零RAM ($0000-$07FF)。

### 3. 问题确认

**症状**: 游戏执行了5000+条指令，仍然在RAM清零循环中

**预期**: 循环应该执行256次后退出（Y从$FF递减到$00）

**实际**: 循环永远不退出

## 🎯 根本原因

RAM清零循环无法退出，可能的原因：

### 原因1: DEY指令问题
- DEY没有正确递减Y寄存器
- 或者没有正确设置Z标志

### 原因2: BNE指令问题  
- BNE没有正确检查Z标志
- 或者分支逻辑有误

### 原因3: Y寄存器初始化问题
- Y寄存器可能没有正确初始化
- 导致循环次数不对

## 📊 内存访问日志

循环中的内存访问：
```
[STUCK_LOOP_WRITE] PC=c7bb addr=0700 data=00
[STUCK_LOOP_WRITE] PC=c7bb addr=07ff data=00
[STUCK_LOOP_WRITE] PC=c7bb addr=07fe data=00
...
```

确认游戏在清零RAM，但循环不退出。

## 🔧 解决方案

### 方案1: 检查DEY指令实现

在 `cpu_6502.sv` 中检查DEY指令：

```systemverilog
// DEY - Decrement Y
8'h88: begin
    Y <= Y - 1;
    Z <= (Y - 1 == 0);  // 设置Z标志
    N <= (Y - 1)[7];    // 设置N标志
end
```

### 方案2: 检查BNE指令实现

检查BNE (Branch if Not Equal) 指令：

```systemverilog
// BNE - Branch if Not Equal (Z=0)
8'hD0: begin
    if (!Z) begin
        PC <= PC + signed_offset;
    end
end
```

### 方案3: 添加Y寄存器追踪

添加日志追踪Y寄存器的值：

```systemverilog
if (cpu_pc == 16'hc7bc) begin  // DEY指令
    $display("[DEY] Y=%02x -> %02x, Z=%b", Y_before, Y_after, Z);
end
```

## 📝 下一步

1. **立即**: 检查DEY和BNE指令实现
2. **短期**: 添加Y寄存器追踪
3. **中期**: 修复指令bug
4. **验证**: 重新运行Level 6测试

## 🎓 关键发现

1. ✅ VBlank读取正常
2. ✅ 游戏开始初始化流程
3. ✅ 游戏执行RAM清零
4. ❌ RAM清零循环无法退出
5. ❌ 可能是DEY或BNE指令bug

## 💡 测试方法

使用PC追踪功能：

```bash
# 编译
cd src/test/rtl
rm -rf obj_dir_gui
verilator ... --build

# 运行并追踪
timeout 30 obj_dir_gui/Vnes_system games/DonkeyKong_mapper0.nes test.bmp 2>&1 | grep PC_TRACK
```

---

**状态**: 已定位问题到DEY/BNE指令  
**下一步**: 检查CPU指令实现
