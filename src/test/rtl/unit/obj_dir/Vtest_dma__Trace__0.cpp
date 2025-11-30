// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_dma__Syms.h"


void Vtest_dma___024root__trace_chg_0_sub_0(Vtest_dma___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtest_dma___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root__trace_chg_0\n"); );
    // Body
    Vtest_dma___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_dma___024root*>(voidSelf);
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vtest_dma___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtest_dma___024root__trace_chg_0_sub_0(Vtest_dma___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root__trace_chg_0_sub_0\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgBit(oldp+0,(vlSelfRef.test_dma__DOT__dma_active));
        bufp->chgCData(oldp+1,(vlSelfRef.test_dma__DOT__ram_addr_low),8);
        bufp->chgCData(oldp+2,(vlSelfRef.test_dma__DOT__oam_addr),8);
        bufp->chgCData(oldp+3,(vlSelfRef.test_dma__DOT__oam_data),8);
        bufp->chgBit(oldp+4,(vlSelfRef.test_dma__DOT__oam_write));
        bufp->chgCData(oldp+5,(vlSelfRef.test_dma__DOT__dut__DOT__dma_offset),8);
    }
    bufp->chgBit(oldp+6,(vlSelfRef.test_dma__DOT__clk));
    bufp->chgBit(oldp+7,(vlSelfRef.test_dma__DOT__rst_n));
    bufp->chgBit(oldp+8,(vlSelfRef.test_dma__DOT__dma_start));
    bufp->chgCData(oldp+9,(vlSelfRef.test_dma__DOT__dma_page),8);
    bufp->chgCData(oldp+10,(vlSelfRef.test_dma__DOT__test_ram
                            [vlSelfRef.test_dma__DOT__ram_addr_low]),8);
    bufp->chgIData(oldp+11,(vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i),32);
}

void Vtest_dma___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root__trace_cleanup\n"); );
    // Body
    Vtest_dma___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_dma___024root*>(voidSelf);
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
