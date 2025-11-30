# 6502 CPU 测试套件总结

## ✅ 已创建的测试

### 1. 基础指令测试 (01_basic/)

#### test_lda_sta.asm - Load/Store 测试
- **测试内容**：
  - LDA #immediate
  - STA absolute
  - LDA/STA zero page
  - LDA/STA zero page,X
  - LDA/STA absolute,X
  - LDA/STA absolute,Y
- **预期输出**：`123456 OK`
- **文件大小**：155 字节

#### test_math.asm - 算术测试
- **测试内容**：
  - ADC 简单加法
  - ADC 带进位
  - ADC 进位标志
  - SBC 简单减法
  - SBC 带借位
  - 零标志测试
  - 负标志测试
- **预期输出**：`1234567 OK`
- **文件大小**：~200 字节

### 2. 控制流测试 (02_control/)

#### test_branch.asm - 分支测试
- **测试内容**：
  - BEQ (Branch if Equal)
  - BNE (Branch if Not Equal)
  - BCS (Branch if Carry Set)
  - BCC (Branch if Carry Clear)
  - BMI (Branch if Minus)
  - BPL (Branch if Plus)
  - BVS (Branch if Overflow Set)
  - BVC (Branch if Overflow Clear)
- **预期输出**：`12345678 OK`
- **文件大小**：~180 字节

### 3. 集成测试 (05_integration/)

#### test_fibonacci.asm - 斐波那契数列
- **测试内容**：
  - 循环控制
  - 内存操作
  - 算术运算
  - 子程序调用
- **预期输出**：`00 01 01 02 03 05 08 0D 15 22 OK`
- **文件大小**：~150 字节

## 如何使用

### 编译测试

```bash
cd basic/test_suite
./compile_tests.sh
```

### 在 Verilog 中运行

#### 方法 1：直接加载二进制

```systemverilog
initial begin
    $readmemh("test_suite/01_basic/test_lda_sta.hex", memory);
    // 或者使用 bin 文件
    // $readmemb("test_suite/01_basic/test_lda_sta.bin", memory);
end
```

#### 方法 2：转换为 hex 格式

```bash
# 使用 hexdump 转换
hexdump -v -e '1/1 "%02X\n"' test_lda_sta.bin > test_lda_sta.hex
```

#### 方法 3：在 testbench 中监控输出

```systemverilog
reg [7:0] output_buffer [0:255];
integer output_index = 0;

always @(posedge clk) begin
    if (addr == 16'hF000 && !rw) begin
        $write("%c", data_out);
        output_buffer[output_index] = data_out;
        output_index = output_index + 1;
    end
end

// 检查测试结果
initial begin
    // ... 运行测试 ...
    #100000;  // 等待完成
    
    // 检查是否包含 "OK"
    if (output_buffer[output_index-2] == "O" && 
        output_buffer[output_index-1] == "K")
        $display("✓ Test PASSED");
    else
        $display("✗ Test FAILED");
end
```

## 测试覆盖率

### 当前覆盖的指令

| 类别 | 指令 | 测试文件 |
|------|------|----------|
| **Load/Store** | LDA, STA, LDX, LDY, STX, STY | test_lda_sta.asm |
| **算术** | ADC, SBC | test_math.asm |
| **比较** | CMP, CPX, CPY | test_math.asm |
| **分支** | BEQ, BNE, BCS, BCC, BMI, BPL, BVS, BVC | test_branch.asm |
| **跳转** | JMP, JSR, RTS | test_fibonacci.asm |
| **栈操作** | PHA, PLA, PHP, PLP | test_fibonacci.asm |
| **标志位** | CLC, SEC, CLV | test_math.asm, test_branch.asm |
| **递增/递减** | INX, INY, DEX, DEY | test_fibonacci.asm |
| **逻辑** | AND, LSR | test_fibonacci.asm |

### 覆盖统计

- **已测试指令**：~40 条
- **你的 CPU 已实现**：94 条
- **测试覆盖率**：~42%

## 下一步：扩展测试

### 需要添加的测试

#### 1. test_logic.asm - 逻辑运算
```
- AND (所有寻址模式)
- ORA (所有寻址模式)
- EOR (所有寻址模式)
```

#### 2. test_shift.asm - 移位运算
```
- ASL (Arithmetic Shift Left)
- LSR (Logical Shift Right)
- ROL (Rotate Left)
- ROR (Rotate Right)
```

#### 3. test_inc_dec.asm - 内存递增/递减
```
- INC (所有寻址模式)
- DEC (所有寻址模式)
```

#### 4. test_bit.asm - 位测试
```
- BIT zero page
- BIT absolute
```

#### 5. test_indirect.asm - 间接寻址
```
- (indirect,X)
- (indirect),Y
- JMP indirect
```

#### 6. test_stack.asm - 栈操作
```
- PHA/PLA
- PHP/PLP
- TSX/TXS
```

## 调试技巧

### 1. 查看测试输出

如果测试失败，输出会显示 `FAIL` 而不是数字。

例如：
- 成功：`123456 OK`
- 失败：`12FAIL` (在测试 3 失败)

### 2. 添加调试输出

在 Verilog testbench 中：

```systemverilog
always @(posedge clk) begin
    if (state == EXECUTE) begin
        $display("PC=%04X OP=%02X A=%02X X=%02X Y=%02X P=%08b", 
                 PC, opcode, A, X, Y, {N,V,1'b1,B,D,I,Z,C});
    end
end
```

### 3. 单步执行

```systemverilog
// 在特定 PC 处暂停
always @(posedge clk) begin
    if (PC == 16'h0320) begin
        $display("Breakpoint at 0x0320");
        $stop;
    end
end
```

### 4. 内存转储

```systemverilog
initial begin
    // ... 运行测试 ...
    
    // 转储内存
    $writememh("memory_dump.hex", memory, 16'h0000, 16'h00FF);
end
```

## 与标准测试对比

### Klaus Dormann 测试套件

- **优点**：全面、标准、自动化
- **缺点**：需要完整实现、难以调试
- **适用**：最终验证

### 本测试套件

- **优点**：渐进式、易调试、输出清晰
- **缺点**：覆盖不完整、需要手动编写
- **适用**：开发阶段

### 建议流程

1. **开发阶段**：使用本测试套件
   - 快速验证新实现的指令
   - 容易定位问题

2. **集成阶段**：运行实际程序
   - 测试 NES 游戏
   - 验证系统集成

3. **最终验证**：Klaus Dormann 测试
   - 确保完整性
   - 符合标准

## 性能基准

### 预期执行周期

| 测试 | 指令数 | 预期周期 | 实际周期 |
|------|--------|----------|----------|
| test_lda_sta | ~50 | ~150 | ? |
| test_math | ~60 | ~180 | ? |
| test_branch | ~40 | ~120 | ? |
| test_fibonacci | ~200 | ~600 | ? |

### 如何测量

```systemverilog
integer cycle_count = 0;

always @(posedge clk) begin
    if (!reset)
        cycle_count = cycle_count + 1;
end

initial begin
    // ... 运行测试 ...
    $display("Total cycles: %d", cycle_count);
end
```

## 常见问题

### Q: 测试卡住不动？

**检查**：
- PC 是否正确递增
- 分支指令是否正确
- 是否进入无限循环

**解决**：
```systemverilog
// 添加超时
integer timeout = 0;
always @(posedge clk) begin
    timeout = timeout + 1;
    if (timeout > 10000) begin
        $display("TIMEOUT!");
        $finish;
    end
end
```

### Q: 输出乱码？

**检查**：
- $F000 地址的写入逻辑
- rw 信号时序
- 数据总线驱动

### Q: 标志位错误？

**检查**：
- N, Z, C, V 的更新逻辑
- 溢出计算公式
- 标志位保存/恢复

## 总结

✅ **已完成**：
- 4 个基础测试
- 覆盖 ~40 条指令
- 编译脚本

🔄 **进行中**：
- 扩展测试覆盖
- 添加更多寻址模式测试

📋 **待完成**：
- 逻辑运算测试
- 移位运算测试
- 间接寻址测试
- 完整的栈操作测试

---

**下一步**：在你的 Verilog CPU 中运行这些测试！
