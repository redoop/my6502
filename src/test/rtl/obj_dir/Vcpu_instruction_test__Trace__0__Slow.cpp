// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vcpu_instruction_test__Syms.h"


VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_init_sub__TOP__0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_init_sub__TOP__0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("cpu_instruction_test", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+30,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+31,0,"rst_n",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+1,0,"addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+32,0,"data_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+2,0,"data_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"rw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("cpu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+30,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+31,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+1,0,"addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+32,0,"data_in",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+2,0,"data_out",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+3,0,"rw",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+34,0,"nmi",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+34,0,"irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+4,0,"A",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+5,0,"X",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+6,0,"Y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+7,0,"SP",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+8,0,"PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+9,0,"C",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+10,0,"Z",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+11,0,"I",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+12,0,"D",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+13,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+14,0,"V",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+15,0,"N",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+16,0,"state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+17,0,"next_state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+18,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+19,0,"operand",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+20,0,"alu_result",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+35,0,"ea",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+21,0,"cycle_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+22,0,"reset_vector",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+23,0,"nmi_cycle",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+24,0,"nmi_pending",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+33,0,"nmi_prev",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+25,0,"indirect_addr_lo",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+26,0,"indirect_addr_hi",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+27,0,"temp_sum",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+28,0,"temp_diff",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+29,0,"temp_result",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_init_top(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_init_top\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vcpu_instruction_test___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vcpu_instruction_test___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vcpu_instruction_test___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_register(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_register\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vcpu_instruction_test___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&Vcpu_instruction_test___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&Vcpu_instruction_test___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&Vcpu_instruction_test___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_const_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_const_0\n"); );
    // Body
    Vcpu_instruction_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vcpu_instruction_test___024root*>(voidSelf);
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vcpu_instruction_test___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_const_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_const_0_sub_0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullBit(oldp+34,(0U));
    bufp->fullSData(oldp+35,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__ea),16);
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_full_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_full_0\n"); );
    // Body
    Vcpu_instruction_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vcpu_instruction_test___024root*>(voidSelf);
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vcpu_instruction_test___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_full_0_sub_0(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root__trace_full_0_sub_0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullSData(oldp+1,(vlSelfRef.cpu_instruction_test__DOT__addr),16);
    bufp->fullCData(oldp+2,(vlSelfRef.cpu_instruction_test__DOT__data_out),8);
    bufp->fullBit(oldp+3,(vlSelfRef.cpu_instruction_test__DOT__rw));
    bufp->fullCData(oldp+4,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A),8);
    bufp->fullCData(oldp+5,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X),8);
    bufp->fullCData(oldp+6,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y),8);
    bufp->fullCData(oldp+7,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP),8);
    bufp->fullSData(oldp+8,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC),16);
    bufp->fullBit(oldp+9,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C));
    bufp->fullBit(oldp+10,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z));
    bufp->fullBit(oldp+11,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I));
    bufp->fullBit(oldp+12,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D));
    bufp->fullBit(oldp+13,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B));
    bufp->fullBit(oldp+14,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V));
    bufp->fullBit(oldp+15,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N));
    bufp->fullCData(oldp+16,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state),3);
    bufp->fullCData(oldp+17,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__next_state),3);
    bufp->fullCData(oldp+18,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode),8);
    bufp->fullCData(oldp+19,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand),8);
    bufp->fullCData(oldp+20,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__alu_result),8);
    bufp->fullCData(oldp+21,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count),3);
    bufp->fullSData(oldp+22,((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__) 
                               << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__))),16);
    bufp->fullCData(oldp+23,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle),3);
    bufp->fullBit(oldp+24,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_pending));
    bufp->fullCData(oldp+25,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo),8);
    bufp->fullCData(oldp+26,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi),8);
    bufp->fullSData(oldp+27,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum),9);
    bufp->fullSData(oldp+28,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff),9);
    bufp->fullCData(oldp+29,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result),8);
    bufp->fullBit(oldp+30,(vlSelfRef.cpu_instruction_test__DOT__clk));
    bufp->fullBit(oldp+31,(vlSelfRef.cpu_instruction_test__DOT__rst_n));
    bufp->fullCData(oldp+32,(vlSelfRef.cpu_instruction_test__DOT__data_in),8);
    bufp->fullBit(oldp+33,(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_prev));
}
