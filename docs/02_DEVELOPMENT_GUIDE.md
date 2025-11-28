# 开发指南

## 开发环境设置

### 必需软件

1. **Scala 和 SBT**
   ```bash
   # macOS
   brew install scala sbt
   
   # Linux
   sdk install scala 2.13.12
   sdk install sbt 1.9.7
   ```

2. **Verilator**
   ```bash
   # macOS
   brew install verilator
   
   # Linux
   sudo apt-get install verilator
   ```

3. **SDL2**
   ```bash
   # macOS
   brew install sdl2
   
   # Linux
   sudo apt-get install libsdl2-dev
   ```

4. **C++ 编译器**
   ```bash
   # macOS (Xcode Command Line Tools)
   xcode-select --install
   
   # Linux
   sudo apt-get install build-essential
   ```

### 项目克隆

```bash
git clone https://github.com/redoop/my6502.git
cd my6502
```

## 开发工作流

### 1. 修改 Chisel 代码

编辑 `src/main/scala/` 下的文件：

```scala
// 示例：修改 CPU 指令
// src/main/scala/cpu/instructions/Arithmetic.scala

def executeADC(cycle: UInt, regs: Registers, ...): ExecutionResult = {
  // 实现 ADC 指令
  ...
}
```

### 2. 生成 Verilog

```bash
./scripts/generate_verilog.sh
```

生成的文件位于 `generated/nes/NESSystem.v`

### 3. 编译 Verilator 仿真器

```bash
./scripts/verilator_build.sh
```

编译输出位于 `build/verilator/VNESSystem`

### 4. 运行测试

```bash
# 运行游戏
./build/verilator/VNESSystem games/Donkey-Kong.nes

# 或使用脚本
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

### 5. 调试

```bash
# 使用最小化测试程序
./scripts/build_minimal.sh
./build/minimal/VNESSystem games/Donkey-Kong.nes 10000

# 生成 VCD 波形文件
./scripts/test_reset_trace.sh
```

## 代码结构

### CPU 模块

```
src/main/scala/cpu/
├── core/
│   ├── CPU6502Core.scala      # CPU 核心状态机
│   ├── Registers.scala         # 寄存器定义
│   └── ExecutionResult.scala   # 执行结果
└── instructions/
    ├── Arithmetic.scala        # 算术指令
    ├── Logic.scala             # 逻辑指令
    ├── LoadStore.scala         # 加载/存储指令
    ├── Branch.scala            # 分支指令
    ├── Jump.scala              # 跳转指令
    ├── Stack.scala             # 栈操作
    ├── Transfer.scala          # 传输指令
    ├── Flag.scala              # 标志位指令
    ├── Shift.scala             # 移位指令
    └── Compare.scala           # 比较指令
```

### PPU 模块

```
src/main/scala/nes/
├── PPUSimplified.scala         # 简化的 PPU 实现
├── PPU.scala                   # 完整的 PPU 实现
└── MemoryController.scala      # 内存控制器
```

### NES 系统

```
src/main/scala/nes/
└── NESSystem.scala             # 顶层系统模块
```

## 添加新指令

### 步骤 1: 定义指令

在相应的指令文件中添加实现：

```scala
// src/main/scala/cpu/instructions/Arithmetic.scala

def executeNewInstruction(
  cycle: UInt, 
  regs: Registers, 
  operand: UInt, 
  memDataIn: UInt
): ExecutionResult = {
  val result = Wire(new ExecutionResult)
  val newRegs = Wire(new Registers)
  newRegs := regs
  
  // 实现指令逻辑
  when(cycle === 0.U) {
    // 周期 0 的操作
    ...
  }.elsewhen(cycle === 1.U) {
    // 周期 1 的操作
    ...
  }
  
  result.done := true.B
  result.regs := newRegs
  result
}
```

### 步骤 2: 在 CPU 核心中注册

```scala
// src/main/scala/cpu/core/CPU6502Core.scala

switch(opcode) {
  is(0xXX.U) {  // 新指令的操作码
    result := NewInstructions.executeNewInstruction(
      cycle, regs, operand, io.memDataIn
    )
  }
}
```

### 步骤 3: 测试

```bash
# 重新生成 Verilog
./scripts/generate_verilog.sh

# 编译
./scripts/verilator_build.sh

# 测试
./build/verilator/VNESSystem test.nes
```

## 调试技巧

### 1. 使用 printf 调试

```scala
when(state === sExecute) {
  printf("PC: 0x%x, Opcode: 0x%x\n", regs.pc, opcode)
}
```

### 2. 生成 VCD 波形

```bash
./scripts/test_reset_trace.sh
# 查看 nes_trace.vcd
```

### 3. 使用最小化测试程序

```bash
./scripts/build_minimal.sh
./build/minimal/VNESSystem games/Donkey-Kong.nes 1000
```

### 4. 分析执行日志

```bash
./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | tee execution.log
python3 scripts/analyze_execution.py execution.log
```

## 性能优化

### 1. 减少调试输出

注释掉不必要的 printf 语句

### 2. 优化 Verilator 编译选项

编辑 `scripts/verilator_build.sh`：

```bash
verilator --cc generated/nes/NESSystem.v \
    -O3 \
    --x-assign fast \
    --x-initial fast \
    --noassert \
    ...
```

### 3. 使用更高效的数据结构

避免不必要的内存访问和计算

## 常见问题

### Q: 编译失败

**A**: 检查 Chisel 语法错误：
```bash
sbt compile
```

### Q: Verilator 编译错误

**A**: 检查生成的 Verilog：
```bash
cat generated/nes/NESSystem.v | grep -i error
```

### Q: 游戏不显示

**A**: 检查 SDL2 是否正确安装：
```bash
sdl2-config --version
```

### Q: 性能太慢

**A**: 
1. 减少调试输出
2. 使用 -O3 优化
3. 检查是否有死循环

## 代码规范

### Scala/Chisel 代码

- 使用 2 空格缩进
- 类名使用 PascalCase
- 方法名使用 camelCase
- 常量使用 UPPER_CASE

### C++ 代码

- 使用 4 空格缩进
- 遵循 Google C++ Style Guide
- 使用有意义的变量名

### 提交规范

```bash
# 格式
<type>: <subject>

# 类型
feat:     新功能
fix:      Bug 修复
docs:     文档更新
style:    代码格式
refactor: 重构
test:     测试
chore:    构建/工具

# 示例
git commit -m "feat: 添加 ADC 指令的零页寻址模式"
git commit -m "fix: 修复 Branch 指令的 PC 计算错误"
```

## 测试

### 单元测试

```bash
sbt test
```

### 集成测试

```bash
./scripts/run_tests.sh
```

### 游戏测试

```bash
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

## 文档

### 更新文档

修改 `docs/` 目录下的相应文件

### 生成 API 文档

```bash
sbt doc
```

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'feat: Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 相关资源

- [Chisel 文档](https://www.chisel-lang.org/)
- [Verilator 文档](https://verilator.org/)
- [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
- [NES Dev Wiki](https://wiki.nesdev.com/)

---
**最后更新**: 2025-11-28
