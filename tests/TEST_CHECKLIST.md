# 6502 指令集测试清单

## 测试概述

本文档列出了所有 151 种 6502 指令的测试清单，特别关注 Donkey Kong 中使用的 27 种新实现指令。

## 测试优先级

### P0 - 关键指令（Donkey Kong 高频使用）

这些指令在 Donkey Kong 中使用频率最高，必须首先测试：

- [ ] **0x16 ASL zp,X** (68次) - 零页X索引左移
- [ ] **0xFE INC abs,X** (66次) - 绝对X索引递增
- [ ] **0x0E ASL abs** (53次) - 绝对地址左移
- [ ] **0x36 ROL zp,X** (46次) - 零页X索引循环左移
- [ ] **0x5E LSR abs,X** (40次) - 绝对X索引逻辑右移
- [ ] **0xE1 SBC (ind,X)** (37次) - 间接X索引减法
- [ ] **0xE5 SBC zp** (33次) - 零页减法
- [ ] **0x56 LSR zp,X** (30次) - 零页X索引逻辑右移
- [ ] **0x3E ROL abs,X** (29次) - 绝对X索引循环左移
- [ ] **0xF1 SBC (ind),Y** (29次) - 间接Y索引减法

### P1 - 重要指令（中等频率）

- [ ] **0x65 ADC zp** (28次) - 零页加法
- [ ] **0xF6 INC zp,X** (26次) - 零页X索引递增
- [ ] **0x4E LSR abs** (24次) - 绝对地址逻辑右移
- [ ] **0x1E ASL abs,X** (22次) - 绝对X索引左移
- [ ] **0xDE DEC abs,X** (22次) - 绝对X索引递减
- [ ] **0xD6 DEC zp,X** (21次) - 零页X索引递减
- [ ] **0x2E ROL abs** (17次) - 绝对地址循环左移
- [ ] **0xF5 SBC zp,X** (17次) - 零页X索引减法
- [ ] **0xED SBC abs** (16次) - 绝对地址减法
- [ ] **0x6D ADC abs** (15次) - 绝对地址加法

### P2 - 一般指令（低频率）

- [ ] **0x6C JMP ind** (14次) - 间接跳转
- [ ] **0x75 ADC zp,X** (12次) - 零页X索引加法
- [ ] **0x7E ROR abs,X** (12次) - 绝对X索引循环右移
- [ ] **0x61 ADC (ind,X)** (11次) - 间接X索引加法
- [ ] **0x71 ADC (ind),Y** (9次) - 间接Y索引加法
- [ ] **0x6E ROR abs** (8次) - 绝对地址循环右移
- [ ] **0x76 ROR zp,X** (5次) - 零页X索引循环右移

## 测试分类

### 1. 算术指令 (Arithmetic)

#### ADC - 带进位加法
- [ ] 0x69 ADC #imm - 立即数
- [ ] 0x65 ADC zp - 零页
- [ ] 0x75 ADC zp,X - 零页X索引
- [ ] 0x6D ADC abs - 绝对地址
- [ ] 0x7D ADC abs,X - 绝对X索引
- [ ] 0x79 ADC abs,Y - 绝对Y索引
- [ ] 0x61 ADC (ind,X) - 间接X索引
- [ ] 0x71 ADC (ind),Y - 间接Y索引

测试要点：
- 正常加法（无进位）
- 进位标志设置
- 溢出标志设置
- 零标志和负标志
- 边界情况：0xFF + 0x01

#### SBC - 带借位减法
- [ ] 0xE9 SBC #imm - 立即数
- [ ] 0xE5 SBC zp - 零页
- [ ] 0xF5 SBC zp,X - 零页X索引
- [ ] 0xED SBC abs - 绝对地址
- [ ] 0xFD SBC abs,X - 绝对X索引
- [ ] 0xF9 SBC abs,Y - 绝对Y索引
- [ ] 0xE1 SBC (ind,X) - 间接X索引
- [ ] 0xF1 SBC (ind),Y - 间接Y索引

测试要点：
- 正常减法（无借位）
- 借位标志设置
- 溢出标志设置
- 零标志和负标志
- 边界情况：0x00 - 0x01

#### INC - 递增
- [ ] 0xE6 INC zp - 零页
- [ ] 0xF6 INC zp,X - 零页X索引
- [ ] 0xEE INC abs - 绝对地址
- [ ] 0xFE INC abs,X - 绝对X索引
- [ ] 0xE8 INX - X寄存器
- [ ] 0xC8 INY - Y寄存器

测试要点：
- 正常递增
- 0xFF → 0x00 回绕
- 零标志和负标志

#### DEC - 递减
- [ ] 0xC6 DEC zp - 零页
- [ ] 0xD6 DEC zp,X - 零页X索引
- [ ] 0xCE DEC abs - 绝对地址
- [ ] 0xDE DEC abs,X - 绝对X索引
- [ ] 0xCA DEX - X寄存器
- [ ] 0x88 DEY - Y寄存器

测试要点：
- 正常递减
- 0x00 → 0xFF 回绕
- 零标志和负标志

### 2. 移位指令 (Shift)

#### ASL - 算术左移
- [ ] 0x0A ASL A - 累加器
- [ ] 0x06 ASL zp - 零页
- [ ] 0x16 ASL zp,X - 零页X索引
- [ ] 0x0E ASL abs - 绝对地址
- [ ] 0x1E ASL abs,X - 绝对X索引

测试要点：
- 左移一位
- 进位标志（bit 7）
- 零标志和负标志
- 边界情况：0x80 左移

#### LSR - 逻辑右移
- [ ] 0x4A LSR A - 累加器
- [ ] 0x46 LSR zp - 零页
- [ ] 0x56 LSR zp,X - 零页X索引
- [ ] 0x4E LSR abs - 绝对地址
- [ ] 0x5E LSR abs,X - 绝对X索引

测试要点：
- 右移一位
- 进位标志（bit 0）
- 零标志（负标志总是0）
- 边界情况：0x01 右移

#### ROL - 循环左移
- [ ] 0x2A ROL A - 累加器
- [ ] 0x26 ROL zp - 零页
- [ ] 0x36 ROL zp,X - 零页X索引
- [ ] 0x2E ROL abs - 绝对地址
- [ ] 0x3E ROL abs,X - 绝对X索引

测试要点：
- 左移一位，进位进入bit 0
- 进位标志（bit 7）
- 零标志和负标志
- 连续旋转测试

#### ROR - 循环右移
- [ ] 0x6A ROR A - 累加器
- [ ] 0x66 ROR zp - 零页
- [ ] 0x76 ROR zp,X - 零页X索引
- [ ] 0x6E ROR abs - 绝对地址
- [ ] 0x7E ROR abs,X - 绝对X索引

测试要点：
- 右移一位，进位进入bit 7
- 进位标志（bit 0）
- 零标志和负标志
- 连续旋转测试

### 3. 跳转指令 (Jump)

#### JMP - 跳转
- [ ] 0x4C JMP abs - 绝对地址
- [ ] 0x6C JMP ind - 间接地址

测试要点（JMP indirect）：
- 正常间接跳转
- **页边界bug测试**：间接地址在 0x??FF 时
- 验证跳转目标正确

#### JSR/RTS - 子程序调用/返回
- [ ] 0x20 JSR abs - 调用子程序
- [ ] 0x60 RTS - 返回

测试要点：
- 栈指针正确变化
- 返回地址正确
- 嵌套调用

### 4. 逻辑指令 (Logic)

#### AND - 逻辑与
- [ ] 0x29 AND #imm
- [ ] 0x25 AND zp
- [ ] 0x35 AND zp,X
- [ ] 0x2D AND abs
- [ ] 0x3D AND abs,X
- [ ] 0x39 AND abs,Y
- [ ] 0x21 AND (ind,X)
- [ ] 0x31 AND (ind),Y

#### ORA - 逻辑或
- [ ] 0x09 ORA #imm
- [ ] 0x05 ORA zp
- [ ] 0x15 ORA zp,X
- [ ] 0x0D ORA abs
- [ ] 0x1D ORA abs,X
- [ ] 0x19 ORA abs,Y
- [ ] 0x01 ORA (ind,X)
- [ ] 0x11 ORA (ind),Y

#### EOR - 逻辑异或
- [ ] 0x49 EOR #imm
- [ ] 0x45 EOR zp
- [ ] 0x55 EOR zp,X
- [ ] 0x4D EOR abs
- [ ] 0x5D EOR abs,X
- [ ] 0x59 EOR abs,Y
- [ ] 0x41 EOR (ind,X)
- [ ] 0x51 EOR (ind),Y

#### BIT - 位测试
- [ ] 0x24 BIT zp
- [ ] 0x2C BIT abs

### 5. 比较指令 (Compare)

#### CMP - 比较累加器
- [ ] 0xC9 CMP #imm
- [ ] 0xC5 CMP zp
- [ ] 0xD5 CMP zp,X
- [ ] 0xCD CMP abs
- [ ] 0xDD CMP abs,X
- [ ] 0xD9 CMP abs,Y
- [ ] 0xC1 CMP (ind,X)
- [ ] 0xD1 CMP (ind),Y

#### CPX - 比较X寄存器
- [ ] 0xE0 CPX #imm
- [ ] 0xE4 CPX zp
- [ ] 0xEC CPX abs

#### CPY - 比较Y寄存器
- [ ] 0xC0 CPY #imm
- [ ] 0xC4 CPY zp
- [ ] 0xCC CPY abs

### 6. 分支指令 (Branch)

- [ ] 0x10 BPL - 正数分支
- [ ] 0x30 BMI - 负数分支
- [ ] 0x50 BVC - 无溢出分支
- [ ] 0x70 BVS - 溢出分支
- [ ] 0x90 BCC - 无进位分支
- [ ] 0xB0 BCS - 进位分支
- [ ] 0xD0 BNE - 不等于分支
- [ ] 0xF0 BEQ - 等于分支

测试要点：
- 条件满足时分支
- 条件不满足时不分支
- 向前分支
- 向后分支
- 页边界跨越

### 7. 加载/存储指令 (Load/Store)

#### LDA/STA - 累加器
- [ ] 0xA9 LDA #imm / 0x85 STA zp
- [ ] 0xA5 LDA zp / 0x95 STA zp,X
- [ ] 0xB5 LDA zp,X / 0x8D STA abs
- [ ] 0xAD LDA abs / 0x9D STA abs,X
- [ ] 0xBD LDA abs,X / 0x99 STA abs,Y
- [ ] 0xB9 LDA abs,Y / 0x81 STA (ind,X)
- [ ] 0xA1 LDA (ind,X) / 0x91 STA (ind),Y
- [ ] 0xB1 LDA (ind),Y

#### LDX/STX - X寄存器
- [ ] 0xA2 LDX #imm / 0x86 STX zp
- [ ] 0xA6 LDX zp / 0x96 STX zp,Y
- [ ] 0xB6 LDX zp,Y / 0x8E STX abs
- [ ] 0xAE LDX abs
- [ ] 0xBE LDX abs,Y

#### LDY/STY - Y寄存器
- [ ] 0xA0 LDY #imm / 0x84 STY zp
- [ ] 0xA4 LDY zp / 0x94 STY zp,X
- [ ] 0xB4 LDY zp,X / 0x8C STY abs
- [ ] 0xAC LDY abs
- [ ] 0xBC LDY abs,X

### 8. 栈指令 (Stack)

- [ ] 0x48 PHA - 压入累加器
- [ ] 0x68 PLA - 弹出累加器
- [ ] 0x08 PHP - 压入状态寄存器
- [ ] 0x28 PLP - 弹出状态寄存器

测试要点：
- 栈指针正确变化
- 数据正确保存/恢复
- 栈溢出处理

### 9. 标志指令 (Flags)

- [ ] 0x18 CLC - 清除进位
- [ ] 0x38 SEC - 设置进位
- [ ] 0x58 CLI - 清除中断禁止
- [ ] 0x78 SEI - 设置中断禁止
- [ ] 0xB8 CLV - 清除溢出
- [ ] 0xD8 CLD - 清除十进制模式
- [ ] 0xF8 SED - 设置十进制模式

### 10. 传送指令 (Transfer)

- [ ] 0xAA TAX - A → X
- [ ] 0xA8 TAY - A → Y
- [ ] 0x8A TXA - X → A
- [ ] 0x98 TYA - Y → A
- [ ] 0xBA TSX - SP → X
- [ ] 0x9A TXS - X → SP

### 11. 其他指令

- [ ] 0xEA NOP - 空操作
- [ ] 0x00 BRK - 中断
- [ ] 0x40 RTI - 中断返回

## 测试方法

### 单元测试

为每条指令创建独立的测试用例：

```scala
class InstructionTest extends AnyFlatSpec with ChiselScalatestTester {
  "ASL zp,X" should "correctly shift left" in {
    test(new CPU6502Core) { dut =>
      // 设置初始状态
      // 执行指令
      // 验证结果
    }
  }
}
```

### 集成测试

使用真实的 ROM 测试：
1. Klaus Dormann 的 6502 功能测试
2. Donkey Kong ROM
3. 其他 NES 游戏

### 回归测试

每次修改后运行完整测试套件，确保没有破坏现有功能。

## 测试工具

1. **Chisel 测试框架** - 单元测试
2. **Verilator** - 硬件仿真测试
3. **Python 脚本** - 自动化测试和结果分析
4. **对比测试** - 与已知正确的模拟器对比

## 测试报告模板

```
测试日期: YYYY-MM-DD
测试人员: [姓名]
测试版本: [Git commit hash]

测试结果:
- 通过: XX/151
- 失败: XX/151
- 未测试: XX/151

失败指令列表:
1. 0xXX 指令名 - 失败原因
2. ...

备注:
[其他说明]
```
