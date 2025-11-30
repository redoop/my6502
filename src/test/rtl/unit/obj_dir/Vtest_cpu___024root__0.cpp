// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_cpu.h for the primary calling header

#include "Vtest_cpu__pch.h"

VL_ATTR_COLD void Vtest_cpu___024root___eval_initial__TOP(Vtest_cpu___024root* vlSelf);
VlCoroutine Vtest_cpu___024root___eval_initial__TOP__Vtiming__0(Vtest_cpu___024root* vlSelf);
VlCoroutine Vtest_cpu___024root___eval_initial__TOP__Vtiming__1(Vtest_cpu___024root* vlSelf);

void Vtest_cpu___024root___eval_initial(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_initial\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_cpu___024root___eval_initial__TOP(vlSelf);
    Vtest_cpu___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtest_cpu___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vtest_cpu___024root___eval_initial__TOP__Vtiming__0(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile("waveforms/test_cpu.vcd"s);
    vlSymsp->_traceDumpOpen();
    vlSelfRef.test_cpu__DOT__rst_n = 0U;
    vlSelfRef.test_cpu__DOT__nmi = 0U;
    vlSelfRef.test_cpu__DOT__irq = 0U;
    vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00010000U, vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.test_cpu__DOT__mem[(0x0000ffffU & vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i)] = 0xeaU;
        vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i 
            = ((IData)(1U) + vlSelfRef.test_cpu__DOT__unnamedblk1__DOT__i);
    }
    vlSelfRef.test_cpu__DOT__mem[0xfffcU] = 0U;
    vlSelfRef.test_cpu__DOT__mem[0xfffdU] = 0x80U;
    vlSelfRef.test_cpu__DOT__mem[0x8000U] = 0xa9U;
    vlSelfRef.test_cpu__DOT__mem[0x8001U] = 0x42U;
    vlSelfRef.test_cpu__DOT__mem[0x8002U] = 0x85U;
    vlSelfRef.test_cpu__DOT__mem[0x8003U] = 0x10U;
    vlSelfRef.test_cpu__DOT__mem[0x8004U] = 0xa5U;
    vlSelfRef.test_cpu__DOT__mem[0x8005U] = 0x10U;
    vlSelfRef.test_cpu__DOT__mem[0x8006U] = 0x69U;
    vlSelfRef.test_cpu__DOT__mem[0x8007U] = 8U;
    vlSelfRef.test_cpu__DOT__mem[0x8008U] = 0x85U;
    vlSelfRef.test_cpu__DOT__mem[0x8009U] = 0x11U;
    vlSelfRef.test_cpu__DOT__mem[0x800aU] = 0x4cU;
    vlSelfRef.test_cpu__DOT__mem[0x800bU] = 0x0aU;
    vlSelfRef.test_cpu__DOT__mem[0x800cU] = 0x80U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000014ULL, 
                                         nullptr, "test_cpu.sv", 
                                         70);
    vlSelfRef.test_cpu__DOT__rst_n = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x00000000000003e8ULL, 
                                         nullptr, "test_cpu.sv", 
                                         73);
    if ((0x42U == vlSelfRef.test_cpu__DOT__mem[0x0010U])) {
        VL_WRITEF_NX("[TEST] PASS: mem[$10] = $42\n",0);
    } else {
        VL_WRITEF_NX("[TEST] FAIL: mem[$10] = $%02x (expected $42)\n",0,
                     8,vlSelfRef.test_cpu__DOT__mem
                     [0x0010U]);
    }
    if ((0x4aU == vlSelfRef.test_cpu__DOT__mem[0x0011U])) {
        VL_WRITEF_NX("[TEST] PASS: mem[$11] = $4A\n",0);
    } else {
        VL_WRITEF_NX("[TEST] FAIL: mem[$11] = $%02x (expected $4A)\n",0,
                     8,vlSelfRef.test_cpu__DOT__mem
                     [0x0011U]);
    }
    VL_WRITEF_NX("[TEST] Triggering NMI\n",0);
    vlSelfRef.test_cpu__DOT__mem[0xfffaU] = 0U;
    vlSelfRef.test_cpu__DOT__mem[0xfffbU] = 0x90U;
    vlSelfRef.test_cpu__DOT__mem[0x9000U] = 0x40U;
    vlSelfRef.test_cpu__DOT__nmi = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000064ULL, 
                                         nullptr, "test_cpu.sv", 
                                         95);
    vlSelfRef.test_cpu__DOT__nmi = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000064ULL, 
                                         nullptr, "test_cpu.sv", 
                                         97);
    VL_WRITEF_NX("[TEST] All tests passed!\n",0);
    VL_FINISH_MT("test_cpu.sv", 100, "");
}

VlCoroutine Vtest_cpu___024root___eval_initial__TOP__Vtiming__1(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "test_cpu.sv", 
                                             25);
        vlSelfRef.test_cpu__DOT__clk = (1U & (~ (IData)(vlSelfRef.test_cpu__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_cpu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vtest_cpu___024root___eval_triggers__act(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_triggers__act\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                      << 2U) 
                                                     | ((((~ (IData)(vlSelfRef.test_cpu__DOT__rst_n)) 
                                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__rst_n__0)) 
                                                         << 1U) 
                                                        | ((IData)(vlSelfRef.test_cpu__DOT__clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__clk__0)))))));
    vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__clk__0 
        = vlSelfRef.test_cpu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__rst_n__0 
        = vlSelfRef.test_cpu__DOT__rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_cpu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vtest_cpu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___trigger_anySet__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void Vtest_cpu___024root___act_sequent__TOP__0(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___act_sequent__TOP__0\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_cpu__DOT__data_in = ((IData)(vlSelfRef.test_cpu__DOT__rw)
                                         ? vlSelfRef.test_cpu__DOT__mem
                                        [vlSelfRef.test_cpu__DOT__addr]
                                         : 0U);
}

void Vtest_cpu___024root___eval_act(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_act\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        Vtest_cpu___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vtest_cpu___024root___nba_sequent__TOP__0(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___nba_sequent__TOP__0\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D = vlSelfRef.test_cpu__DOT__dut__DOT__D;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C = vlSelfRef.test_cpu__DOT__dut__DOT__C;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A = vlSelfRef.test_cpu__DOT__dut__DOT__A;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z = vlSelfRef.test_cpu__DOT__dut__DOT__Z;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N = vlSelfRef.test_cpu__DOT__dut__DOT__N;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X = vlSelfRef.test_cpu__DOT__dut__DOT__X;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y = vlSelfRef.test_cpu__DOT__dut__DOT__Y;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V = vlSelfRef.test_cpu__DOT__dut__DOT__V;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP = vlSelfRef.test_cpu__DOT__dut__DOT__SP;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I = vlSelfRef.test_cpu__DOT__dut__DOT__I;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__B = vlSelfRef.test_cpu__DOT__dut__DOT__B;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__indirect_addr_lo 
        = vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_lo;
    vlSelfRef.__Vdly__test_cpu__DOT__addr = vlSelfRef.test_cpu__DOT__addr;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count 
        = vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__opcode 
        = vlSelfRef.test_cpu__DOT__dut__DOT__opcode;
    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle 
        = vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle;
}

void Vtest_cpu___024root___nba_sequent__TOP__1(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___nba_sequent__TOP__1\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ __VdlyVal__test_cpu__DOT__mem__v0;
    __VdlyVal__test_cpu__DOT__mem__v0 = 0;
    SData/*15:0*/ __VdlyDim0__test_cpu__DOT__mem__v0;
    __VdlyDim0__test_cpu__DOT__mem__v0 = 0;
    CData/*0:0*/ __VdlySet__test_cpu__DOT__mem__v0;
    __VdlySet__test_cpu__DOT__mem__v0 = 0;
    // Body
    if (VL_UNLIKELY(((1U & (~ (IData)(vlSelfRef.test_cpu__DOT__rw)))))) {
        VL_WRITEF_NX("  Write: [$%04x] = $%02x\n",0,
                     16,vlSelfRef.test_cpu__DOT__addr,
                     8,(IData)(vlSelfRef.test_cpu__DOT__data_out));
    }
    __VdlySet__test_cpu__DOT__mem__v0 = 0U;
    if ((1U & (~ (IData)(vlSelfRef.test_cpu__DOT__rw)))) {
        __VdlyVal__test_cpu__DOT__mem__v0 = vlSelfRef.test_cpu__DOT__data_out;
        __VdlyDim0__test_cpu__DOT__mem__v0 = vlSelfRef.test_cpu__DOT__addr;
        __VdlySet__test_cpu__DOT__mem__v0 = 1U;
    }
    if (__VdlySet__test_cpu__DOT__mem__v0) {
        vlSelfRef.test_cpu__DOT__mem[__VdlyDim0__test_cpu__DOT__mem__v0] 
            = __VdlyVal__test_cpu__DOT__mem__v0;
    }
}

void Vtest_cpu___024root___nba_sequent__TOP__2(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___nba_sequent__TOP__2\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.test_cpu__DOT__rst_n) {
        if (((((IData)(vlSelfRef.test_cpu__DOT__nmi) 
               & (~ (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_prev))) 
              & (~ (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending))) 
             & (1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state)))) {
            vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending = 1U;
        }
        if ((0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr = 0xfffcU;
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
            } else if (VL_LIKELY(((1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__ 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__addr = 0xfffdU;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 2U;
            } else {
                vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__15__03a8__KET__ 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 0U;
                VL_WRITEF_NX("[CPU] Reset vector: $%04x\n",0,
                             16,(((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                  << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__)));
            }
        } else if (VL_UNLIKELY(((1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))))) {
            vlSelfRef.__Vdly__test_cpu__DOT__addr = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
            vlSelfRef.test_cpu__DOT__rw = 1U;
            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 0U;
            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
            VL_WRITEF_NX("[CPU] PC=$%04x\n",0,16,vlSelfRef.test_cpu__DOT__dut__DOT__PC);
        } else if ((2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__opcode 
                = vlSelfRef.test_cpu__DOT__data_in;
            vlSelfRef.__Vdly__test_cpu__DOT__addr = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
            vlSelfRef.test_cpu__DOT__rw = 1U;
        } else if ((3U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            if ((0x00000080U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((0x00000040U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((0x00000020U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                    } else if ((1U 
                                                & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                            = (0x0000ffffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                            = (0x0000ffffU 
                                               & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                    << 8U) 
                                                   | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                        vlSelfRef.test_cpu__DOT__rw = 1U;
                                    } else {
                                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                    }
                                } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D = 1U;
                                }
                            } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                }
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                           ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                           : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                               ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                               : ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Z)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.test_cpu__DOT__data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))))));
                            }
                        } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff 
                                    = (0x000001ffU 
                                       & (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                           - (IData)(vlSelfRef.test_cpu__DOT__data_in)) 
                                          - (1U & (~ (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)))));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                    = (1U & (~ ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff) 
                                                >> 8U)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                    = (0x000000ffU 
                                       & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                    = (0U == (0x000000ffU 
                                              & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff) 
                                             >> 7U));
                            } else {
                                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = vlSelfRef.test_cpu__DOT__data_in;
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = vlSelfRef.test_cpu__DOT__data_in;
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X) 
                                                  - (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X) 
                                   >= (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X) 
                                   == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D = 0U;
                            }
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((4U 
                                                   & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                   ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                   : 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                    ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                     ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                     : 
                                                    ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Z)
                                                      ? 
                                                     ((IData)(1U) 
                                                      + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))
                                                      : 
                                                     ((IData)(1U) 
                                                      + 
                                                      ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                       + 
                                                       ((0x0000ff00U 
                                                         & ((- (IData)(
                                                                       (1U 
                                                                        & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                           >> 7U)))) 
                                                            << 8U)) 
                                                        | (IData)(vlSelfRef.test_cpu__DOT__data_in)))))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X) 
                                          - (IData)(1U)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                                  - (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                   >= (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                   == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                         >> 7U));
                        } else {
                            vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = vlSelfRef.test_cpu__DOT__data_in;
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                                              - (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                            = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                               >= (IData)(vlSelfRef.test_cpu__DOT__data_in));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                               == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((0x00000020U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__SP;
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                        = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                        = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                                 >> 7U));
                                }
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V = 0U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.test_cpu__DOT__data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                         >> 7U));
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = vlSelfRef.test_cpu__DOT__data_in;
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                     >> 7U));
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                vlSelfRef.test_cpu__DOT__data_out 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                                vlSelfRef.test_cpu__DOT__rw = 0U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__X;
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__Y;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                                vlSelfRef.test_cpu__DOT__data_out 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__X;
                                vlSelfRef.test_cpu__DOT__rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                            vlSelfRef.test_cpu__DOT__data_out 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                            vlSelfRef.test_cpu__DOT__rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                            vlSelfRef.test_cpu__DOT__data_out 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__Y;
                            vlSelfRef.test_cpu__DOT__rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)
                                               ? ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))
                                               : ((IData)(1U) 
                                                  + 
                                                  ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                   + 
                                                   ((0x0000ff00U 
                                                     & ((- (IData)(
                                                                   (1U 
                                                                    & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                       >> 7U)))) 
                                                        << 8U)) 
                                                    | (IData)(vlSelfRef.test_cpu__DOT__data_in))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                vlSelfRef.test_cpu__DOT__data_out 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__X;
                                vlSelfRef.test_cpu__DOT__rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                    << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                            vlSelfRef.test_cpu__DOT__data_out 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                            vlSelfRef.test_cpu__DOT__rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                    << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                            vlSelfRef.test_cpu__DOT__data_out 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__Y;
                            vlSelfRef.test_cpu__DOT__rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__X;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                                              - (IData)(1U)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__data_out 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__X;
                            vlSelfRef.test_cpu__DOT__rw = 0U;
                        }
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.test_cpu__DOT__data_out 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                        vlSelfRef.test_cpu__DOT__rw = 0U;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.test_cpu__DOT__data_out 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__Y;
                        vlSelfRef.test_cpu__DOT__rw = 0U;
                    }
                } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                }
            } else if ((0x00000040U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((0x00000020U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                    vlSelfRef.test_cpu__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand)) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I = 1U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            }
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((2U 
                                                   & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                   ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                    ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.test_cpu__DOT__data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand));
                                vlSelfRef.test_cpu__DOT__rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            } else {
                                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                    = (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C) 
                                        << 7U) | (0x0000007fU 
                                                  & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                                     >> 1U)));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                    = (1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum 
                                = (0x000001ffU & (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                                   + (IData)(vlSelfRef.test_cpu__DOT__data_in)) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                                         >> 8U));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (0x000000ffU 
                                          & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                                         >> 7U));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V 
                                = (((1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                           >> 7U)) 
                                    == (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                                                >> 7U))));
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        }
                    } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                            vlSelfRef.__Vdly__test_cpu__DOT__addr 
                                = vlSelfRef.test_cpu__DOT__data_in;
                            vlSelfRef.test_cpu__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        }
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I = 0U;
                        }
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                               ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                   ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                    ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))
                                                     : 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.test_cpu__DOT__data_in)))))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                    ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                    : (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__operand))));
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                = (1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N = 0U;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = (0x0000007fU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                                  >> 1U));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (0x0000007fU 
                                          & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                             >> 1U)));
                        }
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                            = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                               ^ (IData)(vlSelfRef.test_cpu__DOT__data_in));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                        vlSelfRef.test_cpu__DOT__data_out 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                        vlSelfRef.test_cpu__DOT__rw = 0U;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                            = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                              - (IData)(1U)));
                    }
                } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                        = (0x000000ffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                }
            } else if ((0x00000020U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C = 1U;
                        }
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                               ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                   ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                    ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__N)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.test_cpu__DOT__data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        } else {
                            vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                                = ((0x000000feU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                                   << 1U)) 
                                   | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                         >> 7U));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                                = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                                = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                            vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                                = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                            = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                               & (IData)(vlSelfRef.test_cpu__DOT__data_in));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP)));
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                    }
                } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                    }
                } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                    vlSelfRef.test_cpu__DOT__data_out 
                        = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                          >> 8U));
                    vlSelfRef.test_cpu__DOT__rw = 0U;
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                          - (IData)(1U)));
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                }
            } else if ((0x00000010U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C = 0U;
                    }
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = (0x0000ffffU & ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                           ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                           : ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                               ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                               : ((1U 
                                                   & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))
                                                   ? (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)
                                                   : 
                                                  ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__N)
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC))
                                                    : 
                                                   ((IData)(1U) 
                                                    + 
                                                    ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                                     + 
                                                     ((0x0000ff00U 
                                                       & ((- (IData)(
                                                                     (1U 
                                                                      & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                                         >> 7U)))) 
                                                          << 8U)) 
                                                      | (IData)(vlSelfRef.test_cpu__DOT__data_in)))))))));
                }
            } else if ((8U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                     >> 7U));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                            = (0x000000feU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                              << 1U));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                            = (0U == (0x0000007fU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A)));
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                            = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                     >> 6U));
                    }
                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                        = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                           | (IData)(vlSelfRef.test_cpu__DOT__data_in));
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                        = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                        = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                                 >> 7U));
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                    vlSelfRef.test_cpu__DOT__data_out 
                        = (0x00000020U | ((((((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__N) 
                                              << 3U) 
                                             | ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__V) 
                                                << 2U)) 
                                            | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__B)) 
                                           << 4U) | 
                                          ((((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__D) 
                                             << 3U) 
                                            | ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__I) 
                                               << 2U)) 
                                           | (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Z) 
                                               << 1U) 
                                              | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)))));
                    vlSelfRef.test_cpu__DOT__rw = 0U;
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                          - (IData)(1U)));
                }
            } else if ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                        vlSelfRef.__Vdly__test_cpu__DOT__addr 
                            = vlSelfRef.test_cpu__DOT__data_in;
                        vlSelfRef.test_cpu__DOT__rw = 1U;
                    }
                } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                    vlSelfRef.__Vdly__test_cpu__DOT__addr 
                        = vlSelfRef.test_cpu__DOT__data_in;
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                } else {
                    vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
                }
            } else if ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
            } else if ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC)));
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                      + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__X)));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 1U;
            } else {
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                vlSelfRef.test_cpu__DOT__data_out = 
                    (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                    >> 8U));
                vlSelfRef.test_cpu__DOT__rw = 0U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__B = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                      - (IData)(1U)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = vlSelfRef.test_cpu__DOT__dut__DOT__PC;
            }
            vlSelfRef.test_cpu__DOT__dut__DOT__operand 
                = vlSelfRef.test_cpu__DOT__data_in;
        } else if ((4U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            if ((((((((0xa1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                      | (0x81U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                     | (1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                    | (0x21U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                   | (0xb1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                  | (0x91U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                 & (1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.test_cpu__DOT__addr)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__indirect_addr_lo 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 2U;
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((((((0xa1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                           | (0x81U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | (1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                         | (0x21U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count)))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_hi 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_lo));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 0U;
                if ((0x81U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.test_cpu__DOT__data_out 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                    vlSelfRef.test_cpu__DOT__rw = 0U;
                } else {
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                }
            } else if ((((0xb1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                         | (0x91U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count)))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_hi 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x0000ffffU & ((((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_lo)) 
                                      + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 0U;
                if ((0x91U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                    vlSelfRef.test_cpu__DOT__data_out 
                        = vlSelfRef.test_cpu__DOT__dut__DOT__A;
                    vlSelfRef.test_cpu__DOT__rw = 0U;
                } else {
                    vlSelfRef.test_cpu__DOT__rw = 1U;
                }
            } else if ((((((((0xa5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                             | (0xadU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                            | (0xb5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                           | (0xbdU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | (0xb9U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                         | (0xa1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        | (0xb1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((((0xa6U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                         | (0xb6U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        | (0xaeU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if (((0xa4U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                        | (0xb4U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((0x68U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = vlSelfRef.test_cpu__DOT__data_in;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((0x28U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 6U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__B 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 4U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 3U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 2U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 1U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = (1U & (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                       | (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                             >> 7U));
            } else if ((1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                       | (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                             >> 7U));
            } else if ((0x21U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                       & (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = vlSelfRef.test_cpu__DOT__dut__DOT__temp_result;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                             >> 7U));
            } else if ((0x24U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                              & (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 6U));
                vlSelfRef.test_cpu__DOT__rw = 1U;
            } else if ((6U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 7U));
                vlSelfRef.test_cpu__DOT__dut__DOT__alu_result 
                    = (0x000000feU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                      << 1U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (0x0000007fU & (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                             >> 6U));
                vlSelfRef.test_cpu__DOT__data_out = 
                    (0x000000feU & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                    << 1U));
                vlSelfRef.test_cpu__DOT__rw = 0U;
            } else if ((0xc5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                      - (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                       >= (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                       == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                             >> 7U));
            } else if ((0xc4U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                                      - (IData)(vlSelfRef.test_cpu__DOT__data_in)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                       >= (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Y) 
                       == (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_result) 
                             >> 7U));
            } else if ((((((0x65U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                           | (0x75U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | (0x6dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                         | (0x7dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        | (0x79U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum 
                    = (0x000001ffU & (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                       + (IData)(vlSelfRef.test_cpu__DOT__data_in)) 
                                      + (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                             >> 8U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                             >> 7U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V 
                    = (((1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                               >> 7U)) == (1U & ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                                                 >> 7U))) 
                       & ((1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                 >> 7U)) != (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_sum) 
                                                   >> 7U))));
            } else if ((((((0xe5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                           | (0xf5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | (0xedU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                         | (0xfdU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                        | (0xf9U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)))) {
                vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff 
                    = (0x000001ffU & (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__A) 
                                       - (IData)(vlSelfRef.test_cpu__DOT__data_in)) 
                                      - (1U & (~ (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)))));
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C 
                    = (1U & (~ ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff) 
                                >> 8U)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff)));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N 
                    = (1U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__temp_diff) 
                             >> 7U));
            }
        } else if ((5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            vlSelfRef.test_cpu__DOT__rw = 1U;
        } else if ((6U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                vlSelfRef.test_cpu__DOT__data_out = 
                    (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC) 
                                    >> 8U));
                vlSelfRef.test_cpu__DOT__rw = 0U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((1U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                vlSelfRef.test_cpu__DOT__data_out = 
                    (0x000000ffU & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__PC));
                vlSelfRef.test_cpu__DOT__rw = 0U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 2U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP));
                vlSelfRef.test_cpu__DOT__data_out = 
                    (0x00000020U | ((((((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__N) 
                                        << 3U) | ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__V) 
                                                  << 2U)) 
                                      | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__B)) 
                                     << 4U) | ((((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__D) 
                                                 << 3U) 
                                                | ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__I) 
                                                   << 2U)) 
                                               | (((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__Z) 
                                                   << 1U) 
                                                  | (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__C)))));
                vlSelfRef.test_cpu__DOT__rw = 0U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 3U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((3U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__addr = 0xfffaU;
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 4U;
            } else if ((4U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = ((0xff00U & (IData)(vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC)) 
                       | (IData)(vlSelfRef.test_cpu__DOT__data_in));
                vlSelfRef.__Vdly__test_cpu__DOT__addr = 0xfffbU;
                vlSelfRef.test_cpu__DOT__rw = 1U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 5U;
            } else if ((5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC 
                    = ((0x00ffU & (IData)(vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC)) 
                       | ((IData)(vlSelfRef.test_cpu__DOT__data_in) 
                          << 8U));
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 0U;
                vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending = 0U;
                vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I = 1U;
            }
        }
        vlSelfRef.test_cpu__DOT__dut__DOT__nmi_prev 
            = vlSelfRef.test_cpu__DOT__nmi;
        vlSelfRef.test_cpu__DOT__dut__DOT__state = vlSelfRef.test_cpu__DOT__dut__DOT__next_state;
    } else {
        vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending = 0U;
        vlSelfRef.test_cpu__DOT__dut__DOT__state = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count = 0U;
        vlSelfRef.test_cpu__DOT__rw = 1U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP = 0xfdU;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I = 1U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__B = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N = 0U;
        vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = 0U;
        vlSelfRef.test_cpu__DOT__dut__DOT__nmi_prev = 0U;
    }
    vlSelfRef.test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.test_cpu__DOT__dut__DOT__PC = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__PC;
    vlSelfRef.test_cpu__DOT__dut__DOT__D = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__D;
    vlSelfRef.test_cpu__DOT__dut__DOT__C = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__C;
    vlSelfRef.test_cpu__DOT__dut__DOT__A = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__A;
    vlSelfRef.test_cpu__DOT__dut__DOT__Z = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Z;
    vlSelfRef.test_cpu__DOT__dut__DOT__N = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__N;
    vlSelfRef.test_cpu__DOT__dut__DOT__X = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__X;
    vlSelfRef.test_cpu__DOT__dut__DOT__Y = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__Y;
    vlSelfRef.test_cpu__DOT__dut__DOT__V = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__V;
    vlSelfRef.test_cpu__DOT__dut__DOT__SP = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__SP;
    vlSelfRef.test_cpu__DOT__dut__DOT__I = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__I;
    vlSelfRef.test_cpu__DOT__dut__DOT__B = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__B;
    vlSelfRef.test_cpu__DOT__dut__DOT__indirect_addr_lo 
        = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__indirect_addr_lo;
    vlSelfRef.test_cpu__DOT__addr = vlSelfRef.__Vdly__test_cpu__DOT__addr;
    vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count 
        = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__cycle_count;
    vlSelfRef.test_cpu__DOT__dut__DOT__opcode = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__opcode;
    vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle = vlSelfRef.__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle;
    vlSelfRef.test_cpu__DOT__dut__DOT__next_state = 
        ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
          ? ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
              ? ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                  ? 1U : ((5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))
                           ? 1U : 6U)) : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                                           ? 1U : (
                                                   (0U 
                                                    < (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))
                                                    ? 4U
                                                    : 5U)))
          : ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
              ? ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                  ? ((((1U == (3U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                       & (4U != (7U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode) 
                                       >> 2U)))) | 
                      ((0x85U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                       | (((0x8dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                           | (0x95U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | ((0x9dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                             | ((0x86U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                | ((0x96U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                   | ((0x84U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                      | ((0x94U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                         | ((0xa5U 
                                             == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                            | ((0xadU 
                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                               | ((0xb5U 
                                                   == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                  | ((0xbdU 
                                                      == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                     | ((0xb9U 
                                                         == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                        | ((0xa6U 
                                                            == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                           | ((0xb6U 
                                                               == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                              | ((0xaeU 
                                                                  == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                 | ((0xa4U 
                                                                     == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                    | ((0xb4U 
                                                                        == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                       | ((5U 
                                                                           == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                          | ((0x24U 
                                                                              == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                             | ((6U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xc5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xc4U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x65U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x75U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x6dU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x7dU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x79U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xe5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xf5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xedU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xfdU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xf9U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xa1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xb1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x81U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x91U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | (0x21U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))))))))))))))))))))))))))))))))))))))))
                      ? 4U : 1U) : 3U) : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                                           ? ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending)
                                               ? 6U
                                               : 2U)
                                           : ((2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))
                                               ? 1U
                                               : 0U))));
}

void Vtest_cpu___024root___eval_nba(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_nba\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_cpu___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_cpu___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_cpu___024root___nba_sequent__TOP__2(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
    if ((7ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_cpu___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vtest_cpu___024root___timing_resume(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___timing_resume\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vtest_cpu___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_cpu___024root___eval_phase__act(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_phase__act\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vtest_cpu___024root___eval_triggers__act(vlSelf);
    Vtest_cpu___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vtest_cpu___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vtest_cpu___024root___timing_resume(vlSelf);
        Vtest_cpu___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vtest_cpu___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_cpu___024root___eval_phase__nba(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_phase__nba\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vtest_cpu___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vtest_cpu___024root___eval_nba(vlSelf);
        Vtest_cpu___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vtest_cpu___024root___eval(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vtest_cpu___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("test_cpu.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vtest_cpu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("test_cpu.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vtest_cpu___024root___eval_phase__act(vlSelf));
    } while (Vtest_cpu___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vtest_cpu___024root___eval_debug_assertions(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_debug_assertions\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
