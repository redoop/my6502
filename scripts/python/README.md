# Python 分析工具

NES 系统的 Python 分析和调试工具集。

## 工具列表

### 1. rom_analyzer.py
**功能**: 分析 NES ROM 文件的指令覆盖率

**用法**:
```bash
python3 scripts/python/rom_analyzer.py <rom文件>
```

**示例**:
```bash
python3 scripts/python/rom_analyzer.py games/Donkey-Kong.nes
```

**输出**:
- ROM 基本信息（大小、Mapper 类型）
- 指令使用统计
- 指令覆盖率分析
- 未实现的指令列表

---

### 2. vcd_analyzer.py
**功能**: 分析 VCD 波形文件，提取信号变化

**用法**:
```bash
python3 scripts/python/vcd_analyzer.py <vcd文件>
```

**示例**:
```bash
# 先生成 VCD 文件
./scripts/build.sh trace
./scripts/run.sh

# 分析 VCD
python3 scripts/python/vcd_analyzer.py nes_trace.vcd
```

**输出**:
- 信号列表
- 时序分析
- 状态变化统计
- 关键事件时间点

---

### 3. transistor_counter.py
**功能**: 统计 Verilog 文件的晶体管数量

**用法**:
```bash
python3 scripts/python/transistor_counter.py <verilog文件>
```

**示例**:
```bash
python3 scripts/python/transistor_counter.py generated/nes/NESSystem.v
```

**输出**:
- 逻辑门统计（AND, OR, XOR, NOT 等）
- 寄存器数量
- 多路选择器统计
- 估算晶体管总数
- 与原始 6502 的对比

---

### 4. execution_tracer.py
**功能**: 追踪程序执行流程，分析指令序列

**用法**:
```bash
python3 scripts/python/execution_tracer.py <vcd文件>
```

**示例**:
```bash
python3 scripts/python/execution_tracer.py nes_trace.vcd
```

**输出**:
- PC (程序计数器) 变化轨迹
- 指令执行序列
- 跳转和分支分析
- 循环检测
- 热点代码识别

---

## 快速使用

通过 `debug.sh` 统一调用：

```bash
# ROM 分析
./scripts/debug.sh opcodes games/Donkey-Kong.nes

# VCD 分析
./scripts/debug.sh vcd

# 晶体管统计
./scripts/debug.sh transistors

# 执行追踪
./scripts/debug.sh execution
```

## 依赖

所有工具仅依赖 Python 3 标准库，无需额外安装。

## 开发

添加新工具时：
1. 创建新的 `.py` 文件，使用清晰的命名
2. 添加到 `debug.sh` 中
3. 更新本 README
4. 确保可执行权限：`chmod +x scripts/python/your_tool.py`
