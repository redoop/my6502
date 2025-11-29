#!/bin/bash
# NES Emulator Quick Start Script

cd "$(dirname "$0")"

cd /Users/tongxiaojun/github/my6502/verilator && make -f Makefile.gui clean && make -f Makefile.gui 2>&1 | tail -20
