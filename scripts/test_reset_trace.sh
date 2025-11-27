#!/bin/bash
# 测试 CPU reset 并生成 VCD 波形

echo "🔍 测试 CPU Reset 序列..."
echo ""

# 切换到项目根目录
cd "$(dirname "$0")/.."

# 创建一个简单的测试程序
cat > verilator/test_reset.cpp << 'EOF'
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VNESSystem.h"
#include <iostream>
#include <fstream>

double sc_time_stamp() { return 0; }

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    
    VNESSystem* dut = new VNESSystem;
    VerilatedVcdC* tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);
    tfp->open("reset_trace.vcd");
    
    std::cout << "初始化..." << std::endl;
    
    // 初始化信号
    dut->reset = 0;
    dut->io_romLoadEn = 0;
    dut->io_romLoadPRG = 1;
    dut->io_controller1 = 0;
    dut->io_controller2 = 0;
    
    // 加载简单的测试数据到 ROM
    // 在 0x3FFC (对应 CPU 地址 0xFFFC) 写入 reset vector
    dut->io_romLoadEn = 1;
    
    // 写入 reset vector: 0xC000
    dut->io_romLoadAddr = 0x3FFC;  // ROM 地址
    dut->io_romLoadData = 0x00;    // 低字节
    dut->clock = 0; dut->eval(); tfp->dump(0);
    dut->clock = 1; dut->eval(); tfp->dump(1);
    
    dut->io_romLoadAddr = 0x3FFD;  // ROM 地址
    dut->io_romLoadData = 0xC0;    // 高字节
    dut->clock = 0; dut->eval(); tfp->dump(2);
    dut->clock = 1; dut->eval(); tfp->dump(3);
    
    // 在 0xC000 写入 NOP 指令 (0xEA)
    dut->io_romLoadAddr = 0x4000;  // ROM 地址 (对应 CPU 0xC000)
    dut->io_romLoadData = 0xEA;
    dut->clock = 0; dut->eval(); tfp->dump(4);
    dut->clock = 1; dut->eval(); tfp->dump(5);
    
    dut->io_romLoadEn = 0;
    
    std::cout << "ROM 加载完成" << std::endl;
    std::cout << "  Reset Vector: 0xC000" << std::endl;
    std::cout << "  指令 @ 0xC000: NOP (0xEA)" << std::endl;
    std::cout << "" << std::endl;
    
    // Reset CPU
    std::cout << "执行 Reset..." << std::endl;
    dut->reset = 1;
    for (int i = 0; i < 5; i++) {
        dut->clock = 0; dut->eval(); tfp->dump(10 + i*2);
        dut->clock = 1; dut->eval(); tfp->dump(10 + i*2 + 1);
    }
    
    // 释放 reset
    dut->reset = 0;
    std::cout << "Reset 释放，观察 CPU 行为..." << std::endl;
    
    for (int i = 0; i < 30; i++) {
        dut->clock = 0; dut->eval(); tfp->dump(100 + i*2);
        dut->clock = 1; dut->eval(); tfp->dump(100 + i*2 + 1);
        
        if (i < 20) {
            std::cout << "周期 " << i 
                      << ": state=" << (int)dut->io_debug_state
                      << " cycle=" << (int)dut->io_debug_cycle
                      << " PC=0x" << std::hex << dut->io_debug_regPC << std::dec
                      << std::endl;
        }
    }
    
    tfp->close();
    delete tfp;
    delete dut;
    
    std::cout << "" << std::endl;
    std::cout << "✅ VCD 文件已生成: reset_trace.vcd" << std::endl;
    std::cout << "   使用 GTKWave 查看: gtkwave reset_trace.vcd" << std::endl;
    
    return 0;
}
EOF

# 编译测试程序
echo "编译测试程序..."
g++ -I/opt/homebrew/Cellar/verilator/5.042/share/verilator/include \
    -I/opt/homebrew/Cellar/verilator/5.042/share/verilator/include/vltstd \
    -I build/verilator \
    verilator/test_reset.cpp \
    build/verilator/verilated.o \
    build/verilator/verilated_vcd_c.o \
    build/verilator/verilated_threads.o \
    build/verilator/VNESSystem__ALL.a \
    -o test_reset \
    -std=c++17

if [ $? -eq 0 ]; then
    echo "✅ 编译成功"
    echo ""
    ./test_reset
else
    echo "❌ 编译失败"
    exit 1
fi
