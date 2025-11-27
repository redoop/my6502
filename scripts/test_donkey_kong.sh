#!/bin/bash
# 快速测试 Donkey Kong

./scripts/verilator_build.sh 2>&1
./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1