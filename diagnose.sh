#!/bin/bash
# NES 模拟器诊断脚本

echo "=== NES 模拟器诊断 ==="
echo ""

echo "1. 检查编译状态..."
if [ -f "verilator/obj_dir/Vnes_gui" ]; then
    echo "   ✅ 可执行文件存在"
    ls -lh verilator/obj_dir/Vnes_gui
else
    echo "   ❌ 可执行文件不存在，需要编译"
fi

echo ""
echo "2. 检查 ROM 文件..."
if [ -f "games/Donkey-Kong.nes" ]; then
    echo "   ✅ Donkey Kong ROM 存在"
    ls -lh games/Donkey-Kong.nes
else
    echo "   ❌ ROM 文件不存在"
fi

echo ""
echo "3. 运行 10 秒测试..."
timeout 10 ./run_nes.sh games/Donkey-Kong.nes 2>&1 | tee /tmp/nes_test.log | grep -E "(Frame [0-9]+|Video:|Render:|Audio:)" | tail -20

echo ""
echo "4. 分析输出..."
echo "   画面状态:"
grep "Render:ON" /tmp/nes_test.log | wc -l | xargs echo "     - Render ON 次数:"
grep "Render:OFF" /tmp/nes_test.log | wc -l | xargs echo "     - Render OFF 次数:"

echo "   颜色输出:"
grep -o "Video:[0-9,]*" /tmp/nes_test.log | sort | uniq -c | head -5

echo "   音频状态:"
grep "Audio:" /tmp/nes_test.log | tail -1

echo ""
echo "5. 诊断结果:"
if grep -q "Video:236,238,236" /tmp/nes_test.log; then
    echo "   ✅ 检测到白色像素 - 游戏在渲染"
fi
if grep -q "Video:152,34,32" /tmp/nes_test.log; then
    echo "   ✅ 检测到红色像素 - 游戏在渲染"
fi
if grep -q "value=4096" /tmp/nes_test.log; then
    echo "   ✅ 音频工作 - 检测到测试音"
fi

echo ""
echo "=== 诊断完成 ==="
echo ""
echo "建议:"
echo "1. 运行游戏并等待 10-15 秒"
echo "2. 看到橙色平台后按 Enter (Start)"
echo "3. 使用方向键和 Z 键控制"
echo "4. 截图并查看 images/ 目录"
