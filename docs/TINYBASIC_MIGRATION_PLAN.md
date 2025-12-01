# Tiny BASIC 测试驱动移植方案

## 目标
将完整的 tinybasic.asm (1310行) 移植到 my6502，使用测试驱动开发 (TDD) 方法确保每个功能正常工作。

## 移植策略

### 阶段 0: 准备工作 (1小时)
- [x] 分析 tinybasic.asm 功能完整性
- [ ] 创建测试框架
- [ ] 设置编译环境

### 阶段 1: I/O 层测试 (30分钟)
**目标**: 验证基本输入输出

#### 测试 1.1: 字符输出
```assembly
; test_io_output.asm
LDA #'A'
STA $F000
LDA #'O'
STA $F000
LDA #'K'
STA $F000
```
**期望**: 输出 "AOK"

#### 测试 1.2: 字符输入（模拟）
```assembly
; test_io_input.asm
LDA $F001    ; 模拟读取
CMP #'X'
BEQ OK
```
**期望**: 能读取字符

### 阶段 2: 向量表测试 (30分钟)
**目标**: 验证冷启动/热启动向量

#### 测试 2.1: 冷启动向量
```assembly
; test_cold_start.asm
JMP COLD_S
COLD_S:
    LDA #'O'
    STA $F000
    LDA #'K'
    STA $F000
```
**期望**: 输出 "OK"

#### 测试 2.2: 热启动向量
```assembly
; test_warm_start.asm
JMP WARM_S
WARM_S:
    LDA #'O'
    STA $F000
    LDA #'K'
    STA $F000
```
**期望**: 输出 "OK"

### 阶段 3: IL 解释器核心测试 (2小时)
**目标**: 验证 IL 字节码解释器

#### 测试 3.1: IL 操作码 NO (空操作)
```assembly
; test_il_no.asm
LDA #$08     ; NO opcode
JSR IL_EXEC
```
**期望**: 正常返回

#### 测试 3.2: IL 操作码 LB (压入字面字节)
```assembly
; test_il_lb.asm
LDA #$09     ; LB opcode
LDA #$42     ; 'B'
JSR IL_EXEC
```
**期望**: 栈顶为 $42

#### 测试 3.3: IL 操作码 PC (打印字面字符串)
```assembly
; test_il_pc.asm
LDA #$24     ; PC opcode
.byte "OK",0
```
**期望**: 输出 "OK"

### 阶段 4: 栈操作测试 (1小时)
**目标**: 验证栈操作正确性

#### 测试 4.1: 压栈/弹栈
```assembly
; test_stack.asm
LDA #$42
PHA
PLA
CMP #$42
BEQ OK
```
**期望**: 栈操作正确

#### 测试 4.2: IL 栈操作
```assembly
; test_il_stack.asm
; LB + SP (压入后弹出)
```
**期望**: 栈平衡

### 阶段 5: 算术运算测试 (2小时)
**目标**: 验证加减乘除

#### 测试 5.1: 加法 (IL_AD)
```assembly
; test_add.asm
; 压入 5
; 压入 3
; 执行 AD
; 结果应为 8
```
**期望**: 5 + 3 = 8

#### 测试 5.2: 减法 (IL_SU)
**期望**: 5 - 3 = 2

#### 测试 5.3: 乘法 (IL_MP)
**期望**: 5 * 3 = 15

#### 测试 5.4: 除法 (IL_DV)
**期望**: 15 / 3 = 5

### 阶段 6: 变量操作测试 (1小时)
**目标**: 验证变量存储和读取

#### 测试 6.1: 存储变量 (IL_SV)
```assembly
; test_var_store.asm
; LET A=42
```
**期望**: 变量 A 存储 42

#### 测试 6.2: 读取变量 (IL_FV)
```assembly
; test_var_fetch.asm
; PRINT A
```
**期望**: 输出 42

### 阶段 7: 分支测试 (1小时)
**目标**: 验证条件分支

#### 测试 7.1: GOTO
```assembly
; test_goto.asm
; 10 GOTO 20
; 15 PRINT "FAIL"
; 20 PRINT "OK"
```
**期望**: 输出 "OK"

#### 测试 7.2: IF...THEN
```assembly
; test_if.asm
; 10 LET A=5
; 20 IF A=5 THEN 40
; 30 PRINT "FAIL"
; 40 PRINT "OK"
```
**期望**: 输出 "OK"

### 阶段 8: 子程序测试 (1小时)
**目标**: 验证 GOSUB/RETURN

#### 测试 8.1: GOSUB/RETURN
```assembly
; test_gosub.asm
; 10 GOSUB 30
; 20 PRINT "OK"
; 25 END
; 30 PRINT "SUB"
; 40 RETURN
```
**期望**: 输出 "SUBOK"

### 阶段 9: 程序管理测试 (1小时)
**目标**: 验证程序存储和执行

#### 测试 9.1: 插入行 (IL_IL)
```assembly
; test_insert_line.asm
; 输入: 10 PRINT "OK"
```
**期望**: 程序存储成功

#### 测试 9.2: LIST
```assembly
; test_list.asm
; LIST
```
**期望**: 显示程序

#### 测试 9.3: RUN
```assembly
; test_run.asm
; RUN
```
**期望**: 执行程序

### 阶段 10: 完整 BASIC 程序测试 (2小时)
**目标**: 运行完整的 BASIC 程序

#### 测试 10.1: Hello World
```basic
10 PRINT "HELLO WORLD"
20 END
```

#### 测试 10.2: 变量和算术
```basic
10 LET A=10
20 LET B=20
30 LET C=A+B
40 PRINT C
50 END
```

#### 测试 10.3: 循环
```basic
10 LET A=1
20 PRINT A
30 LET A=A+1
40 IF A<10 THEN 20
50 END
```

#### 测试 10.4: 子程序
```basic
10 GOSUB 100
20 PRINT "MAIN"
30 END
100 PRINT "SUB"
110 RETURN
```

## 测试框架

### 目录结构
```
basic/
├── tinybasic/
│   ├── tinybasic.asm          # 原始文件
│   ├── tinybasic_adapted.asm  # 适配版本
│   └── tests/
│       ├── phase1/            # I/O 测试
│       ├── phase2/            # 向量测试
│       ├── phase3/            # IL 解释器测试
│       ├── phase4/            # 栈测试
│       ├── phase5/            # 算术测试
│       ├── phase6/            # 变量测试
│       ├── phase7/            # 分支测试
│       ├── phase8/            # 子程序测试
│       ├── phase9/            # 程序管理测试
│       └── phase10/           # 完整程序测试
```

### 测试脚本
```bash
#!/bin/bash
# run_tinybasic_tests.sh

PHASES=(1 2 3 4 5 6 7 8 9 10)
PASS=0
FAIL=0

for phase in "${PHASES[@]}"; do
    echo "=== Phase $phase ==="
    for test in basic/tinybasic/tests/phase$phase/*.asm; do
        name=$(basename "$test" .asm)
        xa -o /tmp/$name.bin "$test"
        result=$(timeout 2 src/test/rtl/obj_dir/Vcpu_6502 /tmp/$name.bin 2>&1 | grep "Output:")
        if echo "$result" | grep -q "OK"; then
            echo "  ✅ $name"
            ((PASS++))
        else
            echo "  ❌ $name"
            ((FAIL++))
        fi
    done
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
```

## 适配要点

### 1. 内存映射调整
```assembly
; 原始: $F000 = ACIA
; 适配: $F000 = OUTCH, $F001 = INCH (已兼容)
```

### 2. 汇编器语法
```assembly
; 原始: .org, .db, .dw
; 适配: *=, .byte, .word
```

### 3. 监视器移除
```assembly
; 移除 $F800-$FFFF 的监视器代码
; 只保留核心 BASIC 解释器
```

## 成功标准

### 阶段完成标准
- [ ] 阶段 1: 所有 I/O 测试通过
- [ ] 阶段 2: 向量表测试通过
- [ ] 阶段 3: IL 核心测试通过
- [ ] 阶段 4: 栈操作测试通过
- [ ] 阶段 5: 算术运算测试通过
- [ ] 阶段 6: 变量操作测试通过
- [ ] 阶段 7: 分支测试通过
- [ ] 阶段 8: 子程序测试通过
- [ ] 阶段 9: 程序管理测试通过
- [ ] 阶段 10: 完整程序测试通过

### 最终验收标准
```basic
10 PRINT "TINY BASIC V1.0"
20 LET A=10
30 LET B=20
40 LET C=A+B
50 PRINT "10+20=";C
60 GOSUB 100
70 END
100 PRINT "READY"
110 RETURN
```
**期望输出**:
```
TINY BASIC V1.0
10+20=30
READY
```

## 时间估算

| 阶段 | 时间 | 累计 |
|-----|------|------|
| 0. 准备 | 1h | 1h |
| 1. I/O | 0.5h | 1.5h |
| 2. 向量 | 0.5h | 2h |
| 3. IL核心 | 2h | 4h |
| 4. 栈 | 1h | 5h |
| 5. 算术 | 2h | 7h |
| 6. 变量 | 1h | 8h |
| 7. 分支 | 1h | 9h |
| 8. 子程序 | 1h | 10h |
| 9. 程序管理 | 1h | 11h |
| 10. 完整测试 | 2h | 13h |

**总计**: 约 13 小时

## 风险和缓解

### 风险 1: IL 字节码不兼容
**缓解**: 逐个测试 IL 操作码，确保每个都正确

### 风险 2: 内存布局冲突
**缓解**: 调整内存映射，避免冲突

### 风险 3: 汇编器语法差异
**缓解**: 创建语法转换脚本

## 下一步行动

1. **立即开始**: 创建测试框架目录
2. **第一个测试**: 编写 test_io_output.asm
3. **持续集成**: 每个测试通过后提交
4. **文档更新**: 记录每个阶段的发现

## 参考

- [TINYBASIC_ANALYSIS.md](TINYBASIC_ANALYSIS.md) - 功能分析
- [TINYBASIC.md](TINYBASIC.md) - 基本文档
- Tom Pitman's Tiny BASIC 规范
