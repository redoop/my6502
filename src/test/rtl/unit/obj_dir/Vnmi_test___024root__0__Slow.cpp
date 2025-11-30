// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnmi_test.h for the primary calling header

#include "Vnmi_test__pch.h"

VL_ATTR_COLD void Vnmi_test___024root___eval_static(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_static\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__clk__0 
        = vlSelfRef.nmi_test__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__rst_n__0 
        = vlSelfRef.nmi_test__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__cpu_clk__0 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__ppu_clk__0 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppu_clk;
}

VL_ATTR_COLD void Vnmi_test___024root___eval_initial__TOP(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_initial__TOP\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00004000U, vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.nmi_test__DOT__test_rom[(0x00003fffU 
                                           & vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i)] = 0xeaU;
        vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i 
            = ((IData)(1U) + vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i);
    }
    vlSelfRef.nmi_test__DOT__test_rom[0x3ffcU] = 0U;
    vlSelfRef.nmi_test__DOT__test_rom[0x3ffdU] = 0x80U;
    vlSelfRef.nmi_test__DOT__test_rom[0x3ffaU] = 0U;
    vlSelfRef.nmi_test__DOT__test_rom[0x3ffbU] = 0x81U;
    vlSelfRef.nmi_test__DOT__test_rom[0U] = 0xa9U;
    vlSelfRef.nmi_test__DOT__test_rom[1U] = 0x90U;
    vlSelfRef.nmi_test__DOT__test_rom[2U] = 0x8dU;
    vlSelfRef.nmi_test__DOT__test_rom[3U] = 0U;
    vlSelfRef.nmi_test__DOT__test_rom[4U] = 0x20U;
    vlSelfRef.nmi_test__DOT__test_rom[5U] = 0x4cU;
    vlSelfRef.nmi_test__DOT__test_rom[6U] = 5U;
    vlSelfRef.nmi_test__DOT__test_rom[7U] = 0x80U;
    vlSelfRef.nmi_test__DOT__test_rom[0x0100U] = 0xeeU;
    vlSelfRef.nmi_test__DOT__test_rom[0x0101U] = 0U;
    vlSelfRef.nmi_test__DOT__test_rom[0x0102U] = 2U;
    vlSelfRef.nmi_test__DOT__test_rom[0x0103U] = 0x40U;
    vlSelfRef.nmi_test__DOT__clk = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000800U, vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.nmi_test__DOT__dut__DOT__vram[(0x000007ffU 
                                                 & vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i)] = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i 
            = ((IData)(1U) + vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i);
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000100U, vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i)) {
        vlSelfRef.nmi_test__DOT__dut__DOT__oam[(0x000000ffU 
                                                & vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i)] = 0xffU;
        vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i 
            = ((IData)(1U) + vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i);
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[1U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[2U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[3U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[4U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[5U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[6U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[7U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[8U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[9U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0aU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0bU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0cU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0dU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0eU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x0fU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x10U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x11U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x12U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x13U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x14U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x15U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x16U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x17U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x18U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x19U] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1aU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1bU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1cU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1dU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1eU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__palette[0x1fU] = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk3__DOT__i = 0x00000020U;
}

VL_ATTR_COLD void Vnmi_test___024root___eval_final(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_final\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnmi_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vnmi_test___024root___eval_phase__stl(Vnmi_test___024root* vlSelf);

VL_ATTR_COLD void Vnmi_test___024root___eval_settle(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_settle\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vnmi_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("../nmi_test.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vnmi_test___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vnmi_test___024root___eval_triggers__stl(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_triggers__stl\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vnmi_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vnmi_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnmi_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vnmi_test___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vnmi_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vnmi_test___024root___stl_sequent__TOP__0(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___stl_sequent__TOP__0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[4U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [4U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[5U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [5U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[6U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [6U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[7U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [7U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[8U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [8U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[9U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [9U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000aU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000aU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000bU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000bU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000cU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000cU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000dU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000dU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000eU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000eU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000000fU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000000fU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000010U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000010U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000011U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000011U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000012U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000012U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000013U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000013U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000014U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000014U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000015U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000015U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000016U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000016U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000017U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000017U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000018U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000018U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x00000019U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x00000019U];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001aU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001aU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001bU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001bU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001cU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001cU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001dU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001dU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001eU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001eU];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0x0000001fU] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [0x0000001fU];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[0U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc
        [0U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[1U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc
        [1U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[2U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc
        [2U];
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[3U] 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc
        [3U];
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_clk = (1U 
                                                  & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                                     >> 3U));
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu_clk = (1U 
                                                  & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                                     >> 1U));
    vlSelfRef.nmi_test__DOT__dut__DOT__video_de = (
                                                   (0x00f0U 
                                                    > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
                                                   & (0x0100U 
                                                      > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)));
    vlSelfRef.nmi_test__DOT__dut__DOT____Vcellinp__dma__ram_data 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ram[((0x00000700U 
                                                   & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page) 
                                                      << 8U)) 
                                                  | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low))];
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__next_state 
        = ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
            ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                    ? 1U : ((5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))
                             ? 1U : 6U)) : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                                             ? 1U : 
                                            ((0U < (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count))
                                              ? 4U : 5U)))
            : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                    ? ((((1U == (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         & (4U != (7U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode) 
                                         >> 2U)))) 
                        | ((0x85U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (((0x8dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                               | (0x95U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                              | ((0x9dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                 | ((0x86U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                    | ((0x96U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                       | ((0x84U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                          | ((0x94U 
                                              == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                             | ((0xa5U 
                                                 == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                | ((0xadU 
                                                    == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                   | ((0xb5U 
                                                       == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                      | ((0xbdU 
                                                          == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                         | ((0xb9U 
                                                             == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                            | ((0xa6U 
                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                               | ((0xb6U 
                                                                   == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                  | ((0xaeU 
                                                                      == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                     | ((0xa4U 
                                                                         == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                        | ((0xb4U 
                                                                            == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                           | ((5U 
                                                                               == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                              | ((0x24U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((6U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc5U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc4U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x65U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x75U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x6dU 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x7dU 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x79U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xe5U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf5U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xedU 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xfdU 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf9U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xa1U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xb1U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x81U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x91U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((1U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | (0x21U 
                                                                                == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))))))))))))))))))))))))))))))))))))))))
                        ? 4U : 1U) : 3U) : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))
                                             ? ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending)
                                                 ? 6U
                                                 : 2U)
                                             : ((2U 
                                                 == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count))
                                                 ? 1U
                                                 : 0U))));
    vlSelfRef.nmi_test__DOT__prg_rom_addr = ((0x8000U 
                                              <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                                              ? (0x00003fffU 
                                                 & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                                              : 0U);
    if (((0x00f0U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
         & (0x0100U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))) {
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x 
            = (0x000001ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot) 
                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_x)));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y 
            = (0x000001ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline) 
                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_y)));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x 
            = (0x0000001fU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x) 
                              >> 3U));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y 
            = (0x0000001fU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y) 
                              >> 3U));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index 
            = vlSelfRef.nmi_test__DOT__dut__DOT__vram
            [(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y) 
               << 5U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x))];
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr 
            = (0x03c0U | ((0x00000038U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y) 
                                          << 1U)) | 
                          (7U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x) 
                                 >> 2U))));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte 
            = vlSelfRef.nmi_test__DOT__dut__DOT__vram
            [vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr];
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits 
            = (3U & ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y))
                      ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x))
                          ? ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte) 
                             >> 6U) : ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte) 
                                       >> 4U)) : ((2U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x))
                                                   ? 
                                                  ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte) 
                                                   >> 2U)
                                                   : (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte))));
        vlSelfRef.nmi_test__DOT__chr_rom_addr = ((5U 
                                                  == 
                                                  (7U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))
                                                  ? 
                                                 ((0x00001000U 
                                                   & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl) 
                                                      << 8U)) 
                                                  | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index) 
                                                      << 4U) 
                                                     | (7U 
                                                        & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y))))
                                                  : 
                                                 ((7U 
                                                   == 
                                                   (7U 
                                                    & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))
                                                   ? 
                                                  (8U 
                                                   | ((0x00001000U 
                                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl) 
                                                          << 8U)) 
                                                      | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index) 
                                                          << 4U) 
                                                         | (7U 
                                                            & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y)))))
                                                   : 
                                                  ((0x00001000U 
                                                    & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl) 
                                                       << 8U)) 
                                                   | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index) 
                                                       << 4U) 
                                                      | (7U 
                                                         & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y))))));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value 
            = ((2U & (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg) 
                       >> (7U & ((IData)(7U) - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x)))) 
                      << 1U)) | (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg) 
                                       >> (7U & ((IData)(7U) 
                                                 - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x))))));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx 
            = ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value))
                ? 0U : (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits) 
                         << 2U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value)));
    } else {
        vlSelfRef.nmi_test__DOT__chr_rom_addr = (0x00003fffU 
                                                 & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr));
        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx = 0U;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i = 0U;
    {
        while (VL_GTS_III(32, 8U, vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i)) {
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y 
                = vlSelfRef.nmi_test__DOT__dut__DOT__oam
                [(0x000000ffU & VL_MULS_III(32, (IData)(4U), vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i))];
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_tile 
                = vlSelfRef.nmi_test__DOT__dut__DOT__oam
                [(0x000000ffU & ((IData)(1U) + VL_MULS_III(32, (IData)(4U), vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i)))];
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr 
                = vlSelfRef.nmi_test__DOT__dut__DOT__oam
                [(0x000000ffU & ((IData)(2U) + VL_MULS_III(32, (IData)(4U), vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i)))];
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x 
                = vlSelfRef.nmi_test__DOT__dut__DOT__oam
                [(0x000000ffU & ((IData)(3U) + VL_MULS_III(32, (IData)(4U), vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i)))];
            if ((0xefU > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y))) {
                if ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline) 
                      >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y)) 
                     & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline) 
                        < ((IData)(8U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y))))) {
                    if ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot) 
                          >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x)) 
                         & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot) 
                            < ((IData)(8U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x))))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active = 1U;
                        vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel = 0U;
                        if ((0U != (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel))) {
                            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx 
                                = (0x00000010U | ((0x0000000cU 
                                                   & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr) 
                                                      << 2U)) 
                                                  | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel)));
                        }
                        goto __Vlabel0;
                    }
                }
            }
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i 
                = ((IData)(1U) + vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i);
        }
        __Vlabel0: ;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in = 0U;
    if (VL_UNLIKELY(((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw) 
                       & (0x2000U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) 
                      & (0x2007U >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))))) {
        VL_WRITEF_NX("[DEBUG] PPU read: addr=$%04x\n",0,
                     16,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr);
    }
    if ((0x1fffU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in 
            = vlSelfRef.nmi_test__DOT__dut__DOT__ram
            [(0x000007ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))];
    } else if ((0x2002U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
        if (VL_UNLIKELY((vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw))) {
            VL_WRITEF_NX("[PPU] $2002 read: VBlank=%b status=$%02x\n",0,
                         1,(1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus) 
                                  >> 7U)),8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus));
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in 
            = vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus;
    } else {
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in 
            = ((0x2004U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                ? vlSelfRef.nmi_test__DOT__dut__DOT__oam
               [vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr]
                : ((0x2007U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppudata_buffer)
                    : ((0x4015U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                        ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu_status)
                        : ((0x4016U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                            ? 0U : ((0x4017U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                                     ? 0U : ((0x4000U 
                                              <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))
                                              ? ((0x4000U 
                                                  > (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))
                                                  ? 
                                                 vlSelfRef.nmi_test__DOT__test_rom
                                                 [(0x00003fffU 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))]
                                                  : 0U)
                                              : 0U))))));
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx 
        = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active) 
            & (0U != (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel)))
            ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx)
            : (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx));
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color 
        = vlSelfRef.nmi_test__DOT__dut__DOT__palette
        [vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx];
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color 
        = ((0x00000020U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
            ? ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                ? ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                    ? ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? 0U : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                     ? 0x00a0a2a0U : 0x00a0d6e4U))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x0098e2b4U : 0x00a8e290U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00b4de78U : 0x00ccd278U)))
                    : ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00e4c490U : 0x00ecb4b0U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00ecaed4U : 0x00ecaeecU))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00d4b2ecU : 0x00bcbcecU)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00a8ccecU : 0x00eceeecU))))
                : ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                    ? ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? 0U : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                     ? 0x003c3c3cU : 0x0038b4ccU))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x0038cc6cU : 0x004cd020U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x0074c400U : 0x00a0aa00U)))
                    : ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00d48820U : 0x00ec6a64U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00ec58b4U : 0x00e454ecU))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00b062ecU : 0x00787cecU)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x004c9aecU : 0x00eceeecU)))))
            : ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                ? ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                    ? ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? 0U : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                     ? 0U : 0x00006678U))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00007628U : 0x00087c00U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00287200U : 0x00545a00U)))
                    : ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00783c00U : 0x00982220U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00a01464U : 0x008814b0U))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x005c1ee4U : 0x003032ecU)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00084cc4U : 0x00989698U))))
                : ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                    ? ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? 0U : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                     ? 0U : 0x0000325dU))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00003c22U : 0x00004000U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00083a00U : 0x00202a00U)))
                    : ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                        ? ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x003c1800U : 0x00540400U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x005c0030U : 0x00440064U))
                        : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                            ? ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00300088U : 0x00081090U)
                            : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color))
                                ? 0x00001e74U : 0x00545454U))))));
}

VL_ATTR_COLD void Vnmi_test___024root____Vm_traceActivitySetAll(Vnmi_test___024root* vlSelf);

VL_ATTR_COLD void Vnmi_test___024root___eval_stl(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_stl\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vnmi_test___024root___stl_sequent__TOP__0(vlSelf);
        Vnmi_test___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool Vnmi_test___024root___eval_phase__stl(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_phase__stl\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vnmi_test___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vnmi_test___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vnmi_test___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vnmi_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnmi_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vnmi_test___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge nmi_test.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge nmi_test.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @(posedge nmi_test.dut.cpu_clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 3U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 3 is active: @(posedge nmi_test.dut.ppu_clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 4U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 4 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vnmi_test___024root____Vm_traceActivitySetAll(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root____Vm_traceActivitySetAll\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.__Vm_traceActivity[3U] = 1U;
    vlSelfRef.__Vm_traceActivity[4U] = 1U;
    vlSelfRef.__Vm_traceActivity[5U] = 1U;
    vlSelfRef.__Vm_traceActivity[6U] = 1U;
    vlSelfRef.__Vm_traceActivity[7U] = 1U;
}

VL_ATTR_COLD void Vnmi_test___024root___ctor_var_reset(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___ctor_var_reset\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->nmi_test__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15275808598678690579ull);
    vlSelf->nmi_test__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10355314591654646300ull);
    vlSelf->nmi_test__DOT__prg_rom_addr = VL_SCOPED_RAND_RESET_I(15, __VscopeHash, 9132144773556796568ull);
    vlSelf->nmi_test__DOT__chr_rom_addr = VL_SCOPED_RAND_RESET_I(14, __VscopeHash, 317135343080957739ull);
    vlSelf->nmi_test__DOT__nmi_trigger_count = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 4742931449633758507ull);
    for (int __Vi0 = 0; __Vi0 < 16384; ++__Vi0) {
        vlSelf->nmi_test__DOT__test_rom[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11122088651697595366ull);
    }
    vlSelf->nmi_test__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->nmi_test__DOT__dut__DOT__video_de = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 846146551284417631ull);
    vlSelf->nmi_test__DOT__dut__DOT__vram_write_count = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 729024468482744094ull);
    vlSelf->nmi_test__DOT__dut__DOT__clk_div = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 14753587752438122985ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15967146296942178859ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16862449722288693431ull);
    for (int __Vi0 = 0; __Vi0 < 2048; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__ram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2585460580909807837ull);
    }
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__oam[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7612653425517175854ull);
    }
    for (int __Vi0 = 0; __Vi0 < 2048; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__vram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9830352352181619620ull);
    }
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__palette[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 18077706819766917461ull);
    }
    vlSelf->nmi_test__DOT__dut__DOT__cpu_addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 8016817159969557724ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu_data_out = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6089254969243384871ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu_data_in = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11126820813068968581ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu_rw = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 649220104323548331ull);
    vlSelf->nmi_test__DOT__dut__DOT__nmi = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11924253597728748127ull);
    vlSelf->nmi_test__DOT__dut__DOT__irq = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18328815051705658583ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppuctrl = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 524773642666135383ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppumask = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12364321195838892776ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppustatus = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14273270197896421551ull);
    vlSelf->nmi_test__DOT__dut__DOT__oamaddr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15462498867199149645ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppuscroll_x = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12852013836283423932ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppuscroll_y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2900787637108326058ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppuaddr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 9214769931825646079ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppuaddr_latch = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1059776146681538929ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppudata_buffer = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11687920585426227414ull);
    vlSelf->nmi_test__DOT__dut__DOT__vblank = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4538819205371633325ull);
    vlSelf->nmi_test__DOT__dut__DOT__sprite0_hit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10694159643326521258ull);
    vlSelf->nmi_test__DOT__dut__DOT__rendering = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10942570887961324028ull);
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu_pulse1[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15401414993064777409ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu_pulse2[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8685157933912606117ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu_triangle[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15518087072851932314ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu_noise[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15083895919123201363ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu_dmc[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7393180580528428389ull);
    }
    vlSelf->nmi_test__DOT__dut__DOT__apu_status = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5520511372709273180ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu_frame_counter = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12923021505441428654ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16374536565479610621ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_start = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1548605075806303978ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_page = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5397747149676123778ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15294088906804517615ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_ram_addr_low = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5011946757108545448ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_oam_addr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5101256917906829918ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_oam_data = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6942760543449235573ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma_oam_write = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16484324487241032051ull);
    vlSelf->nmi_test__DOT__dut__DOT____Vcellinp__dma__ram_data = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9593934195738061986ull);
    vlSelf->nmi_test__DOT__dut__DOT__total_write_count = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 15763541733310929366ull);
    vlSelf->nmi_test__DOT__dut__DOT__vblank_sync1 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8913524265987182066ull);
    vlSelf->nmi_test__DOT__dut__DOT__vblank_sync2 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13627290901865758227ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppustatus_read_last = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7853808409027590886ull);
    vlSelf->nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i = 0;
    vlSelf->nmi_test__DOT__dut__DOT__unnamedblk3__DOT__i = 0;
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8886911889236100941ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2777528551363569259ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14162772238650562927ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1024779971432193671ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 792329028878366069ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2479380293285377803ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14565052851315699504ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8640362682194517120ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17890150687557259352ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17674346015027611216ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9040839569199693598ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9534577158764923758ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 16506096543198153598ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__next_state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 12159359620060712294ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3992305905671735451ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 154007713511348871ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__alu_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6896158603305920800ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__ea = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 8078063417338680856ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 8683661316527363431ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 94107510093220325ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 613046032659417953ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 5514975322203144038ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15691885683072048412ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17769546249041809098ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6985834132047636016ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11750669452733926216ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 13750353283051224453ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 10599013084995827111ull);
    vlSelf->nmi_test__DOT__dut__DOT__cpu__DOT__temp_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16948452854385334143ull);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__palette[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16543780332416442335ull);
    }
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 16290150230808744982ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 89604685299586402ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7247088766852368414ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9998700559305859692ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17407602158369525058ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_tile = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15097143739058534591ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10817310826812855985ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2760704298867421730ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 12719024531541419781ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 496231473416278056ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5584871708558982835ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__tile_index = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16852039864499806079ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3336109335497709091ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 12810178537473236299ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 10406633121468961157ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 12829655598295175640ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__tile_x = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 810724905508755919ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__tile_y = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 16139271659671147417ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 4737342030234476501ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 10990004040339436187ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 12832684204058766ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__nes_color = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 4293208846254313276ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 12543141931256167686ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__palette_color = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14009980158972285413ull);
    vlSelf->nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i = 0;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17094591456941783489ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9154574414821895202ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1607782557050362533ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9262966210855551910ull);
    }
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7794098941306650390ull);
    }
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__audio_counter = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 3076389037323500579ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__test_tone = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 13829912084634174245ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 4436623143468392204ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 3592976597686461951ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 13407935747403455993ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6996619335431247107ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6670333232912628482ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 9273975028456173970ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 5354007161595730130ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 15849841535017186881ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 11935820836349722090ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12010403215143450881ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12722295362594605189ull);
    vlSelf->nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 9631185932992436118ull);
    vlSelf->nmi_test__DOT__dut__DOT__dma__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 62505960606331164ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__total_write_count = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16284214368955592734ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppuctrl = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3851170050175018997ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppumask = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17701560439038690628ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__oamaddr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5729648127131776216ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10421234015235202010ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppuaddr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 7480829508143559736ull);
    vlSelf->__Vdly__nmi_test__DOT__nmi_trigger_count = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 6334725065488379627ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu_addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 15187845001600529858ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 3151855180368335048ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4996430251533105697ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 10878816883619065888ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 847622814545552183ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15234741040754477411ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16772911709380603321ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2649910936535355301ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7493295021746695351ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11293392381327710323ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 18359446807660877009ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4448861217612999398ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8324397065769259846ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16223499049105509085ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17825577169475853934ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7900697960000958218ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1867304593647219844ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11054848178616408325ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 3344884140480486406ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__dma_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10087707701727495857ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10954612233084220034ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 1441183144811665806ull);
    vlSelf->__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 10616225625357259869ull);
    vlSelf->__VdlyVal__nmi_test__DOT__dut__DOT__oam__v0 = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7966322085720550192ull);
    vlSelf->__VdlyDim0__nmi_test__DOT__dut__DOT__oam__v0 = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9772353295586468072ull);
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__oam__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__ram__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__oam__v1 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__vram__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__palette__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__apu_noise__v0 = 0;
    vlSelf->__VdlySet__nmi_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__nmi_test__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10234386058698640866ull);
    vlSelf->__Vtrigprevexpr___TOP__nmi_test__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6093884336238615789ull);
    vlSelf->__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__cpu_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17063846260219891132ull);
    vlSelf->__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__ppu_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8944700382612698054ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 8; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
