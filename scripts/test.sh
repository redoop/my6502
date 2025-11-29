#!/bin/bash
# 统一测试脚本 - 运行所有测试

set -e

TEST_TYPE="${1:-all}"  # all, unit, integration, quick

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

TOTAL=0
PASSED=0
FAILED=0

run_test() {
    local name="$1"
    local cmd="$2"
    
    echo ""
    echo "🧪 $name"
    echo "================================"
    
    ((TOTAL++))
    if eval "$cmd"; then
        echo -e "${GREEN}✅ 通过${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ 失败${NC}"
        ((FAILED++))
    fi
}

case "$TEST_TYPE" in
    unit)
        run_test "Scala 单元测试" "sbt test"
        ;;
    
    integration)
        run_test "NES 集成测试" "sbt 'testOnly nes.NESIntegrationSpec'"
        run_test "游戏兼容性测试" "sbt 'testOnly nes.GameCompatibilitySpec'"
        ;;
    
    quick)
        run_test "快速测试" "sbt 'testOnly nes.NESIntegrationQuickSpec nes.GameCompatibilityQuickSpec'"
        ;;
    
    all|*)
        run_test "Scala 单元测试" "sbt test"
        run_test "Verilator 编译" "./scripts/build.sh fast > /dev/null 2>&1"
        ;;
esac

echo ""
echo "================================"
echo "测试总结"
echo "================================"
echo -e "总计: ${TOTAL}"
echo -e "${GREEN}通过: ${PASSED}${NC}"
echo -e "${RED}失败: ${FAILED}${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 所有测试通过！${NC}"
    exit 0
else
    echo -e "${RED}⚠️  有 ${FAILED} 个测试失败${NC}"
    exit 1
fi
