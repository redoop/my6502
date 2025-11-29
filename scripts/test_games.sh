#!/bin/bash

# 游戏兼容性测试脚本
# 用法: ./scripts/test_games.sh [game.nes]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
GAMES_DIR="$PROJECT_ROOT/games"
LOGS_DIR="$PROJECT_ROOT/docs/logs"

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 创建日志目录
mkdir -p "$LOGS_DIR"

# 测试单个游戏
test_game() {
    local rom_path="$1"
    local game_name=$(basename "$rom_path" .nes)
    local log_file="$LOGS_DIR/game_test_${game_name}_$(date +%Y%m%d_%H%M%S).log"
    
    echo -e "${BLUE}=== 测试游戏: $game_name ===${NC}"
    echo "ROM: $rom_path"
    echo "日志: $log_file"
    echo ""
    
    # Stage 1: ROM 分析
    echo -e "${YELLOW}[1/5] ROM 分析...${NC}"
    if sbt -no-colors "runMain nes.ROMAnalyzer \"$rom_path\"" > "$log_file" 2>&1; then
        echo -e "${GREEN}✓ ROM 分析成功${NC}"
        grep -A 20 "ROM Information" "$log_file" || true
    else
        echo -e "${RED}✗ ROM 分析失败${NC}"
        return 1
    fi
    echo ""
    
    # Stage 2: 系统初始化测试
    echo -e "${YELLOW}[2/5] 系统初始化测试...${NC}"
    if sbt -no-colors "testOnly nes.GameCompatibilityQuickSpec -- -z \"$game_name\"" >> "$log_file" 2>&1; then
        echo -e "${GREEN}✓ 系统初始化成功${NC}"
    else
        echo -e "${RED}✗ 系统初始化失败${NC}"
        tail -20 "$log_file"
        return 1
    fi
    echo ""
    
    # Stage 3: Verilator 编译
    echo -e "${YELLOW}[3/5] Verilator 编译...${NC}"
    if [ ! -f "$PROJECT_ROOT/verilator/obj_dir/Vnes_top" ]; then
        echo "编译 Verilator..."
        if ./scripts/build.sh fast >> "$log_file" 2>&1; then
            echo -e "${GREEN}✓ 编译成功${NC}"
        else
            echo -e "${RED}✗ 编译失败${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ 已编译${NC}"
    fi
    echo ""
    
    # Stage 4: 短时运行测试 (5秒)
    echo -e "${YELLOW}[4/5] 短时运行测试 (5秒)...${NC}"
    timeout 5 ./scripts/run.sh "$rom_path" >> "$log_file" 2>&1 || true
    echo -e "${GREEN}✓ 运行测试完成${NC}"
    echo ""
    
    # Stage 5: 结果分析
    echo -e "${YELLOW}[5/5] 结果分析...${NC}"
    if grep -q "ERROR\|FATAL\|Segmentation fault" "$log_file"; then
        echo -e "${RED}✗ 发现错误${NC}"
        grep -i "error\|fatal" "$log_file" | tail -5
        return 1
    else
        echo -e "${GREEN}✓ 无严重错误${NC}"
    fi
    echo ""
    
    # 生成测试报告
    echo -e "${BLUE}=== 测试报告 ===${NC}"
    echo "游戏: $game_name"
    echo "状态: ✓ 通过"
    echo "日志: $log_file"
    echo ""
    
    return 0
}

# 测试所有游戏
test_all_games() {
    echo -e "${BLUE}=== 测试所有游戏 ===${NC}"
    echo ""
    
    local total=0
    local passed=0
    local failed=0
    
    for rom in "$GAMES_DIR"/*.nes; do
        if [ -f "$rom" ]; then
            total=$((total + 1))
            if test_game "$rom"; then
                passed=$((passed + 1))
            else
                failed=$((failed + 1))
            fi
            echo ""
            echo "---"
            echo ""
        fi
    done
    
    # 总结
    echo -e "${BLUE}=== 测试总结 ===${NC}"
    echo "总计: $total"
    echo -e "${GREEN}通过: $passed${NC}"
    if [ $failed -gt 0 ]; then
        echo -e "${RED}失败: $failed${NC}"
    else
        echo "失败: $failed"
    fi
    echo ""
    
    if [ $failed -eq 0 ]; then
        echo -e "${GREEN}✓ 所有游戏测试通过！${NC}"
        return 0
    else
        echo -e "${RED}✗ 部分游戏测试失败${NC}"
        return 1
    fi
}

# 显示帮助
show_help() {
    cat << EOF
游戏兼容性测试脚本

用法:
  ./scripts/test_games.sh              # 测试所有游戏
  ./scripts/test_games.sh <game.nes>   # 测试单个游戏
  ./scripts/test_games.sh --help       # 显示帮助

测试阶段:
  1. ROM 分析 - 解析 ROM 格式和 Mapper
  2. 系统初始化 - 测试 CPU/PPU/内存初始化
  3. Verilator 编译 - 编译硬件仿真器
  4. 短时运行 - 运行 5 秒检查基本功能
  5. 结果分析 - 检查错误和生成报告

示例:
  ./scripts/test_games.sh games/Donkey-Kong.nes
  ./scripts/test_games.sh

日志位置: docs/logs/game_test_*.log
EOF
}

# 主函数
main() {
    cd "$PROJECT_ROOT"
    
    if [ $# -eq 0 ]; then
        # 测试所有游戏
        test_all_games
    elif [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
    elif [ -f "$1" ]; then
        # 测试单个游戏
        test_game "$1"
    else
        echo -e "${RED}错误: 文件不存在: $1${NC}"
        echo ""
        show_help
        exit 1
    fi
}

main "$@"
