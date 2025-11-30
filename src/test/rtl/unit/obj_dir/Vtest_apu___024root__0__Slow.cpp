// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_apu.h for the primary calling header

#include "Vtest_apu__pch.h"

VL_ATTR_COLD void Vtest_apu___024root___eval_static(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_static\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__clk__0 
        = vlSelfRef.test_apu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__rst_n__0 
        = vlSelfRef.test_apu__DOT__rst_n;
}

VL_ATTR_COLD void Vtest_apu___024root___eval_initial__TOP(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_initial__TOP\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_apu__DOT__clk = 0U;
}

VL_ATTR_COLD void Vtest_apu___024root___eval_final(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_final\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_apu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtest_apu___024root___eval_phase__stl(Vtest_apu___024root* vlSelf);

VL_ATTR_COLD void Vtest_apu___024root___eval_settle(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_settle\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vtest_apu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("test_apu.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vtest_apu___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vtest_apu___024root___eval_triggers__stl(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_triggers__stl\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_apu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vtest_apu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_apu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_apu___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vtest_apu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___trigger_anySet__stl\n"); );
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

void Vtest_apu___024root___act_sequent__TOP__0(Vtest_apu___024root* vlSelf);
VL_ATTR_COLD void Vtest_apu___024root____Vm_traceActivitySetAll(Vtest_apu___024root* vlSelf);

VL_ATTR_COLD void Vtest_apu___024root___eval_stl(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_stl\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vtest_apu___024root___act_sequent__TOP__0(vlSelf);
        Vtest_apu___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool Vtest_apu___024root___eval_phase__stl(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_phase__stl\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtest_apu___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vtest_apu___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vtest_apu___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vtest_apu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_apu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_apu___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge test_apu.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge test_apu.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtest_apu___024root____Vm_traceActivitySetAll(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root____Vm_traceActivitySetAll\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.__Vm_traceActivity[3U] = 1U;
    vlSelfRef.__Vm_traceActivity[4U] = 1U;
    vlSelfRef.__Vm_traceActivity[5U] = 1U;
}

VL_ATTR_COLD void Vtest_apu___024root___ctor_var_reset(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___ctor_var_reset\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->test_apu__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9364669598594227576ull);
    vlSelf->test_apu__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 93038842382299351ull);
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__apu_pulse1[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6436202121759773563ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__apu_pulse2[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12667057918418963328ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__apu_triangle[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16554737090672318455ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__apu_noise[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5712754761227076821ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__apu_dmc[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16599787838191624696ull);
    }
    vlSelf->test_apu__DOT__apu_status = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1452074857779612397ull);
    vlSelf->test_apu__DOT__unnamedblk1__DOT__i = 0;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__dut__DOT__apu_pulse1[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3834785682843656116ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__dut__DOT__apu_pulse2[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1783374011864827250ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__dut__DOT__apu_triangle[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5472049522811249287ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__dut__DOT__apu_noise[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 18397356668522950446ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->test_apu__DOT__dut__DOT__apu_dmc[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10504255357632170960ull);
    }
    vlSelf->test_apu__DOT__dut__DOT__audio_counter = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 18180551769591031114ull);
    vlSelf->test_apu__DOT__dut__DOT__test_tone = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 10932567768164712987ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 4249688352831210947ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 14220763442771172265ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_volume = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 9358285027458356257ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_enabled = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4911695693575181959ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_out_bit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14193283676560750550ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse1_out = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 17014062235774731665ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 13575793000798914890ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 9885730117790807826ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_volume = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 7754094512736408218ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_enabled = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13847094723403044150ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_out_bit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6779433344935118145ull);
    vlSelf->test_apu__DOT__dut__DOT__pulse2_out = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 3677827815635258628ull);
    vlSelf->__Vdly__test_apu__DOT__dut__DOT__test_tone = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 16981127473717572124ull);
    vlSelf->__Vdly__test_apu__DOT__dut__DOT__pulse1_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 17294540234314464297ull);
    vlSelf->__Vdly__test_apu__DOT__dut__DOT__pulse1_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 7382846797313765928ull);
    vlSelf->__Vdly__test_apu__DOT__dut__DOT__pulse2_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 11871750931512112173ull);
    vlSelf->__Vdly__test_apu__DOT__dut__DOT__pulse2_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 4401650374329592567ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__test_apu__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6996539763398723159ull);
    vlSelf->__Vtrigprevexpr___TOP__test_apu__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12423239388500132615ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 6; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
