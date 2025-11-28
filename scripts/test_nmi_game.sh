#!/bin/bash

echo "🎮 游戏 NMI 中断测试"
echo "===================="
echo ""
echo "运行 Super Mario Bros. 并监控 NMI 触发"
echo "测试时间：2 分钟"
echo ""

# 创建临时文件
LOGFILE="/tmp/nmi_game_test.log"
rm -f $LOGFILE

echo "启动游戏..."
echo ""

# 运行游戏 120 秒，捕获所有输出
timeout 120 sbt "runMain nes.NESEmulator games/Donkey-Kong.nes" 2>&1 | tee $LOGFILE &
PID=$!

# 等待游戏启动
sleep 5

echo "监控中..."
echo ""

# 实时监控关键信息
tail -f $LOGFILE 2>/dev/null | while read line; do
    # 检查 PPUCTRL 变化
    if echo "$line" | grep -q "PPUCTRL"; then
        echo "[$(date +%H:%M:%S)] $line"
    fi
    
    # 检查 PC 跳转到 NMI 向量
    if echo "$line" | grep -q "PC: 0xc85"; then
        echo ""
        echo "🎉 检测到 NMI 触发！"
        echo "[$(date +%H:%M:%S)] $line"
        echo ""
    fi
done &
TAIL_PID=$!

# 等待游戏运行完成
wait $PID 2>/dev/null

# 停止监控
kill $TAIL_PID 2>/dev/null

echo ""
echo "分析结果..."
echo "============"
echo ""

# 分析 PPUCTRL 变化
echo "1. PPUCTRL 历史："
grep "PPUCTRL" $LOGFILE | sort -u | tail -10

echo ""
echo "2. 检查 NMI 向量 (0xc85f)："
NMI_COUNT=$(grep -c "PC: 0xc85" $LOGFILE)
if [ $NMI_COUNT -gt 0 ]; then
    echo "   ✅ 检测到 $NMI_COUNT 次 NMI 触发！"
    echo ""
    echo "   前 5 次 NMI："
    grep "PC: 0xc85" $LOGFILE | head -5
else
    echo "   ⚠️  未检测到 NMI 触发"
fi

echo ""
echo "3. PC 地址分布（最后 1000 条）："
tail -1000 $LOGFILE | grep -o "PC: 0x[0-9a-f]*" | sort | uniq -c | sort -rn | head -10

echo ""
echo "4. 最终 PPUCTRL 状态："
FINAL_PPUCTRL=$(grep "PPUCTRL" $LOGFILE | tail -1)
if [ ! -z "$FINAL_PPUCTRL" ]; then
    echo "   $FINAL_PPUCTRL"
    
    # 提取 PPUCTRL 值
    if [[ "$FINAL_PPUCTRL" =~ 0x([0-9a-fA-F]+) ]]; then
        HEX_VAL="${BASH_REMATCH[1]}"
        DEC_VAL=$((16#$HEX_VAL))
        BIT7=$((DEC_VAL >> 7))
        
        if [ $BIT7 -eq 1 ]; then
            echo "   ✅ NMI 已启用 (bit 7 = 1)"
        else
            echo "   ⚠️  NMI 仍未启用 (bit 7 = 0)"
            echo "   游戏可能需要更长时间初始化"
        fi
    fi
else
    echo "   ⚠️  未找到 PPUCTRL 信息"
fi

echo ""
echo "测试完成"
echo ""

# 清理
rm -f $LOGFILE
