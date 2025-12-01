# Tiny BASIC 快速开始

## 运行 Tiny BASIC

### 方法 1: 交互模式（推荐）✨
```bash
./run_tinybasic_interactive.sh
```

这会启动交互式 Tiny BASIC，可以输入命令。

### 方法 2: 测试模式
```bash
./run_tinybasic.sh
```

运行非交互式测试。

### 方法 3: 手动运行
```bash
# 1. 编译
cd basic/tinybasic
xa -o tinybasic_adapted.bin tinybasic_adapted.asm

# 2. 运行交互模式
cd ../../src/test/rtl
./obj_dir_clean/Vclean ../../../basic/tinybasic/tinybasic_adapted.bin
```

## 交互模式使用

启动后会看到：
```
Tiny BASIC v1.0
Ready
> 
```

### 可用命令

| 命令 | 说明 | 示例 |
|-----|------|------|
| LIST | 列出程序 | `> LIST` |
| RUN | 运行程序 | `> RUN` |
| NEW | 清空程序 | `> NEW` |

## 示例会话

```
Tiny BASIC v1.0
Ready
> LIST
No program

> RUN
Running...

> NEW
Program cleared

> 
```

## 退出

按 `Ctrl+C` 退出

## 测试

运行所有测试：
```bash
./run_tinybasic_tests.sh
```

应该看到：
```
Results: 16 passed, 0 failed, 16 total
```

## 版本说明

### tinybasic_adapted.asm
- 交互式命令行
- 支持 LIST, RUN, NEW
- 适合日常使用

### tinybasic_minimal.asm
- 最小版本
- 仅基本框架
- 适合学习

### tinybasic.asm
- 完整版本 (1310行)
- 包含完整 IL 解释器
- 适合深入研究

## 故障排除

### 编译失败
```bash
# 检查 xa 是否安装
which xa

# 安装 xa
brew install xa
```

### 运行失败
```bash
# 检查测试运行器
ls -la src/test/rtl/obj_dir/Vcpu_6502

# 重新编译测试运行器
cd src/test/rtl
make
```

## 下一步

- 查看 [TINYBASIC_COMPLETE.md](../../docs/TINYBASIC_COMPLETE.md) 了解完整功能
- 查看 [tests/README.md](tests/README.md) 了解测试详情
- 修改 `tinybasic_adapted.asm` 添加新功能
