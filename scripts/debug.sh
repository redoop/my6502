#!/bin/bash
# 统一调试脚本 - 调试和分析工具

MODE="${1:-help}"
ROM="${2:-games/Donkey-Kong.nes}"

case "$MODE" in
    opcodes)
        echo "🔍 分析 ROM 指令..."
        python3 scripts/python/rom_analyzer.py "$ROM"
        ;;
    
    vcd)
        echo "🔍 分析 VCD 波形..."
        if [ ! -f "nes_trace.vcd" ]; then
            echo "❌ VCD 文件不存在"
            echo "请先运行: ./scripts/build.sh trace && ./scripts/run.sh"
            exit 1
        fi
        python3 scripts/python/vcd_analyzer.py nes_trace.vcd
        ;;
    
    transistors)
        echo "🔍 分析晶体管数量..."
        python3 scripts/python/transistor_counter.py generated/nes/NESSystem.v
        ;;
    
    execution)
        echo "🔍 分析执行流程..."
        if [ ! -f "nes_trace.vcd" ]; then
            echo "❌ VCD 文件不存在"
            exit 1
        fi
        python3 scripts/python/execution_tracer.py nes_trace.vcd
        ;;
    
    monitor)
        MONITOR_TYPE="${2:-pc}"
        echo "📊 监控 $MONITOR_TYPE..."
        
        # 重新编译并运行，监控输出
        ./scripts/build.sh trace > /dev/null 2>&1
        
        case "$MONITOR_TYPE" in
            pc)
                ./build/verilator/VNESSystemRefactored "$ROM" 2>&1 | grep -E "PC:|Opcode:" | head -100
                ;;
            ppu)
                ./build/verilator/VNESSystemRefactored "$ROM" 2>&1 | grep -E "PPU|PPUSTATUS|PPUCTRL" | head -100
                ;;
            nmi)
                ./build/verilator/VNESSystemRefactored "$ROM" 2>&1 | grep -E "NMI|nmi" | head -100
                ;;
            *)
                echo "❌ 未知监控类型: $MONITOR_TYPE"
                echo "可用类型: pc, ppu, nmi"
                exit 1
                ;;
        esac
        ;;
    
    help|*)
        echo "🔧 调试工具"
        echo "=========================================="
        echo ""
        echo "用法: $0 <模式> [参数]"
        echo ""
        echo "模式:"
        echo "  opcodes <rom>     - 分析 ROM 指令覆盖率"
        echo "  vcd               - 分析 VCD 波形文件"
        echo "  transistors       - 分析晶体管数量"
        echo "  execution         - 分析执行流程"
        echo "  monitor <type>    - 实时监控 (pc/ppu/nmi)"
        echo ""
        echo "示例:"
        echo "  $0 opcodes games/Donkey-Kong.nes"
        echo "  $0 vcd"
        echo "  $0 monitor pc"
        ;;
esac
