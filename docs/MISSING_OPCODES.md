# 缺失指令分析 - Donkey Kong

## 统计
- ✅ 已实现：76 种指令
- ❌ 未实现：75 种指令
- 📊 总共：151 种指令

## 优先级排序（按出现频率）

### 🔥 高优先级（出现 > 100 次）
1. **0x01 ORA (ind,X)** - 503 次
2. **0x05 ORA zp** - 205 次
3. **0xA6 LDX zp** - 151 次
4. **0x21 AND (ind,X)** - 106 次

### ⚡ 中优先级（出现 50-100 次）
- 0xAE LDX abs - 90 次
- 0xC4 CPY zp - 81 次
- 0x5D EOR abs,X - 72 次
- 0x16 ASL zp,X - 68 次
- 0xFE INC abs,X - 66 次
- 0x9D STA abs,X - 62 次
- 0xC1 CMP (ind,X) - 62 次
- 0x96 STX zp,Y - 54 次
- 0x0E ASL abs - 53 次
- 0x15 ORA zp,X - 53 次
- 0x31 AND (ind),Y - 50 次

### 📝 低优先级（出现 < 50 次）
其余 60 种指令

## 按类别分组

### Logic 指令（最多缺失）
- **ORA**: 7 种，共 899 次 ⚠️
- **AND**: 7 种，共 293 次
- **EOR**: 7 种，共 184 次

### Load/Store 指令
- **LDX**: 4 种，共 253 次
- **LDY**: 4 种，共 99 次
- **STA**: 3 种，共 118 次

### Arithmetic 指令
- **SBC**: 5 种，共 132 次
- **ADC**: 5 种，共 75 次

### Compare 指令
- **CMP**: 6 种，共 229 次
- **CPX**: 2 种，共 77 次
- **CPY**: 2 种，共 104 次

### Shift/Rotate 指令
- **ASL**: 3 种，共 143 次
- **LSR**: 3 种，共 94 次
- **ROL**: 3 种，共 92 次
- **ROR**: 3 种，共 25 次

### Inc/Dec 指令
- **INC**: 3 种，共 123 次
- **DEC**: 3 种，共 78 次

## 实现策略

### 第一批：Logic 指令（最高优先级）
实现所有 ORA, AND, EOR 的寻址模式：
- 零页 (zp)
- 零页索引 (zp,X)
- 绝对 (abs)
- 绝对索引 (abs,X/Y)
- 间接索引 ((ind,X) 和 (ind),Y)

### 第二批：Load/Store 扩展
- LDX 所有寻址模式
- LDY 所有寻址模式
- STA 缺失的寻址模式

### 第三批：Compare 和 Arithmetic
- CMP 所有寻址模式
- CPX/CPY 扩展
- ADC/SBC 缺失的寻址模式

### 第四批：Shift/Rotate 和 Inc/Dec
- ASL, LSR, ROL, ROR 的绝对和索引寻址
- INC, DEC 的扩展寻址模式

## 当前卡住的指令
最近遇到的未实现指令：
- 0xF9 SBC abs,Y - ✅ 已修复
- 0x91 STA (ind),Y - ✅ 已修复
- 0x8E STX abs - ✅ 已修复
- 0xCE DEC abs - ❌ 当前卡住

## 建议
由于有 75 种指令未实现，建议：
1. 先实现最常用的 20 种指令（覆盖 80% 的使用）
2. 使用模板化方法批量实现相似的寻址模式
3. 创建自动化测试来验证每个指令
