// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_apu__Syms.h"


void Vtest_apu___024root__trace_chg_0_sub_0(Vtest_apu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtest_apu___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_chg_0\n"); );
    // Body
    Vtest_apu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_apu___024root*>(voidSelf);
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vtest_apu___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtest_apu___024root__trace_chg_0_sub_0(Vtest_apu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_chg_0_sub_0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[1U] 
                      | vlSelfRef.__Vm_traceActivity
                      [2U])))) {
        bufp->chgBit(oldp+0,(vlSelfRef.test_apu__DOT__rst_n));
        bufp->chgCData(oldp+1,(vlSelfRef.test_apu__DOT__apu_pulse1[0]),8);
        bufp->chgCData(oldp+2,(vlSelfRef.test_apu__DOT__apu_pulse1[1]),8);
        bufp->chgCData(oldp+3,(vlSelfRef.test_apu__DOT__apu_pulse1[2]),8);
        bufp->chgCData(oldp+4,(vlSelfRef.test_apu__DOT__apu_pulse1[3]),8);
        bufp->chgCData(oldp+5,(vlSelfRef.test_apu__DOT__apu_pulse2[0]),8);
        bufp->chgCData(oldp+6,(vlSelfRef.test_apu__DOT__apu_pulse2[1]),8);
        bufp->chgCData(oldp+7,(vlSelfRef.test_apu__DOT__apu_pulse2[2]),8);
        bufp->chgCData(oldp+8,(vlSelfRef.test_apu__DOT__apu_pulse2[3]),8);
        bufp->chgCData(oldp+9,(vlSelfRef.test_apu__DOT__apu_triangle[0]),8);
        bufp->chgCData(oldp+10,(vlSelfRef.test_apu__DOT__apu_triangle[1]),8);
        bufp->chgCData(oldp+11,(vlSelfRef.test_apu__DOT__apu_triangle[2]),8);
        bufp->chgCData(oldp+12,(vlSelfRef.test_apu__DOT__apu_triangle[3]),8);
        bufp->chgCData(oldp+13,(vlSelfRef.test_apu__DOT__apu_noise[0]),8);
        bufp->chgCData(oldp+14,(vlSelfRef.test_apu__DOT__apu_noise[1]),8);
        bufp->chgCData(oldp+15,(vlSelfRef.test_apu__DOT__apu_noise[2]),8);
        bufp->chgCData(oldp+16,(vlSelfRef.test_apu__DOT__apu_noise[3]),8);
        bufp->chgCData(oldp+17,(vlSelfRef.test_apu__DOT__apu_dmc[0]),8);
        bufp->chgCData(oldp+18,(vlSelfRef.test_apu__DOT__apu_dmc[1]),8);
        bufp->chgCData(oldp+19,(vlSelfRef.test_apu__DOT__apu_dmc[2]),8);
        bufp->chgCData(oldp+20,(vlSelfRef.test_apu__DOT__apu_dmc[3]),8);
        bufp->chgCData(oldp+21,(vlSelfRef.test_apu__DOT__apu_status),8);
        bufp->chgIData(oldp+22,(vlSelfRef.test_apu__DOT__unnamedblk1__DOT__i),32);
    }
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[3U] 
                      | vlSelfRef.__Vm_traceActivity
                      [4U])))) {
        bufp->chgCData(oldp+23,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[0]),8);
        bufp->chgCData(oldp+24,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[1]),8);
        bufp->chgCData(oldp+25,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[2]),8);
        bufp->chgCData(oldp+26,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[3]),8);
        bufp->chgCData(oldp+27,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[0]),8);
        bufp->chgCData(oldp+28,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[1]),8);
        bufp->chgCData(oldp+29,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[2]),8);
        bufp->chgCData(oldp+30,(vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[3]),8);
        bufp->chgCData(oldp+31,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[0]),8);
        bufp->chgCData(oldp+32,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[1]),8);
        bufp->chgCData(oldp+33,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[2]),8);
        bufp->chgCData(oldp+34,(vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[3]),8);
        bufp->chgCData(oldp+35,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[0]),8);
        bufp->chgCData(oldp+36,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[1]),8);
        bufp->chgCData(oldp+37,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[2]),8);
        bufp->chgCData(oldp+38,(vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[3]),8);
        bufp->chgCData(oldp+39,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[0]),8);
        bufp->chgCData(oldp+40,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[1]),8);
        bufp->chgCData(oldp+41,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[2]),8);
        bufp->chgCData(oldp+42,(vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[3]),8);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[5U]))) {
        bufp->chgSData(oldp+43,((0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                                + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                                   + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out))))),16);
        bufp->chgSData(oldp+44,(vlSelfRef.test_apu__DOT__dut__DOT__test_tone),16);
        bufp->chgSData(oldp+45,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer),16);
        bufp->chgCData(oldp+46,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty),4);
        bufp->chgCData(oldp+47,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_volume),4);
        bufp->chgBit(oldp+48,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_enabled));
        bufp->chgBit(oldp+49,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out_bit));
        bufp->chgSData(oldp+50,(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out),16);
        bufp->chgSData(oldp+51,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer),16);
        bufp->chgCData(oldp+52,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty),4);
        bufp->chgCData(oldp+53,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_volume),4);
        bufp->chgBit(oldp+54,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_enabled));
        bufp->chgBit(oldp+55,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out_bit));
        bufp->chgSData(oldp+56,(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out),16);
    }
    bufp->chgBit(oldp+57,(vlSelfRef.test_apu__DOT__clk));
    bufp->chgSData(oldp+58,(vlSelfRef.test_apu__DOT__dut__DOT__audio_counter),16);
}

void Vtest_apu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root__trace_cleanup\n"); );
    // Body
    Vtest_apu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_apu___024root*>(voidSelf);
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[5U] = 0U;
}
