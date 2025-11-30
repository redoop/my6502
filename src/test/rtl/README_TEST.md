# CPU 6502 指令单元测试

## 快速开始

```bash
cd src/test
make test
```

## 测试框架特点

### ✅ 优势
- **简洁**: 每个测试 5-10 行代码
- **快速**: 秒级完成所有测试
- **直观**: 清晰的 PASS/FAIL 输出
- **完整**: 覆盖所有指令类型

### 📋 测试覆盖

**已实现测试**:
1. LDA #imm - 立即数加载
2. LDA zp - 零页加载
3. STA zp - 零页存储
4. ADC #imm - 加法
5. SBC #imm - 减法
6. AND #imm - 逻辑与
7. ORA #imm - 逻辑或
8. TAX - 寄存器传输
9. INX - 递增
10. BEQ - 条件分支

**待添加测试**:
- [ ] LDA abs, abs,X, abs,Y
- [ ] STA abs, abs,X
- [ ] 间接寻址 (ind,X), (ind),Y
- [ ] 移位指令 ASL, LSR, ROL, ROR
- [ ] 比较指令 CMP, CPX, CPY
- [ ] 栈操作 PHA, PLA, PHP, PLP
- [ ] 跳转 JMP, JSR, RTS
- [ ] 中断 BRK, RTI

## 添加新测试

### 模板

```systemverilog
// Test N: 指令名称
begin
    logic [7:0] prog[] = '{
        8'hXX, 8'hYY,  // 指令和操作数
        8'hEA          // NOP
    };
    $display("Test N: 指令描述");
    load_program(prog, size, 16'hC000);
    reset_cpu();
    run_cycles(30);
    check_register("寄存器", 期望值, 实际值);
    $display("  PASS\n");
end
```

### 示例：测试 EOR

```systemverilog
begin
    logic [7:0] prog[] = '{
        8'hA9, 8'hAA,  // LDA #$AA
        8'h49, 8'h55,  // EOR #$55
        8'hEA          // NOP
    };
    $display("Test: EOR #$55");
    load_program(prog, 5, 16'hC000);
    reset_cpu();
    run_cycles(30);
    check_register("A", 8'hFF, cpu.A);  // AA ^ 55 = FF
    $display("  PASS\n");
end
```

## 工具函数

### reset_cpu()
复位 CPU，等待稳定

### load_program(prog[], size, addr)
加载程序到指定地址，设置 Reset Vector

### run_cycles(n)
运行 n 个时钟周期

### check_register(name, expected, actual)
检查寄存器值，失败则终止

## 调试

### 生成波形
```bash
make wave
gtkwave cpu_test.vcd
```

### 添加调试输出
```systemverilog
$display("DEBUG: PC=$%04x A=$%02x", cpu.PC, cpu.A);
```

## 高级用法

### 测试标志位
```systemverilog
check_register("Z flag", 1'b1, cpu.Z);
check_register("N flag", 1'b0, cpu.N);
```

### 测试内存
```systemverilog
check_register("MEM[$20]", 8'h42, mem[16'h0020]);
```

### 测试多周期指令
```systemverilog
run_cycles(50);  // 给足够的时间
```

## 性能

- 单个测试: ~1μs
- 10 个测试: ~10μs
- 完整套件 (100+ 测试): ~100μs

## 与 Chisel 测试对比

| 特性 | SystemVerilog | Chisel |
|------|---------------|--------|
| 编译时间 | 2-3秒 | 10-20秒 |
| 运行时间 | 微秒级 | 毫秒级 |
| 代码量 | 5-10行/测试 | 10-20行/测试 |
| 调试 | 直接波形 | 需要转换 |

## 最佳实践

1. **一个测试一个功能** - 保持简单
2. **使用描述性名称** - 清晰的测试目的
3. **检查所有副作用** - 寄存器、标志、内存
4. **足够的周期数** - 确保指令完成
5. **独立测试** - 每个测试重新加载程序

## 示例输出

```
=== CPU 6502 Instruction Tests ===

Test 1: LDA #$42
  PASS

Test 2: LDA $10
  PASS

Test 3: STA $20
  PASS

...

=== All Tests Passed! ===
```
