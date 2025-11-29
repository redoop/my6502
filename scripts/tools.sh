#!/bin/bash
# 统一工具脚本 - 项目管理工具

MODE="${1:-help}"

case "$MODE" in
    clean)
        echo "🧹 清理构建文件..."
        rm -rf build/verilator
        rm -rf target
        rm -f nes_trace.vcd
        rm -f *.vcd
        echo "✅ 清理完成"
        ;;
    
    generate)
        echo "📝 生成 Verilog..."
        sbt "runMain nes.GenerateNESVerilog"
        echo "✅ 生成完成: generated/nes/NESSystem.v"
        ;;
    
    check)
        echo "🔍 检查环境..."
        echo ""
        
        check_cmd() {
            if command -v "$1" &> /dev/null; then
                echo "✅ $1: $(command -v $1)"
            else
                echo "❌ $1: 未安装"
            fi
        }
        
        check_cmd verilator
        check_cmd sbt
        check_cmd java
        check_cmd python3
        
        if pkg-config --exists sdl2; then
            echo "✅ SDL2: $(pkg-config --modversion sdl2)"
        else
            echo "❌ SDL2: 未安装"
        fi
        
        echo ""
        echo "Verilator 版本:"
        verilator --version 2>/dev/null | head -1 || echo "未安装"
        
        echo ""
        echo "Java 版本:"
        java -version 2>&1 | head -1
        ;;
    
    stats)
        echo "📊 项目统计"
        echo "=========================================="
        echo ""
        
        echo "代码行数:"
        find src -name "*.scala" | xargs wc -l | tail -1
        
        echo ""
        echo "测试文件:"
        find src/test -name "*.scala" | wc -l
        
        echo ""
        echo "Verilog 大小:"
        if [ -f "generated/nes/NESSystem.v" ]; then
            ls -lh generated/nes/NESSystem.v | awk '{print $5}'
        else
            echo "未生成"
        fi
        
        echo ""
        echo "构建大小:"
        if [ -f "build/verilator/VNESSystem" ]; then
            ls -lh build/verilator/VNESSystem | awk '{print $5}'
        else
            echo "未构建"
        fi
        ;;
    
    rom)
        echo "🎮 ROM 信息"
        echo "=========================================="
        echo ""
        
        if [ -d "games" ]; then
            for rom in games/*.nes; do
                if [ -f "$rom" ]; then
                    size=$(ls -lh "$rom" | awk '{print $5}')
                    echo "$(basename "$rom"): $size"
                fi
            done
        else
            echo "games/ 目录不存在"
        fi
        ;;
    
    archive)
        echo "📦 创建归档..."
        timestamp=$(date +%Y%m%d_%H%M%S)
        archive_name="my6502_backup_${timestamp}.tar.gz"
        
        tar -czf "$archive_name" \
            --exclude='target' \
            --exclude='build' \
            --exclude='*.vcd' \
            --exclude='.git' \
            src/ docs/ scripts/ build.sbt README.md
        
        echo "✅ 归档完成: $archive_name"
        ls -lh "$archive_name"
        ;;
    
    help|*)
        echo "🛠️  项目工具"
        echo "=========================================="
        echo ""
        echo "用法: $0 <命令>"
        echo ""
        echo "命令:"
        echo "  clean      - 清理构建文件"
        echo "  generate   - 生成 Verilog"
        echo "  check      - 检查环境依赖"
        echo "  stats      - 显示项目统计"
        echo "  rom        - 显示 ROM 信息"
        echo "  archive    - 创建项目归档"
        echo ""
        echo "示例:"
        echo "  $0 clean"
        echo "  $0 check"
        echo "  $0 stats"
        ;;
esac
