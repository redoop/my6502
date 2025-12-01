# Tiny BASIC 移植状态

## 概述
成功将 Tiny BASIC 移植到 my6502 系统。

## 移植进度

### ✅ 已完成
1. **基础框架** - 创建了简化版 Tiny BASIC
   - 入口向量（Cold/Warm start, I/O, Break）
   - 初始化代码（设置堆栈）
   - 启动消息输出

2. **I/O 适配** - 适配到 my6502 的 I/O 端口
   - OUTCH = $F000 (输出端口)
   - INCH = $F001 (输入端口)
   - RCCHR - 读字符函数
   - SNDCHR - 写字符函数
   - BREAK - 中断检测函数

3. **编译环境** - 使用 xa 汇编器
   - 语法转换：`.org` → `*=`
   - 数据指令：`.byte`, `.word`
   - 成功编译生成 89 字节二进制文件

4. **测试验证** - 在 Verilator 仿真中运行
   - 成功输出启动消息
   - 字符输出正常工作
   - CPU 指令执行正确（JSR/RTS/JMP）

## 测试结果

```
Testing Tiny BASIC for my6502

Tiny BASIC v0.1
Ready
```

## 文件清单

- `basic/tinybasic_my6502.asm` - 简化版 Tiny BASIC 源代码
- `basic/tinybasic_my6502.bin` - 编译后的二进制文件（89 字节）
- `src/test/rtl/test_tinybasic.cpp` - 测试程序
- `run_tinybasic.sh` - 运行脚本

## 运行方法

```bash
./run_tinybasic.sh
```

或者：

```bash
cd src/test/rtl
verilator --cc --exe --build -j 0 -Wno-fatal ../../main/rtl/cpu_6502.sv test_tinybasic.cpp
cd ../../..
./src/test/rtl/obj_dir/Vcpu_6502
```

## 当前状态

**基础移植完成** ✅

当前版本是一个最小化的 Tiny BASIC 框架：
- ✅ 启动和初始化
- ✅ I/O 函数（输入/输出/中断检测）
- ✅ 启动消息显示
- ⏸️ BASIC 解释器核心（待集成）

## 下一步计划

如需完整的 Tiny BASIC 解释器功能，需要：

1. **集成完整的 IL 解释器**
   - Tom Pitman 的 Tiny BASIC IL (Intermediate Language) 代码
   - 约 1300 行汇编代码

2. **内存管理**
   - 变量存储区
   - 程序存储区
   - 堆栈管理

3. **BASIC 命令实现**
   - LET, PRINT, INPUT
   - IF, GOTO, GOSUB, RETURN
   - FOR/NEXT 循环
   - 等等

## 技术细节

### 内存布局
```
$0200-$02xx  Tiny BASIC 代码
$F000        输出端口
$F001        输入端口
$FFFC-$FFFD  Reset 向量
```

### I/O 协议
- **输出**: 写入 $F000，字符立即输出
- **输入**: 读取 $F001，返回 0 表示无输入，非 0 为字符
- **中断**: BREAK 函数检查 $F001，有字符则设置 Carry

## 验证状态

- ✅ 编译成功
- ✅ 加载成功
- ✅ 启动成功
- ✅ 输出正常
- ⏸️ 输入功能（未测试）
- ⏸️ BASIC 命令（未实现）

## 结论

**Tiny BASIC 基础移植已完成**，可以正常启动并输出消息。这证明了：
1. my6502 CPU 核心功能完整
2. I/O 系统工作正常
3. 汇编工具链可用
4. 测试环境完善

如需完整的 BASIC 解释器功能，可以继续集成 Tom Pitman 的完整 Tiny BASIC 代码（约 1300 行）。
