// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_dma.h for the primary calling header

#include "Vtest_dma__pch.h"

VL_ATTR_COLD void Vtest_dma___024root___eval_initial__TOP(Vtest_dma___024root* vlSelf);
VlCoroutine Vtest_dma___024root___eval_initial__TOP__Vtiming__0(Vtest_dma___024root* vlSelf);
VlCoroutine Vtest_dma___024root___eval_initial__TOP__Vtiming__1(Vtest_dma___024root* vlSelf);

void Vtest_dma___024root___eval_initial(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_initial\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_dma___024root___eval_initial__TOP(vlSelf);
    Vtest_dma___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtest_dma___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vtest_dma___024root___eval_initial__TOP__Vtiming__0(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile("waveforms/test_dma.vcd"s);
    vlSymsp->_traceDumpOpen();
    vlSelfRef.test_dma__DOT__rst_n = 0U;
    vlSelfRef.test_dma__DOT__dma_start = 0U;
    vlSelfRef.test_dma__DOT__dma_page = 0U;
    vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000100U, vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.test_dma__DOT__test_ram[(0x000000ffU 
                                           & vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i)] 
            = (0x000000ffU & vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i);
        vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i 
            = ((IData)(1U) + vlSelfRef.test_dma__DOT__unnamedblk1__DOT__i);
    }
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000014ULL, 
                                         nullptr, "test_dma.sv", 
                                         48);
    vlSelfRef.test_dma__DOT__rst_n = 1U;
    VL_WRITEF_NX("[TEST] Starting DMA from page $02\n",0);
    vlSelfRef.test_dma__DOT__dma_page = 2U;
    vlSelfRef.test_dma__DOT__dma_start = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x000000000000000aULL, 
                                         nullptr, "test_dma.sv", 
                                         54);
    vlSelfRef.test_dma__DOT__dma_start = 0U;
    while (vlSelfRef.test_dma__DOT__dma_active) {
        co_await vlSelfRef.__VtrigSched_h58b62cd4__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( (~ test_dma.dma_active))", 
                                                             "test_dma.sv", 
                                                             57);
    }
    co_await vlSelfRef.__VdlySched.delay(0x000000000000000aULL, 
                                         nullptr, "test_dma.sv", 
                                         58);
    VL_WRITEF_NX("[TEST] DMA transfer complete\n[TEST] Starting DMA from page $03\n",0);
    vlSelfRef.test_dma__DOT__dma_page = 3U;
    vlSelfRef.test_dma__DOT__dma_start = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x000000000000000aULL, 
                                         nullptr, "test_dma.sv", 
                                         66);
    vlSelfRef.test_dma__DOT__dma_start = 0U;
    while (vlSelfRef.test_dma__DOT__dma_active) {
        co_await vlSelfRef.__VtrigSched_h58b62cd4__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( (~ test_dma.dma_active))", 
                                                             "test_dma.sv", 
                                                             68);
    }
    co_await vlSelfRef.__VdlySched.delay(0x000000000000000aULL, 
                                         nullptr, "test_dma.sv", 
                                         69);
    VL_WRITEF_NX("[TEST] All tests passed!\n",0);
    VL_FINISH_MT("test_dma.sv", 72, "");
}

VlCoroutine Vtest_dma___024root___eval_initial__TOP__Vtiming__1(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "test_dma.sv", 
                                             28);
        vlSelfRef.test_dma__DOT__clk = (1U & (~ (IData)(vlSelfRef.test_dma__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_dma___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vtest_dma___024root___eval_triggers__act(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_triggers__act\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __Vtrigprevexpr_hcd016d00__0;
    __Vtrigprevexpr_hcd016d00__0 = 0;
    // Body
    __Vtrigprevexpr_hcd016d00__0 = (1U & (~ (IData)(vlSelfRef.test_dma__DOT__dma_active)));
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    (((((IData)(__Vtrigprevexpr_hcd016d00__0) 
                                                        != (IData)(vlSelfRef.__Vtrigprevexpr_hcd016d00__1)) 
                                                       << 3U) 
                                                      | (vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                         << 2U)) 
                                                     | ((((~ (IData)(vlSelfRef.test_dma__DOT__rst_n)) 
                                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__rst_n__0)) 
                                                         << 1U) 
                                                        | ((IData)(vlSelfRef.test_dma__DOT__clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__clk__0)))))));
    vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__clk__0 
        = vlSelfRef.test_dma__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__rst_n__0 
        = vlSelfRef.test_dma__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr_hcd016d00__1 = __Vtrigprevexpr_hcd016d00__0;
    if (VL_UNLIKELY(((1U & (~ (IData)(vlSelfRef.__VactDidInit)))))) {
        vlSelfRef.__VactDidInit = 1U;
        vlSelfRef.__VactTriggered[0U] = (8ULL | vlSelfRef.__VactTriggered
                                         [0U]);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_dma___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vtest_dma___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___trigger_anySet__act\n"); );
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

void Vtest_dma___024root___act_comb__TOP__0(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___act_comb__TOP__0\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_dma__DOT__ram_data = vlSelfRef.test_dma__DOT__test_ram
        [vlSelfRef.test_dma__DOT__ram_addr_low];
}

void Vtest_dma___024root___eval_act(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_act\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x000000000000000cULL & vlSelfRef.__VactTriggered
         [0U])) {
        Vtest_dma___024root___act_comb__TOP__0(vlSelf);
    }
}

void Vtest_dma___024root___nba_sequent__TOP__0(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___nba_sequent__TOP__0\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__test_dma__DOT__dma_active = vlSelfRef.test_dma__DOT__dma_active;
    vlSelfRef.__Vdly__test_dma__DOT__dut__DOT__dma_offset 
        = vlSelfRef.test_dma__DOT__dut__DOT__dma_offset;
}

void Vtest_dma___024root___nba_sequent__TOP__1(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___nba_sequent__TOP__1\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY((vlSelfRef.test_dma__DOT__oam_write))) {
        VL_WRITEF_NX("  OAM[$%02x] = $%02x\n",0,8,vlSelfRef.test_dma__DOT__oam_addr,
                     8,(IData)(vlSelfRef.test_dma__DOT__oam_data));
    }
}

void Vtest_dma___024root___nba_sequent__TOP__2(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___nba_sequent__TOP__2\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.test_dma__DOT__rst_n) {
        if (((IData)(vlSelfRef.test_dma__DOT__dma_start) 
             & (~ (IData)(vlSelfRef.test_dma__DOT__dma_active)))) {
            vlSelfRef.__Vdly__test_dma__DOT__dma_active = 1U;
            vlSelfRef.__Vdly__test_dma__DOT__dut__DOT__dma_offset = 0U;
        } else if (vlSelfRef.test_dma__DOT__dma_active) {
            vlSelfRef.test_dma__DOT__ram_addr_low = vlSelfRef.test_dma__DOT__dut__DOT__dma_offset;
            vlSelfRef.test_dma__DOT__oam_data = vlSelfRef.test_dma__DOT__ram_data;
            vlSelfRef.test_dma__DOT__oam_addr = vlSelfRef.test_dma__DOT__dut__DOT__dma_offset;
            vlSelfRef.test_dma__DOT__oam_write = 1U;
            vlSelfRef.__Vdly__test_dma__DOT__dut__DOT__dma_offset 
                = (0x000000ffU & ((IData)(1U) + (IData)(vlSelfRef.test_dma__DOT__dut__DOT__dma_offset)));
            if ((0xffU == (IData)(vlSelfRef.test_dma__DOT__dut__DOT__dma_offset))) {
                vlSelfRef.__Vdly__test_dma__DOT__dma_active = 0U;
                vlSelfRef.test_dma__DOT__oam_write = 0U;
            }
        } else {
            vlSelfRef.test_dma__DOT__oam_write = 0U;
        }
    } else {
        vlSelfRef.__Vdly__test_dma__DOT__dma_active = 0U;
        vlSelfRef.__Vdly__test_dma__DOT__dut__DOT__dma_offset = 0U;
        vlSelfRef.test_dma__DOT__oam_write = 0U;
    }
    vlSelfRef.test_dma__DOT__dma_active = vlSelfRef.__Vdly__test_dma__DOT__dma_active;
    vlSelfRef.test_dma__DOT__dut__DOT__dma_offset = vlSelfRef.__Vdly__test_dma__DOT__dut__DOT__dma_offset;
}

void Vtest_dma___024root___eval_nba(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_nba\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_dma___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_dma___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_dma___024root___nba_sequent__TOP__2(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
    if ((0x000000000000000fULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vtest_dma___024root___act_comb__TOP__0(vlSelf);
    }
}

void Vtest_dma___024root___timing_commit(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___timing_commit\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (8ULL & vlSelfRef.__VactTriggered[0U]))) {
        vlSelfRef.__VtrigSched_h58b62cd4__0.commit(
                                                   "@( (~ test_dma.dma_active))");
    }
}

void Vtest_dma___024root___timing_resume(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___timing_resume\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((8ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VtrigSched_h58b62cd4__0.resume(
                                                   "@( (~ test_dma.dma_active))");
    }
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vtest_dma___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_dma___024root___eval_phase__act(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_phase__act\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vtest_dma___024root___eval_triggers__act(vlSelf);
    Vtest_dma___024root___timing_commit(vlSelf);
    Vtest_dma___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vtest_dma___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vtest_dma___024root___timing_resume(vlSelf);
        Vtest_dma___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vtest_dma___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_dma___024root___eval_phase__nba(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_phase__nba\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vtest_dma___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vtest_dma___024root___eval_nba(vlSelf);
        Vtest_dma___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vtest_dma___024root___eval(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vtest_dma___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("test_dma.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vtest_dma___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("test_dma.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vtest_dma___024root___eval_phase__act(vlSelf));
    } while (Vtest_dma___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vtest_dma___024root___eval_debug_assertions(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_debug_assertions\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
