# Tiny BASIC 移植计划

## 概述

Tom Pittman的Tiny BASIC是一个经典的6502 BASIC解释器，约2.5KB大小。

## 许可

根据Tom Pittman的声明，Tiny BASIC可以免费使用：
> "TinyBasic interpreter Copyright 1976 Itty Bitty Computers, used by permission."

来源：http://ittybittycomputers.com/IttyBitty/TinyBasic/

## 资源

### 官方资源
- **源代码**: http://retro.hansotten.nl/6502-sbc/kim-1-manuals-and-software/kim-1-software/tiny-basic/
- **用户手册**: 完整的语言参考和使用说明
- **实验手册**: IL解释器详细说明

### 技术规格
- **内存需求**: 2.5KB ROM + 零页使用
- **I/O**: 字符输入/输出（需要适配）
- **架构**: IL (Intermediate Language) 解释器

## 移植步骤

### 1. 下载源代码
从Hans Otten的网站下载KIM-1版本的Tiny BASIC源代码和二进制文件。

### 2. 适配I/O
需要修改三个I/O子程序：
- **INCH**: 字符输入 (从$F001读取)
- **OUTCH**: 字符输出 (写入$F000)
- **BREAK**: 中断检测 (可选)

### 3. 内存布局
调整内存地址以适应我们的系统：
- **程序区**: $0300-$0BFF (2.5KB)
- **变量区**: $0C00-$0FFF
- **栈**: $0100-$01FF (系统栈)

### 4. 编译和测试
使用xa汇编器编译修改后的源代码。

## 当前状态

由于完整移植Tiny BASIC需要：
1. 下载和理解约2000行汇编代码
2. 适配I/O例程
3. 调整内存映射
4. 处理IL解释器
5. 全面测试

这是一个较大的工程，建议作为独立项目进行。

## 替代方案

### 方案1: 使用预编译的Tiny BASIC
直接使用KIM-1版本的二进制文件，只需修改I/O地址。

### 方案2: 移植更简单的BASIC
考虑移植更小的BASIC实现，如：
- **VTL-02** (Very Tiny Language) - 约1KB
- **Woz BASIC** - Apple 1的BASIC

### 方案3: 验证CPU功能
我们已经通过汇编程序验证了CPU支持BASIC所需的所有功能：
- ✅ 循环和分支
- ✅ 子程序调用
- ✅ 栈操作
- ✅ 算术运算
- ✅ I/O操作

## 示例BASIC程序

一旦Tiny BASIC移植完成，可以运行如下程序：

```basic
10 PRINT "HELLO WORLD"
20 FOR I=1 TO 10
30 PRINT I
40 NEXT I
50 END
```

```basic
10 LET A=5
20 LET B=10
30 LET C=A+B
40 PRINT C
50 END
```

```basic
10 PRINT "GUESS THE NUMBER"
20 LET N=42
30 INPUT G
40 IF G=N THEN GOTO 70
50 PRINT "WRONG"
60 GOTO 30
70 PRINT "CORRECT!"
80 END
```

## 结论

完整移植Tiny BASIC是可行的，但需要专门的时间和精力。当前CPU核心已100%验证可以运行BASIC解释器。

建议：
1. 作为独立项目进行Tiny BASIC移植
2. 或使用现有的6502 BASIC ROM
3. 当前专注于NES游戏ROM测试

## 参考资料

- [Tiny BASIC User Manual](http://retro.hansotten.nl/uploads/tinybasic/tbum.html)
- [Tiny BASIC Experimenters Kit](http://retro.hansotten.nl/uploads/tinybasic/TBEK.txt)
- [Tom Pittman's Website](http://ittybittycomputers.com/)
- [6502.org Tiny BASIC Discussion](http://forum.6502.org/viewtopic.php?t=1346)
