// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_ppu.h for the primary calling header

#include "Vtest_ppu__pch.h"

VL_ATTR_COLD void Vtest_ppu___024root___eval_static(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_static\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0 
        = vlSelfRef.test_ppu__DOT__vblank;
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__clk__0 
        = vlSelfRef.test_ppu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__rst_n__0 
        = vlSelfRef.test_ppu__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr_h8ca0d663__1 = (1U & 
                                              (~ (IData)(vlSelfRef.test_ppu__DOT__vblank)));
}

VL_ATTR_COLD void Vtest_ppu___024root___eval_initial__TOP(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_initial__TOP\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_ppu__DOT__clk = 0U;
}

VL_ATTR_COLD void Vtest_ppu___024root___eval_final(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_final\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_ppu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtest_ppu___024root___eval_phase__stl(Vtest_ppu___024root* vlSelf);

VL_ATTR_COLD void Vtest_ppu___024root___eval_settle(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_settle\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vtest_ppu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("test_ppu.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vtest_ppu___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vtest_ppu___024root___eval_triggers__stl(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_triggers__stl\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_ppu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vtest_ppu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_ppu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_ppu___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vtest_ppu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vtest_ppu___024root___stl_sequent__TOP__0(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___stl_sequent__TOP__0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0U] 
        = vlSelfRef.test_ppu__DOT__palette[0U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[1U] 
        = vlSelfRef.test_ppu__DOT__palette[1U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[2U] 
        = vlSelfRef.test_ppu__DOT__palette[2U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[3U] 
        = vlSelfRef.test_ppu__DOT__palette[3U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[4U] 
        = vlSelfRef.test_ppu__DOT__palette[4U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[5U] 
        = vlSelfRef.test_ppu__DOT__palette[5U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[6U] 
        = vlSelfRef.test_ppu__DOT__palette[6U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[7U] 
        = vlSelfRef.test_ppu__DOT__palette[7U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[8U] 
        = vlSelfRef.test_ppu__DOT__palette[8U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[9U] 
        = vlSelfRef.test_ppu__DOT__palette[9U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000aU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000aU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000bU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000bU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000cU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000cU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000dU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000dU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000eU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000eU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000000fU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000000fU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000010U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000010U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000011U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000011U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000012U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000012U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000013U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000013U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000014U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000014U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000015U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000015U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000016U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000016U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000017U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000017U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000018U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000018U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x00000019U] 
        = vlSelfRef.test_ppu__DOT__palette[0x00000019U];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001aU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001aU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001bU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001bU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001cU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001cU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001dU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001dU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001eU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001eU];
    vlSelfRef.test_ppu__DOT__dut__DOT__palette[0x0000001fU] 
        = vlSelfRef.test_ppu__DOT__palette[0x0000001fU];
    if (((0x00f0U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
         & (0x0100U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
        vlSelfRef.test_ppu__DOT__video_de = 1U;
        vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x 
            = (0x000001ffU & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot) 
                              + (IData)(vlSelfRef.test_ppu__DOT__ppuscroll_x)));
        vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y 
            = (0x000001ffU & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline) 
                              + (IData)(vlSelfRef.test_ppu__DOT__ppuscroll_y)));
        vlSelfRef.test_ppu__DOT__dut__DOT__tile_x = 
            (0x0000001fU & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x) 
                            >> 3U));
        vlSelfRef.test_ppu__DOT__dut__DOT__tile_y = 
            (0x0000001fU & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y) 
                            >> 3U));
        vlSelfRef.test_ppu__DOT__dut__DOT__tile_index 
            = vlSelfRef.test_ppu__DOT__vram[(((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_y) 
                                              << 5U) 
                                             | (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x))];
        vlSelfRef.test_ppu__DOT__dut__DOT__attr_addr 
            = (0x03c0U | ((0x00000038U & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_y) 
                                          << 1U)) | 
                          (7U & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x) 
                                 >> 2U))));
        vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte 
            = vlSelfRef.test_ppu__DOT__vram[vlSelfRef.test_ppu__DOT__dut__DOT__attr_addr];
        vlSelfRef.test_ppu__DOT__dut__DOT__attr_bits 
            = (3U & ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_y))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x))
                          ? ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte) 
                             >> 6U) : ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte) 
                                       >> 4U)) : ((2U 
                                                   & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x))
                                                   ? 
                                                  ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte) 
                                                   >> 2U)
                                                   : (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte))));
        vlSelfRef.test_ppu__DOT__chr_rom_addr = ((5U 
                                                  == 
                                                  (7U 
                                                   & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))
                                                  ? 
                                                 ((0x00001000U 
                                                   & ((IData)(vlSelfRef.test_ppu__DOT__ppuctrl) 
                                                      << 8U)) 
                                                  | (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_index) 
                                                      << 4U) 
                                                     | (7U 
                                                        & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y))))
                                                  : 
                                                 ((7U 
                                                   == 
                                                   (7U 
                                                    & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))
                                                   ? 
                                                  (8U 
                                                   | ((0x00001000U 
                                                       & ((IData)(vlSelfRef.test_ppu__DOT__ppuctrl) 
                                                          << 8U)) 
                                                      | (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_index) 
                                                          << 4U) 
                                                         | (7U 
                                                            & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y)))))
                                                   : 
                                                  ((0x00001000U 
                                                    & ((IData)(vlSelfRef.test_ppu__DOT__ppuctrl) 
                                                       << 8U)) 
                                                   | (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__tile_index) 
                                                       << 4U) 
                                                      | (7U 
                                                         & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y))))));
        vlSelfRef.test_ppu__DOT__dut__DOT__pixel_value 
            = ((2U & (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_hi_reg) 
                       >> (7U & ((IData)(7U) - (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x)))) 
                      << 1U)) | (1U & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_lo_reg) 
                                       >> (7U & ((IData)(7U) 
                                                 - (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x))))));
        vlSelfRef.test_ppu__DOT__dut__DOT__bg_palette_idx 
            = ((0U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__pixel_value))
                ? 0U : (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__attr_bits) 
                         << 2U) | (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__pixel_value)));
    } else {
        vlSelfRef.test_ppu__DOT__video_de = 0U;
        vlSelfRef.test_ppu__DOT__chr_rom_addr = (0x00003fffU 
                                                 & (IData)(vlSelfRef.test_ppu__DOT__ppuaddr));
        vlSelfRef.test_ppu__DOT__dut__DOT__bg_palette_idx = 0U;
    }
    vlSelfRef.test_ppu__DOT__dut__DOT__sprite_active = 0U;
    vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel = 0U;
    vlSelfRef.test_ppu__DOT__dut__DOT__sprite_palette_idx = 0U;
    vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i = 0U;
    {
        while (VL_GTS_III(32, 8U, vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i)) {
            vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y 
                = vlSelfRef.test_ppu__DOT__oam[(0x000000ffU 
                                                & VL_MULS_III(32, (IData)(4U), vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i))];
            vlSelfRef.test_ppu__DOT__dut__DOT__sprite_tile 
                = vlSelfRef.test_ppu__DOT__oam[(0x000000ffU 
                                                & ((IData)(1U) 
                                                   + 
                                                   VL_MULS_III(32, (IData)(4U), vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i)))];
            vlSelfRef.test_ppu__DOT__dut__DOT__sprite_attr 
                = vlSelfRef.test_ppu__DOT__oam[(0x000000ffU 
                                                & ((IData)(2U) 
                                                   + 
                                                   VL_MULS_III(32, (IData)(4U), vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i)))];
            vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x 
                = vlSelfRef.test_ppu__DOT__oam[(0x000000ffU 
                                                & ((IData)(3U) 
                                                   + 
                                                   VL_MULS_III(32, (IData)(4U), vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i)))];
            if ((0xefU > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y))) {
                if ((((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline) 
                      >= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y)) 
                     & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline) 
                        < ((IData)(8U) + (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y))))) {
                    if ((((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot) 
                          >= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x)) 
                         & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot) 
                            < ((IData)(8U) + (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x))))) {
                        vlSelfRef.test_ppu__DOT__dut__DOT__sprite_active = 1U;
                        vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel 
                            = ((2U & ((0xaaU >> (7U 
                                                 & ((IData)(7U) 
                                                    - 
                                                    ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot) 
                                                     - (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x))))) 
                                      << 1U)) | (1U 
                                                 & (0xaaU 
                                                    >> 
                                                    (7U 
                                                     & ((IData)(7U) 
                                                        - 
                                                        ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot) 
                                                         - (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x)))))));
                        if ((0U != (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel))) {
                            vlSelfRef.test_ppu__DOT__dut__DOT__sprite_palette_idx 
                                = (0x00000010U | ((0x0000000cU 
                                                   & ((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_attr) 
                                                      << 2U)) 
                                                  | (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel)));
                        }
                        goto __Vlabel0;
                    }
                }
            }
            vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i 
                = ((IData)(1U) + vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i);
        }
        __Vlabel0: ;
    }
    vlSelfRef.test_ppu__DOT__dut__DOT__final_palette_idx 
        = (((IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_active) 
            & (0U != (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel)))
            ? (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_palette_idx)
            : (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__bg_palette_idx));
    vlSelfRef.test_ppu__DOT__dut__DOT__palette_color 
        = vlSelfRef.test_ppu__DOT__palette[vlSelfRef.test_ppu__DOT__dut__DOT__final_palette_idx];
    vlSelfRef.test_ppu__DOT__dut__DOT__nes_color = 
        ((0x00000020U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
          ? ((0x00000010U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
              ? ((8U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                  ? ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? 0U : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                                   ? 0x00a0a2a0U : 0x00a0d6e4U))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x0098e2b4U : 0x00a8e290U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00b4de78U : 0x00ccd278U)))
                  : ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00e4c490U : 0x00ecb4b0U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00ecaed4U : 0x00ecaeecU))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00d4b2ecU : 0x00bcbcecU)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00a8ccecU : 0x00eceeecU))))
              : ((8U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                  ? ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? 0U : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                                   ? 0x003c3c3cU : 0x0038b4ccU))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x0038cc6cU : 0x004cd020U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x0074c400U : 0x00a0aa00U)))
                  : ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00d48820U : 0x00ec6a64U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00ec58b4U : 0x00e454ecU))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00b062ecU : 0x00787cecU)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x004c9aecU : 0x00eceeecU)))))
          : ((0x00000010U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
              ? ((8U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                  ? ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? 0U : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                                   ? 0U : 0x00006678U))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00007628U : 0x00087c00U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00287200U : 0x00545a00U)))
                  : ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00783c00U : 0x00982220U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00a01464U : 0x008814b0U))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x005c1ee4U : 0x003032ecU)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00084cc4U : 0x00989698U))))
              : ((8U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                  ? ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? 0U : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                                   ? 0U : 0x0000325dU))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00003c22U : 0x00004000U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00083a00U : 0x00202a00U)))
                  : ((4U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                      ? ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x003c1800U : 0x00540400U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x005c0030U : 0x00440064U))
                      : ((2U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                          ? ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00300088U : 0x00081090U)
                          : ((1U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color))
                              ? 0x00001e74U : 0x00545454U))))));
}

VL_ATTR_COLD void Vtest_ppu___024root____Vm_traceActivitySetAll(Vtest_ppu___024root* vlSelf);

VL_ATTR_COLD void Vtest_ppu___024root___eval_stl(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_stl\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vtest_ppu___024root___stl_sequent__TOP__0(vlSelf);
        Vtest_ppu___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool Vtest_ppu___024root___eval_phase__stl(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_phase__stl\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtest_ppu___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vtest_ppu___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vtest_ppu___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vtest_ppu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_ppu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_ppu___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge test_ppu.vblank)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge test_ppu.vblank)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @(posedge test_ppu.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 3U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 3 is active: @(negedge test_ppu.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 4U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 4 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
    if ((1U & (IData)((triggers[0U] >> 5U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 5 is active: @( test_ppu.vblank)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 6U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 6 is active: @( (~ test_ppu.vblank))\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtest_ppu___024root____Vm_traceActivitySetAll(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root____Vm_traceActivitySetAll\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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

VL_ATTR_COLD void Vtest_ppu___024root___ctor_var_reset(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___ctor_var_reset\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->test_ppu__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3138015703446423323ull);
    vlSelf->test_ppu__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 7709715098863435495ull);
    vlSelf->test_ppu__DOT__ppuctrl = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8167050639879729268ull);
    vlSelf->test_ppu__DOT__ppumask = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15462717395453154997ull);
    vlSelf->test_ppu__DOT__ppuscroll_x = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3335330789795252682ull);
    vlSelf->test_ppu__DOT__ppuscroll_y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14479459216771524370ull);
    vlSelf->test_ppu__DOT__ppuaddr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 10130578694036242894ull);
    for (int __Vi0 = 0; __Vi0 < 2048; ++__Vi0) {
        vlSelf->test_ppu__DOT__vram[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3788912586331855954ull);
    }
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->test_ppu__DOT__oam[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17452443921896609308ull);
    }
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->test_ppu__DOT__palette[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3325202524666232719ull);
    }
    vlSelf->test_ppu__DOT__chr_rom_addr = VL_SCOPED_RAND_RESET_I(14, __VscopeHash, 1338569359822393351ull);
    vlSelf->test_ppu__DOT__video_de = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1302393677317891503ull);
    vlSelf->test_ppu__DOT__vblank = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 687357206791515149ull);
    vlSelf->test_ppu__DOT__sprite0_hit = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14675386960817287577ull);
    vlSelf->test_ppu__DOT__rendering = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12193505535051957420ull);
    vlSelf->test_ppu__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->test_ppu__DOT__unnamedblk2__DOT__i = 0;
    vlSelf->test_ppu__DOT__unnamedblk3__DOT__i = 0;
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->test_ppu__DOT__dut__DOT__palette[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6281290356194619056ull);
    }
    vlSelf->test_ppu__DOT__dut__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 14525041097642810107ull);
    vlSelf->test_ppu__DOT__dut__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 12883920195251945717ull);
    vlSelf->test_ppu__DOT__dut__DOT__pattern_lo_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5571466434409394764ull);
    vlSelf->test_ppu__DOT__dut__DOT__pattern_hi_reg = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6409170695355844030ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12746532584744326540ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_tile = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 11281396119757413542ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_attr = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6502751486179774160ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_x = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9154300692405030508ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_pixel = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 6338512606106180547ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 8893419242068717848ull);
    vlSelf->test_ppu__DOT__dut__DOT__sprite_active = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16681107246535287573ull);
    vlSelf->test_ppu__DOT__dut__DOT__tile_index = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7949803707317690012ull);
    vlSelf->test_ppu__DOT__dut__DOT__attr_byte = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8546533644083308617ull);
    vlSelf->test_ppu__DOT__dut__DOT__attr_bits = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 16609663750737953826ull);
    vlSelf->test_ppu__DOT__dut__DOT__pixel_value = VL_SCOPED_RAND_RESET_I(2, __VscopeHash, 11299198608635883759ull);
    vlSelf->test_ppu__DOT__dut__DOT__bg_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 9228056883798902412ull);
    vlSelf->test_ppu__DOT__dut__DOT__tile_x = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 17527101579055635102ull);
    vlSelf->test_ppu__DOT__dut__DOT__tile_y = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 15291228004671320544ull);
    vlSelf->test_ppu__DOT__dut__DOT__scroll_x = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 390861052647794591ull);
    vlSelf->test_ppu__DOT__dut__DOT__scroll_y = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 10200088749574527689ull);
    vlSelf->test_ppu__DOT__dut__DOT__attr_addr = VL_SCOPED_RAND_RESET_I(10, __VscopeHash, 1385810888190412246ull);
    vlSelf->test_ppu__DOT__dut__DOT__nes_color = VL_SCOPED_RAND_RESET_I(24, __VscopeHash, 10430057324053518615ull);
    vlSelf->test_ppu__DOT__dut__DOT__final_palette_idx = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 999690443641248845ull);
    vlSelf->test_ppu__DOT__dut__DOT__palette_color = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8932525939605898706ull);
    vlSelf->test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->__Vdly__test_ppu__DOT__dut__DOT__scanline = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 12625771250586538464ull);
    vlSelf->__Vdly__test_ppu__DOT__dut__DOT__dot = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 12883229656937395272ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13165623707026218139ull);
    vlSelf->__Vtrigprevexpr___TOP__test_ppu__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16242627530906706447ull);
    vlSelf->__Vtrigprevexpr___TOP__test_ppu__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3511182411699869459ull);
    vlSelf->__Vtrigprevexpr_h8ca0d663__1 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1194008581866694082ull);
    vlSelf->__VactDidInit = 0;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 8; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
