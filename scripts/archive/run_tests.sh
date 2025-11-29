#!/bin/bash
# 运行所有测试

set -e

echo "================================"
echo "6502 指令集测试套件"
echo "================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 测试计数
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# 1. 运行 Scala 单元测试
echo "📝 运行 Scala 单元测试..."
echo "================================"
if sbt test; then
    echo -e "${GREEN}✅ Scala 单元测试通过${NC}"
    ((PASSED_TESTS++))
else
    echo -e "${RED}❌ Scala 单元测试失败${NC}"
    ((FAILED_TESTS++))
fi
((TOTAL_TESTS++))
echo ""

# 2. 运行 Python 自动化测试
echo "🐍 运行 Python 自动化测试..."
echo "================================"
if python3 tests/run_instruction_tests.py; then
    echo -e "${GREEN}✅ Python 自动化测试通过${NC}"
    ((PASSED_TESTS++))
else
    echo -e "${RED}❌ Python 自动化测试失败${NC}"
    ((FAILED_TESTS++))
fi
((TOTAL_TESTS++))
echo ""

# 3. 运行 Verilator 仿真测试
echo "🔧 运行 Verilator 仿真测试..."
echo "================================"
if ./scripts/verilator_build.sh > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Verilator 编译成功${NC}"
    ((PASSED_TESTS++))
else
    echo -e "${RED}❌ Verilator 编译失败${NC}"
    ((FAILED_TESTS++))
fi
((TOTAL_TESTS++))
echo ""

# 4. 分析 Donkey Kong 指令覆盖率
echo "🎮 分析 Donkey Kong 指令覆盖率..."
echo "================================"
python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes
echo ""

# 打印总结
echo "================================"
echo "测试总结"
echo "================================"
echo -e "总计: ${TOTAL_TESTS} 个测试套件"
echo -e "${GREEN}通过: ${PASSED_TESTS}${NC}"
echo -e "${RED}失败: ${FAILED_TESTS}${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}🎉 所有测试通过！${NC}"
    exit 0
else
    echo -e "${RED}⚠️  有 ${FAILED_TESTS} 个测试失败${NC}"
    exit 1
fi
