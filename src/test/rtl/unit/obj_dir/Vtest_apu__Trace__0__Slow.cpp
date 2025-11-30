// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_apu__Syms.h"


VL_ATTR_COLD void Vtest_apu___024root__trace_init_sub__TOP__0(Vtest_apu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_init_sub__TOP__0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("test_apu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+58,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"rst_n",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("apu_pulse1", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+2+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_pulse2", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+6+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_triangle", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+10+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_noise", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+14+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_dmc", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+18+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+22,0,"apu_status",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+44,0,"audio_l",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+44,0,"audio_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+58,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("apu_pulse1", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+24+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_pulse2", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+28+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_triangle", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+32+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_noise", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+36+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_dmc", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+40+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+22,0,"apu_status",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+44,0,"audio_l",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+44,0,"audio_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+59,0,"audio_counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+45,0,"test_tone",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+46,0,"pulse1_timer",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+47,0,"pulse1_duty",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+48,0,"pulse1_volume",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+49,0,"pulse1_enabled",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+50,0,"pulse1_out_bit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+51,0,"pulse1_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+52,0,"pulse2_timer",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+53,0,"pulse2_duty",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+54,0,"pulse2_volume",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+55,0,"pulse2_enabled",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"pulse2_out_bit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+57,0,"pulse2_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+23,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vtest_apu___024root__trace_init_top(Vtest_apu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_init_top\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_apu___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtest_apu___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vtest_apu___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtest_apu___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtest_apu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vtest_apu___024root__trace_register(Vtest_apu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_register\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vtest_apu___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&Vtest_apu___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&Vtest_apu___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&Vtest_apu___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtest_apu___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_const_0\n"); );
    // Body
    Vtest_apu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_apu___024root*>(voidSelf);
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
}

VL_ATTR_COLD void Vtest_apu___024root__trace_full_0_sub_0(Vtest_apu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtest_apu___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_full_0\n"); );
    // Body
    Vtest_apu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_apu___024root*>(voidSelf);
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vtest_apu___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtest_apu___024root__trace_full_0_sub_0(Vtest_apu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_full_0_sub_0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullBit(oldp+1,(vlSelfRef.test_apu__DOT__rst_n));
    bufp->fullCData(oldp+2,(vlSelfRef.test_apu__DOT__apu_pulse1[0]),8);
    bufp->fullCData(oldp+3,(vlSelfRef.test_apu__DOT__apu_pulse1[1]),8);
    bufp->fullCData(oldp+4,(vlSelfRef.test_apu__DOT__apu_pulse1[2]),8);
    bufp->fullCData(oldp+5,(vlSelfRef.test_apu__DOT__apu_pulse1[3]),8);
    bufp->fullCData(oldp+6,(vlSelfRef.test_apu__DOT__apu_pulse2[0]),8);
    bufp->fullCData(oldp+7,(vlSelfRef.test_apu__DOT__apu_pulse2[1]),8);
    bufp->fullCData(oldp+8,(vlSelfRef.test_apu__DOT__apu_pulse2[2]),8);
    bufp->fullCData(oldp+9,(vlSelfRef.test_apu__DOT__apu_pulse2[3]),8);
    bufp->fullCData(oldp+10,(vlSelfRef.test_apu__DOT__apu_triangle[0]),8);
    bufp->fullCData(oldp+11,(vlSelfRef.test_apu__DOT__apu_triangle[1]),8);
    bufp->fullCData(oldp+12,(vlSelfRef.test_apu__DOT__apu_triangle[2]),8);
    bufp->fullCData(oldp+13,(vlSelfRef.test_apu__DOT__apu_triangle[3]),8);
    bufp->fullCData(oldp+14,(vlSelfRef.test_apu__DOT__apu_noise[0]),8);
    bufp->fullCData(oldp+15,(vlSelfRef.test_apu__DOT__apu_noise[1]),8);
    bufp->fullCData(oldp+16,(vlSelfRef.test_apu__DOT__apu_noise[2]),8);
    bufp->fullCData(oldp+17,(vlSelfRef.test_apu__DOT__apu_noise[3]),8);
    bufp->fullCData(oldp+18,(vlSelfRef.test_apu__DOT__apu_dmc[0]),8);
    bufp->fullCData(oldp+19,(vlSelfRef.test_apu__DOT__apu_dmc[1]),8);
    bufp->fullCData(oldp+20,(vlSelfRef.test_apu__DOT__apu_dmc[2]),8);
    bufp->fullCData(oldp+21,(vlSelfRef.test_apu__DOT__apu_dmc[3]),8);
    bufp->fullCData(oldp+22,(vlSelfRef.test_apu__DOT__apu_status),8);
    bufp->fullIData(oldp+23,(vlSelfRef.test_apu__DOT__unnamedblk1__DOT__i),32);
    bufp->fullCData(oldp+24,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[0]),8);
    bufp->fullCData(oldp+25,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[1]),8);
    bufp->fullCData(oldp+26,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[2]),8);
    bufp->fullCData(oldp+27,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[3]),8);
    bufp->fullCData(oldp+28,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[0]),8);
    bufp->fullCData(oldp+29,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[1]),8);
    bufp->fullCData(oldp+30,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[2]),8);
    bufp->fullCData(oldp+31,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[3]),8);
    bufp->fullCData(oldp+32,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[0]),8);
    bufp->fullCData(oldp+33,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[1]),8);
    bufp->fullCData(oldp+34,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[2]),8);
    bufp->fullCData(oldp+35,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[3]),8);
    bufp->fullCData(oldp+36,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[0]),8);
    bufp->fullCData(oldp+37,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[1]),8);
    bufp->fullCData(oldp+38,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[2]),8);
    bufp->fullCData(oldp+39,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[3]),8);
    bufp->fullCData(oldp+40,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[0]),8);
    bufp->fullCData(oldp+41,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[1]),8);
    bufp->fullCData(oldp+42,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[2]),8);
    bufp->fullCData(oldp+43,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[3]),8);
    bufp->fullSData(oldp+44,((0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                             + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                                + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out))))),16);
    bufp->fullSData(oldp+45,(vlSelfRef.test_apu__DOT__dut__DOT__test_tone),16);
    bufp->fullSData(oldp+46,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer),16);
    bufp->fullCData(oldp+47,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty),4);
    bufp->fullCData(oldp+48,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_volume),4);
    bufp->fullBit(oldp+49,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_enabled));
    bufp->fullBit(oldp+50,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out_bit));
    bufp->fullSData(oldp+51,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out),16);
    bufp->fullSData(oldp+52,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer),16);
    bufp->fullCData(oldp+53,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty),4);
    bufp->fullCData(oldp+54,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_volume),4);
    bufp->fullBit(oldp+55,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_enabled));
    bufp->fullBit(oldp+56,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out_bit));
    bufp->fullSData(oldp+57,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out),16);
    bufp->fullBit(oldp+58,(vlSelfRef.test_apu__DOT__clk));
    bufp->fullSData(oldp+59,(vlSelfRef.test_apu__DOT__dut__DOT__audio_counter),16);
}
