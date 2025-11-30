// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_cpu__Syms.h"


void Vtest_cpu___024root__trace_chg_0_sub_0(Vtest_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtest_cpu___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root__trace_chg_0\n"); );
    // Body
    Vtest_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_cpu___024root*>(voidSelf);
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vtest_cpu___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtest_cpu___024root__trace_chg_0_sub_0(Vtest_cpu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root__trace_chg_0_sub_0\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgSData(oldp+0,(vlSelfRef.test_cpu__DOT__addr),16);
        bufp->chgCData(oldp+1,(vlSelfRef.test_cpu__DOT__data_out),8);
        bufp->chgBit(oldp+2,(vlSelfRef.test_cpu__DOT__rw));
        bufp->chgCData(oldp+3,(vlSelfRef.test_cpu__DOT__dut__DOT__A),8);
        bufp->chgCData(oldp+4,(vlSelfRef.test_cpu__DOT__dut__DOT__X),8);
        bufp->chgCData(oldp+5,(vlSelfRef.test_cpu__DOT__dut__DOT__Y),8);
        bufp->chgCData(oldp+6,(vlSelfRef.test_cpu__DOT__dut__DOT__SP),8);
        bufp->chgSData(oldp+7,(vlSelfRef.test_cpu__DOT__dut__DOT__PC),16);
        bufp->chgBit(oldp+8,(vlSelfRef.test_cpu__DOT__dut__DOT__C));
        bufp->chgBit(oldp+9,(vlSelfRef.test_cpu__DOT__dut__DOT__Z));
        bufp->chgBit(oldp+10,(vlSelfRef.test_cpu__DOT__dut__DOT__I));
        bufp->chgBit(oldp+11,(vlSelfRef.test_cpu__DOT__dut__DOT__D));
        bufp->chgBit(oldp+12,(vlSelfRef.test_cpu__DOT__dut__DOT__B));
        bufp->chgBit(oldp+13,(vlSelfRef.test_cpu__DOT__dut__DOT__V));
        bufp->chgBit(oldp+14,(vlSelfRef.test_cpu__DOT__dut__DOT__N));
        bufp->chgCData(oldp+15,(vlSelfRef.test_cpu__DOT__dut__DOT__state),3);
        bufp->chgCData(oldp+16,(vlSelfRef.test_cpu__DOT__dut__DOT__next_state),3);
        bufp->chgCData(oldp+17,(vlSelfRef.test_cpu__DOT__dut__DOT__opcode),8);
        bufp->chgCData(oldp+18,(vlSelfRef.test_cpu__DOT__dut__DOT__operand),8);
        bufp->chgCData(oldp+19,(vlSelfRef.test_cpu__DOT__dut__DOT__alu_result),8);
        bufp->chgCData(oldp+20,(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count),3);
        bufp->chgSData(oldp+21,((((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__15__03a8__KET__) 
                                  << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__))),16);
        bufp->chgCData(oldp+22,(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle),3);
        bufp->chgBit(oldp+23,(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending));
        bufp->chgBit(oldp+24,(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_prev));
        bufp->chgCData(oldp+25,(vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_lo),8);
        bufp->chgCData(oldp+26,(vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_hi),8);
        bufp->chgSData(oldp+27,(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum),9);
        bufp->chgSData(oldp+28,(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff),9);
        bufp->chgCData(oldp+29,(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result),8);
    }
    bufp->chgBit(oldp+30,(vlSelfRef.test_cpu__DOT__clk));
    bufp->chgBit(oldp+31,(vlSelfRef.test_cpu__DOT__rst_n));
    bufp->chgCData(oldp+32,(vlSelfRef.test_cpu__DOT__data_in),8);
    bufp->chgBit(oldp+33,(vlSelfRef.test_cpu__DOT__nmi));
    bufp->chgBit(oldp+34,(vlSelfRef.test_cpu__DOT__irq));
    bufp->chgIData(oldp+35,(vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i),32);
}

void Vtest_cpu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root__trace_cleanup\n"); );
    // Body
    Vtest_cpu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_cpu___024root*>(voidSelf);
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
