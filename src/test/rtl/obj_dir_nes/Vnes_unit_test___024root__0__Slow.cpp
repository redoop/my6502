// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnes_unit_test.h for the primary calling header

#include "Vnes_unit_test__pch.h"

VL_ATTR_COLD void Vnes_unit_test___024root___eval_static__TOP(Vnes_unit_test___024root* vlSelf);

VL_ATTR_COLD void Vnes_unit_test___024root___eval_static(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_static\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vnes_unit_test___024root___eval_static__TOP(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__clk__0 = 0U;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__rst_n__0 
        = vlSelfRef.nes_unit_test__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__cpu_clk__0 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__ppu_clk__0 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__ppu_clk;
}

VL_ATTR_COLD void Vnes_unit_test___024root___eval_static__TOP(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_static__TOP\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nes_unit_test__DOT__clk = 0U;
    vlSelfRef.nes_unit_test__DOT__controller1 = 0U;
    vlSelfRef.nes_unit_test__DOT__pass_count = 0U;
    vlSelfRef.nes_unit_test__DOT__fail_count = 0U;
}

VL_ATTR_COLD void Vnes_unit_test___024root___eval_initial__TOP(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_initial__TOP\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i;
    nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i = 0;
    // Body
    IData/*31:0*/ __Vilp1;
    __Vilp1 = 0U;
    while ((__Vilp1 <= 0x0000003fU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp1] = 0x24U;
        __Vilp1 = ((IData)(1U) + __Vilp1);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0040U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0041U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0042U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0043U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0044U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0045U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0046U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0047U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0048U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0049U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x004fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0050U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0051U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0052U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0053U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0054U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0055U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0056U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0057U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0058U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0059U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x005fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0060U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0061U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0062U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0063U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0064U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0065U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0066U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0067U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0068U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0069U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x006fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0070U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0071U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0072U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0073U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0074U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0075U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0076U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0077U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0078U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0079U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x007fU] = 0U;
    IData/*31:0*/ __Vilp2;
    __Vilp2 = 0x00000080U;
    while ((__Vilp2 <= 0x000000bfU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp2] = 0x24U;
        __Vilp2 = ((IData)(1U) + __Vilp2);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00c9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00caU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00cbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ccU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00cdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ceU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00cfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00d9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00daU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00dbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00dcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ddU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00deU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00dfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00e9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00eaU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ebU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ecU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00edU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00eeU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00efU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00f9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00faU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00fbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00fcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00fdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00feU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x00ffU] = 0U;
    IData/*31:0*/ __Vilp3;
    __Vilp3 = 0x00000100U;
    while ((__Vilp3 <= 0x0000013fU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp3] = 0x24U;
        __Vilp3 = ((IData)(1U) + __Vilp3);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0140U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0141U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0142U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0143U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0144U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0145U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0146U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0147U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0148U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0149U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x014fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0150U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0151U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0152U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0153U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0154U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0155U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0156U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0157U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0158U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0159U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x015fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0160U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0161U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0162U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0163U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0164U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0165U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0166U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0167U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0168U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0169U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x016fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0170U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0171U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0172U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0173U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0174U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0175U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0176U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0177U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0178U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0179U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x017fU] = 0U;
    IData/*31:0*/ __Vilp4;
    __Vilp4 = 0x00000180U;
    while ((__Vilp4 <= 0x000001bfU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp4] = 0x24U;
        __Vilp4 = ((IData)(1U) + __Vilp4);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01c9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01caU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01cbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ccU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01cdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ceU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01cfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01d9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01daU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01dbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01dcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ddU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01deU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01dfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01e9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01eaU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ebU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ecU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01edU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01eeU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01efU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01f9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01faU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01fbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01fcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01fdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01feU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x01ffU] = 0U;
    IData/*31:0*/ __Vilp5;
    __Vilp5 = 0x00000200U;
    while ((__Vilp5 <= 0x0000023fU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp5] = 0x24U;
        __Vilp5 = ((IData)(1U) + __Vilp5);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0240U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0241U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0242U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0243U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0244U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0245U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0246U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0247U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0248U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0249U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x024fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0250U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0251U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0252U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0253U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0254U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0255U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0256U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0257U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0258U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0259U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x025fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0260U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0261U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0262U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0263U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0264U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0265U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0266U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0267U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0268U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0269U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x026fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0270U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0271U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0272U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0273U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0274U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0275U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0276U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0277U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0278U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0279U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x027fU] = 0U;
    IData/*31:0*/ __Vilp6;
    __Vilp6 = 0x00000280U;
    while ((__Vilp6 <= 0x000002bfU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp6] = 0x24U;
        __Vilp6 = ((IData)(1U) + __Vilp6);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02c9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02caU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02cbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ccU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02cdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ceU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02cfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02d9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02daU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02dbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02dcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ddU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02deU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02dfU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02e9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02eaU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ebU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ecU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02edU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02eeU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02efU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f0U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f1U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f2U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f3U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f4U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f5U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f6U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f7U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f8U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02f9U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02faU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02fbU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02fcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02fdU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02feU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x02ffU] = 0U;
    IData/*31:0*/ __Vilp7;
    __Vilp7 = 0x00000300U;
    while ((__Vilp7 <= 0x0000033fU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp7] = 0x24U;
        __Vilp7 = ((IData)(1U) + __Vilp7);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0340U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0341U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0342U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0343U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0344U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0345U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0346U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0347U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0348U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0349U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x034fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0350U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0351U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0352U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0353U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0354U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0355U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0356U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0357U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0358U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0359U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x035fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0360U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0361U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0362U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0363U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0364U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0365U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0366U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0367U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0368U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0369U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x036fU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0370U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0371U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0372U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0373U] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0374U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0375U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0376U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0377U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0378U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x0379U] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037aU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037bU] = 0x26U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037cU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037dU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037eU] = 0U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[0x037fU] = 0U;
    IData/*31:0*/ __Vilp8;
    __Vilp8 = 0x00000380U;
    while ((__Vilp8 <= 0x000003bfU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp8] = 0x24U;
        __Vilp8 = ((IData)(1U) + __Vilp8);
    }
    IData/*31:0*/ __Vilp9;
    __Vilp9 = 0x000003c0U;
    while ((__Vilp9 <= 0x000003ffU)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__Vilp9] = 0xe4U;
        __Vilp9 = ((IData)(1U) + __Vilp9);
    }
    nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000100U, nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i)) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__oam[(0x000000ffU 
                                                     & nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i)] = 0xffU;
        nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i 
            = ((IData)(1U) + nes_unit_test__DOT__dut__DOT__unnamedblk5__DOT__i);
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0U] = 0x0fU;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[1U] = 0x30U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[2U] = 0x27U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[3U] = 0x16U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[5U] = 0x11U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[6U] = 0x21U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[7U] = 0x31U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[9U] = 0x25U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x0aU] = 0x35U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x0bU] = 0x15U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x0dU] = 0x28U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x0eU] = 0x38U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x0fU] = 0x18U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x11U] = 0x30U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x12U] = 0x27U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x13U] = 0x16U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x15U] = 0x11U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x16U] = 0x21U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x17U] = 0x31U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x19U] = 0x1aU;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x1aU] = 0x2aU;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x1bU] = 0x3aU;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x1dU] = 0x28U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x1eU] = 0x38U;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[0x1fU] = 0x18U;
}

VL_ATTR_COLD void Vnes_unit_test___024root___eval_final(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_final\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnes_unit_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vnes_unit_test___024root___eval_phase__stl(Vnes_unit_test___024root* vlSelf);

VL_ATTR_COLD void Vnes_unit_test___024root___eval_settle(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_settle\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vnes_unit_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("nes_unit_test.sv", 4, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vnes_unit_test___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vnes_unit_test___024root___eval_triggers__stl(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_triggers__stl\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vnes_unit_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vnes_unit_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnes_unit_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vnes_unit_test___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vnes_unit_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vnes_unit_test___024root___stl_sequent__TOP__0(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___stl_sequent__TOP__0\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_clk 
        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div) 
                 >> 3U));
    vlSelfRef.nes_unit_test__DOT__dut__DOT__ppu_clk 
        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div) 
                 >> 1U));
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__next_state 
        = ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
            ? ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                    ? 1U : ((5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))
                             ? 1U : 6U)) : ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                                             ? 1U : 
                                            ((0U < (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count))
                                              ? 4U : 5U)))
            : ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                    ? ((((1U == (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         & (4U != (7U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode) 
                                         >> 2U)))) 
                        | ((0x85U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (((0x8dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                               | (0x95U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                              | ((0x9dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                 | ((0x86U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                    | ((0x96U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                       | ((0x84U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                          | ((0x94U 
                                              == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                             | ((0xa5U 
                                                 == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                | ((0xadU 
                                                    == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                   | ((0xb5U 
                                                       == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                      | ((0xbdU 
                                                          == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                         | ((0xb9U 
                                                             == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                            | ((0xa6U 
                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                               | ((0xb6U 
                                                                   == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                  | ((0xaeU 
                                                                      == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                     | ((0xa4U 
                                                                         == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                        | ((0xb4U 
                                                                            == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                           | ((5U 
                                                                               == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                              | ((0x24U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((6U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc5U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc4U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x65U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x75U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x6dU 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x7dU 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x79U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xe5U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf5U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xedU 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xfdU 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf9U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xa1U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xb1U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x81U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x91U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | ((1U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                                                                | (0x21U 
                                                                                == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))))))))))))))))))))))))))))))))))))))))
                        ? 4U : 1U) : 3U) : ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))
                                             ? ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending)
                                                 ? 6U
                                                 : 2U)
                                             : ((2U 
                                                 == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count))
                                                 ? 1U
                                                 : 0U))));
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in 
        = (((((((((0x1000U == (0xf000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                  | (0x2002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                 | (0x2004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                | (0x2007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
               | (0x4015U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
              | (0x4016U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
             | (0x4017U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
            | ((0x4000U == (0xc000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
               || (0x8000U == (0x8000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))))
            ? ((0x1000U == (0xf000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))
                ? vlSelfRef.nes_unit_test__DOT__dut__DOT__ram
               [(0x000007ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))]
                : ((0x2002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                    ? (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank_sync) 
                        << 7U) | (0x0000007fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus)))
                    : ((0x2004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                        ? vlSelfRef.nes_unit_test__DOT__dut__DOT__oam
                       [vlSelfRef.nes_unit_test__DOT__dut__DOT__oamaddr]
                        : ((0x2007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                            ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppudata_buffer)
                            : ((0x4015U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__apu_status)
                                : ((0x4016U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                    ? (1U & (IData)(vlSelfRef.nes_unit_test__DOT__controller1))
                                    : ((0x4017U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                        ? 0U : vlSelfRef.nes_unit_test__DOT__prg_rom
                                       [((0x8000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                          ? (0x00003fffU 
                                             & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                          : 0U)])))))))
            : 0U);
}

VL_ATTR_COLD void Vnes_unit_test___024root___eval_stl(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_stl\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vnes_unit_test___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD bool Vnes_unit_test___024root___eval_phase__stl(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_phase__stl\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vnes_unit_test___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vnes_unit_test___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vnes_unit_test___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vnes_unit_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnes_unit_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vnes_unit_test___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge nes_unit_test.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge nes_unit_test.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @(posedge nes_unit_test.dut.cpu_clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 3U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 3 is active: @(posedge nes_unit_test.dut.ppu_clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 4U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 4 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vnes_unit_test___024root___ctor_var_reset(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___ctor_var_reset\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->nes_unit_test__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2058795934195760544ull);
    vlSelf->nes_unit_test__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3420747294421147607ull);
    for (int __Vi0 = 0; __Vi0 < 16384; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__prg_rom[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11868531766125338673ull);
    }
    for (int __Vi0 = 0; __Vi0 < 8192; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__chr_rom[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2493172824324189481ull);
    }
    vlSelf->nes_unit_test__DOT__controller1 = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11921739059840518718ull);
    vlSelf->nes_unit_test__DOT__pass_count = 0;
    vlSelf->nes_unit_test__DOT__fail_count = 0;
    vlSelf->nes_unit_test__DOT__dut__DOT__clk_div = VL_SCOPED_RAND_RESET_I(4, __VscopeHash, 4141221282559547019ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11688820123159895383ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppu_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10418938568711192232ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu_addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 4218907074596821819ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu_data_out = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3365063675386219609ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu_data_in = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10742415181550329981ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu_rw = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12314689473248980227ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__nmi = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6328564691076299192ull);
    for (int __Vi0 = 0; __Vi0 < 2048; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__dut__DOT__ram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2818374772717528629ull);
    }
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__dut__DOT__oam[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12312896893476309427ull);
    }
    for (int __Vi0 = 0; __Vi0 < 2048; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__dut__DOT__vram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11332393416437342943ull);
    }
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->nes_unit_test__DOT__dut__DOT__palette[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12363506717387806232ull);
    }
    vlSelf->nes_unit_test__DOT__dut__DOT__ppuctrl = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9942203437395324415ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppustatus = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14586656271585926487ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__oamaddr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11127613852335010406ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppuaddr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 17855290162834613893ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppudata = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10340532118786770044ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppuaddr_latch = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13092873408738548712ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__ppudata_buffer = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6831813214984509037ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__apu_status = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4752044315965912823ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 16559161736037287809ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 8393241207021975215ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__vblank = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1378191113159790778ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__dma_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15671244031185618795ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__dma_page = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1306013526457176436ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__dma_offset = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16063939779062181161ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__vram_write_count = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 584705892286950869ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__total_write_count = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 11538553523241329533ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__vblank_sync = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14191373147600070822ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1729429438255915550ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12442030267548221149ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6798637188248081373ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9001228774232934088ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 8156603866297674201ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4045980430825461782ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4025822225383633529ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12247712296623821503ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8973968160972421171ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12374047406728492806ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10980590489469387289ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4288024645603106664ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 7662053096327483390ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__next_state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 173096454735740133ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4940610384991564418ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7440738049598142325ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 17635502385283512707ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17156751956288389363ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 12711688794248046118ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12177714563988493068ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_prev = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5910626257439908809ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16617234110151531098ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 11210433911243059353ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 5752824816261941741ull);
    vlSelf->nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 13389895710251708744ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__ppuctrl = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16213449288655957342ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 12326820611833991038ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 15964616483682720766ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 7424987041640090466ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1684915304652341893ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 16372774653057376704ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6250442438976174271ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14891874631232280106ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4242062235265132164ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14761043466376577894ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10409082641142992963ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11283929379587964354ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2481319798544940185ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2880846417988569072ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5451669177707057491ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5425759390579120703ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8928783264495774775ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9125019073919832126ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15050826366523448265ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 12488599195069091148ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 16757575602603078818ull);
    vlSelf->__Vdly__nes_unit_test__DOT__dut__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 6520598202153180206ull);
    vlSelf->__VdlyVal__nes_unit_test__DOT__dut__DOT__palette__v0 = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12932108339235453330ull);
    vlSelf->__VdlyDim0__nes_unit_test__DOT__dut__DOT__palette__v0 = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 5196316710494062102ull);
    vlSelf->__VdlySet__nes_unit_test__DOT__dut__DOT__palette__v0 = 0;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__nes_unit_test__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 121835552543389115ull);
    vlSelf->__Vtrigprevexpr___TOP__nes_unit_test__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1897290057093736048ull);
    vlSelf->__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__cpu_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13905237892380519236ull);
    vlSelf->__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__ppu_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10103942179411907976ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
}
