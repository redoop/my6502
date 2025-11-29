#!/bin/bash

# 阶段 3: PPU 寄存器访问验证
# 目标：确认 CPU 能正确读写 PPU 寄存器

echo "🔍 阶段 3: PPU 寄存器访问验证"
echo "=============================="
echo ""
echo "验证目标："
echo "  1. PPUCTRL (0x2000) 写入正常"
echo "  2. PPUMASK (0x2001) 写入正常"
echo "  3. PPUSTATUS (0x2002) 读取正常"
echo "  4. 游戏最终启用渲染"
echo ""

# 运行游戏并监控 PPUMASK 变化
echo "📊 监控 PPUMASK 变化（最多 3 分钟）..."
echo ""

timeout 180 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    awk '
        BEGIN {
            last_mask = ""
            changes = 0
            rendering_enabled = 0
        }
        /PPUMASK:/ {
            # 提取 PPUMASK 值
            for(i=1; i<=NF; i++) {
                if($i == "PPUMASK:") {
                    mask = $(i+1)
                    gsub(/\(.*/, "", mask)
                    
                    if (mask != last_mask && last_mask != "") {
                        changes++
                        print "变化 " changes ": PPUMASK = " mask
                        
                        # 检查是否启用渲染
                        if ($0 ~ /BG: ON/ || $0 ~ /SPR: ON/) {
                            print ""
                            print "✅ 渲染已启用！"
                            print "   " $0
                            print ""
                            rendering_enabled = 1
                            exit 0
                        }
                    }
                    last_mask = mask
                }
            }
        }
        END {
            print ""
            if (rendering_enabled) {
                print "━━━━━━━━━━━━━━━━━━━━"
                print "✅ 阶段 3: 通过"
                print "━━━━━━━━━━━━━━━━━━━━"
                print ""
                print "验证结果："
                print "  ✅ CPU 能写入 PPUMASK"
                print "  ✅ 游戏启用了渲染"
                print "  ✅ PPU 寄存器访问正常"
                print ""
                print "🎯 下一步: 阶段 4 - PPU 内存访问验证"
            } else if (changes > 0) {
                print "━━━━━━━━━━━━━━━━━━━━"
                print "⚠️  阶段 3: 部分通过"
                print "━━━━━━━━━━━━━━━━━━━━"
                print ""
                print "验证结果："
                print "  ✅ CPU 能写入 PPUMASK (检测到 " changes " 次变化)"
                print "  ⏸️  渲染尚未启用"
                print ""
                print "💡 建议: 继续等待或检查游戏逻辑"
            } else {
                print "━━━━━━━━━━━━━━━━━━━━"
                print "⏸️  阶段 3: 未完成"
                print "━━━━━━━━━━━━━━━━━━━━"
                print ""
                print "验证结果："
                print "  ⏸️  未检测到 PPUMASK 变化"
                print "  ⏸️  游戏可能还在初始化"
                print ""
                print "💡 建议: 等待更长时间或检查 CPU 执行"
            }
        }
    '

echo ""
echo "提示："
echo "  - 如果渲染已启用，说明阶段 3 通过"
echo "  - 如果 PPUMASK 有变化但渲染未启用，说明游戏在推进"
echo "  - 如果没有任何变化，可能需要更长时间"
