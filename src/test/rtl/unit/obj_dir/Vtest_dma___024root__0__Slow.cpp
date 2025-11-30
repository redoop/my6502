// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_dma.h for the primary calling header

#include "Vtest_dma__pch.h"

VL_ATTR_COLD void Vtest_dma___024root___eval_static(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_static\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__clk__0 
        = vlSelfRef.test_dma__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_dma__DOT__rst_n__0 
        = vlSelfRef.test_dma__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr_hcd016d00__1 = (1U & 
                                              (~ (IData)(vlSelfRef.test_dma__DOT__dma_active)));
}

VL_ATTR_COLD void Vtest_dma___024root___eval_initial__TOP(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_initial__TOP\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_dma__DOT__clk = 0U;
}

VL_ATTR_COLD void Vtest_dma___024root___eval_final(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_final\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_dma___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtest_dma___024root___eval_phase__stl(Vtest_dma___024root* vlSelf);

VL_ATTR_COLD void Vtest_dma___024root___eval_settle(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_settle\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vtest_dma___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("test_dma.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vtest_dma___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vtest_dma___024root___eval_triggers__stl(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_triggers__stl\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_dma___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vtest_dma___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_dma___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_dma___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vtest_dma___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___trigger_anySet__stl\n"); );
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

void Vtest_dma___024root___act_comb__TOP__0(Vtest_dma___024root* vlSelf);

VL_ATTR_COLD void Vtest_dma___024root___eval_stl(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_stl\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vtest_dma___024root___act_comb__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vtest_dma___024root___eval_phase__stl(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___eval_phase__stl\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtest_dma___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vtest_dma___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vtest_dma___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vtest_dma___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_dma___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_dma___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge test_dma.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge test_dma.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((1U & (IData)((triggers[0U] >> 3U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 3 is active: @( (~ test_dma.dma_active))\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtest_dma___024root___ctor_var_reset(Vtest_dma___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_dma___024root___ctor_var_reset\n"); );
    Vtest_dma__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->test_dma__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4498722279633393342ull);
    vlSelf->test_dma__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6672502065712589054ull);
    vlSelf->test_dma__DOT__dma_start = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5395996884592836394ull);
    vlSelf->test_dma__DOT__dma_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 936791808146204796ull);
    vlSelf->test_dma__DOT__dma_page = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 992354774745559873ull);
    vlSelf->test_dma__DOT__ram_data = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7523118200057129368ull);
    vlSelf->test_dma__DOT__ram_addr_low = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9443053538127146776ull);
    vlSelf->test_dma__DOT__oam_addr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6048507196443386800ull);
    vlSelf->test_dma__DOT__oam_data = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9303337217003233151ull);
    vlSelf->test_dma__DOT__oam_write = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13097081128976327333ull);
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->test_dma__DOT__test_ram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9006330383477744036ull);
    }
    vlSelf->test_dma__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->test_dma__DOT__dut__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 739680564510009720ull);
    vlSelf->__Vdly__test_dma__DOT__dma_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10075054306506500945ull);
    vlSelf->__Vdly__test_dma__DOT__dut__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12454942871565431074ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__test_dma__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14950786756477511222ull);
    vlSelf->__Vtrigprevexpr___TOP__test_dma__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4509571004836761673ull);
    vlSelf->__Vtrigprevexpr_hcd016d00__1 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15468905930913493266ull);
    vlSelf->__VactDidInit = 0;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
