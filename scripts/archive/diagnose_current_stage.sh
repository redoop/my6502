#!/bin/bash

# 快速诊断当前处于哪个阶段

echo "🏥 NES 模拟器阶段诊断"
echo "===================="
echo ""

# 运行 10 秒获取状态
echo "📊 采集数据（10 秒）..."
timeout 10 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 > /tmp/nes_diag.log 2>&1

echo ""
echo "📋 诊断结果："
echo ""

# 阶段 1: CPU 基础
if grep -q "CPU 已启动" /tmp/nes_diag.log; then
    echo "✅ 阶段 1: CPU 基础验证 - 通过"
    echo "   - CPU 从 reset vector 启动"
    echo "   - 程序计数器正常工作"
else
    echo "❌ 阶段 1: CPU 基础验证 - 失败"
    echo "   - CPU 无法启动"
    exit 1
fi

echo ""

# 阶段 2: CPU 循环
PC_RANGE=$(grep -c "PC: 0xf1a" /tmp/nes_diag.log)
if [ "$PC_RANGE" -gt 10 ]; then
    echo "⚠️  阶段 2: CPU 循环验证 - 进行中"
    echo "   - CPU 卡在内存清零循环 (0xf19f-0xf1a8)"
    
    # 检查 X 寄存器是否在变化
    X_VALUES=$(grep "PC: 0xf1a" /tmp/nes_diag.log | grep -o "X: 0x[0-9a-f]*" | sort -u | wc -l)
    if [ "$X_VALUES" -gt 5 ]; then
        echo "   - X 寄存器正在变化（DEX 工作正常）"
        echo "   - 循环需要更多时间完成"
        echo ""
        echo "   💡 建议：运行 ./scripts/debug_cpu_loop.sh 查看详情"
    else
        echo "   - X 寄存器变化很少（可能有问题）"
        echo ""
        echo "   💡 建议：检查 DEX 指令实现"
    fi
    CURRENT_STAGE=2
else
    echo "✅ 阶段 2: CPU 循环验证 - 通过"
    CURRENT_STAGE=3
fi

echo ""

# 阶段 3: PPU 寄存器
if [ "$CURRENT_STAGE" -ge 3 ]; then
    PPUMASK=$(grep "PPUMASK:" /tmp/nes_diag.log | tail -1 | grep -o "0x[0-9a-f]*" | head -1)
    if [ -n "$PPUMASK" ]; then
        # 检查是否启用了渲染（bit 3 或 4）
        MASK_DEC=$(printf "%d" $PPUMASK 2>/dev/null || echo "0")
        if [ $((MASK_DEC & 0x18)) -ne 0 ]; then
            echo "✅ 阶段 3: PPU 寄存器访问 - 通过"
            echo "   - PPUMASK = $PPUMASK (渲染已启用)"
            CURRENT_STAGE=4
        else
            echo "⏸️  阶段 3: PPU 寄存器访问 - 等待中"
            echo "   - PPUMASK = $PPUMASK (渲染未启用)"
            echo "   - 游戏还在初始化"
        fi
    else
        echo "⏸️  阶段 3: PPU 寄存器访问 - 未到达"
    fi
else
    echo "⏸️  阶段 3: PPU 寄存器访问 - 未到达"
    echo "   - 需要先完成阶段 2"
fi

echo ""

# 阶段 4: PPU 内存
if [ "$CURRENT_STAGE" -ge 4 ]; then
    NON_ZERO=$(grep "非零像素:" /tmp/nes_diag.log | tail -1 | grep -o "[0-9]* /" | grep -o "[0-9]*" | head -1)
    if [ -n "$NON_ZERO" ] && [ "$NON_ZERO" -gt 0 ]; then
        echo "✅ 阶段 4: PPU 内存访问 - 通过"
        echo "   - 非零像素: $NON_ZERO"
        CURRENT_STAGE=5
    else
        echo "⚠️  阶段 4: PPU 内存访问 - 有问题"
        echo "   - 非零像素: ${NON_ZERO:-0}"
        echo "   - VRAM 或 CHR ROM 可能有问题"
    fi
else
    echo "⏸️  阶段 4: PPU 内存访问 - 未到达"
fi

echo ""

# 阶段 5: PPU 渲染
if [ "$CURRENT_STAGE" -ge 5 ]; then
    echo "✅ 阶段 5: PPU 渲染 - 通过"
    echo "   - 画面正在渲染"
    CURRENT_STAGE=6
else
    echo "⏸️  阶段 5: PPU 渲染 - 未到达"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━"
echo "📍 当前阶段: $CURRENT_STAGE"
echo ""

case $CURRENT_STAGE in
    2)
        echo "🎯 下一步："
        echo "   1. 运行 ./scripts/debug_cpu_loop.sh"
        echo "   2. 等待循环完成（可能需要几分钟）"
        echo "   3. 或检查 CPU 指令实现"
        ;;
    3)
        echo "🎯 下一步："
        echo "   1. 等待游戏初始化完成"
        echo "   2. 运行 ./scripts/monitor_ppu_registers.sh"
        echo "   3. 检查游戏何时写入 PPUMASK"
        ;;
    4)
        echo "🎯 下一步："
        echo "   1. 运行 ./scripts/verify_chr_rom.sh"
        echo "   2. 运行 ./scripts/monitor_vram.sh"
        echo "   3. 检查 PPU 渲染逻辑"
        ;;
    *)
        echo "🎯 继续等待游戏运行..."
        ;;
esac

# 清理
rm -f /tmp/nes_diag.log
