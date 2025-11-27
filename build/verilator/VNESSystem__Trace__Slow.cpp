// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VNESSystem__Syms.h"


//======================

void VNESSystem::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, __VlSymsp);
    traceRegister(tfp->spTrace());
}

void VNESSystem::traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    if (!Verilated::calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    VNESSystem::traceInitTop(vlSymsp, tracep);
    tracep->scopeEscape('.');
}

//======================


void VNESSystem::traceInitTop(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceInitSub0(userp, tracep);
    }
}

void VNESSystem::traceInitSub0(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+241,"clock", false,-1);
        tracep->declBit(c+242,"reset", false,-1);
        tracep->declBus(c+243,"io_pixelX", false,-1, 8,0);
        tracep->declBus(c+244,"io_pixelY", false,-1, 8,0);
        tracep->declBus(c+245,"io_pixelColor", false,-1, 5,0);
        tracep->declBit(c+246,"io_vblank", false,-1);
        tracep->declBus(c+247,"io_controller1", false,-1, 7,0);
        tracep->declBus(c+248,"io_controller2", false,-1, 7,0);
        tracep->declBus(c+249,"io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+250,"io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+251,"io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+252,"io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+253,"io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+254,"io_debug_flagC", false,-1);
        tracep->declBit(c+255,"io_debug_flagZ", false,-1);
        tracep->declBit(c+256,"io_debug_flagN", false,-1);
        tracep->declBit(c+257,"io_debug_flagV", false,-1);
        tracep->declBus(c+258,"io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+259,"io_romLoadEn", false,-1);
        tracep->declBus(c+260,"io_romLoadAddr", false,-1, 15,0);
        tracep->declBus(c+261,"io_romLoadData", false,-1, 7,0);
        tracep->declBit(c+262,"io_romLoadPRG", false,-1);
        tracep->declBit(c+241,"NESSystem clock", false,-1);
        tracep->declBit(c+242,"NESSystem reset", false,-1);
        tracep->declBus(c+243,"NESSystem io_pixelX", false,-1, 8,0);
        tracep->declBus(c+244,"NESSystem io_pixelY", false,-1, 8,0);
        tracep->declBus(c+245,"NESSystem io_pixelColor", false,-1, 5,0);
        tracep->declBit(c+246,"NESSystem io_vblank", false,-1);
        tracep->declBus(c+247,"NESSystem io_controller1", false,-1, 7,0);
        tracep->declBus(c+248,"NESSystem io_controller2", false,-1, 7,0);
        tracep->declBus(c+249,"NESSystem io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+250,"NESSystem io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+251,"NESSystem io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+252,"NESSystem io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+253,"NESSystem io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+254,"NESSystem io_debug_flagC", false,-1);
        tracep->declBit(c+255,"NESSystem io_debug_flagZ", false,-1);
        tracep->declBit(c+256,"NESSystem io_debug_flagN", false,-1);
        tracep->declBit(c+257,"NESSystem io_debug_flagV", false,-1);
        tracep->declBus(c+258,"NESSystem io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+259,"NESSystem io_romLoadEn", false,-1);
        tracep->declBus(c+260,"NESSystem io_romLoadAddr", false,-1, 15,0);
        tracep->declBus(c+261,"NESSystem io_romLoadData", false,-1, 7,0);
        tracep->declBit(c+262,"NESSystem io_romLoadPRG", false,-1);
        tracep->declBit(c+241,"NESSystem cpu_clock", false,-1);
        tracep->declBit(c+242,"NESSystem cpu_reset", false,-1);
        tracep->declBus(c+1,"NESSystem cpu_io_memAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem cpu_io_memDataOut", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem cpu_io_memDataIn", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem cpu_io_memWrite", false,-1);
        tracep->declBit(c+3,"NESSystem cpu_io_memRead", false,-1);
        tracep->declBus(c+4,"NESSystem cpu_io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+5,"NESSystem cpu_io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+6,"NESSystem cpu_io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+7,"NESSystem cpu_io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+8,"NESSystem cpu_io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+9,"NESSystem cpu_io_debug_flagC", false,-1);
        tracep->declBit(c+10,"NESSystem cpu_io_debug_flagZ", false,-1);
        tracep->declBit(c+11,"NESSystem cpu_io_debug_flagN", false,-1);
        tracep->declBit(c+12,"NESSystem cpu_io_debug_flagV", false,-1);
        tracep->declBus(c+13,"NESSystem cpu_io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+242,"NESSystem cpu_io_reset", false,-1);
        tracep->declBit(c+241,"NESSystem ppu_clock", false,-1);
        tracep->declBit(c+242,"NESSystem ppu_reset", false,-1);
        tracep->declBus(c+14,"NESSystem ppu_io_cpuAddr", false,-1, 2,0);
        tracep->declBus(c+216,"NESSystem ppu_io_cpuDataIn", false,-1, 7,0);
        tracep->declBus(c+15,"NESSystem ppu_io_cpuDataOut", false,-1, 7,0);
        tracep->declBit(c+16,"NESSystem ppu_io_cpuWrite", false,-1);
        tracep->declBit(c+17,"NESSystem ppu_io_cpuRead", false,-1);
        tracep->declBus(c+18,"NESSystem ppu_io_pixelX", false,-1, 8,0);
        tracep->declBus(c+19,"NESSystem ppu_io_pixelY", false,-1, 8,0);
        tracep->declBit(c+20,"NESSystem ppu_io_vblank", false,-1);
        tracep->declBit(c+241,"NESSystem memory_clock", false,-1);
        tracep->declBus(c+1,"NESSystem memory_io_cpuAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem memory_io_cpuDataIn", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem memory_io_cpuDataOut", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem memory_io_cpuWrite", false,-1);
        tracep->declBit(c+3,"NESSystem memory_io_cpuRead", false,-1);
        tracep->declBus(c+14,"NESSystem memory_io_ppuAddr", false,-1, 2,0);
        tracep->declBus(c+216,"NESSystem memory_io_ppuDataIn", false,-1, 7,0);
        tracep->declBus(c+15,"NESSystem memory_io_ppuDataOut", false,-1, 7,0);
        tracep->declBit(c+16,"NESSystem memory_io_ppuWrite", false,-1);
        tracep->declBit(c+17,"NESSystem memory_io_ppuRead", false,-1);
        tracep->declBus(c+247,"NESSystem memory_io_controller1", false,-1, 7,0);
        tracep->declBus(c+248,"NESSystem memory_io_controller2", false,-1, 7,0);
        tracep->declBit(c+259,"NESSystem memory_io_romLoadEn", false,-1);
        tracep->declBus(c+260,"NESSystem memory_io_romLoadAddr", false,-1, 15,0);
        tracep->declBus(c+261,"NESSystem memory_io_romLoadData", false,-1, 7,0);
        tracep->declBit(c+262,"NESSystem memory_io_romLoadPRG", false,-1);
        tracep->declBit(c+241,"NESSystem cpu clock", false,-1);
        tracep->declBit(c+242,"NESSystem cpu reset", false,-1);
        tracep->declBus(c+1,"NESSystem cpu io_memAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem cpu io_memDataOut", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem cpu io_memDataIn", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem cpu io_memWrite", false,-1);
        tracep->declBit(c+3,"NESSystem cpu io_memRead", false,-1);
        tracep->declBus(c+4,"NESSystem cpu io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+5,"NESSystem cpu io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+6,"NESSystem cpu io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+7,"NESSystem cpu io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+8,"NESSystem cpu io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+9,"NESSystem cpu io_debug_flagC", false,-1);
        tracep->declBit(c+10,"NESSystem cpu io_debug_flagZ", false,-1);
        tracep->declBit(c+11,"NESSystem cpu io_debug_flagN", false,-1);
        tracep->declBit(c+12,"NESSystem cpu io_debug_flagV", false,-1);
        tracep->declBus(c+13,"NESSystem cpu io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+242,"NESSystem cpu io_reset", false,-1);
        tracep->declBit(c+241,"NESSystem cpu core_clock", false,-1);
        tracep->declBit(c+242,"NESSystem cpu core_reset", false,-1);
        tracep->declBus(c+1,"NESSystem cpu core_io_memAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem cpu core_io_memDataOut", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem cpu core_io_memDataIn", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem cpu core_io_memWrite", false,-1);
        tracep->declBit(c+3,"NESSystem cpu core_io_memRead", false,-1);
        tracep->declBus(c+4,"NESSystem cpu core_io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+5,"NESSystem cpu core_io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+6,"NESSystem cpu core_io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+7,"NESSystem cpu core_io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+8,"NESSystem cpu core_io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+9,"NESSystem cpu core_io_debug_flagC", false,-1);
        tracep->declBit(c+10,"NESSystem cpu core_io_debug_flagZ", false,-1);
        tracep->declBit(c+11,"NESSystem cpu core_io_debug_flagN", false,-1);
        tracep->declBit(c+12,"NESSystem cpu core_io_debug_flagV", false,-1);
        tracep->declBus(c+13,"NESSystem cpu core_io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+242,"NESSystem cpu core_io_reset", false,-1);
        tracep->declBit(c+241,"NESSystem cpu core clock", false,-1);
        tracep->declBit(c+242,"NESSystem cpu core reset", false,-1);
        tracep->declBus(c+1,"NESSystem cpu core io_memAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem cpu core io_memDataOut", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem cpu core io_memDataIn", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem cpu core io_memWrite", false,-1);
        tracep->declBit(c+3,"NESSystem cpu core io_memRead", false,-1);
        tracep->declBus(c+4,"NESSystem cpu core io_debug_regA", false,-1, 7,0);
        tracep->declBus(c+5,"NESSystem cpu core io_debug_regX", false,-1, 7,0);
        tracep->declBus(c+6,"NESSystem cpu core io_debug_regY", false,-1, 7,0);
        tracep->declBus(c+7,"NESSystem cpu core io_debug_regPC", false,-1, 15,0);
        tracep->declBus(c+8,"NESSystem cpu core io_debug_regSP", false,-1, 7,0);
        tracep->declBit(c+9,"NESSystem cpu core io_debug_flagC", false,-1);
        tracep->declBit(c+10,"NESSystem cpu core io_debug_flagZ", false,-1);
        tracep->declBit(c+11,"NESSystem cpu core io_debug_flagN", false,-1);
        tracep->declBit(c+12,"NESSystem cpu core io_debug_flagV", false,-1);
        tracep->declBus(c+13,"NESSystem cpu core io_debug_opcode", false,-1, 7,0);
        tracep->declBit(c+242,"NESSystem cpu core io_reset", false,-1);
        tracep->declBus(c+4,"NESSystem cpu core regs_a", false,-1, 7,0);
        tracep->declBus(c+5,"NESSystem cpu core regs_x", false,-1, 7,0);
        tracep->declBus(c+6,"NESSystem cpu core regs_y", false,-1, 7,0);
        tracep->declBus(c+8,"NESSystem cpu core regs_sp", false,-1, 7,0);
        tracep->declBus(c+7,"NESSystem cpu core regs_pc", false,-1, 15,0);
        tracep->declBit(c+9,"NESSystem cpu core regs_flagC", false,-1);
        tracep->declBit(c+10,"NESSystem cpu core regs_flagZ", false,-1);
        tracep->declBit(c+21,"NESSystem cpu core regs_flagI", false,-1);
        tracep->declBit(c+22,"NESSystem cpu core regs_flagD", false,-1);
        tracep->declBit(c+12,"NESSystem cpu core regs_flagV", false,-1);
        tracep->declBit(c+11,"NESSystem cpu core regs_flagN", false,-1);
        tracep->declBus(c+23,"NESSystem cpu core state", false,-1, 1,0);
        tracep->declBus(c+13,"NESSystem cpu core opcode", false,-1, 7,0);
        tracep->declBus(c+24,"NESSystem cpu core operand", false,-1, 15,0);
        tracep->declBus(c+25,"NESSystem cpu core cycle", false,-1, 2,0);
        tracep->declBus(c+217,"NESSystem cpu core resetVector", false,-1, 15,0);
        tracep->declBit(c+26,"NESSystem cpu core execResult_result_newRegs_flagC", false,-1);
        tracep->declBit(c+27,"NESSystem cpu core execResult_result_newRegs_flagD", false,-1);
        tracep->declBit(c+28,"NESSystem cpu core execResult_result_newRegs_flagI", false,-1);
        tracep->declBit(c+29,"NESSystem cpu core execResult_result_newRegs_flagV", false,-1);
        tracep->declBus(c+30,"NESSystem cpu core execResult_result_newRegs_1_x", false,-1, 7,0);
        tracep->declBit(c+31,"NESSystem cpu core execResult_result_newRegs_1_flagN", false,-1);
        tracep->declBit(c+32,"NESSystem cpu core execResult_result_newRegs_1_flagZ", false,-1);
        tracep->declBus(c+33,"NESSystem cpu core execResult_result_newRegs_1_y", false,-1, 7,0);
        tracep->declBus(c+34,"NESSystem cpu core execResult_result_newRegs_1_a", false,-1, 7,0);
        tracep->declBus(c+35,"NESSystem cpu core execResult_result_newRegs_1_sp", false,-1, 7,0);
        tracep->declBus(c+36,"NESSystem cpu core execResult_result_res", false,-1, 7,0);
        tracep->declBus(c+37,"NESSystem cpu core execResult_result_res_1", false,-1, 7,0);
        tracep->declBus(c+38,"NESSystem cpu core execResult_result_res_2", false,-1, 7,0);
        tracep->declBus(c+39,"NESSystem cpu core execResult_result_res_3", false,-1, 7,0);
        tracep->declBus(c+40,"NESSystem cpu core execResult_result_res_4", false,-1, 7,0);
        tracep->declBus(c+41,"NESSystem cpu core execResult_result_res_5", false,-1, 7,0);
        tracep->declBus(c+42,"NESSystem cpu core execResult_result_newRegs_2_x", false,-1, 7,0);
        tracep->declBit(c+43,"NESSystem cpu core execResult_result_newRegs_2_flagN", false,-1);
        tracep->declBit(c+44,"NESSystem cpu core execResult_result_newRegs_2_flagZ", false,-1);
        tracep->declBus(c+45,"NESSystem cpu core execResult_result_newRegs_2_y", false,-1, 7,0);
        tracep->declBus(c+46,"NESSystem cpu core execResult_result_newRegs_2_a", false,-1, 7,0);
        tracep->declBus(c+218,"NESSystem cpu core execResult_result_sum", false,-1, 9,0);
        tracep->declBus(c+219,"NESSystem cpu core execResult_result_newRegs_3_a", false,-1, 7,0);
        tracep->declBit(c+220,"NESSystem cpu core execResult_result_newRegs_3_flagC", false,-1);
        tracep->declBit(c+221,"NESSystem cpu core execResult_result_newRegs_3_flagN", false,-1);
        tracep->declBit(c+222,"NESSystem cpu core execResult_result_newRegs_3_flagZ", false,-1);
        tracep->declBit(c+140,"NESSystem cpu core execResult_result_newRegs_3_flagV", false,-1);
        tracep->declBus(c+223,"NESSystem cpu core execResult_result_diff", false,-1, 9,0);
        tracep->declBus(c+224,"NESSystem cpu core execResult_result_newRegs_4_a", false,-1, 7,0);
        tracep->declBit(c+225,"NESSystem cpu core execResult_result_newRegs_4_flagC", false,-1);
        tracep->declBit(c+226,"NESSystem cpu core execResult_result_newRegs_4_flagN", false,-1);
        tracep->declBit(c+227,"NESSystem cpu core execResult_result_newRegs_4_flagZ", false,-1);
        tracep->declBit(c+141,"NESSystem cpu core execResult_result_newRegs_4_flagV", false,-1);
        tracep->declBus(c+228,"NESSystem cpu core execResult_result_res_6", false,-1, 7,0);
        tracep->declBus(c+47,"NESSystem cpu core execResult_result_newRegs_5_pc", false,-1, 15,0);
        tracep->declBit(c+142,"NESSystem cpu core execResult_result_newRegs_5_flagZ", false,-1);
        tracep->declBit(c+143,"NESSystem cpu core execResult_result_newRegs_5_flagN", false,-1);
        tracep->declBus(c+48,"NESSystem cpu core execResult_result_result_6_memAddr", false,-1, 15,0);
        tracep->declBit(c+49,"NESSystem cpu core execResult_result_result_6_memRead", false,-1);
        tracep->declBus(c+229,"NESSystem cpu core execResult_result_result_6_operand", false,-1, 15,0);
        tracep->declBus(c+50,"NESSystem cpu core execResult_result_result_6_nextCycle", false,-1, 2,0);
        tracep->declBus(c+144,"NESSystem cpu core execResult_result_result_6_memData", false,-1, 7,0);
        tracep->declBit(c+51,"NESSystem cpu core execResult_result_result_6_done", false,-1);
        tracep->declBus(c+230,"NESSystem cpu core execResult_result_res_7", false,-1, 7,0);
        tracep->declBit(c+231,"NESSystem cpu core execResult_result_newRegs_6_flagN", false,-1);
        tracep->declBit(c+232,"NESSystem cpu core execResult_result_newRegs_6_flagZ", false,-1);
        tracep->declBit(c+145,"NESSystem cpu core execResult_result_newRegs_7_flagZ", false,-1);
        tracep->declBit(c+233,"NESSystem cpu core execResult_result_newRegs_7_flagV", false,-1);
        tracep->declBit(c+234,"NESSystem cpu core execResult_result_newRegs_7_flagN", false,-1);
        tracep->declBus(c+52,"NESSystem cpu core execResult_result_result_8_memAddr", false,-1, 15,0);
        tracep->declBus(c+53,"NESSystem cpu core execResult_result_result_8_nextCycle", false,-1, 2,0);
        tracep->declBit(c+54,"NESSystem cpu core execResult_result_result_8_done", false,-1);
        tracep->declBit(c+55,"NESSystem cpu core execResult_result_newRegs_8_flagC", false,-1);
        tracep->declBus(c+56,"NESSystem cpu core execResult_result_res_8", false,-1, 7,0);
        tracep->declBit(c+57,"NESSystem cpu core execResult_result_newRegs_8_flagN", false,-1);
        tracep->declBit(c+58,"NESSystem cpu core execResult_result_newRegs_8_flagZ", false,-1);
        tracep->declBus(c+235,"NESSystem cpu core execResult_result_res_9", false,-1, 7,0);
        tracep->declBit(c+146,"NESSystem cpu core execResult_result_newRegs_9_flagC", false,-1);
        tracep->declBit(c+147,"NESSystem cpu core execResult_result_newRegs_9_flagZ", false,-1);
        tracep->declBit(c+148,"NESSystem cpu core execResult_result_newRegs_9_flagN", false,-1);
        tracep->declBus(c+149,"NESSystem cpu core execResult_result_result_10_memData", false,-1, 7,0);
        tracep->declBus(c+59,"NESSystem cpu core execResult_result_regValue", false,-1, 7,0);
        tracep->declBus(c+150,"NESSystem cpu core execResult_result_diff_1", false,-1, 8,0);
        tracep->declBit(c+151,"NESSystem cpu core execResult_result_newRegs_10_flagC", false,-1);
        tracep->declBit(c+152,"NESSystem cpu core execResult_result_newRegs_10_flagZ", false,-1);
        tracep->declBit(c+153,"NESSystem cpu core execResult_result_newRegs_10_flagN", false,-1);
        tracep->declBit(c+154,"NESSystem cpu core execResult_result_newRegs_11_flagC", false,-1);
        tracep->declBit(c+155,"NESSystem cpu core execResult_result_newRegs_11_flagZ", false,-1);
        tracep->declBit(c+156,"NESSystem cpu core execResult_result_newRegs_11_flagN", false,-1);
        tracep->declBit(c+60,"NESSystem cpu core execResult_result_takeBranch", false,-1);
        tracep->declBus(c+215,"NESSystem cpu core execResult_result_offset", false,-1, 7,0);
        tracep->declBus(c+157,"NESSystem cpu core execResult_result_newRegs_12_pc", false,-1, 15,0);
        tracep->declBus(c+158,"NESSystem cpu core execResult_result_newRegs_13_a", false,-1, 7,0);
        tracep->declBus(c+159,"NESSystem cpu core execResult_result_newRegs_13_x", false,-1, 7,0);
        tracep->declBus(c+160,"NESSystem cpu core execResult_result_newRegs_13_y", false,-1, 7,0);
        tracep->declBit(c+236,"NESSystem cpu core execResult_result_newRegs_13_flagZ", false,-1);
        tracep->declBit(c+61,"NESSystem cpu core execResult_result_isLoad", false,-1);
        tracep->declBit(c+62,"NESSystem cpu core execResult_result_isStoreA", false,-1);
        tracep->declBit(c+63,"NESSystem cpu core execResult_result_isStoreX", false,-1);
        tracep->declBus(c+161,"NESSystem cpu core execResult_result_newRegs_14_a", false,-1, 7,0);
        tracep->declBit(c+162,"NESSystem cpu core execResult_result_newRegs_14_flagZ", false,-1);
        tracep->declBit(c+163,"NESSystem cpu core execResult_result_newRegs_14_flagN", false,-1);
        tracep->declBit(c+64,"NESSystem cpu core execResult_result_result_15_memRead", false,-1);
        tracep->declBit(c+65,"NESSystem cpu core execResult_result_result_15_memWrite", false,-1);
        tracep->declBus(c+66,"NESSystem cpu core execResult_result_result_15_memData", false,-1, 7,0);
        tracep->declBit(c+67,"NESSystem cpu core execResult_result_isLoad_1", false,-1);
        tracep->declBus(c+164,"NESSystem cpu core execResult_result_newRegs_15_a", false,-1, 7,0);
        tracep->declBit(c+165,"NESSystem cpu core execResult_result_newRegs_15_flagZ", false,-1);
        tracep->declBit(c+166,"NESSystem cpu core execResult_result_newRegs_15_flagN", false,-1);
        tracep->declBit(c+68,"NESSystem cpu core execResult_result_result_16_memRead", false,-1);
        tracep->declBus(c+167,"NESSystem cpu core execResult_result_result_16_operand", false,-1, 15,0);
        tracep->declBit(c+69,"NESSystem cpu core execResult_result_result_16_memWrite", false,-1);
        tracep->declBus(c+70,"NESSystem cpu core execResult_result_result_16_memData", false,-1, 7,0);
        tracep->declBit(c+71,"NESSystem cpu core execResult_result_isLoad_2", false,-1);
        tracep->declBus(c+168,"NESSystem cpu core execResult_result_newRegs_16_a", false,-1, 7,0);
        tracep->declBus(c+72,"NESSystem cpu core execResult_result_newRegs_16_pc", false,-1, 15,0);
        tracep->declBit(c+169,"NESSystem cpu core execResult_result_newRegs_16_flagZ", false,-1);
        tracep->declBit(c+170,"NESSystem cpu core execResult_result_newRegs_16_flagN", false,-1);
        tracep->declBus(c+73,"NESSystem cpu core execResult_result_result_17_memAddr", false,-1, 15,0);
        tracep->declBit(c+74,"NESSystem cpu core execResult_result_result_17_memRead", false,-1);
        tracep->declBus(c+237,"NESSystem cpu core execResult_result_result_17_operand", false,-1, 15,0);
        tracep->declBit(c+75,"NESSystem cpu core execResult_result_result_17_memWrite", false,-1);
        tracep->declBus(c+76,"NESSystem cpu core execResult_result_result_17_memData", false,-1, 7,0);
        tracep->declBus(c+77,"NESSystem cpu core execResult_result_indexReg", false,-1, 7,0);
        tracep->declBus(c+171,"NESSystem cpu core execResult_result_newRegs_17_a", false,-1, 7,0);
        tracep->declBit(c+172,"NESSystem cpu core execResult_result_newRegs_17_flagZ", false,-1);
        tracep->declBit(c+173,"NESSystem cpu core execResult_result_newRegs_17_flagN", false,-1);
        tracep->declBit(c+78,"NESSystem cpu core execResult_result_result_18_memRead", false,-1);
        tracep->declBus(c+174,"NESSystem cpu core execResult_result_result_18_operand", false,-1, 15,0);
        tracep->declBus(c+79,"NESSystem cpu core execResult_result_pushData", false,-1, 7,0);
        tracep->declBus(c+80,"NESSystem cpu core execResult_result_newRegs_18_sp", false,-1, 7,0);
        tracep->declBus(c+81,"NESSystem cpu core execResult_result_result_19_memAddr", false,-1, 15,0);
        tracep->declBus(c+175,"NESSystem cpu core execResult_result_newRegs_19_a", false,-1, 7,0);
        tracep->declBus(c+82,"NESSystem cpu core execResult_result_newRegs_19_sp", false,-1, 7,0);
        tracep->declBit(c+176,"NESSystem cpu core execResult_result_newRegs_19_flagC", false,-1);
        tracep->declBit(c+177,"NESSystem cpu core execResult_result_newRegs_19_flagZ", false,-1);
        tracep->declBit(c+178,"NESSystem cpu core execResult_result_newRegs_19_flagI", false,-1);
        tracep->declBit(c+179,"NESSystem cpu core execResult_result_newRegs_19_flagD", false,-1);
        tracep->declBit(c+180,"NESSystem cpu core execResult_result_newRegs_19_flagV", false,-1);
        tracep->declBit(c+181,"NESSystem cpu core execResult_result_newRegs_19_flagN", false,-1);
        tracep->declBus(c+83,"NESSystem cpu core execResult_result_result_20_memAddr", false,-1, 15,0);
        tracep->declBus(c+182,"NESSystem cpu core execResult_result_newRegs_20_pc", false,-1, 15,0);
        tracep->declBus(c+84,"NESSystem cpu core execResult_result_result_21_memAddr", false,-1, 15,0);
        tracep->declBus(c+85,"NESSystem cpu core execResult_result_newRegs_21_sp", false,-1, 7,0);
        tracep->declBus(c+86,"NESSystem cpu core execResult_result_newRegs_21_pc", false,-1, 15,0);
        tracep->declBus(c+87,"NESSystem cpu core execResult_result_result_22_memAddr", false,-1, 15,0);
        tracep->declBus(c+88,"NESSystem cpu core execResult_result_result_22_nextCycle", false,-1, 2,0);
        tracep->declBus(c+89,"NESSystem cpu core execResult_result_result_22_memData", false,-1, 7,0);
        tracep->declBit(c+90,"NESSystem cpu core execResult_result_result_22_memWrite", false,-1);
        tracep->declBit(c+91,"NESSystem cpu core execResult_result_result_22_done", false,-1);
        tracep->declBus(c+92,"NESSystem cpu core execResult_result_newRegs_22_sp", false,-1, 7,0);
        tracep->declBus(c+183,"NESSystem cpu core execResult_result_newRegs_22_pc", false,-1, 15,0);
        tracep->declBus(c+93,"NESSystem cpu core execResult_result_result_23_memAddr", false,-1, 15,0);
        tracep->declBit(c+94,"NESSystem cpu core execResult_result_result_23_memRead", false,-1);
        tracep->declBus(c+184,"NESSystem cpu core execResult_result_result_23_operand", false,-1, 15,0);
        tracep->declBus(c+95,"NESSystem cpu core execResult_result_newRegs_23_sp", false,-1, 7,0);
        tracep->declBus(c+185,"NESSystem cpu core execResult_result_newRegs_23_pc", false,-1, 15,0);
        tracep->declBit(c+96,"NESSystem cpu core execResult_result_newRegs_23_flagI", false,-1);
        tracep->declBus(c+97,"NESSystem cpu core execResult_result_result_24_nextCycle", false,-1, 2,0);
        tracep->declBus(c+98,"NESSystem cpu core execResult_result_result_24_memAddr", false,-1, 15,0);
        tracep->declBus(c+99,"NESSystem cpu core execResult_result_result_24_memData", false,-1, 7,0);
        tracep->declBit(c+100,"NESSystem cpu core execResult_result_result_24_memWrite", false,-1);
        tracep->declBit(c+101,"NESSystem cpu core execResult_result_result_24_memRead", false,-1);
        tracep->declBus(c+186,"NESSystem cpu core execResult_result_result_24_operand", false,-1, 15,0);
        tracep->declBit(c+102,"NESSystem cpu core execResult_result_result_24_done", false,-1);
        tracep->declBus(c+103,"NESSystem cpu core execResult_result_newRegs_24_sp", false,-1, 7,0);
        tracep->declBus(c+187,"NESSystem cpu core execResult_result_newRegs_24_pc", false,-1, 15,0);
        tracep->declBit(c+188,"NESSystem cpu core execResult_result_newRegs_24_flagC", false,-1);
        tracep->declBit(c+189,"NESSystem cpu core execResult_result_newRegs_24_flagZ", false,-1);
        tracep->declBit(c+190,"NESSystem cpu core execResult_result_newRegs_24_flagI", false,-1);
        tracep->declBit(c+191,"NESSystem cpu core execResult_result_newRegs_24_flagD", false,-1);
        tracep->declBus(c+104,"NESSystem cpu core execResult_result_result_25_memAddr", false,-1, 15,0);
        tracep->declBus(c+192,"NESSystem cpu core execResult_result_result_25_operand", false,-1, 15,0);
        tracep->declBit(c+105,"NESSystem cpu core execResult_result_1_done", false,-1);
        tracep->declBus(c+106,"NESSystem cpu core execResult_result_1_nextCycle", false,-1, 2,0);
        tracep->declBus(c+193,"NESSystem cpu core execResult_result_1_regs_a", false,-1, 7,0);
        tracep->declBus(c+194,"NESSystem cpu core execResult_result_1_regs_x", false,-1, 7,0);
        tracep->declBus(c+195,"NESSystem cpu core execResult_result_1_regs_y", false,-1, 7,0);
        tracep->declBus(c+107,"NESSystem cpu core execResult_result_1_regs_sp", false,-1, 7,0);
        tracep->declBus(c+196,"NESSystem cpu core execResult_result_1_regs_pc", false,-1, 15,0);
        tracep->declBit(c+197,"NESSystem cpu core execResult_result_1_regs_flagC", false,-1);
        tracep->declBit(c+198,"NESSystem cpu core execResult_result_1_regs_flagZ", false,-1);
        tracep->declBit(c+199,"NESSystem cpu core execResult_result_1_regs_flagI", false,-1);
        tracep->declBit(c+238,"NESSystem cpu core execResult_result_1_regs_flagD", false,-1);
        tracep->declBit(c+200,"NESSystem cpu core execResult_result_1_regs_flagV", false,-1);
        tracep->declBit(c+201,"NESSystem cpu core execResult_result_1_regs_flagN", false,-1);
        tracep->declBus(c+108,"NESSystem cpu core execResult_result_1_memAddr", false,-1, 15,0);
        tracep->declBus(c+239,"NESSystem cpu core execResult_result_1_memData", false,-1, 7,0);
        tracep->declBit(c+109,"NESSystem cpu core execResult_result_1_memWrite", false,-1);
        tracep->declBit(c+110,"NESSystem cpu core execResult_result_1_memRead", false,-1);
        tracep->declBus(c+202,"NESSystem cpu core execResult_result_1_operand", false,-1, 15,0);
        tracep->declBit(c+111,"NESSystem cpu core execResult_done", false,-1);
        tracep->declBus(c+112,"NESSystem cpu core execResult_nextCycle", false,-1, 2,0);
        tracep->declBus(c+113,"NESSystem cpu core execResult_memAddr", false,-1, 15,0);
        tracep->declBus(c+203,"NESSystem cpu core execResult_memData", false,-1, 7,0);
        tracep->declBit(c+114,"NESSystem cpu core execResult_memWrite", false,-1);
        tracep->declBit(c+115,"NESSystem cpu core execResult_memRead", false,-1);
        tracep->declBus(c+204,"NESSystem cpu core execResult_regs_a", false,-1, 7,0);
        tracep->declBus(c+205,"NESSystem cpu core execResult_regs_x", false,-1, 7,0);
        tracep->declBus(c+206,"NESSystem cpu core execResult_regs_y", false,-1, 7,0);
        tracep->declBus(c+116,"NESSystem cpu core execResult_regs_sp", false,-1, 7,0);
        tracep->declBus(c+207,"NESSystem cpu core execResult_regs_pc", false,-1, 15,0);
        tracep->declBit(c+208,"NESSystem cpu core execResult_regs_flagC", false,-1);
        tracep->declBit(c+240,"NESSystem cpu core execResult_regs_flagZ", false,-1);
        tracep->declBit(c+209,"NESSystem cpu core execResult_regs_flagI", false,-1);
        tracep->declBit(c+210,"NESSystem cpu core execResult_regs_flagD", false,-1);
        tracep->declBit(c+211,"NESSystem cpu core execResult_regs_flagV", false,-1);
        tracep->declBit(c+212,"NESSystem cpu core execResult_regs_flagN", false,-1);
        tracep->declBus(c+213,"NESSystem cpu core execResult_operand", false,-1, 15,0);
        tracep->declBit(c+241,"NESSystem ppu clock", false,-1);
        tracep->declBit(c+242,"NESSystem ppu reset", false,-1);
        tracep->declBus(c+14,"NESSystem ppu io_cpuAddr", false,-1, 2,0);
        tracep->declBus(c+216,"NESSystem ppu io_cpuDataIn", false,-1, 7,0);
        tracep->declBus(c+15,"NESSystem ppu io_cpuDataOut", false,-1, 7,0);
        tracep->declBit(c+16,"NESSystem ppu io_cpuWrite", false,-1);
        tracep->declBit(c+17,"NESSystem ppu io_cpuRead", false,-1);
        tracep->declBus(c+18,"NESSystem ppu io_pixelX", false,-1, 8,0);
        tracep->declBus(c+19,"NESSystem ppu io_pixelY", false,-1, 8,0);
        tracep->declBit(c+20,"NESSystem ppu io_vblank", false,-1);
        tracep->declBit(c+117,"NESSystem ppu vram_io_cpuDataOut_MPORT_1_en", false,-1);
        tracep->declBus(c+118,"NESSystem ppu vram_io_cpuDataOut_MPORT_1_addr", false,-1, 10,0);
        tracep->declBus(c+119,"NESSystem ppu vram_io_cpuDataOut_MPORT_1_data", false,-1, 7,0);
        tracep->declBus(c+216,"NESSystem ppu vram_MPORT_1_data", false,-1, 7,0);
        tracep->declBus(c+120,"NESSystem ppu vram_MPORT_1_addr", false,-1, 10,0);
        tracep->declBit(c+265,"NESSystem ppu vram_MPORT_1_mask", false,-1);
        tracep->declBit(c+121,"NESSystem ppu vram_MPORT_1_en", false,-1);
        tracep->declBit(c+117,"NESSystem ppu vram_io_cpuDataOut_MPORT_1_en_pipe_0", false,-1);
        tracep->declBus(c+118,"NESSystem ppu vram_io_cpuDataOut_MPORT_1_addr_pipe_0", false,-1, 10,0);
        tracep->declBit(c+122,"NESSystem ppu oam_io_cpuDataOut_MPORT_en", false,-1);
        tracep->declBus(c+123,"NESSystem ppu oam_io_cpuDataOut_MPORT_addr", false,-1, 7,0);
        tracep->declBus(c+124,"NESSystem ppu oam_io_cpuDataOut_MPORT_data", false,-1, 7,0);
        tracep->declBus(c+216,"NESSystem ppu oam_MPORT_data", false,-1, 7,0);
        tracep->declBus(c+125,"NESSystem ppu oam_MPORT_addr", false,-1, 7,0);
        tracep->declBit(c+265,"NESSystem ppu oam_MPORT_mask", false,-1);
        tracep->declBit(c+126,"NESSystem ppu oam_MPORT_en", false,-1);
        tracep->declBit(c+122,"NESSystem ppu oam_io_cpuDataOut_MPORT_en_pipe_0", false,-1);
        tracep->declBus(c+123,"NESSystem ppu oam_io_cpuDataOut_MPORT_addr_pipe_0", false,-1, 7,0);
        tracep->declBus(c+125,"NESSystem ppu oamAddr", false,-1, 7,0);
        tracep->declBit(c+127,"NESSystem ppu ppuAddrLatch", false,-1);
        tracep->declBus(c+128,"NESSystem ppu ppuAddrReg", false,-1, 15,0);
        tracep->declBus(c+18,"NESSystem ppu scanlineX", false,-1, 8,0);
        tracep->declBus(c+19,"NESSystem ppu scanlineY", false,-1, 8,0);
        tracep->declBit(c+20,"NESSystem ppu vblankFlag", false,-1);
        tracep->declBit(c+241,"NESSystem memory clock", false,-1);
        tracep->declBus(c+1,"NESSystem memory io_cpuAddr", false,-1, 15,0);
        tracep->declBus(c+214,"NESSystem memory io_cpuDataIn", false,-1, 7,0);
        tracep->declBus(c+215,"NESSystem memory io_cpuDataOut", false,-1, 7,0);
        tracep->declBit(c+2,"NESSystem memory io_cpuWrite", false,-1);
        tracep->declBit(c+3,"NESSystem memory io_cpuRead", false,-1);
        tracep->declBus(c+14,"NESSystem memory io_ppuAddr", false,-1, 2,0);
        tracep->declBus(c+216,"NESSystem memory io_ppuDataIn", false,-1, 7,0);
        tracep->declBus(c+15,"NESSystem memory io_ppuDataOut", false,-1, 7,0);
        tracep->declBit(c+16,"NESSystem memory io_ppuWrite", false,-1);
        tracep->declBit(c+17,"NESSystem memory io_ppuRead", false,-1);
        tracep->declBus(c+247,"NESSystem memory io_controller1", false,-1, 7,0);
        tracep->declBus(c+248,"NESSystem memory io_controller2", false,-1, 7,0);
        tracep->declBit(c+259,"NESSystem memory io_romLoadEn", false,-1);
        tracep->declBus(c+260,"NESSystem memory io_romLoadAddr", false,-1, 15,0);
        tracep->declBus(c+261,"NESSystem memory io_romLoadData", false,-1, 7,0);
        tracep->declBit(c+262,"NESSystem memory io_romLoadPRG", false,-1);
        tracep->declBit(c+129,"NESSystem memory internalRAM_io_cpuDataOut_MPORT_en", false,-1);
        tracep->declBus(c+130,"NESSystem memory internalRAM_io_cpuDataOut_MPORT_addr", false,-1, 10,0);
        tracep->declBus(c+131,"NESSystem memory internalRAM_io_cpuDataOut_MPORT_data", false,-1, 7,0);
        tracep->declBus(c+214,"NESSystem memory internalRAM_MPORT_data", false,-1, 7,0);
        tracep->declBus(c+132,"NESSystem memory internalRAM_MPORT_addr", false,-1, 10,0);
        tracep->declBit(c+265,"NESSystem memory internalRAM_MPORT_mask", false,-1);
        tracep->declBit(c+133,"NESSystem memory internalRAM_MPORT_en", false,-1);
        tracep->declBit(c+129,"NESSystem memory internalRAM_io_cpuDataOut_MPORT_en_pipe_0", false,-1);
        tracep->declBus(c+130,"NESSystem memory internalRAM_io_cpuDataOut_MPORT_addr_pipe_0", false,-1, 10,0);
        tracep->declBit(c+134,"NESSystem memory prgROM_io_cpuDataOut_MPORT_1_en", false,-1);
        tracep->declBus(c+135,"NESSystem memory prgROM_io_cpuDataOut_MPORT_1_addr", false,-1, 14,0);
        tracep->declBus(c+136,"NESSystem memory prgROM_io_cpuDataOut_MPORT_1_data", false,-1, 7,0);
        tracep->declBus(c+214,"NESSystem memory prgROM_MPORT_1_data", false,-1, 7,0);
        tracep->declBus(c+137,"NESSystem memory prgROM_MPORT_1_addr", false,-1, 14,0);
        tracep->declBit(c+265,"NESSystem memory prgROM_MPORT_1_mask", false,-1);
        tracep->declBit(c+138,"NESSystem memory prgROM_MPORT_1_en", false,-1);
        tracep->declBus(c+261,"NESSystem memory prgROM_MPORT_2_data", false,-1, 7,0);
        tracep->declBus(c+263,"NESSystem memory prgROM_MPORT_2_addr", false,-1, 14,0);
        tracep->declBit(c+265,"NESSystem memory prgROM_MPORT_2_mask", false,-1);
        tracep->declBit(c+264,"NESSystem memory prgROM_MPORT_2_en", false,-1);
        tracep->declBit(c+134,"NESSystem memory prgROM_io_cpuDataOut_MPORT_1_en_pipe_0", false,-1);
        tracep->declBus(c+135,"NESSystem memory prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0", false,-1, 14,0);
        tracep->declBus(c+139,"NESSystem memory romAddr", false,-1, 15,0);
    }
}

void VNESSystem::traceRegister(VerilatedVcd* tracep) {
    // Body
    {
        tracep->addFullCb(&traceFullTop0, __VlSymsp);
        tracep->addChgCb(&traceChgTop0, __VlSymsp);
        tracep->addCleanupCb(&traceCleanup, __VlSymsp);
    }
}

void VNESSystem::traceFullTop0(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceFullSub0(userp, tracep);
    }
}

void VNESSystem::traceFullSub0(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullSData(oldp+1,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr),16);
        tracep->fullBit(oldp+2,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite));
        tracep->fullBit(oldp+3,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead));
        tracep->fullCData(oldp+4,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a),8);
        tracep->fullCData(oldp+5,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x),8);
        tracep->fullCData(oldp+6,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y),8);
        tracep->fullSData(oldp+7,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc),16);
        tracep->fullCData(oldp+8,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp),8);
        tracep->fullBit(oldp+9,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC));
        tracep->fullBit(oldp+10,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ));
        tracep->fullBit(oldp+11,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN));
        tracep->fullBit(oldp+12,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV));
        tracep->fullCData(oldp+13,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode),8);
        tracep->fullCData(oldp+14,(vlTOPp->NESSystem__DOT__memory_io_ppuAddr),3);
        tracep->fullCData(oldp+15,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead)
                                     ? ((2U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                         ? ((IData)(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag) 
                                            << 7U) : 
                                        ((4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                          ? vlTOPp->NESSystem__DOT__ppu__DOT__oam
                                         [vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0]
                                          : ((7U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                              ? vlTOPp->NESSystem__DOT__ppu__DOT__vram
                                             [vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0]
                                              : 0U)))
                                     : 0U)),8);
        tracep->fullBit(oldp+16,(vlTOPp->NESSystem__DOT__memory_io_ppuWrite));
        tracep->fullBit(oldp+17,(vlTOPp->NESSystem__DOT__memory_io_ppuRead));
        tracep->fullSData(oldp+18,(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX),9);
        tracep->fullSData(oldp+19,(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY),9);
        tracep->fullBit(oldp+20,(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag));
        tracep->fullBit(oldp+21,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI));
        tracep->fullBit(oldp+22,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD));
        tracep->fullCData(oldp+23,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state),2);
        tracep->fullSData(oldp+24,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand),16);
        tracep->fullCData(oldp+25,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle),3);
        tracep->fullBit(oldp+26,(((0x18U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  & ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
        tracep->fullBit(oldp+27,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                   : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                       : ((0xd8U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          & ((0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))))));
        tracep->fullBit(oldp+28,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                   : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                       : ((0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                           : ((0xf8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                               : ((0x58U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  & ((0x78U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))));
        tracep->fullBit(oldp+29,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                   : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                       : ((0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                           : ((0xf8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                               : ((0x58U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                   : 
                                                  ((0x78U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0xb8U 
                                                     != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))));
        tracep->fullCData(oldp+30,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                     : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                         : ((0x8aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                             : ((0x98U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                 : 
                                                ((0xbaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))))),8);
        tracep->fullBit(oldp+31,((1U & ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                            >> 7U) : 
                                        ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                             >> 7U)
                                          : ((0x8aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                 >> 7U)
                                              : ((0x98U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                  >> 7U)
                                                  : 
                                                 ((0xbaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                   >> 7U)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))))));
        tracep->fullBit(oldp+32,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                   : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                       : ((0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                           : ((0x98U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                               : ((0xbaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))));
        tracep->fullCData(oldp+33,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                     : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))),8);
        tracep->fullCData(oldp+34,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                     : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((0x8aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                             : ((0x98U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))),8);
        tracep->fullCData(oldp+35,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                     : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                         : ((0x8aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                             : ((0x98U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                 : 
                                                ((0xbaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                  : 
                                                 ((0x9aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))))),8);
        tracep->fullCData(oldp+36,((0xffU & ((IData)(1U) 
                                             + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))),8);
        tracep->fullCData(oldp+37,((0xffU & ((IData)(1U) 
                                             + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))),8);
        tracep->fullCData(oldp+38,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                             - (IData)(1U)))),8);
        tracep->fullCData(oldp+39,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                             - (IData)(1U)))),8);
        tracep->fullCData(oldp+40,((0xffU & ((IData)(1U) 
                                             + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
        tracep->fullCData(oldp+41,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                             - (IData)(1U)))),8);
        tracep->fullCData(oldp+42,((0xffU & ((0xe8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                              : ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                   - (IData)(1U))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))))),8);
        tracep->fullBit(oldp+43,((1U & ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (1U & (((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)) 
                                                  >> 7U))
                                         : ((0xc8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (1U 
                                                & (((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)) 
                                                   >> 7U))
                                             : ((0xcaU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? 
                                                (1U 
                                                 & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                     - (IData)(1U)) 
                                                    >> 7U))
                                                 : 
                                                ((0x88U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (1U 
                                                  & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                      - (IData)(1U)) 
                                                     >> 7U))
                                                  : 
                                                 ((0x1aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (1U 
                                                   & (((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)) 
                                                      >> 7U))
                                                   : 
                                                  ((0x3aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (1U 
                                                    & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                        - (IData)(1U)) 
                                                       >> 7U))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))))))));
        tracep->fullBit(oldp+44,(((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (0U == (0xffU 
                                             & ((IData)(1U) 
                                                + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))
                                   : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (0U == (0xffU 
                                                 & ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                       : ((0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (0U == 
                                              (0xffU 
                                               & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                  - (IData)(1U))))
                                           : ((0x88U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (0U 
                                                  == 
                                                  (0xffU 
                                                   & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                      - (IData)(1U))))
                                               : ((0x1aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == 
                                                   (0xffU 
                                                    & ((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))
                                                   : 
                                                  ((0x3aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (0U 
                                                    == 
                                                    (0xffU 
                                                     & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                        - (IData)(1U))))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))))))));
        tracep->fullCData(oldp+45,((0xffU & ((0xe8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                              : ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                   : 
                                                  ((0x88U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                    - (IData)(1U))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))))),8);
        tracep->fullCData(oldp+46,((0xffU & ((0xe8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                              : ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                   : 
                                                  ((0x88U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                    : 
                                                   ((0x1aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                     : 
                                                    ((0x3aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                      - (IData)(1U))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))))))),8);
        tracep->fullSData(oldp+47,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc),16);
        tracep->fullSData(oldp+48,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr),16);
        tracep->fullBit(oldp+49,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead));
        tracep->fullCData(oldp+50,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle),3);
        tracep->fullBit(oldp+51,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done));
        tracep->fullSData(oldp+52,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr),16);
        tracep->fullCData(oldp+53,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle),3);
        tracep->fullBit(oldp+54,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done));
        tracep->fullBit(oldp+55,((1U & ((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                            >> 7U) : 
                                        ((0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                          : ((0x2aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                 >> 7U)
                                              : ((0x6aU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))))));
        tracep->fullCData(oldp+56,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8),8);
        tracep->fullBit(oldp+57,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8) 
                                        >> 7U))));
        tracep->fullBit(oldp+58,((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8))));
        tracep->fullCData(oldp+59,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue),8);
        tracep->fullBit(oldp+60,((1U & ((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                         : ((0xd0U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                             : ((0xb0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                 : 
                                                ((0x90U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                                  : 
                                                 ((0x30U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                   : 
                                                  ((0x10U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                    : 
                                                   ((0x70U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                     : 
                                                    ((0x50U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     & (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))))))))))));
        tracep->fullBit(oldp+61,((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
        tracep->fullBit(oldp+62,((0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
        tracep->fullBit(oldp+63,((0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
        tracep->fullBit(oldp+64,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
        tracep->fullBit(oldp+65,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (0xa5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
        tracep->fullCData(oldp+66,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0xa5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 0U
                                                  : 
                                                 ((0x85U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                   : 
                                                  ((0x86U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                              : 0U))),8);
        tracep->fullBit(oldp+67,((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
        tracep->fullBit(oldp+68,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
        tracep->fullBit(oldp+69,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (0xb5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
        tracep->fullCData(oldp+70,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0xb5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 0U
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                              : 0U))),8);
        tracep->fullBit(oldp+71,((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
        tracep->fullSData(oldp+72,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc),16);
        tracep->fullSData(oldp+73,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr),16);
        tracep->fullBit(oldp+74,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     | ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))));
        tracep->fullBit(oldp+75,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xadU != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))));
        tracep->fullCData(oldp+76,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? 0U : 
                                             ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? ((0xadU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 0U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                               : 0U)))),8);
        tracep->fullCData(oldp+77,(((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))),8);
        tracep->fullBit(oldp+78,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))));
        tracep->fullCData(oldp+79,(((8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T)
                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))),8);
        tracep->fullCData(oldp+80,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                             - (IData)(1U)))),8);
        tracep->fullSData(oldp+81,((0x100U | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))),16);
        tracep->fullCData(oldp+82,((0xffU & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))),8);
        tracep->fullSData(oldp+83,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                              : 0U))),16);
        tracep->fullSData(oldp+84,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                     : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                         : 0U))),16);
        tracep->fullCData(oldp+85,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                     : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647)))),8);
        tracep->fullSData(oldp+86,((0xffffU & ((0U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                ? ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                : (
                                                   (1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                    : 
                                                   ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((3U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))))),16);
        tracep->fullSData(oldp+87,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                     : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))),16);
        tracep->fullCData(oldp+88,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle),3);
        tracep->fullCData(oldp+89,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? 0U : 
                                             (0xffU 
                                              & ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                  >> 8U)
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : 0U)))))),8);
        tracep->fullBit(oldp+90,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_646)))));
        tracep->fullBit(oldp+91,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done));
        tracep->fullCData(oldp+92,((0xffU & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                              : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))))),8);
        tracep->fullSData(oldp+93,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : 0U)))),16);
        tracep->fullBit(oldp+94,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                  & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))));
        tracep->fullCData(oldp+95,((0xffU & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                              : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                  - (IData)(1U))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647))))),8);
        tracep->fullBit(oldp+96,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                   : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                       : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                           : ((3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                              | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))));
        tracep->fullCData(oldp+97,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 1U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? 2U : 
                                             ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? 3U
                                               : ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 4U
                                                   : 
                                                  ((4U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 5U
                                                    : 
                                                   (7U 
                                                    & ((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))))))))),3);
        tracep->fullSData(oldp+98,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  (0x100U 
                                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : 
                                                  ((4U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 0xfffeU
                                                    : 
                                                   ((5U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 0xffffU
                                                     : 0U))))))),16);
        tracep->fullCData(oldp+99,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                     ? 0U : (0xffU 
                                             & ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                 >> 8U)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T)
                                                   : 0U)))))),8);
        tracep->fullBit(oldp+100,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite));
        tracep->fullBit(oldp+101,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                   & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                      & ((2U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                         & ((3U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                            & ((4U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                               | (5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))));
        tracep->fullBit(oldp+102,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                   & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                      & ((2U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                         & ((3U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                            & ((4U 
                                                != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                               & (5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))));
        tracep->fullCData(oldp+103,((0xffU & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                               : ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : 
                                                  ((2U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))),8);
        tracep->fullSData(oldp+104,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))),16);
        tracep->fullBit(oldp+105,((((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x38U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           | (0xa8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x8aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (((((((0xe8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0xc8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xcaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x88U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x1aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x3aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | ((0x69U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | ((0xe9U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (((0xe6U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0xc6U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1309)))))))));
        tracep->fullCData(oldp+106,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle),3);
        tracep->fullCData(oldp+107,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409))),8);
        tracep->fullSData(oldp+108,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? 0U : ((((((
                                                   (0xaaU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0xa8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x8aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xbaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x9aU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                               ? 0U
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399)))),16);
        tracep->fullBit(oldp+109,(((~ ((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                   & ((~ ((((((0xaaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0xa8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x98U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xbaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x9aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                      & ((~ ((((((0xe8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0xc8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x88U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x1aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x3aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                         & ((0x69U 
                                             != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            & ((0xe9U 
                                                != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               & (((0xe6U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0xc6U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1325)))))))));
        tracep->fullBit(oldp+110,(((~ ((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                   & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421))));
        tracep->fullBit(oldp+111,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_done));
        tracep->fullCData(oldp+112,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle)
                                                   : 0U)))),3);
        tracep->fullSData(oldp+113,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? 
                                                  (((((((((0x18U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                          | (0x38U 
                                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                         | (0xd8U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xf8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x58U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x78U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xb8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xeaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 0U
                                                    : 
                                                   (((((((0xaaU 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0xa8U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0x8aU 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x98U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xbaU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x9aU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                     ? 0U
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399)))
                                                   : 0U)))),16);
        tracep->fullBit(oldp+114,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                   & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                      & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1460)))));
        tracep->fullBit(oldp+115,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                   & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                      & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                         & ((~ ((((
                                                   ((((0x18U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0x38U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xd8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x58U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x78U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0xb8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xeaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                            & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421)))))));
        tracep->fullCData(oldp+116,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))))),8);
        tracep->fullBit(oldp+117,(vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_en_pipe_0));
        tracep->fullSData(oldp+118,(vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0),11);
        tracep->fullCData(oldp+119,(vlTOPp->NESSystem__DOT__ppu__DOT__vram
                                    [vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0]),8);
        tracep->fullSData(oldp+120,((0x7ffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg))),11);
        tracep->fullBit(oldp+121,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
                                   & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                         & ((3U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                            & ((4U 
                                                != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                               & ((5U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                  & ((6U 
                                                      != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                     & (7U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)))))))))));
        tracep->fullBit(oldp+122,(vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_en_pipe_0));
        tracep->fullCData(oldp+123,(vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0),8);
        tracep->fullCData(oldp+124,(vlTOPp->NESSystem__DOT__ppu__DOT__oam
                                    [vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0]),8);
        tracep->fullCData(oldp+125,(vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr),8);
        tracep->fullBit(oldp+126,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
                                   & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                         & ((3U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                            & (4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))))))));
        tracep->fullBit(oldp+127,(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch));
        tracep->fullSData(oldp+128,(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg),16);
        tracep->fullBit(oldp+129,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_en_pipe_0));
        tracep->fullSData(oldp+130,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0),11);
        tracep->fullCData(oldp+131,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM
                                    [vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0]),8);
        tracep->fullSData(oldp+132,((0x7ffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))),11);
        tracep->fullBit(oldp+133,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
                                   & (0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))));
        tracep->fullBit(oldp+134,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_en_pipe_0));
        tracep->fullSData(oldp+135,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0),15);
        tracep->fullCData(oldp+136,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM
                                    [vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0]),8);
        tracep->fullSData(oldp+137,((0x7fffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))),15);
        tracep->fullBit(oldp+138,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
                                   & ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                                      & ((~ (IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3)) 
                                         & (0x8000U 
                                            <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))))));
        tracep->fullSData(oldp+139,((0xffffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr) 
                                                - (IData)(0x8000U)))),16);
        tracep->fullBit(oldp+140,((((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                           >> 7U)) 
                                    == (1U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                                >> 7U))))));
        tracep->fullBit(oldp+141,((((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                           >> 7U)) 
                                    != (1U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                                >> 7U))))));
        tracep->fullBit(oldp+142,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+143,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
        tracep->fullCData(oldp+144,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6)
                                                   : 0U)))),8);
        tracep->fullBit(oldp+145,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
        tracep->fullBit(oldp+146,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((6U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 7U)
                                                   : 
                                                  ((0x46U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                    : 
                                                   ((0x26U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                     >> 7U)
                                                     : 
                                                    ((0x66U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))));
        tracep->fullBit(oldp+147,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+148,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
        tracep->fullCData(oldp+149,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9)
                                                   : 0U)))),8);
        tracep->fullSData(oldp+150,((0x1ffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                               - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)))),9);
        tracep->fullBit(oldp+151,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                   >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
        tracep->fullBit(oldp+152,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                   == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
        tracep->fullBit(oldp+153,((1U & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                          - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)) 
                                         >> 7U))));
        tracep->fullBit(oldp+154,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                           >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
        tracep->fullBit(oldp+155,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                           == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
        tracep->fullBit(oldp+156,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T) 
                                                 >> 7U)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
        tracep->fullSData(oldp+157,((0xffffU & ((1U 
                                                 & ((0xf0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                                     : 
                                                    ((0xd0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                                      : 
                                                     ((0xb0U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                       : 
                                                      ((0x90U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                        ? 
                                                       (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                                        : 
                                                       ((0x30U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                         : 
                                                        ((0x10U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                          ? 
                                                         (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                          : 
                                                         ((0x70U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                           : 
                                                          ((0x50U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                           & (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))))))))))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                 + 
                                                 ((0xff00U 
                                                   & ((- (IData)(
                                                                 (1U 
                                                                  & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                                     >> 7U)))) 
                                                      << 8U)) 
                                                  | (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))),16);
        tracep->fullCData(oldp+158,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))),8);
        tracep->fullCData(oldp+159,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                      : ((0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))),8);
        tracep->fullCData(oldp+160,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                      : ((0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                          : ((0xa0U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))),8);
        tracep->fullCData(oldp+161,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? ((0xa5U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
        tracep->fullBit(oldp+162,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? ((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
        tracep->fullBit(oldp+163,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0xa5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
        tracep->fullCData(oldp+164,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? ((0xb5U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
        tracep->fullBit(oldp+165,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? ((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
        tracep->fullBit(oldp+166,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0xb5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
        tracep->fullSData(oldp+167,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (0xffU & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))),16);
        tracep->fullCData(oldp+168,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0xadU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
        tracep->fullBit(oldp+169,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? ((0xadU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+170,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((0xadU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 7U)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
        tracep->fullCData(oldp+171,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
        tracep->fullBit(oldp+172,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+173,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                              : ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
        tracep->fullSData(oldp+174,((0xffffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector) 
                                                  + 
                                                  ((0xbdU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
        tracep->fullCData(oldp+175,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? ((0x68U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
        tracep->fullBit(oldp+176,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                  : (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
        tracep->fullBit(oldp+177,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 1U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+178,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 2U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
        tracep->fullBit(oldp+179,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 3U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
        tracep->fullBit(oldp+180,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 6U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))));
        tracep->fullBit(oldp+181,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
        tracep->fullSData(oldp+182,((0xffffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))),16);
        tracep->fullSData(oldp+183,((0xffffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))),16);
        tracep->fullSData(oldp+184,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)))),16);
        tracep->fullSData(oldp+185,((0xffffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : 
                                                  ((3U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                    : 
                                                   ((4U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((5U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))))))),16);
        tracep->fullSData(oldp+186,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                              : ((3U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                  : 
                                                 ((4U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))))),16);
        tracep->fullSData(oldp+187,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                              : ((3U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))),16);
        tracep->fullBit(oldp+188,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
        tracep->fullBit(oldp+189,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 1U)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
        tracep->fullBit(oldp+190,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 2U)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
        tracep->fullBit(oldp+191,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 3U)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
        tracep->fullSData(oldp+192,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
        tracep->fullCData(oldp+193,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : (((((((0xaaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0xa8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x98U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xbaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x9aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                          ? ((0xaaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                              : ((0xa8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 ((0x8aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                   : 
                                                  ((0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387)))),8);
        tracep->fullCData(oldp+194,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407))),8);
        tracep->fullCData(oldp+195,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408))),8);
        tracep->fullSData(oldp+196,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                      : (((((((0xaaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0xa8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x98U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xbaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x9aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391)))),16);
        tracep->fullBit(oldp+197,((((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x38U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? ((0x18U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                       & ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                    : (((((((0xaaU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0xa8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x8aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x98U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392)))));
        tracep->fullBit(oldp+198,((((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x38U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : (((((((0xaaU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0xa8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x8aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x98U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                            : ((0xa8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                : (
                                                   (0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                                    : 
                                                   ((0x98U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    (0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                                     : 
                                                    ((0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     (0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1393)))));
        tracep->fullBit(oldp+199,((((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x38U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                        : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                            : ((0xd8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                : (
                                                   (0xf8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                    : 
                                                   ((0x58U 
                                                     != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    & ((0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413))));
        tracep->fullBit(oldp+200,((((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x38U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                        : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                            : ((0xd8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                : (
                                                   (0xf8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0x58U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                     : 
                                                    ((0x78U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                      : 
                                                     ((0xb8U 
                                                       != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416))));
        tracep->fullBit(oldp+201,((1U & (((((((((0x18U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (0x38U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0xd8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xf8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x58U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x78U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xb8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xeaU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : (((((((0xaaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  | (0xa8U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x98U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0xbaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x9aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                              ? ((0xaaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                  >> 7U)
                                                  : 
                                                 ((0xa8U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                   >> 7U)
                                                   : 
                                                  ((0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                    >> 7U)
                                                    : 
                                                   ((0x98U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                     >> 7U)
                                                     : 
                                                    ((0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                      >> 7U)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1398))))));
        tracep->fullSData(oldp+202,((((((((((0x18U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                            | (0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xf8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? 0U : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422))),16);
        tracep->fullCData(oldp+203,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData)
                                                   : 0U)))),8);
        tracep->fullCData(oldp+204,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 (((((((0xaaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (0xa8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x8aU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x98U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xbaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x9aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  ((0xaaU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                    : 
                                                   ((0xa8U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                     : 
                                                    ((0x8aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                      : 
                                                     ((0x98U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387)))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
        tracep->fullCData(oldp+205,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))),8);
        tracep->fullCData(oldp+206,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))),8);
        tracep->fullSData(oldp+207,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                  : 
                                                 (((((((0xaaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (0xa8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x8aU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x98U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xbaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x9aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391)))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))),16);
        tracep->fullBit(oldp+208,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                            ? (((((
                                                   ((((0x18U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0x38U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xd8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x58U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x78U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0xb8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xeaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                ? (
                                                   (0x18U 
                                                    != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   & ((0x38U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                                : (
                                                   ((((((0xaaU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0xa8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x8aU 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x98U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xbaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x9aU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392)))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
        tracep->fullBit(oldp+209,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                            ? (((((
                                                   ((((0x18U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0x38U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xd8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x58U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x78U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0xb8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xeaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                ? (
                                                   (0x18U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                    : 
                                                   ((0x38U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                     : 
                                                    ((0xd8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                      : 
                                                     ((0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                       : 
                                                      ((0x58U 
                                                        != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       & ((0x78U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                          | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
        tracep->fullBit(oldp+210,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
        tracep->fullBit(oldp+211,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                            ? (((((
                                                   ((((0x18U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0x38U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xd8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x58U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x78U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0xb8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xeaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                ? (
                                                   (0x18U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0x38U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                     : 
                                                    ((0xd8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                      : 
                                                     ((0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                       : 
                                                      ((0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                        : 
                                                       ((0x78U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                         : 
                                                        ((0xb8U 
                                                          != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))));
        tracep->fullBit(oldp+212,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1457)))));
        tracep->fullSData(oldp+213,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                              ? (((
                                                   ((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? 0U
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
        tracep->fullCData(oldp+214,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut),8);
        tracep->fullCData(oldp+215,(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut),8);
        tracep->fullCData(oldp+216,(vlTOPp->NESSystem__DOT__memory_io_ppuDataIn),8);
        tracep->fullSData(oldp+217,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector),16);
        tracep->fullSData(oldp+218,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum),10);
        tracep->fullCData(oldp+219,((0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum))),8);
        tracep->fullBit(oldp+220,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                         >> 8U))));
        tracep->fullBit(oldp+221,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                         >> 7U))));
        tracep->fullBit(oldp+222,((0U == (0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum)))));
        tracep->fullSData(oldp+223,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff),10);
        tracep->fullCData(oldp+224,((0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff))),8);
        tracep->fullBit(oldp+225,((1U & (~ ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                            >> 8U)))));
        tracep->fullBit(oldp+226,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                         >> 7U))));
        tracep->fullBit(oldp+227,((0U == (0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff)))));
        tracep->fullCData(oldp+228,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6),8);
        tracep->fullSData(oldp+229,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand),16);
        tracep->fullCData(oldp+230,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7),8);
        tracep->fullBit(oldp+231,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7) 
                                         >> 7U))));
        tracep->fullBit(oldp+232,((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7))));
        tracep->fullBit(oldp+233,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV));
        tracep->fullBit(oldp+234,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN));
        tracep->fullCData(oldp+235,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9),8);
        tracep->fullBit(oldp+236,((0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
        tracep->fullSData(oldp+237,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand),16);
        tracep->fullBit(oldp+238,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD));
        tracep->fullCData(oldp+239,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData),8);
        tracep->fullBit(oldp+240,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ));
        tracep->fullBit(oldp+241,(vlTOPp->clock));
        tracep->fullBit(oldp+242,(vlTOPp->reset));
        tracep->fullSData(oldp+243,(vlTOPp->io_pixelX),9);
        tracep->fullSData(oldp+244,(vlTOPp->io_pixelY),9);
        tracep->fullCData(oldp+245,(vlTOPp->io_pixelColor),6);
        tracep->fullBit(oldp+246,(vlTOPp->io_vblank));
        tracep->fullCData(oldp+247,(vlTOPp->io_controller1),8);
        tracep->fullCData(oldp+248,(vlTOPp->io_controller2),8);
        tracep->fullCData(oldp+249,(vlTOPp->io_debug_regA),8);
        tracep->fullCData(oldp+250,(vlTOPp->io_debug_regX),8);
        tracep->fullCData(oldp+251,(vlTOPp->io_debug_regY),8);
        tracep->fullSData(oldp+252,(vlTOPp->io_debug_regPC),16);
        tracep->fullCData(oldp+253,(vlTOPp->io_debug_regSP),8);
        tracep->fullBit(oldp+254,(vlTOPp->io_debug_flagC));
        tracep->fullBit(oldp+255,(vlTOPp->io_debug_flagZ));
        tracep->fullBit(oldp+256,(vlTOPp->io_debug_flagN));
        tracep->fullBit(oldp+257,(vlTOPp->io_debug_flagV));
        tracep->fullCData(oldp+258,(vlTOPp->io_debug_opcode),8);
        tracep->fullBit(oldp+259,(vlTOPp->io_romLoadEn));
        tracep->fullSData(oldp+260,(vlTOPp->io_romLoadAddr),16);
        tracep->fullCData(oldp+261,(vlTOPp->io_romLoadData),8);
        tracep->fullBit(oldp+262,(vlTOPp->io_romLoadPRG));
        tracep->fullSData(oldp+263,((0x7fffU & (IData)(vlTOPp->io_romLoadAddr))),15);
        tracep->fullBit(oldp+264,((((IData)(vlTOPp->io_romLoadEn) 
                                    & (IData)(vlTOPp->io_romLoadPRG)) 
                                   & (0x8000U > (IData)(vlTOPp->io_romLoadAddr)))));
        tracep->fullBit(oldp+265,(1U));
    }
}
