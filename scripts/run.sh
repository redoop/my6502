#!/bin/bash
# 统一运行脚本 - 运行 NES 游戏

# 如果没有参数，列出可用游戏
if [ $# -eq 0 ]; then
    if [ ! -d "games" ] || [ -z "$(ls -A games/*.nes 2>/dev/null)" ]; then
        echo "❌ games/ 目录不存在或没有 ROM 文件"
        exit 1
    fi
    
    echo "🎮 可用游戏列表"
    echo "===================="
    echo ""
    
    games=(games/*.nes)
    for i in "${!games[@]}"; do
        game="${games[$i]}"
        name=$(basename "$game" .nes)
        size=$(ls -lh "$game" | awk '{print $5}')
        printf "%2d) %-30s (%s)\n" $((i+1)) "$name" "$size"
    done
    
    echo ""
    echo -n "请选择游戏 (1-${#games[@]}) 或按 Enter 运行默认游戏: "
    read choice
    
    if [ -z "$choice" ]; then
        ROM="games/Donkey-Kong.nes"
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#games[@]}" ]; then
        ROM="${games[$((choice-1))]}"
    else
        echo "❌ 无效选择"
        exit 1
    fi
else
    ROM="$1"
fi

if [ ! -f "$ROM" ]; then
    echo "❌ ROM 文件不存在: $ROM"
    echo ""
    echo "用法: $0 [rom文件]"
    echo "示例: $0 games/Donkey-Kong.nes"
    exit 1
fi

if [ ! -f "build/verilator/VNESSystem" ]; then
    echo "⚠️  仿真器未编译，正在编译..."
    ./scripts/build.sh fast
fi

echo "🎮 启动 NES 模拟器"
echo "===================="
echo "ROM: $ROM"
echo ""
echo "⚠️  注意："
echo "   - Verilator 是硬件级仿真，速度较慢（约 2-5 FPS）"
echo "   - 这是正常的，因为它在模拟每个时钟周期"
echo ""
echo "🎮 控制："
echo "   方向键 - 移动"
echo "   Z - A 按钮"
echo "   X - B 按钮"
echo "   Enter - Start"
echo "   RShift - Select"
echo ""
echo "按 Ctrl+C 退出"
echo ""

./build/verilator/VNESSystem "$ROM"
