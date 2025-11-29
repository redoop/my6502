#!/bin/bash
# Translation Helper Script
# 翻译辅助脚本

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🌐 Translation Helper / 翻译辅助工具"
echo "=================================="
echo ""

# Function to check if file contains Chinese
has_chinese() {
    local file="$1"
    if grep -q "[\u4e00-\u9fff]" "$file" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to list files with Chinese
list_chinese_files() {
    echo "📝 Files containing Chinese / 包含中文的文件:"
    echo ""
    
    local count=0
    
    # Check markdown files
    echo "Markdown files:"
    while IFS= read -r file; do
        if has_chinese "$file"; then
            echo "  - $file"
            ((count++))
        fi
    done < <(find docs -name "*.md" -not -path "*/archive/*" 2>/dev/null)
    
    # Check Scala files
    echo ""
    echo "Scala files:"
    while IFS= read -r file; do
        if has_chinese "$file"; then
            echo "  - $file"
            ((count++))
        fi
    done < <(find src -name "*.scala" 2>/dev/null)
    
    echo ""
    echo "Total: $count files"
}

# Function to backup files
backup_files() {
    local backup_dir="backups/translation_$(date +%Y%m%d_%H%M%S)"
    echo "📦 Creating backup in $backup_dir..."
    
    mkdir -p "$backup_dir"
    
    # Backup docs
    if [ -d "docs" ]; then
        cp -r docs "$backup_dir/"
    fi
    
    # Backup src
    if [ -d "src" ]; then
        cp -r src "$backup_dir/"
    fi
    
    echo -e "${GREEN}✅ Backup created${NC}"
}

# Function to show translation status
show_status() {
    echo "📊 Translation Status / 翻译状态:"
    echo ""
    
    local total_md=$(find docs -name "*.md" -not -path "*/archive/*" 2>/dev/null | wc -l)
    local chinese_md=$(find docs -name "*.md" -not -path "*/archive/*" -exec grep -l "[\u4e00-\u9fff]" {} \; 2>/dev/null | wc -l)
    local english_md=$((total_md - chinese_md))
    
    local total_scala=$(find src -name "*.scala" 2>/dev/null | wc -l)
    local chinese_scala=$(find src -name "*.scala" -exec grep -l "[\u4e00-\u9fff]" {} \; 2>/dev/null | wc -l)
    local english_scala=$((total_scala - chinese_scala))
    
    echo "Markdown files:"
    echo "  Total: $total_md"
    echo "  English: $english_md"
    echo "  Chinese: $chinese_md"
    echo "  Progress: $((english_md * 100 / total_md))%"
    
    echo ""
    echo "Scala files:"
    echo "  Total: $total_scala"
    echo "  English: $english_scala"
    echo "  Chinese: $chinese_scala"
    echo "  Progress: $((english_scala * 100 / total_scala))%"
}

# Function to create translation branch
create_branch() {
    local branch_name="translation-$(date +%Y%m%d)"
    echo "🌿 Creating translation branch: $branch_name"
    
    git checkout -b "$branch_name"
    echo -e "${GREEN}✅ Branch created${NC}"
    echo "You can now start translating files"
}

# Main menu
show_menu() {
    echo ""
    echo "Choose an option / 选择操作:"
    echo "1) List files with Chinese / 列出包含中文的文件"
    echo "2) Show translation status / 显示翻译状态"
    echo "3) Create backup / 创建备份"
    echo "4) Create translation branch / 创建翻译分支"
    echo "5) View translation plan / 查看翻译计划"
    echo "6) Exit / 退出"
    echo ""
    read -p "Enter choice [1-6]: " choice
    
    case $choice in
        1)
            list_chinese_files
            show_menu
            ;;
        2)
            show_status
            show_menu
            ;;
        3)
            backup_files
            show_menu
            ;;
        4)
            create_branch
            show_menu
            ;;
        5)
            if [ -f "docs/TRANSLATION_PLAN.md" ]; then
                cat docs/TRANSLATION_PLAN.md
            else
                echo "Translation plan not found"
            fi
            show_menu
            ;;
        6)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            show_menu
            ;;
    esac
}

# Start
show_menu
