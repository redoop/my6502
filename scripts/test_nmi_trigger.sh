#!/bin/bash

echo "🧪 NMI 触发测试"
echo "================"
echo ""
echo "这个测试会运行游戏更长时间，观察 NMI 是否被触发"
echo ""

# 运行游戏 30 秒，捕获 NMI 相关信息
timeout 30 sbt "runMain nes.NESEmulator games/mario.nes" 2>&1 | \
  grep -E "PPUCTRL|NMI|PC: 0xc85" | \
  head -100 > /tmp/nmi_test.log

echo "分析结果："
echo "----------"

# 检查 PPUCTRL 是否变化
echo ""
echo "1. PPUCTRL 变化："
grep "PPUCTRL" /tmp/nmi_test.log | sort -u | head -10

# 检查是否跳转到 NMI 向量
echo ""
echo "2. 检查 NMI 向量 (0xc85f)："
if grep -q "PC: 0xc85" /tmp/nmi_test.log; then
    echo "   ✅ 检测到 PC 跳转到 NMI 向量！"
    grep "PC: 0xc85" /tmp/nmi_test.log | head -5
else
    echo "   ⚠️  未检测到 NMI 向量跳转"
    echo "   这可能意味着："
    echo "   - 游戏还在初始化阶段"
    echo "   - PPUCTRL bit 7 未设置"
    echo "   - 需要运行更长时间"
fi

echo ""
echo "3. 当前 PPUCTRL 状态："
PPUCTRL=$(grep "PPUCTRL" /tmp/nmi_test.log | tail -1 | awk '{print $NF}')
if [ ! -z "$PPUCTRL" ]; then
    echo "   PPUCTRL = $PPUCTRL"
    
    # 转换为二进制并检查 bit 7
    if [[ "$PPUCTRL" =~ 0x([0-9a-fA-F]+) ]]; then
        HEX_VAL="${BASH_REMATCH[1]}"
        DEC_VAL=$((16#$HEX_VAL))
        BIT7=$((DEC_VAL >> 7))
        
        if [ $BIT7 -eq 1 ]; then
            echo "   ✅ NMI 已启用 (bit 7 = 1)"
        else
            echo "   ⚠️  NMI 未启用 (bit 7 = 0)"
        fi
    fi
fi

echo ""
echo "测试完成"
