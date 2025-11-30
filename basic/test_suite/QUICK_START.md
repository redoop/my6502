# 快速开始 - 5 分钟运行测试

## 1. 编译测试（30 秒）

```bash
cd basic/test_suite
chmod +x compile_tests.sh
./compile_tests.sh
```

**预期输出**：
```
=== Compiling 6502 Test Suite ===
Compiling test_lda_sta.asm... ✓
Compiling test_math.asm... ✓
Compiling test_branch.asm... ✓
Compiling test_fibonacci.asm... ✓

=== Results ===
Compiled: 4/4
✓ All tests compiled successfully
```

---

## 2. 查看测试文件（10 秒）

```bash
ls -lh */*.bin
```

**输出**：
```
155B  01_basic/test_lda_sta.bin
156B  01_basic/test_math.bin
135B  02_control/test_branch.bin
88B   05_integration/test_fibonacci.bin
```

---

## 3. 在 Verilog 中运行（2 分钟）

### 方法 A：最简单（推荐）

创建 `quick_test.sv`：

```systemverilog
module quick_test;
    reg clk, reset;
    
    // 你的 CPU 实例
    cpu_6502 cpu (
        .clk(clk),
        .reset(reset)
        // ... 其他信号 ...
    );
    
    // 加载测试
    initial begin
        $readmemh("test_suite/01_basic/test_lda_sta.hex", cpu.memory);
        reset = 1;
        #100;
        reset = 0;
        #100000;
        $finish;
    end
    
    // 监控输出
    always @(posedge clk) begin
        if (cpu.addr == 16'hF000 && !cpu.rw)
            $write("%c", cpu.data_out);
    end
    
    // 时钟
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
endmodule
```

**运行**：
```bash
iverilog -o test quick_test.sv cpu.sv
vvp test
```

**预期输出**：
```
123456 OK
```

---

### 方法 B：转换为 hex 格式

如果你的 CPU 需要 hex 格式：

```bash
# 转换单个文件
hexdump -v -e '1/1 "%02X\n"' test_lda_sta.bin > test_lda_sta.hex

# 或使用 Python
python3 << EOF
with open('test_lda_sta.bin', 'rb') as f:
    data = f.read()
with open('test_lda_sta.hex', 'w') as f:
    for byte in data:
        f.write(f'{byte:02X}\n')
EOF
```

---

## 4. 解读结果（1 分钟）

### 成功的输出

```
123456 OK          # test_lda_sta
1234567 OK         # test_math
12345678 OK        # test_branch
00 01 01 02... OK  # test_fibonacci
```

每个数字代表一个测试通过。

### 失败的输出

```
12FAIL             # 测试 3 失败
```

或者：

```
123                # 卡在测试 4（超时）
```

---

## 5. 调试（如果需要）

### 添加详细日志

```systemverilog
always @(posedge clk) begin
    if (cpu.state == EXECUTE) begin
        $display("PC=%04X OP=%02X A=%02X X=%02X Y=%02X",
                 cpu.PC, cpu.opcode, cpu.A, cpu.X, cpu.Y);
    end
end
```

### 添加超时保护

```systemverilog
integer timeout = 0;
always @(posedge clk) begin
    timeout = timeout + 1;
    if (timeout > 100000) begin
        $display("TIMEOUT!");
        $finish;
    end
end
```

---

## 测试说明

### test_lda_sta.asm
测试 Load/Store 指令的所有寻址模式。

**测试内容**：
1. LDA #immediate
2. STA absolute
3. LDA/STA zero page
4. LDA/STA zero page,X
5. LDA/STA absolute,X
6. LDA/STA absolute,Y

**预期输出**：`123456 OK`

---

### test_math.asm
测试算术指令和标志位。

**测试内容**：
1. ADC 简单加法
2. ADC 带进位
3. ADC 进位标志
4. SBC 简单减法
5. SBC 带借位
6. 零标志
7. 负标志

**预期输出**：`1234567 OK`

---

### test_branch.asm
测试所有分支指令。

**测试内容**：
1. BEQ
2. BNE
3. BCS
4. BCC
5. BMI
6. BPL
7. BVS
8. BVC

**预期输出**：`12345678 OK`

---

### test_fibonacci.asm
计算斐波那契数列（集成测试）。

**测试内容**：
- 循环控制
- 内存操作
- 算术运算
- 子程序调用

**预期输出**：`00 01 01 02 03 05 08 0D 15 22 OK`

---

## 常见问题

### Q: 编译失败？

**检查**：
- 是否安装了 xa？`brew install xa`
- 是否在正确的目录？`cd basic/test_suite`

### Q: 测试卡住？

**原因**：
- 无限循环
- PC 跳转错误
- 指令实现错误

**解决**：
- 添加超时保护
- 查看 PC 值
- 添加详细日志

### Q: 输出乱码？

**检查**：
- $F000 地址匹配
- rw 信号时序
- 数据总线驱动

### Q: 如何知道哪里出错？

**方法**：
1. 看输出数字（如 `12FAIL` = 测试 3 失败）
2. 添加日志查看 PC 和寄存器
3. 对比预期行为

---

## 下一步

✅ **测试通过**？
- 运行其他测试
- 添加更多测试
- 实现缺失的指令

❌ **测试失败**？
- 查看详细日志
- 对比参考实现
- 逐步调试

---

## 完整文档

- [测试指南](../TESTING_GUIDE.md) - 详细说明
- [Verilog 集成](./VERILOG_INTEGRATION.md) - 集成方法
- [验证策略](../VERIFICATION_STRATEGY.md) - 整体策略
- [测试总结](./TEST_SUMMARY.md) - 测试详情

---

**5 分钟快速开始，立即验证你的 CPU！** ⚡
