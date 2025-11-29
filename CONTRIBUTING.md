# 贡献指南 / Contributing Guide

感谢你对 Chisel 6502 CPU 项目的兴趣！我们欢迎各种形式的贡献。

---

## 🎯 如何贡献

### 1. 报告 Bug
在 [Issues](https://github.com/redoop/my6502/issues) 中创建新 issue，包含：
- 清晰的标题
- 详细的问题描述
- 复现步骤
- 预期行为 vs 实际行为
- 环境信息（OS、版本等）
- 相关日志或截图

**模板**:
```markdown
**问题描述**
简短描述问题

**复现步骤**
1. 运行 `./scripts/run.sh games/xxx.nes`
2. 观察到...
3. 预期应该...

**环境**
- OS: macOS 14.0
- Verilator: 5.042
- SBT: 1.9.7

**日志**
```
粘贴相关日志
```
```

---

### 2. 提出新功能
在 [Issues](https://github.com/redoop/my6502/issues) 中创建 feature request：
- 描述功能需求
- 说明使用场景
- 提供参考资料（如果有）

---

### 3. 提交代码

#### 准备工作
```bash
# Fork 项目
# 克隆你的 fork
git clone https://github.com/YOUR_USERNAME/my6502.git
cd my6502

# 添加上游仓库
git remote add upstream https://github.com/redoop/my6502.git

# 创建新分支
git checkout -b feature/your-feature-name
```

#### 开发流程
1. **编写代码**
   - 遵循项目代码风格
   - 添加必要的注释
   - 保持代码简洁

2. **编写测试**
   ```bash
   # 为新功能添加测试
   # 测试文件放在 src/test/scala/
   ```

3. **运行测试**
   ```bash
   # 确保所有测试通过
   ./scripts/test.sh all
   ```

4. **提交代码**
   ```bash
   git add .
   git commit -m "feat: 添加新功能描述"
   ```

5. **推送到你的 fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**
   - 在 GitHub 上创建 PR
   - 填写 PR 模板
   - 等待 review

---

## 📝 代码规范

### Scala/Chisel 代码

#### 命名规范
```scala
// 类名: PascalCase
class CPU6502Core extends Module

// 变量名: camelCase
val memAddr = Wire(UInt(16.W))

// 常量: UPPER_CASE
val RESET_VECTOR = 0xFFFC.U

// 私有成员: 前缀 _
private val _internalState = RegInit(0.U)
```

#### 代码风格
```scala
// 缩进: 2 空格
class Example extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(8.W))
    val output = Output(UInt(8.W))
  })
  
  // 使用 when/otherwise 而不是 if/else
  when(io.input > 10.U) {
    io.output := io.input + 1.U
  }.otherwise {
    io.output := io.input
  }
}
```

#### 注释
```scala
// 单行注释: 简短说明
val result = a + b  // 计算结果

/**
 * 多行注释: 详细说明
 * 
 * @param opcode 指令操作码
 * @param cycle 当前周期
 * @return 执行结果
 */
def execute(opcode: UInt, cycle: UInt): ExecutionResult = {
  // ...
}
```

---

### C++ 代码 (Verilator)

#### 命名规范
```cpp
// 类名: PascalCase
class NESEmulator {
  // 成员变量: snake_case
  uint64_t cycle_count;
  
  // 方法名: camelCase
  void updateDisplay();
};

// 常量: UPPER_CASE
const int SCREEN_WIDTH = 256;
```

#### 代码风格
```cpp
// 缩进: 4 空格
void tick() {
    dut->clock = 0;
    dut->eval();
    
    dut->clock = 1;
    dut->eval();
}
```

---

## 🧪 测试规范

### 单元测试
```scala
class MyInstructionSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MyInstruction"
  
  it should "execute correctly" in {
    test(new CPU6502Core) { dut =>
      // 设置输入
      dut.io.input.poke(10.U)
      dut.clock.step()
      
      // 验证输出
      dut.io.output.expect(11.U)
    }
  }
}
```

### 测试命名
- 测试文件: `*Spec.scala` 或 `*Test.scala`
- 测试类: `XxxSpec` 或 `XxxTest`
- 测试方法: 描述性的 `should "do something"`

---

## 📋 Commit 规范

使用 [Conventional Commits](https://www.conventionalcommits.org/) 格式：

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式（不影响功能）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具相关

### 示例
```bash
# 新功能
git commit -m "feat(cpu): 添加 BRK 指令支持"

# Bug 修复
git commit -m "fix(ppu): 修复 PPUCTRL 寄存器写入问题"

# 文档
git commit -m "docs: 更新游戏兼容性报告"

# 重构
git commit -m "refactor(cpu): 优化 Fetch 状态逻辑"
```

---

## 🔍 Pull Request 流程

### PR 标题
使用与 commit 相同的格式：
```
feat(cpu): 添加 BRK 指令支持
```

### PR 描述模板
```markdown
## 变更类型
- [ ] Bug 修复
- [ ] 新功能
- [ ] 重构
- [ ] 文档更新
- [ ] 其他

## 变更描述
简要描述你的变更

## 相关 Issue
Closes #123

## 测试
- [ ] 添加了新测试
- [ ] 所有测试通过
- [ ] 手动测试通过

## 检查清单
- [ ] 代码遵循项目规范
- [ ] 添加了必要的注释
- [ ] 更新了相关文档
- [ ] 测试覆盖率足够
```

### Review 流程
1. 提交 PR 后，CI 会自动运行测试
2. 维护者会 review 你的代码
3. 根据反馈修改代码
4. 所有检查通过后，PR 会被合并

---

## 🎯 贡献方向

### 高优先级
- 🔴 修复 PPU 寄存器写入问题 (#4)
- 🟡 提高游戏兼容性
- 🟡 优化性能

### 中优先级
- 🟢 添加更多 Mapper 支持
- 🟢 改进调试工具
- 🟢 完善文档

### 低优先级
- 🔵 添加音频支持
- 🔵 GUI 改进
- 🔵 性能分析工具

---

## 📚 学习资源

### 6502 相关
- [6502 Instruction Set](http://www.6502.org/tutorials/6502opcodes.html)
- [Visual 6502](http://www.visual6502.org/)
- [6502 Programming Manual](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)

### NES 相关
- [NESDev Wiki](https://www.nesdev.org/wiki/)
- [NES Reference Guide](https://www.nesdev.org/NESDoc.pdf)

### Chisel 相关
- [Chisel Documentation](https://www.chisel-lang.org/)
- [Chisel Bootcamp](https://github.com/freechipsproject/chisel-bootcamp)

---

## 💬 交流

- **Issues**: 报告 bug 和提出功能请求
- **Discussions**: 一般性讨论和问题
- **Pull Requests**: 代码贡献

---

## 📜 许可证

贡献的代码将采用与项目相同的 MIT 许可证。

---

## 🙏 致谢

感谢所有贡献者！你们的贡献让这个项目变得更好。

---

**准备好贡献了吗？** 🚀

1. Fork 项目
2. 创建分支
3. 提交代码
4. 创建 PR

我们期待你的贡献！
