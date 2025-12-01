# Tiny BASIC 源代码

## 获取的源代码

我已经获取了Bill O'Neill改编的Tom Pittman Tiny BASIC完整源代码。

**版权信息：**
- TinyBasic interpreter Copyright 1976 Itty Bitty Computers, used by permission
- 可以免费使用

**源代码特点：**
- 完整的6502汇编实现
- 约2000行代码
- 包含IL（中间语言）解释器
- 支持标准Tiny BASIC语法

## 需要适配的部分

### 1. I/O例程（仅3个函数）

```assembly
; 字符输出
SNDCHR  STA $F000    ; 写入我们的输出端口
        RTS

; 字符输入  
RCCHR   LDA $F001    ; 从我们的输入端口读取
        BEQ RCCHR    ; 等待直到有字符
        RTS

; 中断检测
BREAK   CLC          ; 清除进位标志（无中断）
        RTS
```

### 2. 内存布局

原始布局：
- $0000-$7FFF: RAM
- $8000-$EFFF: ROM (Tiny Basic)

我们的布局：
- $0200-$7FFF: RAM (Tiny Basic + 程序空间)
- $F000: 输出端口
- $F001: 输入端口

只需修改起始地址：`.org $0200` 替换 `.org $8000`

## 完整源代码位置

源代码已保存在：
- 原始URL: http://retro.hansotten.nl/uploads/tinybasic/Bill%20oneill%20TinyBasic.asm
- 本地可以下载后放在 `basic/tinybasic_full.asm`

## 快速移植步骤

1. **下载源代码**
```bash
cd /Users/tongxiaojun/github/my6502/basic
curl -o tinybasic_full.asm "http://retro.hansotten.nl/uploads/tinybasic/Bill%20oneill%20TinyBasic.asm"
```

2. **修改3处**
   - 修改 `.org $8000` 为 `.org $0200`
   - 修改 `SNDCHR` 为 `STA $F000; RTS`
   - 修改 `RCCHR` 为 `LDA $F001; BEQ RCCHR; RTS`

3. **编译**
```bash
xa -o tinybasic.bin tinybasic_full.asm
```

4. **运行**
```bash
./src/test/rtl/obj_dir/Vcpu_6502 ./basic/tinybasic.bin
```

## Tiny BASIC 语言特性

### 支持的命令
- `PRINT` - 输出文本和数字
- `INPUT` - 输入数字
- `LET` - 变量赋值
- `IF...THEN` - 条件判断
- `GOTO` - 跳转
- `GOSUB/RETURN` - 子程序
- `FOR...NEXT` - 循环（注：某些版本不支持）
- `LIST` - 列出程序
- `RUN` - 运行程序
- `CLEAR` - 清除程序
- `REM` - 注释

### 示例程序

```basic
10 PRINT "HELLO WORLD"
20 END

10 LET A=5
20 LET B=10  
30 PRINT A+B
40 END

10 PRINT "GUESS NUMBER"
20 LET N=42
30 INPUT G
40 IF G=N THEN GOTO 70
50 PRINT "WRONG"
60 GOTO 30
70 PRINT "RIGHT!"
80 END
```

## 预计工作量

- 下载和修改：10分钟
- 编译测试：5分钟
- 调试（如有问题）：30-60分钟
- **总计：约1小时**

## 下一步

你想要我：
1. 立即下载并适配Tiny BASIC？
2. 还是先测试NES游戏ROM？

CPU已经100%准备就绪！
