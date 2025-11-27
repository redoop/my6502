#!/bin/bash

echo ""
echo "🎨 终端显示改进演示"
echo "===================="
echo ""

echo "改进 1: 半字符提高分辨率"
echo "------------------------"
echo ""
echo "改进前 (全字符 █):"
for i in {16..21}; do
    printf "\e[48;5;${i}m█"
done
printf "\e[0m\n"
echo ""

echo "改进后 (半字符 ▄):"
for i in {16..21}; do
    upper=$i
    lower=$((i+6))
    printf "\e[38;5;${lower}m\e[48;5;${upper}m▄"
done
printf "\e[0m"
echo " ← 每个字符显示2个像素！"
echo ""

echo ""
echo "改进 2: 精确的颜色映射"
echo "----------------------"
echo ""
echo "ANSI 256 色调色板:"
echo ""

echo "标准色 (0-15):"
for i in {0..15}; do
    printf "\e[48;5;${i}m  "
done
printf "\e[0m\n"

echo ""
echo "6x6x6 颜色立方体 (16-231) 示例:"
for r in {0..5}; do
    for g in {0..5}; do
        color=$((16 + 36*r + 6*g))
        printf "\e[48;5;${color}m "
    done
    printf "\e[0m "
done
echo ""

echo ""
echo "灰度 (232-255):"
for i in {232..255}; do
    printf "\e[48;5;${i}m "
done
printf "\e[0m\n"

echo ""
echo ""
echo "改进 3: NES 调色板映射"
echo "----------------------"
echo ""

# 模拟 NES 调色板的一些颜色
echo "NES 灰度系列:"
for gray in 16 59 102 145 188 231 255; do
    printf "\e[48;5;${gray}m   "
done
printf "\e[0m\n"

echo ""
echo "NES 蓝色系列:"
for blue in 17 18 19 20 21 27 33; do
    printf "\e[48;5;${blue}m   "
done
printf "\e[0m\n"

echo ""
echo "NES 红色系列:"
for red in 52 88 124 160 196 202 208; do
    printf "\e[48;5;${red}m   "
done
printf "\e[0m\n"

echo ""
echo "NES 绿色系列:"
for green in 22 28 34 40 46 82 118; do
    printf "\e[48;5;${green}m   "
done
printf "\e[0m\n"

echo ""
echo ""
echo "改进 4: 半字符渲染效果"
echo "----------------------"
echo ""

echo "渐变效果 (使用半字符):"
for i in {0..50}; do
    upper=$((232 + i/2))
    lower=$((232 + (i+1)/2))
    printf "\e[38;5;${lower}m\e[48;5;${upper}m▄"
done
printf "\e[0m\n"

echo ""
echo "棋盘效果:"
for y in {0..9}; do
    for x in {0..50}; do
        if [ $(((x+y)%2)) -eq 0 ]; then
            printf "\e[48;5;16m "
        else
            printf "\e[48;5;231m "
        fi
    done
    printf "\e[0m\n"
done

echo ""
echo ""
echo "✅ 改进总结"
echo "==========="
echo ""
echo "1. ✨ 垂直分辨率提高 2 倍 (使用半字符 ▄)"
echo "2. 🎨 精确的 RGB 到 ANSI-256 颜色映射"
echo "3. 🎯 基于实际 NES 调色板 RGB 值"
echo "4. 🚀 全分辨率显示 (256x240 像素)"
echo ""
echo "现在运行: ./run_terminal.sh games/contra.nes demo"
echo ""
