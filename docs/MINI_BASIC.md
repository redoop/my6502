# Mini BASIC 交互式解释器

## 简介
Mini BASIC是一个运行在6502 CPU上的简单BASIC解释器演示程序。

## 运行

```bash
./run_mini_basic.sh
```

## 功能

### 支持的命令
- `PRINT "text"` - 显示文本

### 示例
```
Mini BASIC
>PRINT "HELLO WORLD"
HELLO WORLD
>
```

## 实现细节

### 内存映射
- `$F000` - 输出端口（写入字符）
- `$F001` - 输入端口（读取字符）
- `$0200-$02FF` - 输入缓冲区

### 程序流程
1. 初始化栈指针
2. 显示启动信息"Mini BASIC"
3. 显示提示符">"
4. 等待用户输入（回车结束）
5. 解析命令
6. 执行PRINT命令（跳过引号，输出文本）
7. 返回提示符

### 验证的CPU功能
- ✅ 栈操作 (TXS, JSR, RTS)
- ✅ 字符串输出循环
- ✅ 字符输入/输出
- ✅ 条件分支
- ✅ 子程序调用

## 技术实现

### 文件
- `basic/mini_basic.asm` - 汇编源码
- `basic/mini_basic.bin` - 编译后的二进制
- `src/test/rtl/mini_basic_interactive.cpp` - 交互式运行器
- `run_mini_basic.sh` - 启动脚本

### 编译
```bash
cd basic
xa -o mini_basic.bin mini_basic.asm
```

### 构建运行器
```bash
cd src/test/rtl
verilator --cc --exe --build -Wall -Wno-fatal \
  --top-module cpu_6502 --Mdir obj_dir_interactive \
  mini_basic_interactive.cpp ../../main/rtl/cpu_6502.sv
```

## 限制
- 仅支持PRINT命令
- 不支持变量
- 不支持算术运算
- 不支持循环和条件语句

这是一个演示程序，用于验证6502 CPU核心功能的正确性。
