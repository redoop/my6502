# 在 Verilog 中集成测试

## 快速开始

### 1. 准备测试文件

```bash
# 编译所有测试
cd basic/test_suite
./compile_tests.sh

# 转换为 hex 格式（如果需要）
hexdump -v -e '1/1 "%02X\n"' 01_basic/test_lda_sta.bin > test_lda_sta.hex
```

### 2. 修改 Testbench

在你的 `cpu_tb.sv` 或 `testbench.sv` 中：

```systemverilog
module cpu_testbench;
    // ... 现有的信号定义 ...
    
    // 添加测试输出捕获
    reg [7:0] test_output [0:255];
    integer output_idx = 0;
    
    // CPU 实例化
    cpu_6502 cpu (
        .clk(clk),
        .reset(reset),
        // ... 其他信号 ...
    );
    
    // 捕获输出到 $F000
    always @(posedge clk) begin
        if (cpu.addr == 16'hF000 && !cpu.rw) begin
            $write("%c", cpu.data_out);
            test_output[output_idx] = cpu.data_out;
            output_idx = output_idx + 1;
        end
    end
    
    // 测试主流程
    initial begin
        $display("=== Running 6502 Tests ===");
        
        // 测试 1: LDA/STA
        run_test("test_lda_sta.hex", "123456 OK");
        
        // 测试 2: Math
        run_test("test_math.hex", "1234567 OK");
        
        // 测试 3: Branch
        run_test("test_branch.hex", "12345678 OK");
        
        // 测试 4: Fibonacci
        run_test("test_fibonacci.hex", "OK");
        
        $display("=== All Tests Complete ===");
        $finish;
    end
    
    // 运行单个测试的任务
    task run_test(input string filename, input string expected);
        integer i;
        reg [7:0] actual [0:255];
        integer actual_len;
        
        begin
            $display("\n--- Testing: %s ---", filename);
            
            // 清空内存和输出
            for (i = 0; i < 65536; i = i + 1)
                cpu.memory[i] = 8'h00;
            output_idx = 0;
            
            // 加载测试程序
            $readmemh(filename, cpu.memory);
            
            // 复位 CPU
            reset = 1;
            #100;
            reset = 0;
            
            // 运行直到 BRK 或超时
            fork
                begin
                    // 等待 BRK (opcode = 0x00)
                    wait(cpu.opcode == 8'h00);
                    #100;  // 等待输出完成
                end
                begin
                    // 超时保护
                    #1000000;
                    $display("TIMEOUT!");
                end
            join_any
            disable fork;
            
            // 检查结果
            actual_len = output_idx;
            for (i = 0; i < actual_len; i = i + 1)
                actual[i] = test_output[i];
            
            if (check_output(actual, actual_len, expected))
                $display("✓ PASSED");
            else begin
                $display("✗ FAILED");
                $display("Expected: %s", expected);
                $display("Actual: ");
                for (i = 0; i < actual_len; i = i + 1)
                    $write("%c", actual[i]);
                $display("");
            end
        end
    endtask
    
    // 检查输出是否包含预期字符串
    function automatic bit check_output(
        input reg [7:0] actual[0:255],
        input integer actual_len,
        input string expected
    );
        integer i, j;
        integer exp_len;
        bit found;
        
        begin
            exp_len = expected.len();
            found = 0;
            
            // 检查是否包含 "OK"
            for (i = 0; i < actual_len - 1; i = i + 1) begin
                if (actual[i] == "O" && actual[i+1] == "K") begin
                    found = 1;
                    break;
                end
            end
            
            // 检查是否包含 "FAIL"
            for (i = 0; i < actual_len - 3; i = i + 1) begin
                if (actual[i] == "F" && actual[i+1] == "A" &&
                    actual[i+2] == "I" && actual[i+3] == "L") begin
                    found = 0;
                    break;
                end
            end
            
            return found;
        end
    endfunction
    
    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
endmodule
```

## 简化版本（如果上面太复杂）

### 最简单的测试方式

```systemverilog
module simple_test;
    // ... CPU 实例化 ...
    
    initial begin
        // 加载测试
        $readmemh("test_lda_sta.hex", cpu.memory);
        
        // 复位
        reset = 1;
        #100;
        reset = 0;
        
        // 运行 10000 个周期
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
iverilog -o test simple_test.sv cpu.sv
vvp test
```

**预期输出**：
```
123456 OK
```

## 调试技巧

### 1. 添加详细日志

```systemverilog
always @(posedge clk) begin
    if (cpu.state == EXECUTE) begin
        $display("PC=%04X OP=%02X A=%02X X=%02X Y=%02X SP=%02X P=%08b",
                 cpu.PC, cpu.opcode, cpu.A, cpu.X, cpu.Y, cpu.SP,
                 {cpu.N, cpu.V, 1'b1, cpu.B, cpu.D, cpu.I, cpu.Z, cpu.C});
    end
end
```

### 2. 断点

```systemverilog
always @(posedge clk) begin
    if (cpu.PC == 16'h0320) begin
        $display("Breakpoint at 0x0320");
        $display("A=%02X X=%02X Y=%02X", cpu.A, cpu.X, cpu.Y);
        $stop;  // 暂停仿真
    end
end
```

### 3. 内存监控

```systemverilog
always @(posedge clk) begin
    if (cpu.addr >= 16'h0200 && cpu.addr < 16'h0300 && !cpu.rw) begin
        $display("Write to %04X: %02X", cpu.addr, cpu.data_out);
    end
end
```

### 4. 波形分析

```systemverilog
initial begin
    $dumpfile("cpu_test.vcd");
    $dumpvars(0, cpu_testbench);
end
```

然后用 GTKWave 查看：
```bash
gtkwave cpu_test.vcd
```

## 常见问题

### Q1: 如何加载 .bin 文件？

**方法 1**：转换为 hex
```bash
hexdump -v -e '1/1 "%02X\n"' test.bin > test.hex
```

**方法 2**：使用 Python 脚本
```python
with open('test.bin', 'rb') as f:
    data = f.read()
with open('test.hex', 'w') as f:
    for byte in data:
        f.write(f'{byte:02X}\n')
```

**方法 3**：在 Verilog 中直接读取
```systemverilog
integer file, i;
reg [7:0] byte;

initial begin
    file = $fopen("test.bin", "rb");
    i = 0;
    while (!$feof(file)) begin
        byte = $fgetc(file);
        memory[i] = byte;
        i = i + 1;
    end
    $fclose(file);
end
```

### Q2: 测试卡住怎么办？

添加超时和周期计数：

```systemverilog
integer cycle_count = 0;
integer max_cycles = 100000;

always @(posedge clk) begin
    if (!reset) begin
        cycle_count = cycle_count + 1;
        if (cycle_count > max_cycles) begin
            $display("TIMEOUT after %d cycles", cycle_count);
            $finish;
        end
    end
end
```

### Q3: 如何知道测试完成？

**方法 1**：检测 BRK 指令
```systemverilog
always @(posedge clk) begin
    if (cpu.opcode == 8'h00 && cpu.state == EXECUTE) begin
        $display("BRK detected, test complete");
        #100;  // 等待输出完成
        $finish;
    end
end
```

**方法 2**：检测特定地址
```systemverilog
always @(posedge clk) begin
    if (cpu.PC == 16'hFFFF) begin
        $display("End address reached");
        $finish;
    end
end
```

### Q4: 输出乱码？

检查：
1. **地址匹配**：确保 `addr == 16'hF000`
2. **写信号**：确保 `rw == 0` (写)
3. **时序**：在正确的时钟边沿采样

```systemverilog
// 调试输出
always @(posedge clk) begin
    if (cpu.addr == 16'hF000) begin
        $display("Access to F000: rw=%b data=%02X", cpu.rw, cpu.data_out);
    end
end
```

## Makefile 自动化

创建 `Makefile`：

```makefile
# Verilog 源文件
SOURCES = cpu.sv testbench.sv

# 测试文件
TESTS = test_lda_sta test_math test_branch test_fibonacci

# 编译器
IVERILOG = iverilog
VVP = vvp

# 默认目标
all: compile run

# 编译
compile:
	$(IVERILOG) -g2012 -o cpu_test $(SOURCES)

# 运行所有测试
run: compile
	@echo "=== Running Tests ==="
	$(VVP) cpu_test

# 运行单个测试
test-%: compile
	@echo "=== Running $* ==="
	$(VVP) cpu_test +test=$*

# 生成波形
wave: compile
	$(VVP) cpu_test
	gtkwave cpu_test.vcd &

# 清理
clean:
	rm -f cpu_test *.vcd *.hex

.PHONY: all compile run clean wave
```

使用：
```bash
make              # 编译并运行所有测试
make test-lda     # 运行单个测试
make wave         # 生成并查看波形
make clean        # 清理
```

## 性能测量

```systemverilog
integer start_time, end_time;
integer instruction_count = 0;

always @(posedge clk) begin
    if (cpu.state == EXECUTE)
        instruction_count = instruction_count + 1;
end

initial begin
    start_time = $time;
    // ... 运行测试 ...
    end_time = $time;
    
    $display("=== Performance ===");
    $display("Total time: %d ns", end_time - start_time);
    $display("Instructions: %d", instruction_count);
    $display("Cycles: %d", (end_time - start_time) / 10);
    $display("CPI: %.2f", real'((end_time - start_time) / 10) / instruction_count);
end
```

## 总结

### 推荐流程

1. **编译测试**
   ```bash
   cd basic/test_suite
   ./compile_tests.sh
   ```

2. **转换格式**（如果需要）
   ```bash
   hexdump -v -e '1/1 "%02X\n"' test.bin > test.hex
   ```

3. **修改 testbench**
   - 添加输出捕获
   - 加载测试文件
   - 添加超时保护

4. **运行仿真**
   ```bash
   iverilog -o test testbench.sv cpu.sv
   vvp test
   ```

5. **查看结果**
   - 控制台输出
   - 波形文件
   - 日志文件

### 下一步

- ✅ 运行基础测试
- ✅ 验证已实现的指令
- 🔄 修复发现的问题
- 📋 实现缺失的指令
- 📋 添加更多测试

---

**祝测试顺利！** 🚀
