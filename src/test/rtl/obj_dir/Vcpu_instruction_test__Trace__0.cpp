// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vcpu_instruction_test__Syms.h"


void Vcpu_instruction_test___024root__trace_chg_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vcpu_instruction_test___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_chg_0\n"); );
    // Body
    Vcpu_instruction_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vcpu_instruction_test___024root*>(voidSelf);
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vcpu_instruction_test___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vcpu_instruction_test___024root__trace_chg_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_chg_0_sub_0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgSData(oldp+0,(vlSelfRef.cpu_instruction_test__DOT__addr),16);
        bufp->chgCData(oldp+1,(vlSelfRef.cpu_instruction_test__DOT__data_out),8);
        bufp->chgBit(oldp+2,(vlSelfRef.cpu_instruction_test__DOT__rw));
        bufp->chgCData(oldp+3,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A),8);
        bufp->chgCData(oldp+4,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X),8);
        bufp->chgCData(oldp+5,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y),8);
        bufp->chgCData(oldp+6,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP),8);
        bufp->chgSData(oldp+7,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC),16);
        bufp->chgBit(oldp+8,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C));
        bufp->chgBit(oldp+9,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z));
        bufp->chgBit(oldp+10,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I));
        bufp->chgBit(oldp+11,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D));
        bufp->chgBit(oldp+12,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B));
        bufp->chgBit(oldp+13,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V));
        bufp->chgBit(oldp+14,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N));
        bufp->chgCData(oldp+15,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state),3);
        bufp->chgCData(oldp+16,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__next_state),3);
        bufp->chgCData(oldp+17,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode),8);
        bufp->chgCData(oldp+18,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand),8);
        bufp->chgCData(oldp+19,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__alu_result),8);
        bufp->chgCData(oldp+20,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count),3);
        bufp->chgSData(oldp+21,((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__) 
                                  << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__))),16);
        bufp->chgCData(oldp+22,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle),3);
        bufp->chgBit(oldp+23,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_pending));
        bufp->chgCData(oldp+24,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo),8);
        bufp->chgCData(oldp+25,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi),8);
        bufp->chgSData(oldp+26,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum),9);
        bufp->chgSData(oldp+27,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff),9);
        bufp->chgCData(oldp+28,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result),8);
    }
    bufp->chgBit(oldp+29,(vlSelfRef.cpu_instruction_test__DOT__clk));
    bufp->chgBit(oldp+30,(vlSelfRef.cpu_instruction_test__DOT__rst_n));
    bufp->chgCData(oldp+31,(vlSelfRef.cpu_instruction_test__DOT__data_in),8);
    bufp->chgBit(oldp+32,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_prev));
}

void Vcpu_instruction_test___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_cleanup\n"); );
    // Body
    Vcpu_instruction_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vcpu_instruction_test___024root*>(voidSelf);
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
