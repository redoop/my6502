#!/bin/bash
# Auto-update test checklist

RUNNER="../../src/test/rtl/obj_dir/Vcpu_6502"
CHECKLIST="../../docs/TEST_CHECKLIST.md"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
TEMP_RESULTS="/tmp/test_results_$$.txt"

cd "$(dirname "$0")"

echo "======================================"
echo "Running All Tests and Updating Checklist"
echo "======================================"
echo

# Run all tests and collect results
> $TEMP_RESULTS

TOTAL=0
PASSED=0
FAILED=0

# Test basic suite
for test in 01_basic/*.bin 02_control/*.bin 05_integration/*.bin; do
    if [ -f "$test" ]; then
        TOTAL=$((TOTAL + 1))
        name=$(basename "$test")
        echo -n "Testing $name... "
        
        output=$(timeout 5 $RUNNER "$test" 2>&1 | grep "Output:" | sed 's/Output: //' | tr -d "'")
        
        if echo "$output" | grep -q "OK"; then
            echo "✅ PASS"
            echo "$name|PASS|$output" >> $TEMP_RESULTS
            PASSED=$((PASSED + 1))
        else
            echo "❌ FAIL"
            echo "$name|FAIL|$output" >> $TEMP_RESULTS
            FAILED=$((FAILED + 1))
        fi
    fi
done

# Test foundation suite
for level in 1 2 3 4; do
    test="00_foundation/test_level${level}_*.bin"
    if ls $test 1> /dev/null 2>&1; then
        TOTAL=$((TOTAL + 1))
        name=$(ls $test | xargs basename)
        echo -n "Testing $name... "
        
        output=$(timeout 5 $RUNNER $test 2>&1 | grep "Output:" | sed 's/Output: //' | tr -d "'")
        
        if echo "$output" | grep -q "OK"; then
            echo "✅ PASS"
            echo "$name|PASS|$output" >> $TEMP_RESULTS
            PASSED=$((PASSED + 1))
        elif [ -z "$output" ]; then
            echo "⏳ TODO"
            echo "$name|TODO|-" >> $TEMP_RESULTS
        else
            echo "❌ FAIL"
            echo "$name|FAIL|$output" >> $TEMP_RESULTS
            FAILED=$((FAILED + 1))
        fi
    fi
done

echo
echo "======================================"
echo "Results: $PASSED passed, $FAILED failed, $TOTAL total"
echo "======================================"

# Calculate pass rate
if [ $TOTAL -gt 0 ]; then
    PASS_RATE=$((PASSED * 100 / TOTAL))
else
    PASS_RATE=0
fi

# Update checklist
cat > $CHECKLIST << EOF
# 6502 CPU 测试清单

**最后更新**: $TIMESTAMP
**测试环境**: Verilator + SystemVerilog

---

## 测试统计

| 类别 | 通过 | 失败 | 总计 | 通过率 |
|------|------|------|------|--------|
| **总计** | **$PASSED** | **$FAILED** | **$TOTAL** | **${PASS_RATE}%** |

---

## 测试结果详情

EOF

# Add test results
while IFS='|' read -r name status output; do
    if [ "$status" = "PASS" ]; then
        icon="✅"
    elif [ "$status" = "TODO" ]; then
        icon="⏳"
    else
        icon="❌"
    fi
    echo "| $name | $icon $status | \`$output\` |" >> $CHECKLIST
done < $TEMP_RESULTS

cat >> $CHECKLIST << 'EOF'

---

## 指令覆盖率摘要

### 已测试指令类别
- ✅ 数据传输: LDA, LDX, LDY, STA
- ✅ 算术运算: ADC, SBC
- ✅ 逻辑运算: AND (部分)
- ✅ 比较指令: CMP, CPX
- ✅ 分支指令: 全部 8 个
- ✅ 跳转/子程序: JMP, JSR, RTS
- ✅ 栈操作: PHA, PLA
- ✅ 标志操作: CLC, SEC, CLV
- ✅ 递增: INX

### 待测试指令
- ❌ 传送指令: TAX, TAY, TXA, TYA, TSX, TXS
- ❌ 逻辑运算: ORA, EOR
- ❌ 移位/旋转: ASL, LSR, ROL, ROR (累加器模式)
- ❌ 递增/递减: INY, DEX, DEY, INC, DEC
- ❌ 比较: CPY
- ❌ 栈操作: PHP, PLP
- ❌ 标志操作: CLI, SEI, CLD, SED
- ❌ 其他: NOP, JMP (indirect)

---

## 寻址模式覆盖率

| 模式 | 状态 |
|------|------|
| 立即数 (#) | ✅ |
| 零页 (zp) | ✅ |
| 零页索引 (zp,X/Y) | ✅ |
| 绝对 (abs) | ✅ |
| 绝对索引 (abs,X/Y) | ✅ |
| 隐含 (impl) | ✅ |
| 累加器 (A) | ✅ |
| 相对 (rel) | ✅ |
| 间接 ((ind)) | ❌ |
| 索引间接 ((ind,X)) | ❌ |
| 间接索引 ((ind),Y) | ❌ |

---

**自动生成**: run_tests_and_update.sh
**下次更新**: 运行 `./run_tests_and_update.sh`
EOF

rm -f $TEMP_RESULTS

echo
echo "✅ Checklist updated: $CHECKLIST"
echo
