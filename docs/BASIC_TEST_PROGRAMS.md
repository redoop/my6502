# BASIC 测试程序

使用 Tiny BASIC 框架测试 my6502 CPU 的简单程序集合。

## 测试程序列表

### 1. Tiny BASIC 框架 (tinybasic_my6502.asm)
最小化的 Tiny BASIC 启动框架。

**输出:**
```
Tiny BASIC v0.1
Ready
```

**运行:**
```bash
./run_tinybasic.sh
```

### 2. 计数器测试 (test_counter.asm)
从 0 数到 9。

**输出:**
```
Count: 0123456789
```

**运行:**
```bash
./src/test/rtl/obj_dir/Vtest_basic basic/test_counter.bin
```

### 3. 斐波那契数列 (test_fibonacci.asm)
计算前 10 个斐波那契数。

**输出:**
```
Fib: 0 1 1 2 3 5 8 = E R
```
（注：数字超过 9 后显示为 ASCII 字符）

**运行:**
```bash
./src/test/rtl/obj_dir/Vtest_basic basic/test_fibonacci.bin
```

### 4. Mini BASIC 测试 (test_mini_basic.asm)
之前创建的综合测试程序。

**输出:**
```
ABCDXYZ01234 OK
```

**运行:**
```bash
./src/test/rtl/obj_dir_mini/Vcpu_6502
```

## 编译新程序

使用 xa 汇编器：

```bash
cd basic
xa -o your_program.bin your_program.asm
```

## 程序模板

```asm
; Your program name
OUTCH = $F000
INCH  = $F001

        *= $0200

START:
        LDX #$FF
        TXS
        
        ; Your code here
        LDA #'H'
        STA OUTCH
        
DONE:   JMP DONE

        *= $FFFC
        .word START
```

## 测试工具

### test_basic_program.cpp
通用测试程序，可以运行任何编译好的 .bin 文件。

**特性:**
- 自动加载程序到 $0200
- 处理 Reset 向量
- 字符去重（避免重复输出）
- 10000 周期超时

**使用:**
```bash
./src/test/rtl/obj_dir/Vtest_basic <bin_file>
```

## 验证的 CPU 功能

通过这些测试程序，验证了：

- ✅ LDA/STA - 加载/存储
- ✅ LDX/STX - X 寄存器操作
- ✅ INX/DEX - 递增/递减
- ✅ CLC/ADC - 加法运算
- ✅ CMP - 比较
- ✅ BNE/BEQ - 条件跳转
- ✅ JMP - 无条件跳转
- ✅ JSR/RTS - 子程序调用
- ✅ TXS - 堆栈初始化
- ✅ I/O 端口 ($F000/$F001)

## 下一步

可以编写更复杂的测试程序：
- 字符串处理
- 数学运算（乘法、除法）
- 内存操作
- 更复杂的算法

或者集成完整的 Tiny BASIC 解释器（1300+ 行）来支持交互式 BASIC 编程。
