# Scripts 目录

## 核心脚本（5个）

### 1. build.sh - 构建脚本
编译 Verilog 和 Verilator 仿真器

```bash
./scripts/build.sh [模式]
```

模式:
- `normal` - 标准编译（默认）
- `fast` - 快速编译（无断言，优化）
- `trace` - 带波形追踪
- `optimized` - 优化编译（带追踪）

示例:
```bash
./scripts/build.sh              # 标准编译
./scripts/build.sh fast         # 快速编译
./scripts/build.sh trace        # 带波形追踪
```

### 2. test.sh - 测试脚本
运行各种测试

```bash
./scripts/test.sh [类型]
```

类型:
- `all` - 所有测试（默认）
- `unit` - 单元测试
- `integration` - 集成测试
- `quick` - 快速测试

示例:
```bash
./scripts/test.sh               # 所有测试
./scripts/test.sh unit          # 单元测试
./scripts/test.sh quick         # 快速测试
```

### 3. run.sh - 运行脚本
运行 NES 游戏

```bash
./scripts/run.sh [ROM文件]
```

示例:
```bash
./scripts/run.sh                           # 运行 Donkey Kong（默认）
./scripts/run.sh games/Super-Mario.nes     # 运行 Super Mario
```

### 4. debug.sh - 调试脚本
调试和分析工具

```bash
./scripts/debug.sh <模式> [参数]
```

模式:
- `opcodes <rom>` - 分析 ROM 指令覆盖率
- `vcd` - 分析 VCD 波形文件
- `transistors` - 分析晶体管数量
- `execution` - 分析执行流程
- `monitor <type>` - 实时监控（pc/ppu/nmi）

示例:
```bash
./scripts/debug.sh opcodes games/Donkey-Kong.nes
./scripts/debug.sh vcd
./scripts/debug.sh monitor pc
./scripts/debug.sh transistors
```

### 5. tools.sh - 工具脚本
项目管理工具

```bash
./scripts/tools.sh <命令>
```

命令:
- `clean` - 清理构建文件
- `generate` - 生成 Verilog
- `check` - 检查环境依赖
- `stats` - 显示项目统计
- `rom` - 显示 ROM 信息
- `archive` - 创建项目归档

示例:
```bash
./scripts/tools.sh clean        # 清理
./scripts/tools.sh check        # 检查环境
./scripts/tools.sh stats        # 统计信息
```

## Python 工具（4个）

位于 `python/` 目录：

### rom_analyzer.py
分析 ROM 文件的指令覆盖率

```bash
python3 scripts/python/rom_analyzer.py <rom文件>
```

### vcd_analyzer.py
分析 VCD 波形文件

```bash
python3 scripts/python/vcd_analyzer.py <vcd文件>
```

### transistor_counter.py
统计 Verilog 文件的晶体管数量

```bash
python3 scripts/python/transistor_counter.py <verilog文件>
```

### execution_tracer.py
分析执行流程

```bash
python3 scripts/python/execution_tracer.py <vcd文件>
```

## 快速开始

```bash
# 1. 检查环境
./scripts/tools.sh check

# 2. 构建项目
./scripts/build.sh fast

# 3. 运行测试
./scripts/test.sh quick

# 4. 运行游戏
./scripts/run.sh

# 5. 调试分析
./scripts/debug.sh opcodes games/Donkey-Kong.nes
```

## 旧脚本归档

所有旧脚本（69个）已移动到 `archive/` 目录，仅供参考。

## 脚本整合说明

原有 69 个脚本已整合为 5 个核心脚本 + 4 个 Python 工具：

**构建相关** (整合为 build.sh):
- verilator_build.sh, verilator_build_simple.sh, verilator_build_fast.sh
- verilator_build_trace.sh, verilator_build_optimized.sh
- build_minimal.sh, generate_verilog.sh

**测试相关** (整合为 test.sh):
- run_tests.sh, quick_test.sh, test_reset.sh
- test_stage*.sh (6个), test_nmi*.sh (5个)
- test_mario.sh, test_ppu_render.sh, test_long_run.sh
- quick_performance_test.sh, extended_performance_test.sh
- long_performance_test.sh

**运行相关** (整合为 run.sh):
- play_donkey_kong.sh, run_verilator.sh, verilator_run.sh
- run_emulator.sh, run_terminal.sh

**调试相关** (整合为 debug.sh):
- debug_*.sh (4个), monitor_*.sh (9个)
- analyze_loops.sh, check_*.sh (7个)
- diagnose_current_stage.sh, verify_*.sh (3个)
- find_zero_crossing.sh, wait_for_rendering.sh

**工具相关** (整合为 tools.sh):
- 项目管理、清理、统计等功能

**Python 工具** (重命名并移至 python/ 目录):
- analyze_opcodes.py → rom_analyzer.py
- analyze_vcd.py → vcd_analyzer.py
- count_transistors.py → transistor_counter.py
- analyze_execution.py → execution_tracer.py
