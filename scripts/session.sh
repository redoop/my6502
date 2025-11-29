#!/bin/bash

# 会话协作脚本
SESSION_FILE=".kiro/sessions.json"

register() {
    local role="$1"
    local session_id="$$_$(date +%s)"
    echo "📝 注册会话: $role (ID: $session_id)"
    # 简化版：直接写入文件
    echo "$session_id|$role|$(date +%H:%M:%S)" >> .kiro/active_sessions.txt
}

status() {
    echo "=== 当前活跃会话 ==="
    if [ -f .kiro/active_sessions.txt ]; then
        cat .kiro/active_sessions.txt
    else
        echo "无活跃会话"
    fi
    echo ""
    echo "=== 当前任务 ==="
    cat .kiro/sessions.json 2>/dev/null | grep -A 5 "current_task" || echo "无任务"
}

lock() {
    local resource="$1"
    echo "🔒 锁定: $resource"
    echo "$resource|$$|$(date +%s)" >> .kiro/locks.txt
}

unlock() {
    local resource="$1"
    echo "🔓 解锁: $resource"
    grep -v "^$resource|" .kiro/locks.txt > .kiro/locks.txt.tmp 2>/dev/null
    mv .kiro/locks.txt.tmp .kiro/locks.txt 2>/dev/null
}

case "$1" in
    register) register "$2" ;;
    status) status ;;
    lock) lock "$2" ;;
    unlock) unlock "$2" ;;
    *) 
        echo "用法: ./scripts/session.sh {register|status|lock|unlock} [参数]"
        echo ""
        echo "示例:"
        echo "  ./scripts/session.sh register 测试窗口"
        echo "  ./scripts/session.sh status"
        echo "  ./scripts/session.sh lock verilator_build"
        ;;
esac
