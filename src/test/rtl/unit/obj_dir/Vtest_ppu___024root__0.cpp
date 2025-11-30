// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_ppu.h for the primary calling header

#include "Vtest_ppu__pch.h"

VL_ATTR_COLD void Vtest_ppu___024root___eval_initial__TOP(Vtest_ppu___024root* vlSelf);
VlCoroutine Vtest_ppu___024root___eval_initial__TOP__Vtiming__0(Vtest_ppu___024root* vlSelf);
VlCoroutine Vtest_ppu___024root___eval_initial__TOP__Vtiming__1(Vtest_ppu___024root* vlSelf);

void Vtest_ppu___024root___eval_initial(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_initial\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_ppu___024root___eval_initial__TOP(vlSelf);
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    Vtest_ppu___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vtest_ppu___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vtest_ppu___024root___eval_initial__TOP__Vtiming__0(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile("waveforms/test_ppu.vcd"s);
    vlSymsp->_traceDumpOpen();
    vlSelfRef.test_ppu__DOT__rst_n = 0U;
    vlSelfRef.test_ppu__DOT__ppuctrl = 0U;
    vlSelfRef.test_ppu__DOT__ppumask = 0U;
    vlSelfRef.test_ppu__DOT__ppuscroll_x = 0U;
    vlSelfRef.test_ppu__DOT__ppuscroll_y = 0U;
    vlSelfRef.test_ppu__DOT__ppuaddr = 0U;
    vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000800U, vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i)) {
        vlSelfRef.test_ppu__DOT__vram[(0x000007ffU 
                                       & vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i)] = 0U;
        vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i 
            = ((IData)(1U) + vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i);
    }
    vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00000100U, vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i)) {
        vlSelfRef.test_ppu__DOT__oam[(0x000000ffU & vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i)] = 0xffU;
        vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i 
            = ((IData)(1U) + vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i);
    }
    vlSelfRef.test_ppu__DOT__palette[0U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[1U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[2U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[3U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[4U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[5U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[6U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[7U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[8U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[9U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0aU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0bU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0cU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0dU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0eU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x0fU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x10U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x11U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x12U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x13U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x14U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x15U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x16U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x17U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x18U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x19U] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1aU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1bU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1cU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1dU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1eU] = 0U;
    vlSelfRef.test_ppu__DOT__palette[0x1fU] = 0U;
    vlSelfRef.test_ppu__DOT__unnamedblk3__DOT__i = 0x00000020U;
    vlSelfRef.test_ppu__DOT__palette[0U] = 0x0fU;
    vlSelfRef.test_ppu__DOT__palette[1U] = 0x30U;
    vlSelfRef.test_ppu__DOT__palette[2U] = 0x16U;
    vlSelfRef.test_ppu__DOT__palette[3U] = 0x27U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000014ULL, 
                                         nullptr, "test_ppu.sv", 
                                         72);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.test_ppu__DOT__rst_n = 1U;
    VL_WRITEF_NX("[TEST] Waiting for VBlank\n",0);
    while ((1U & (~ (IData)(vlSelfRef.test_ppu__DOT__vblank)))) {
        co_await vlSelfRef.__VtrigSched_h25c96872__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( test_ppu.vblank)", 
                                                             "test_ppu.sv", 
                                                             76);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    VL_WRITEF_NX("[TEST] VBlank detected!\n[TEST] Enable rendering\n",0);
    vlSelfRef.test_ppu__DOT__ppuctrl = 0x90U;
    vlSelfRef.test_ppu__DOT__ppumask = 0x1eU;
    while (vlSelfRef.test_ppu__DOT__vblank) {
        co_await vlSelfRef.__VtrigSched_h189696ad__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( (~ test_ppu.vblank))", 
                                                             "test_ppu.sv", 
                                                             85);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    while ((1U & (~ (IData)(vlSelfRef.test_ppu__DOT__vblank)))) {
        co_await vlSelfRef.__VtrigSched_h25c96872__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( test_ppu.vblank)", 
                                                             "test_ppu.sv", 
                                                             86);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    VL_WRITEF_NX("[TEST] Second VBlank detected!\n",0);
    while (vlSelfRef.test_ppu__DOT__vblank) {
        co_await vlSelfRef.__VtrigSched_h189696ad__0.trigger(1U, 
                                                             nullptr, 
                                                             "@( (~ test_ppu.vblank))", 
                                                             "test_ppu.sv", 
                                                             90);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    co_await vlSelfRef.__VdlySched.delay(0x0000000000002710ULL, 
                                         nullptr, "test_ppu.sv", 
                                         91);
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    VL_WRITEF_NX("[TEST] All tests passed!\n",0);
    VL_FINISH_MT("test_ppu.sv", 94, "");
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
}

VlCoroutine Vtest_ppu___024root___eval_initial__TOP__Vtiming__1(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(2ULL, 
                                             nullptr, 
                                             "test_ppu.sv", 
                                             45);
        vlSelfRef.test_ppu__DOT__clk = (1U & (~ (IData)(vlSelfRef.test_ppu__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_ppu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vtest_ppu___024root___eval_triggers__act(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_triggers__act\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __Vtrigprevexpr_h8ca0d663__0;
    __Vtrigprevexpr_h8ca0d663__0 = 0;
    // Body
    __Vtrigprevexpr_h8ca0d663__0 = (1U & (~ (IData)(vlSelfRef.test_ppu__DOT__vblank)));
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    (((((IData)(__Vtrigprevexpr_h8ca0d663__0) 
                                                        != (IData)(vlSelfRef.__Vtrigprevexpr_h8ca0d663__1)) 
                                                       << 6U) 
                                                      | ((((IData)(vlSelfRef.test_ppu__DOT__vblank) 
                                                           != (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0)) 
                                                          << 5U) 
                                                         | (vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                            << 4U))) 
                                                     | (((((~ (IData)(vlSelfRef.test_ppu__DOT__rst_n)) 
                                                           & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__rst_n__0)) 
                                                          << 3U) 
                                                         | (((IData)(vlSelfRef.test_ppu__DOT__clk) 
                                                             & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__clk__0))) 
                                                            << 2U)) 
                                                        | ((((~ (IData)(vlSelfRef.test_ppu__DOT__vblank)) 
                                                             & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0)) 
                                                            << 1U) 
                                                           | ((IData)(vlSelfRef.test_ppu__DOT__vblank) 
                                                              & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0))))))));
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0 
        = vlSelfRef.test_ppu__DOT__vblank;
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__clk__0 
        = vlSelfRef.test_ppu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_ppu__DOT__rst_n__0 
        = vlSelfRef.test_ppu__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr_h8ca0d663__1 = __Vtrigprevexpr_h8ca0d663__0;
    if (VL_UNLIKELY(((1U & (~ (IData)(vlSelfRef.__VactDidInit)))))) {
        vlSelfRef.__VactDidInit = 1U;
        vlSelfRef.__VactTriggered[0U] = (0x0000000000000020ULL 
                                         | vlSelfRef.__VactTriggered
                                         [0U]);
        vlSelfRef.__VactTriggered[0U] = (0x0000000000000040ULL 
                                         | vlSelfRef.__VactTriggered
                                         [0U]);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_ppu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vtest_ppu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___trigger_anySet__act\n"); );
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

void Vtest_ppu___024root___act_comb__TOP__0(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___act_comb__TOP__0\n"); );
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

void Vtest_ppu___024root___eval_act(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_act\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x0000000000000070ULL & vlSelfRef.__VactTriggered
         [0U])) {
        Vtest_ppu___024root___act_comb__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
}

void Vtest_ppu___024root___nba_sequent__TOP__0(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_sequent__TOP__0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_WRITEF_NX("  VBlank START\n",0);
}

void Vtest_ppu___024root___nba_sequent__TOP__1(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_sequent__TOP__1\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VL_WRITEF_NX("  VBlank END\n",0);
}

void Vtest_ppu___024root___nba_sequent__TOP__2(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_sequent__TOP__2\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__scanline 
        = vlSelfRef.test_ppu__DOT__dut__DOT__scanline;
    vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__dot 
        = vlSelfRef.test_ppu__DOT__dut__DOT__dot;
    if (vlSelfRef.test_ppu__DOT__rst_n) {
        if ((0x0154U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot))) {
            vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__scanline 
                = ((0x0105U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline))
                    ? 0U : (0x000001ffU & ((IData)(1U) 
                                           + (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline))));
            vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__dot = 0U;
        } else {
            vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__dot 
                = (0x000001ffU & ((IData)(1U) + (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)));
        }
        if (VL_UNLIKELY((((0x00f1U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
                          & (1U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))))) {
            VL_WRITEF_NX("[PPU] VBlank START at frame cycle\n",0);
            vlSelfRef.test_ppu__DOT__vblank = 1U;
        }
        if (((0x0105U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
             & (1U == (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
            vlSelfRef.test_ppu__DOT__vblank = 0U;
        }
        vlSelfRef.test_ppu__DOT__rendering = ((0x00f0U 
                                               > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
                                              & (IData)(
                                                        (0U 
                                                         != 
                                                         (0x18U 
                                                          & (IData)(vlSelfRef.test_ppu__DOT__ppumask)))));
    } else {
        vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__scanline = 0U;
        vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__dot = 0U;
        vlSelfRef.test_ppu__DOT__vblank = 0U;
        vlSelfRef.test_ppu__DOT__sprite0_hit = 0U;
    }
}

void Vtest_ppu___024root___nba_comb__TOP__0(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_comb__TOP__0\n"); );
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
}

void Vtest_ppu___024root___nba_sequent__TOP__3(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_sequent__TOP__3\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x00f0U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline))) {
        if ((6U == (7U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
            vlSelfRef.test_ppu__DOT__dut__DOT__pattern_lo_reg = 0xaaU;
        }
        if ((6U != (7U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
            if ((0U == (7U & (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
                vlSelfRef.test_ppu__DOT__dut__DOT__pattern_hi_reg = 0xaaU;
            }
        }
    }
}

void Vtest_ppu___024root___nba_sequent__TOP__4(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_sequent__TOP__4\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_ppu__DOT__dut__DOT__scanline = vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__scanline;
    vlSelfRef.test_ppu__DOT__dut__DOT__dot = vlSelfRef.__Vdly__test_ppu__DOT__dut__DOT__dot;
    vlSelfRef.test_ppu__DOT__video_de = ((0x00f0U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
                                         & (0x0100U 
                                            > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)));
}

void Vtest_ppu___024root___nba_comb__TOP__1(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___nba_comb__TOP__1\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (((0x00f0U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
         & (0x0100U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))) {
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

void Vtest_ppu___024root___eval_nba(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_nba\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_ppu___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((2ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_ppu___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((0x000000000000000cULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vtest_ppu___024root___nba_sequent__TOP__2(vlSelf);
        vlSelfRef.__Vm_traceActivity[4U] = 1U;
    }
    if ((0x0000000000000070ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vtest_ppu___024root___nba_comb__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[5U] = 1U;
    }
    if ((4ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vtest_ppu___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((0x000000000000000cULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vtest_ppu___024root___nba_sequent__TOP__4(vlSelf);
        vlSelfRef.__Vm_traceActivity[6U] = 1U;
    }
    if ((0x000000000000007cULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vtest_ppu___024root___nba_comb__TOP__1(vlSelf);
        vlSelfRef.__Vm_traceActivity[7U] = 1U;
    }
}

void Vtest_ppu___024root___timing_commit(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___timing_commit\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (0x0000000000000020ULL & vlSelfRef.__VactTriggered
            [0U]))) {
        vlSelfRef.__VtrigSched_h25c96872__0.commit(
                                                   "@( test_ppu.vblank)");
    }
    if ((! (0x0000000000000040ULL & vlSelfRef.__VactTriggered
            [0U]))) {
        vlSelfRef.__VtrigSched_h189696ad__0.commit(
                                                   "@( (~ test_ppu.vblank))");
    }
}

void Vtest_ppu___024root___timing_resume(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___timing_resume\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x0000000000000020ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VtrigSched_h25c96872__0.resume(
                                                   "@( test_ppu.vblank)");
    }
    if ((0x0000000000000040ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VtrigSched_h189696ad__0.resume(
                                                   "@( (~ test_ppu.vblank))");
    }
    if ((0x0000000000000010ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vtest_ppu___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_ppu___024root___eval_phase__act(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_phase__act\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vtest_ppu___024root___eval_triggers__act(vlSelf);
    Vtest_ppu___024root___timing_commit(vlSelf);
    Vtest_ppu___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vtest_ppu___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vtest_ppu___024root___timing_resume(vlSelf);
        Vtest_ppu___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vtest_ppu___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vtest_ppu___024root___eval_phase__nba(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_phase__nba\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vtest_ppu___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vtest_ppu___024root___eval_nba(vlSelf);
        Vtest_ppu___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vtest_ppu___024root___eval(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vtest_ppu___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("test_ppu.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vtest_ppu___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("test_ppu.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vtest_ppu___024root___eval_phase__act(vlSelf));
    } while (Vtest_ppu___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vtest_ppu___024root___eval_debug_assertions(Vtest_ppu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root___eval_debug_assertions\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
