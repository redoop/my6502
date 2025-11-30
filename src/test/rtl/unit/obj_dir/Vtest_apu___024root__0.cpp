// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_apu.h for the primary calling header

#include "Vtest_apu__pch.h"

VL_ATTR_COLD void Vtest_apu___024root___eval_initial__TOP(Vtest_apu___024root* vlSelf);
VlCoroutine Vtest_apu___024root___eval_initial__TOP__Vtiming__0(Vtest_apu___024root* vlSelf);
VlCoroutine Vtest_apu___024root___eval_initial__TOP__Vtiming__1(Vtest_apu___024root* vlSelf);

void Vtest_apu___024root___eval_initial(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_initial\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_apu___024root___eval_initial__TOP(vlSelf);
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    Vtest_apu___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtest_apu___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vtest_apu___024root___eval_initial__TOP__Vtiming__0(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile("test_apu.vcd"s);
    vlSymsp->_traceDumpOpen();
    vlSelfRef.test_apu__DOT__rst_n = 0U;
    vlSelfRef.test_apu__DOT__apu_status = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse1[0U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse2[0U] = 0U;
    vlSelfRef.test_apu__DOT__apu_triangle[0U] = 0U;
    vlSelfRef.test_apu__DOT__apu_noise[0U] = 0U;
    vlSelfRef.test_apu__DOT__apu_dmc[0U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse1[1U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse2[1U] = 0U;
    vlSelfRef.test_apu__DOT__apu_triangle[1U] = 0U;
    vlSelfRef.test_apu__DOT__apu_noise[1U] = 0U;
    vlSelfRef.test_apu__DOT__apu_dmc[1U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse1[2U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse2[2U] = 0U;
    vlSelfRef.test_apu__DOT__apu_triangle[2U] = 0U;
    vlSelfRef.test_apu__DOT__apu_noise[2U] = 0U;
    vlSelfRef.test_apu__DOT__apu_dmc[2U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse1[3U] = 0U;
    vlSelfRef.test_apu__DOT__apu_pulse2[3U] = 0U;
    vlSelfRef.test_apu__DOT__apu_triangle[3U] = 0U;
    vlSelfRef.test_apu__DOT__apu_noise[3U] = 0U;
    vlSelfRef.test_apu__DOT__apu_dmc[3U] = 0U;
    vlSelfRef.test_apu__DOT__unnamedblk1__DOT__i = 4U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000014ULL, 
                                         nullptr, "test_apu.sv", 
                                         47);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.test_apu__DOT__rst_n = 1U;
    VL_WRITEF_NX("[TEST] Enable Pulse 1 channel\n",0);
    vlSelfRef.test_apu__DOT__apu_status = 1U;
    vlSelfRef.test_apu__DOT__apu_pulse1[0U] = 0x8fU;
    vlSelfRef.test_apu__DOT__apu_pulse1[2U] = 0xffU;
    vlSelfRef.test_apu__DOT__apu_pulse1[3U] = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x00000000000003e8ULL, 
                                         nullptr, "test_apu.sv", 
                                         56);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    VL_WRITEF_NX("[TEST] Enable Pulse 2 channel\n",0);
    vlSelfRef.test_apu__DOT__apu_status = 3U;
    vlSelfRef.test_apu__DOT__apu_pulse2[0U] = 0x8fU;
    vlSelfRef.test_apu__DOT__apu_pulse2[2U] = 0xffU;
    vlSelfRef.test_apu__DOT__apu_pulse2[3U] = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x00000000000003e8ULL, 
                                         nullptr, "test_apu.sv", 
                                         65);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    VL_WRITEF_NX("[TEST] Disable all channels\n",0);
    vlSelfRef.test_apu__DOT__apu_status = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000064ULL, 
                                         nullptr, "test_apu.sv", 
                                         71);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    VL_WRITEF_NX("[TEST] All tests passed!\n",0);
    VL_FINISH_MT("test_apu.sv", 74, "");
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
}

VlCoroutine Vtest_apu___024root___eval_initial__TOP__Vtiming__1(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "test_apu.sv", 
                                             30);
        vlSelfRef.test_apu__DOT__clk = (1U & (~ (IData)(vlSelfRef.test_apu__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_apu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vtest_apu___024root___eval_triggers__act(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_triggers__act\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                      << 2U) 
                                                     | ((((~ (IData)(vlSelfRef.test_apu__DOT__rst_n)) 
                                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__rst_n__0)) 
                                                         << 1U) 
                                                        | ((IData)(vlSelfRef.test_apu__DOT__clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__clk__0)))))));
    vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__clk__0 
        = vlSelfRef.test_apu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_apu__DOT__rst_n__0 
        = vlSelfRef.test_apu__DOT__rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_apu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vtest_apu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___trigger_anySet__act\n"); );
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

void Vtest_apu___024root___act_sequent__TOP__0(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___act_sequent__TOP__0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[0U] 
        = vlSelfRef.test_apu__DOT__apu_pulse1[0U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[1U] 
        = vlSelfRef.test_apu__DOT__apu_pulse1[1U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[2U] 
        = vlSelfRef.test_apu__DOT__apu_pulse1[2U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse1[3U] 
        = vlSelfRef.test_apu__DOT__apu_pulse1[3U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[0U] 
        = vlSelfRef.test_apu__DOT__apu_pulse2[0U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[1U] 
        = vlSelfRef.test_apu__DOT__apu_pulse2[1U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[2U] 
        = vlSelfRef.test_apu__DOT__apu_pulse2[2U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_pulse2[3U] 
        = vlSelfRef.test_apu__DOT__apu_pulse2[3U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[0U] 
        = vlSelfRef.test_apu__DOT__apu_triangle[0U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[1U] 
        = vlSelfRef.test_apu__DOT__apu_triangle[1U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[2U] 
        = vlSelfRef.test_apu__DOT__apu_triangle[2U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_triangle[3U] 
        = vlSelfRef.test_apu__DOT__apu_triangle[3U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[0U] 
        = vlSelfRef.test_apu__DOT__apu_noise[0U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[1U] 
        = vlSelfRef.test_apu__DOT__apu_noise[1U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[2U] 
        = vlSelfRef.test_apu__DOT__apu_noise[2U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_noise[3U] 
        = vlSelfRef.test_apu__DOT__apu_noise[3U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[0U] 
        = vlSelfRef.test_apu__DOT__apu_dmc[0U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[1U] 
        = vlSelfRef.test_apu__DOT__apu_dmc[1U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[2U] 
        = vlSelfRef.test_apu__DOT__apu_dmc[2U];
    vlSelfRef.test_apu__DOT__dut__DOT__apu_dmc[3U] 
        = vlSelfRef.test_apu__DOT__apu_dmc[3U];
}

void Vtest_apu___024root___eval_act(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_act\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        Vtest_apu___024root___act_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
}

void Vtest_apu___024root___nba_sequent__TOP__0(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___nba_sequent__TOP__0\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    SData/*15:0*/ __Vdly__test_apu__DOT__dut__DOT__audio_counter;
    __Vdly__test_apu__DOT__dut__DOT__audio_counter = 0;
    // Body
    __Vdly__test_apu__DOT__dut__DOT__audio_counter 
        = vlSelfRef.test_apu__DOT__dut__DOT__audio_counter;
    vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__test_tone 
        = vlSelfRef.test_apu__DOT__dut__DOT__test_tone;
    vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_duty 
        = vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty;
    vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_timer 
        = vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer;
    vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_duty 
        = vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty;
    vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_timer 
        = vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer;
    if (vlSelfRef.test_apu__DOT__rst_n) {
        __Vdly__test_apu__DOT__dut__DOT__audio_counter 
            = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__audio_counter)));
        if ((0x07f2U <= (IData)(vlSelfRef.test_apu__DOT__dut__DOT__audio_counter))) {
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__test_tone 
                = ((0x00008000U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone))
                    ? 0U : 0x1000U);
            __Vdly__test_apu__DOT__dut__DOT__audio_counter = 0U;
        }
    } else {
        vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__test_tone = 0U;
        __Vdly__test_apu__DOT__dut__DOT__audio_counter = 0U;
    }
    vlSelfRef.test_apu__DOT__dut__DOT__audio_counter 
        = __Vdly__test_apu__DOT__dut__DOT__audio_counter;
}

void Vtest_apu___024root___nba_sequent__TOP__1(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___nba_sequent__TOP__1\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY((((0U != (0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                             + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                                + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out))))) 
                      | (0U != (0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                               + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                                  + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out))))))))) {
        VL_WRITEF_NX("  Audio: L=$%04x R=$%04x\n",0,
                     16,(0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                        + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                           + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out)))),
                     16,(0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__test_tone) 
                                        + ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out) 
                                           + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out)))));
    }
}

void Vtest_apu___024root___nba_sequent__TOP__3(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___nba_sequent__TOP__3\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_apu__DOT__dut__DOT__test_tone = vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__test_tone;
    if (vlSelfRef.test_apu__DOT__rst_n) {
        vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out 
            = (((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_enabled) 
                & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out_bit))
                ? ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_volume) 
                   << 0x0000000cU) : 0U);
        vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out 
            = (((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_enabled) 
                & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out_bit))
                ? ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_volume) 
                   << 0x0000000cU) : 0U);
        vlSelfRef.test_apu__DOT__dut__DOT__pulse1_volume 
            = (0x0000000fU & vlSelfRef.test_apu__DOT__apu_pulse1
               [0U]);
        if ((0U == (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer))) {
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_duty 
                = (0x0000000fU & ((IData)(1U) + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty)));
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_timer 
                = ((0x00000700U & (vlSelfRef.test_apu__DOT__apu_pulse1
                                   [3U] << 8U)) | vlSelfRef.test_apu__DOT__apu_pulse1
                   [2U]);
        } else {
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_timer 
                = (0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer) 
                                  - (IData)(1U)));
        }
        vlSelfRef.test_apu__DOT__dut__DOT__pulse1_out_bit 
            = ((0x00000080U & vlSelfRef.test_apu__DOT__apu_pulse1
                [0U]) ? ((0x00000040U & vlSelfRef.test_apu__DOT__apu_pulse1
                          [0U]) ? (2U <= (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty)))
                          : (4U > (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty))))
                : ((0x00000040U & vlSelfRef.test_apu__DOT__apu_pulse1
                    [0U]) ? (2U > (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty)))
                    : (0U == (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty)))));
        vlSelfRef.test_apu__DOT__dut__DOT__pulse2_volume 
            = (0x0000000fU & vlSelfRef.test_apu__DOT__apu_pulse2
               [0U]);
        if ((0U == (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer))) {
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_duty 
                = (0x0000000fU & ((IData)(1U) + (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty)));
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_timer 
                = ((0x00000700U & (vlSelfRef.test_apu__DOT__apu_pulse2
                                   [3U] << 8U)) | vlSelfRef.test_apu__DOT__apu_pulse2
                   [2U]);
        } else {
            vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_timer 
                = (0x0000ffffU & ((IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer) 
                                  - (IData)(1U)));
        }
        vlSelfRef.test_apu__DOT__dut__DOT__pulse2_out_bit 
            = ((0x00000080U & vlSelfRef.test_apu__DOT__apu_pulse2
                [0U]) ? ((0x00000040U & vlSelfRef.test_apu__DOT__apu_pulse2
                          [0U]) ? (2U <= (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty)))
                          : (4U > (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty))))
                : ((0x00000040U & vlSelfRef.test_apu__DOT__apu_pulse2
                    [0U]) ? (2U > (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty)))
                    : (0U == (7U & (IData)(vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty)))));
    } else {
        vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_timer = 0U;
        vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_duty = 0U;
        vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_timer = 0U;
        vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_duty = 0U;
    }
    vlSelfRef.test_apu__DOT__dut__DOT__pulse1_enabled 
        = ((IData)(vlSelfRef.test_apu__DOT__rst_n) 
           && (1U & (IData)(vlSelfRef.test_apu__DOT__apu_status)));
    vlSelfRef.test_apu__DOT__dut__DOT__pulse2_enabled 
        = ((IData)(vlSelfRef.test_apu__DOT__rst_n) 
           && (1U & ((IData)(vlSelfRef.test_apu__DOT__apu_status) 
                     >> 1U)));
    vlSelfRef.test_apu__DOT__dut__DOT__pulse1_duty 
        = vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_duty;
    vlSelfRef.test_apu__DOT__dut__DOT__pulse1_timer 
        = vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse1_timer;
    vlSelfRef.test_apu__DOT__dut__DOT__pulse2_duty 
        = vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_duty;
    vlSelfRef.test_apu__DOT__dut__DOT__pulse2_timer 
        = vlSelfRef.__Vdly__test_apu__DOT__dut__DOT__pulse2_timer;
}

void Vtest_apu___024root___eval_nba(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_nba\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_apu___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_apu___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((4ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_apu___024root___act_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[4U] = 1U;
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_apu___024root___nba_sequent__TOP__3(vlSelf);
        vlSelfRef.__Vm_traceActivity[5U] = 1U;
    }
}

void Vtest_apu___024root___timing_resume(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___timing_resume\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vtest_apu___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_apu___024root___eval_phase__act(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_phase__act\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vtest_apu___024root___eval_triggers__act(vlSelf);
    Vtest_apu___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vtest_apu___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vtest_apu___024root___timing_resume(vlSelf);
        Vtest_apu___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vtest_apu___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_apu___024root___eval_phase__nba(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_phase__nba\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vtest_apu___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vtest_apu___024root___eval_nba(vlSelf);
        Vtest_apu___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vtest_apu___024root___eval(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vtest_apu___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("test_apu.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vtest_apu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("test_apu.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vtest_apu___024root___eval_phase__act(vlSelf));
    } while (Vtest_apu___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vtest_apu___024root___eval_debug_assertions(Vtest_apu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_apu___024root___eval_debug_assertions\n"); );
    Vtest_apu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
