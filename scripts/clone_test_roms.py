#!/usr/bin/env python3
import subprocess
import os

# 目标目录
target_dir = "games/nes-test-roms"

# 检查是否已存在
if os.path.exists(target_dir):
    print(f"⚠️  {target_dir} 已存在")
    response = input("是否删除并重新克隆? (y/N): ")
    if response.lower() == 'y':
        subprocess.run(["rm", "-rf", target_dir])
    else:
        print("❌ 取消")
        exit(0)

# 克隆
print(f"📦 克隆测试 ROM 到 {target_dir}...")
result = subprocess.run([
    "git", "clone", 
    "git@github.com:christopherpow/nes-test-roms.git",
    target_dir
])

if result.returncode == 0:
    print("✅ 克隆成功！")
    print(f"\n📊 ROM 数量: {len([f for f in os.listdir(target_dir) if os.path.isdir(os.path.join(target_dir, f))])}")
else:
    print("❌ 克隆失败")
    exit(1)
