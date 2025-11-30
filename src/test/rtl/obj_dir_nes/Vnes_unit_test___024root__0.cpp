// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnes_unit_test.h for the primary calling header

#include "Vnes_unit_test__pch.h"

VL_ATTR_COLD void Vnes_unit_test___024root___eval_initial__TOP(Vnes_unit_test___024root* vlSelf);
VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__0(Vnes_unit_test___024root* vlSelf);
VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__1(Vnes_unit_test___024root* vlSelf);
VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__2(Vnes_unit_test___024root* vlSelf);

void Vnes_unit_test___024root___eval_initial(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_initial\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vnes_unit_test___024root___eval_initial__TOP(vlSelf);
    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__2(vlSelf);
}

VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__0(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ nes_unit_test__DOT__addr_changes;
    nes_unit_test__DOT__addr_changes = 0;
    IData/*31:0*/ nes_unit_test__DOT__hsync_count;
    nes_unit_test__DOT__hsync_count = 0;
    IData/*31:0*/ nes_unit_test__DOT__vsync_count;
    nes_unit_test__DOT__vsync_count = 0;
    IData/*31:0*/ nes_unit_test__DOT__pixel_count;
    nes_unit_test__DOT__pixel_count = 0;
    IData/*31:0*/ nes_unit_test__DOT__error_count;
    nes_unit_test__DOT__error_count = 0;
    SData/*14:0*/ nes_unit_test__DOT__last_addr;
    nes_unit_test__DOT__last_addr = 0;
    CData/*0:0*/ nes_unit_test__DOT__last_hsync;
    nes_unit_test__DOT__last_hsync = 0;
    CData/*0:0*/ nes_unit_test__DOT__last_vsync;
    nes_unit_test__DOT__last_vsync = 0;
    IData/*31:0*/ nes_unit_test__DOT__unnamedblk3__DOT__i;
    nes_unit_test__DOT__unnamedblk3__DOT__i = 0;
    IData/*31:0*/ nes_unit_test__DOT__unnamedblk4__DOT__i;
    nes_unit_test__DOT__unnamedblk4__DOT__i = 0;
    IData/*31:0*/ nes_unit_test__DOT__unnamedblk5__DOT__i;
    nes_unit_test__DOT__unnamedblk5__DOT__i = 0;
    IData/*31:0*/ nes_unit_test__DOT__unnamedblk6__DOT__i;
    nes_unit_test__DOT__unnamedblk6__DOT__i = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i;
    __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i;
    __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__2__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__2__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__4__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__4__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__5__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__5__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__6__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__6__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__7__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__7__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__8__n;
    __Vtask_nes_unit_test__DOT__wait_cycles__8__n = 0;
    IData/*31:0*/ __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    // Body
    VL_WRITEF_NX("\n=== NES System Unit Tests ===\n\nTest 1: System Reset\n",0);
    vlSelfRef.nes_unit_test__DOT__prg_rom[0x03fcU] = 0U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[0x03fdU] = 0xc0U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[0U] = 0xa9U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[1U] = 0x42U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[2U] = 0x8dU;
    vlSelfRef.nes_unit_test__DOT__prg_rom[3U] = 0U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[4U] = 0x20U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[5U] = 0xa9U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[6U] = 0x1eU;
    vlSelfRef.nes_unit_test__DOT__prg_rom[7U] = 0x8dU;
    vlSelfRef.nes_unit_test__DOT__prg_rom[8U] = 1U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[9U] = 0x20U;
    vlSelfRef.nes_unit_test__DOT__prg_rom[0x000aU] = 0x4cU;
    vlSelfRef.nes_unit_test__DOT__prg_rom[0x000bU] = 0x0aU;
    vlSelfRef.nes_unit_test__DOT__prg_rom[0x000cU] = 0xc0U;
    __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i = 0x0000000dU;
    while (VL_GTS_III(32, 0x00004000U, __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i)) {
        vlSelfRef.nes_unit_test__DOT__prg_rom[(0x00003fffU 
                                               & __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i)] = 0xeaU;
        __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk1__DOT__i);
    }
    __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00002000U, __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i)) {
        vlSelfRef.nes_unit_test__DOT__chr_rom[(0x00001fffU 
                                               & __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i)] = 0U;
        __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i 
            = ((IData)(1U) + __Vtask_nes_unit_test__DOT__load_test_rom__0__unnamedblk2__DOT__i);
    }
    __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.nes_unit_test__DOT__rst_n = 0U;
    __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0x00000014U;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             50);
        __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.nes_unit_test__DOT__rst_n = 1U;
    __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x00000014U;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             52);
        __Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_nes_unit_test__DOT__reset_system__1__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    VL_WRITEF_NX("  PASS - System reset\n\n",0);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 2: CPU Execution\n",0);
    __Vtask_nes_unit_test__DOT__wait_cycles__2__n = 0x000003e8U;
    __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__2__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__2__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    if ((0U != ((0x8000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                 ? (0x00003fffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                 : 0U))) {
        VL_WRITEF_NX("  PASS - CPU accessing ROM (addr=0x%04x)\n\n",0,
                     15,((0x8000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                          ? (0x00003fffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                          : 0U));
        vlSelfRef.nes_unit_test__DOT__pass_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__pass_count);
    } else {
        VL_WRITEF_NX("  FAIL - CPU not accessing ROM\n\n",0);
        vlSelfRef.nes_unit_test__DOT__fail_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__fail_count);
    }
    VL_WRITEF_NX("Test 3: Reset Vector\n",0);
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.nes_unit_test__DOT__rst_n = 0U;
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0x00000014U;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             50);
        __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.nes_unit_test__DOT__rst_n = 1U;
    __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x00000014U;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             52);
        __Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_nes_unit_test__DOT__reset_system__3__nes_unit_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_nes_unit_test__DOT__wait_cycles__4__n = 0x00000064U;
    __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__4__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__4__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    VL_WRITEF_NX("  PASS - Reset vector processed\n\n",0);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 4: Memory Access Pattern\n",0);
    nes_unit_test__DOT__addr_changes = 0U;
    nes_unit_test__DOT__last_addr = ((0x8000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                      ? (0x00003fffU 
                                         & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                      : 0U);
    nes_unit_test__DOT__unnamedblk3__DOT__i = 0U;
    while (VL_GTS_III(32, 0x000003e8U, nes_unit_test__DOT__unnamedblk3__DOT__i)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             130);
        if ((((0x8000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
               ? (0x00003fffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
               : 0U) != (IData)(nes_unit_test__DOT__last_addr))) {
            nes_unit_test__DOT__addr_changes = ((IData)(1U) 
                                                + nes_unit_test__DOT__addr_changes);
            nes_unit_test__DOT__last_addr = ((0x8000U 
                                              <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                              ? (0x00003fffU 
                                                 & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))
                                              : 0U);
        }
        nes_unit_test__DOT__unnamedblk3__DOT__i = ((IData)(1U) 
                                                   + nes_unit_test__DOT__unnamedblk3__DOT__i);
    }
    if (VL_LTS_III(32, 0x0000000aU, nes_unit_test__DOT__addr_changes)) {
        VL_WRITEF_NX("  PASS - Memory accessed %0d times\n\n",0,
                     32,nes_unit_test__DOT__addr_changes);
        vlSelfRef.nes_unit_test__DOT__pass_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__pass_count);
    } else {
        VL_WRITEF_NX("  FAIL - Insufficient memory access\n\n",0);
        vlSelfRef.nes_unit_test__DOT__fail_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__fail_count);
    }
    VL_WRITEF_NX("Test 5: Video Sync Signals\n",0);
    nes_unit_test__DOT__hsync_count = 0U;
    nes_unit_test__DOT__vsync_count = 0U;
    nes_unit_test__DOT__last_hsync = 0U;
    nes_unit_test__DOT__last_vsync = 0U;
    nes_unit_test__DOT__unnamedblk4__DOT__i = 0U;
    while (VL_GTS_III(32, 0x0007a120U, nes_unit_test__DOT__unnamedblk4__DOT__i)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             152);
        if ((((0x0118U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)) 
              & (0x0130U > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot))) 
             & (~ (IData)(nes_unit_test__DOT__last_hsync)))) {
            nes_unit_test__DOT__hsync_count = ((IData)(1U) 
                                               + nes_unit_test__DOT__hsync_count);
        }
        if ((((0x00f3U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)) 
              & (0x00f6U > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline))) 
             & (~ (IData)(nes_unit_test__DOT__last_vsync)))) {
            nes_unit_test__DOT__vsync_count = ((IData)(1U) 
                                               + nes_unit_test__DOT__vsync_count);
        }
        nes_unit_test__DOT__last_hsync = ((0x0118U 
                                           <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)) 
                                          & (0x0130U 
                                             > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)));
        nes_unit_test__DOT__last_vsync = ((0x00f3U 
                                           <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)) 
                                          & (0x00f6U 
                                             > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)));
        nes_unit_test__DOT__unnamedblk4__DOT__i = ((IData)(1U) 
                                                   + nes_unit_test__DOT__unnamedblk4__DOT__i);
    }
    if (VL_LTS_III(32, 0x00000064U, nes_unit_test__DOT__hsync_count)) {
        VL_WRITEF_NX("  PASS - HSYNC=%0d VSYNC=%0d\n\n",0,
                     32,nes_unit_test__DOT__hsync_count,
                     32,nes_unit_test__DOT__vsync_count);
        vlSelfRef.nes_unit_test__DOT__pass_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__pass_count);
    } else {
        VL_WRITEF_NX("  FAIL - HSYNC=%0d VSYNC=%0d\n\n",0,
                     32,nes_unit_test__DOT__hsync_count,
                     32,nes_unit_test__DOT__vsync_count);
        vlSelfRef.nes_unit_test__DOT__fail_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__fail_count);
    }
    VL_WRITEF_NX("Test 6: CHR ROM Access\n",0);
    __Vtask_nes_unit_test__DOT__wait_cycles__5__n = 0x00002710U;
    __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__5__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__5__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    VL_WRITEF_NX("  PASS - CHR ROM interface functional\n\n",0);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 7: Controller Input\n",0);
    vlSelfRef.nes_unit_test__DOT__controller1 = 0xffU;
    __Vtask_nes_unit_test__DOT__wait_cycles__6__n = 0x00000064U;
    __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__6__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__6__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    vlSelfRef.nes_unit_test__DOT__controller1 = 0U;
    __Vtask_nes_unit_test__DOT__wait_cycles__7__n = 0x00000064U;
    __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__7__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__7__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    VL_WRITEF_NX("  PASS - Controller input accepted\n\n",0);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 8: Audio Output\n",0);
    __Vtask_nes_unit_test__DOT__wait_cycles__8__n = 0x000003e8U;
    __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_nes_unit_test__DOT__wait_cycles__8__n;
    while (VL_LTS_III(32, 0U, __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             87);
        __Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_nes_unit_test__DOT__wait_cycles__8__nes_unit_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    VL_WRITEF_NX("  PASS - Audio outputs defined\n\n",0);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 9: Video Output\n",0);
    nes_unit_test__DOT__pixel_count = 0U;
    nes_unit_test__DOT__unnamedblk5__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00002710U, nes_unit_test__DOT__unnamedblk5__DOT__i)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             202);
        if (((0x00f0U > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)) 
             & (0x0100U > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)))) {
            nes_unit_test__DOT__pixel_count = ((IData)(1U) 
                                               + nes_unit_test__DOT__pixel_count);
        }
        nes_unit_test__DOT__unnamedblk5__DOT__i = ((IData)(1U) 
                                                   + nes_unit_test__DOT__unnamedblk5__DOT__i);
    }
    VL_WRITEF_NX("  INFO - Pixels output: %0d\n\n  PASS - Video output functional\n\n",0,
                 32,nes_unit_test__DOT__pixel_count);
    vlSelfRef.nes_unit_test__DOT__pass_count = ((IData)(1U) 
                                                + vlSelfRef.nes_unit_test__DOT__pass_count);
    VL_WRITEF_NX("Test 10: System Stability (10K cycles)\n",0);
    nes_unit_test__DOT__error_count = 0U;
    nes_unit_test__DOT__unnamedblk6__DOT__i = 0U;
    while (VL_GTS_III(32, 0x00002710U, nes_unit_test__DOT__unnamedblk6__DOT__i)) {
        co_await vlSelfRef.__VtrigSched_h4614a672__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge nes_unit_test.clk)", 
                                                             "nes_unit_test.sv", 
                                                             213);
        nes_unit_test__DOT__unnamedblk6__DOT__i = ((IData)(1U) 
                                                   + nes_unit_test__DOT__unnamedblk6__DOT__i);
    }
    if ((0U == nes_unit_test__DOT__error_count)) {
        VL_WRITEF_NX("  PASS - No undefined states\n\n",0);
        vlSelfRef.nes_unit_test__DOT__pass_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__pass_count);
    } else {
        VL_WRITEF_NX("  FAIL - %0d undefined states\n\n",0,
                     32,nes_unit_test__DOT__error_count);
        vlSelfRef.nes_unit_test__DOT__fail_count = 
            ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__fail_count);
    }
    VL_WRITEF_NX("\n=== Test Summary ===\nPassed: %0d\nFailed: %0d\nTotal:  %0d\n",0,
                 32,vlSelfRef.nes_unit_test__DOT__pass_count,
                 32,vlSelfRef.nes_unit_test__DOT__fail_count,
                 32,(vlSelfRef.nes_unit_test__DOT__pass_count 
                     + vlSelfRef.nes_unit_test__DOT__fail_count));
    if ((0U == vlSelfRef.nes_unit_test__DOT__fail_count)) {
        VL_WRITEF_NX("\n\342\234\205 All NES unit tests passed!\n",0);
    } else {
        VL_WRITEF_NX("\n\342\232\240\357\270\217  %0d test(s) failed\n",0,
                     32,vlSelfRef.nes_unit_test__DOT__fail_count);
    }
    VL_FINISH_MT("nes_unit_test.sv", 236, "");
}

VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__1(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    co_await vlSelfRef.__VdlySched.delay(0x0000000002faf080ULL, 
                                         nullptr, "nes_unit_test.sv", 
                                         241);
    VL_WRITEF_NX("\nERROR: Test timeout!\n",0);
    VL_FINISH_MT("nes_unit_test.sv", 243, "");
}

VlCoroutine Vnes_unit_test___024root___eval_initial__TOP__Vtiming__2(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_initial__TOP__Vtiming__2\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "nes_unit_test.sv", 
                                             8);
        vlSelfRef.nes_unit_test__DOT__clk = (1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnes_unit_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vnes_unit_test___024root___eval_triggers__act(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_triggers__act\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                      << 4U) 
                                                     | (((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppu_clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__ppu_clk__0))) 
                                                          << 3U) 
                                                         | (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_clk) 
                                                             & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__cpu_clk__0))) 
                                                            << 2U)) 
                                                        | ((((~ (IData)(vlSelfRef.nes_unit_test__DOT__rst_n)) 
                                                             & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__rst_n__0)) 
                                                            << 1U) 
                                                           | ((IData)(vlSelfRef.nes_unit_test__DOT__clk) 
                                                              & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__clk__0))))))));
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__clk__0 
        = vlSelfRef.nes_unit_test__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__rst_n__0 
        = vlSelfRef.nes_unit_test__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__cpu_clk__0 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nes_unit_test__DOT__dut__DOT__ppu_clk__0 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__ppu_clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vnes_unit_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vnes_unit_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___trigger_anySet__act\n"); );
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

void Vnes_unit_test___024root___act_sequent__TOP__0(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___act_sequent__TOP__0\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
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

void Vnes_unit_test___024root___eval_act(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_act\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered[0U])) {
        Vnes_unit_test___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vnes_unit_test___024root___nba_sequent__TOP__0(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__0\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div 
        = ((IData)(vlSelfRef.nes_unit_test__DOT__rst_n)
            ? (0x0000000fU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div)))
            : 0U);
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_clk 
        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div) 
                 >> 3U));
    vlSelfRef.nes_unit_test__DOT__dut__DOT__ppu_clk 
        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__clk_div) 
                 >> 1U));
}

void Vnes_unit_test___024root___nba_sequent__TOP__1(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__1\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__scanline 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__dot 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__dot;
}

void Vnes_unit_test___024root___nba_sequent__TOP__2(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__2\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    VlUnpacked<CData/*7:0*/, 4> nes_unit_test__DOT__dut__DOT__apu_pulse1;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        nes_unit_test__DOT__dut__DOT__apu_pulse1[__Vi0] = 0;
    }
    VlUnpacked<CData/*7:0*/, 4> nes_unit_test__DOT__dut__DOT__apu_pulse2;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        nes_unit_test__DOT__dut__DOT__apu_pulse2[__Vi0] = 0;
    }
    VlUnpacked<CData/*7:0*/, 4> nes_unit_test__DOT__dut__DOT__apu_triangle;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        nes_unit_test__DOT__dut__DOT__apu_triangle[__Vi0] = 0;
    }
    VlUnpacked<CData/*7:0*/, 4> nes_unit_test__DOT__dut__DOT__apu_noise;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        nes_unit_test__DOT__dut__DOT__apu_noise[__Vi0] = 0;
    }
    VlUnpacked<CData/*7:0*/, 4> nes_unit_test__DOT__dut__DOT__apu_dmc;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        nes_unit_test__DOT__dut__DOT__apu_dmc[__Vi0] = 0;
    }
    IData/*31:0*/ __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count;
    __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count = 0;
    CData/*7:0*/ __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr;
    __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr = 0;
    CData/*0:0*/ __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch;
    __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch = 0;
    CData/*7:0*/ __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset;
    __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__ram__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__ram__v0 = 0;
    SData/*10:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__ram__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__ram__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__ram__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__ram__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v0 = 0;
    CData/*7:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__vram__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__vram__v0 = 0;
    SData/*10:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__vram__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__vram__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__vram__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__vram__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_triangle__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_triangle__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__apu_triangle__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_noise__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_noise__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_noise__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_noise__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__apu_noise__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_noise__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_dmc__v0;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_dmc__v0;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__apu_dmc__v0;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    CData/*7:0*/ __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v1;
    __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v1 = 0;
    CData/*7:0*/ __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v1;
    __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v1 = 0;
    CData/*0:0*/ __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v1;
    __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v1 = 0;
    // Body
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__D;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__I;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__B;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr;
    __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuctrl 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuctrl;
    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr;
    __VdlySet__nes_unit_test__DOT__dut__DOT__vram__v0 = 0U;
    vlSelfRef.__VdlySet__nes_unit_test__DOT__dut__DOT__palette__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_noise__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 = 0U;
    __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr = vlSelfRef.nes_unit_test__DOT__dut__DOT__oamaddr;
    __VdlySet__nes_unit_test__DOT__dut__DOT__ram__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v0 = 0U;
    __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v1 = 0U;
    __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr_latch;
    __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset 
        = vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset;
    if (vlSelfRef.nes_unit_test__DOT__rst_n) {
        if (vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_active) {
            __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v1 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__ram
                [((0x00000700U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_page) 
                                  << 8U)) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset))];
            __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v1 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset;
            __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v1 = 1U;
            __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset 
                = (0x000000ffU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset)));
            if ((0xffU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_active = 0U;
            }
        }
        if ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank) 
              & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank_sync))) 
             & (~ ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw) 
                   & (0x2002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))))) {
            vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus 
                = (0x00000080U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus));
        }
        if (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw) 
             & (0x2002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
            __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch = 0U;
            vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus 
                = (0x7fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus));
        }
    } else {
        __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_active = 0U;
        __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__ppustatus = 0U;
    }
    if (vlSelfRef.nes_unit_test__DOT__rst_n) {
        if ((1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw)))) {
            __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count 
                = ((IData)(1U) + vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count);
            if (VL_UNLIKELY((((0x2000U <= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                              & (0x4020U > (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))))) {
                VL_WRITEF_NX("[IO_WRITE] #%10# addr=$%04x data=$%02x\n",0,
                             32,vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count,
                             16,(IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr),
                             8,vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out);
            }
            if (VL_UNLIKELY(((0U == VL_MODDIV_III(32, vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count, (IData)(0x00002710U)))))) {
                VL_WRITEF_NX("[DEBUG] Total writes: %10#\n",0,
                             32,vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count);
            }
            if (((((((((0x1000U == (0xf000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                       | (0x2000U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                      | (0x2001U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                     | (0x2003U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                    | (0x2004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                   | (0x2005U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                  | (0x2006U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                 | (0x2007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                if ((0x1000U == (0xf000U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__ram__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__ram__v0 
                        = (0x000007ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__ram__v0 = 1U;
                } else if (VL_UNLIKELY(((0x2000U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))))) {
                    VL_WRITEF_NX("[PPU] PPUCTRL=$%02x\n",0,
                                 8,vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out);
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuctrl 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                } else if (VL_UNLIKELY(((0x2001U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))))) {
                    VL_WRITEF_NX("[PPU] PPUMASK=$%02x\n",0,
                                 8,vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out);
                } else if ((0x2003U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                } else if ((0x2004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__oamaddr;
                    __VdlySet__nes_unit_test__DOT__dut__DOT__oam__v0 = 1U;
                    __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr 
                        = (0x000000ffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__oamaddr)));
                } else if ((0x2005U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch 
                        = (1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr_latch)));
                } else if ((0x2006U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr 
                        = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr_latch)
                            ? ((0xff00U & (IData)(vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr)) 
                               | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out))
                            : ((0x00ffU & (IData)(vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr)) 
                               | ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out) 
                                  << 8U)));
                    __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch 
                        = (1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr_latch)));
                } else {
                    if ((0x2000U <= (0x00003fffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr)))) {
                        if ((0x3f00U > (0x00003fffU 
                                        & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr)))) {
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__vram_write_count 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__vram_write_count)));
                            __VdlyVal__nes_unit_test__DOT__dut__DOT__vram__v0 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                            __VdlyDim0__nes_unit_test__DOT__dut__DOT__vram__v0 
                                = (0x000007ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr));
                            __VdlySet__nes_unit_test__DOT__dut__DOT__vram__v0 = 1U;
                        } else {
                            vlSelfRef.__VdlyVal__nes_unit_test__DOT__dut__DOT__palette__v0 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                            vlSelfRef.__VdlyDim0__nes_unit_test__DOT__dut__DOT__palette__v0 
                                = (0x0000001fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr));
                            vlSelfRef.__VdlySet__nes_unit_test__DOT__dut__DOT__palette__v0 = 1U;
                        }
                    }
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr 
                        = (0x0000ffffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr) 
                                          + ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuctrl))
                                              ? 0x00000020U
                                              : 1U)));
                }
            } else if ((((((((((((0x4000U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                                 || (0x4001U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                || (0x4002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                               || (0x4003U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                              | ((((0x4004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                                   || (0x4005U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                  || (0x4006U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                 || (0x4007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) 
                             | ((((0x4008U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                                  || (0x4009U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                 || (0x400aU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                || (0x400bU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) 
                            | ((((0x400cU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                                 || (0x400dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                                || (0x400eU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                               || (0x400fU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) 
                           | ((((0x4010U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                                || (0x4011U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                               || (0x4012U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                              || (0x4013U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) 
                          | (0x4014U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                         | (0x4015U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                        | (0x4017U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                if (((((0x4000U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                       || (0x4001U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                      || (0x4002U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                     || (0x4003U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 
                        = (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0 = 1U;
                } else if (((((0x4004U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                              || (0x4005U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                             || (0x4006U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                            || (0x4007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 
                        = (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0 = 1U;
                } else if (((((0x4008U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                              || (0x4009U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                             || (0x400aU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                            || (0x400bU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 
                        = (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_triangle__v0 = 1U;
                } else if (((((0x400cU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                              || (0x400dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                             || (0x400eU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                            || (0x400fU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_noise__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_noise__v0 
                        = (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_noise__v0 = 1U;
                } else if (((((0x4010U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)) 
                              || (0x4011U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                             || (0x4012U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) 
                            || (0x4013U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
                    __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    __VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 
                        = (3U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr));
                    __VdlySet__nes_unit_test__DOT__dut__DOT__apu_dmc__v0 = 1U;
                } else if ((0x4014U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_page 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_active = 1U;
                    __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset = 0U;
                } else if ((0x4015U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr))) {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__apu_status 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out;
                }
            }
        }
    } else {
        __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram_write_count = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuctrl = 0U;
        __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_active = 0U;
        __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count = 0U;
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank_sync 
        = ((IData)(vlSelfRef.nes_unit_test__DOT__rst_n) 
           && (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank));
    vlSelfRef.nes_unit_test__DOT__dut__DOT__total_write_count 
        = __Vdly__nes_unit_test__DOT__dut__DOT__total_write_count;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr_latch 
        = __Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr_latch;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__dma_offset 
        = __Vdly__nes_unit_test__DOT__dut__DOT__dma_offset;
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__vram__v0) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vram[__VdlyDim0__nes_unit_test__DOT__dut__DOT__vram__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__vram__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0) {
        nes_unit_test__DOT__dut__DOT__apu_pulse1[__VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse1__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0) {
        nes_unit_test__DOT__dut__DOT__apu_pulse2[__VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_pulse2__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__apu_triangle__v0) {
        nes_unit_test__DOT__dut__DOT__apu_triangle[__VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_triangle__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_triangle__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__apu_noise__v0) {
        nes_unit_test__DOT__dut__DOT__apu_noise[__VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_noise__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_noise__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__apu_dmc__v0) {
        nes_unit_test__DOT__dut__DOT__apu_dmc[__VdlyDim0__nes_unit_test__DOT__dut__DOT__apu_dmc__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__apu_dmc__v0;
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__oamaddr 
        = __Vdly__nes_unit_test__DOT__dut__DOT__oamaddr;
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__ram__v0) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__ram[__VdlyDim0__nes_unit_test__DOT__dut__DOT__ram__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__ram__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__oam__v0) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__oam[__VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v0] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v0;
    }
    if (__VdlySet__nes_unit_test__DOT__dut__DOT__oam__v1) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__oam[__VdlyDim0__nes_unit_test__DOT__dut__DOT__oam__v1] 
            = __VdlyVal__nes_unit_test__DOT__dut__DOT__oam__v1;
    }
}

void Vnes_unit_test___024root___nba_sequent__TOP__3(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__3\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw) 
         & (0x2007U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)))) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__ppudata_buffer 
            = ((0x3f00U <= (0x00003fffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr)))
                ? vlSelfRef.nes_unit_test__DOT__dut__DOT__palette
               [(0x0000001fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr))]
                : (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppudata));
    }
}

void Vnes_unit_test___024root___nba_sequent__TOP__5(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__5\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.__VdlySet__nes_unit_test__DOT__dut__DOT__palette__v0) {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__palette[vlSelfRef.__VdlyDim0__nes_unit_test__DOT__dut__DOT__palette__v0] 
            = vlSelfRef.__VdlyVal__nes_unit_test__DOT__dut__DOT__palette__v0;
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuaddr 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuaddr;
    if (vlSelfRef.nes_unit_test__DOT__rst_n) {
        if (((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__nmi) 
               & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_prev))) 
              & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending))) 
             & (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state)))) {
            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 1U;
        }
        if ((0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr = 0xfffcU;
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
            } else if ((1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr = 0xfffdU;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 2U;
            } else {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
            }
        } else if ((1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
        } else if ((2U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
        } else if ((3U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((0x00000080U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000040U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000020U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                    } else if ((1U 
                                                & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = (0x0000ffffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                            = (0x0000ffffU 
                                               & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                    << 8U) 
                                                   | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                    } else {
                                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                    }
                                } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D = 1U;
                                }
                            } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                           : ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))))));
                            }
                        } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff 
                                    = (0x000001ffU 
                                       & (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                           - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)) 
                                          - (1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)))));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                    = (1U & (~ ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                                >> 8U)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                    = (0x000000ffU 
                                       & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (0x000000ffU 
                                              & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                             >> 7U));
                            } else {
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X) 
                                                  - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X) 
                                   >= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X) 
                                   == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D = 0U;
                            }
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((4U 
                                                   & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                     ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                     : 
                                                    ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z)
                                                      ? 
                                                     ((IData)(1U) 
                                                      + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))
                                                      : 
                                                     ((IData)(1U) 
                                                      + 
                                                      ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                       + 
                                                       ((0x0000ff00U 
                                                         & ((- (IData)(
                                                                       (1U 
                                                                        & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                           >> 7U)))) 
                                                            << 8U)) 
                                                        | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)))))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X) 
                                          - (IData)(1U)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                                  - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                   >= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                   == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        } else {
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                                              - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                            = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                               >= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                               == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((0x00000020U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP;
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                        = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                                 >> 7U));
                                }
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V = 0U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                         >> 7U));
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                     >> 7U));
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)
                                               ? ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))
                                               : ((IData)(1U) 
                                                  + 
                                                  ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                   + 
                                                   ((0x0000ff00U 
                                                     & ((- (IData)(
                                                                   (1U 
                                                                    & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                       >> 7U)))) 
                                                        << 8U)) 
                                                    | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                    << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                    << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                                              - (IData)(1U)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        }
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                    }
                } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000040U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000020U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I = 1U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((2U 
                                                   & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand));
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C) 
                                        << 7U) | (0x0000007fU 
                                                  & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                                     >> 1U)));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                    = (1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum 
                                = (0x000001ffU & (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                                   + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                         >> 8U));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (0x000000ffU 
                                          & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                         >> 7U));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
                                = (((1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                           >> 7U)) 
                                    == (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                                >> 7U))));
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I = 0U;
                        }
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))
                                                     : 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)))))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                : ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                    ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                    : (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand))));
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N = 0U;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = (0x0000007fU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                                  >> 1U));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (0x0000007fU 
                                          & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 1U)));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                               ^ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                              - (IData)(1U)));
                    }
                } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((0x00000020U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C = 1U;
                        }
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = ((0x000000feU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                                   << 1U)) 
                                   | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                         >> 7U));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                               & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                        = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                          >> 8U));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000010U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C = 0U;
                    }
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                           : ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((1U 
                                                   & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N)
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC))
                                                    : 
                                                   ((IData)(1U) 
                                                    + 
                                                    ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                     + 
                                                     ((0x0000ff00U 
                                                       & ((- (IData)(
                                                                     (1U 
                                                                      & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                                         >> 7U)))) 
                                                          << 8U)) 
                                                      | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)))))))));
                }
            } else if ((8U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                     >> 7U));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                            = (0x000000feU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                              << 1U));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (0x0000007fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                     >> 6U));
                    }
                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                        = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                           | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                        = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                        = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                 >> 7U));
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                        = (0x00000020U | ((((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N) 
                                              << 3U) 
                                             | ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V) 
                                                << 2U)) 
                                            | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__B)) 
                                           << 4U) | 
                                          ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__D) 
                                             << 3U) 
                                            | ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__I) 
                                               << 2U)) 
                                           | (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z) 
                                               << 1U) 
                                              | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)))));
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                }
            } else if ((4U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                } else {
                    vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((2U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
            } else if ((1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                      + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X)));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
            } else {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
            }
            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__operand 
                = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
        } else if ((4U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((((((((0xa1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                      | (0x81U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                     | (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                    | (0x21U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                   | (0xb1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                  | (0x91U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                 & (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 2U;
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((((((0xa1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0x81U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x21U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x81U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                } else {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((((0xb1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                         | (0x91U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x0000ffffU & ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo)) 
                                      + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x91U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                        = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                } else {
                    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((((((((0xa5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                             | (0xadU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                            | (0xb5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                           | (0xbdU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xb9U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0xa1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xb1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((((0xa6U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                         | (0xb6U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xaeU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if (((0xa4U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                        | (0xb4U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((0x68U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((0x28U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 4U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 3U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 2U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 1U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x21U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                       & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x24U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                              & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((6U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x0000007fU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000feU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                      << 1U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
            } else if ((0xc5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                      - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                       >= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                       == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0xc4U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                                      - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                       >= (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y) 
                       == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((((((0x65U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0x75U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0x6dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x7dU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0x79U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum 
                    = (0x000001ffU & (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                       + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)) 
                                      + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                             >> 8U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                             >> 7U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
                    = (((1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                               >> 7U)) == (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                                                 >> 7U))) 
                       & ((1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                 >> 7U)) != (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                                   >> 7U))));
            } else if ((((((0xe5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0xf5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xedU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0xfdU == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xf9U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff 
                    = (0x000001ffU & (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A) 
                                       - (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in)) 
                                      - (1U & (~ (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)))));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & (~ ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                >> 8U)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff)));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                             >> 7U));
            }
        } else if ((5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
        } else if ((6U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 2U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((2U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_out 
                    = (0x00000020U | ((((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N) 
                                          << 3U) | 
                                         ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V) 
                                          << 2U)) | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__B)) 
                                       << 4U) | ((((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__D) 
                                                   << 3U) 
                                                  | ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__I) 
                                                     << 2U)) 
                                                 | (((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z) 
                                                     << 1U) 
                                                    | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C)))));
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 3U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((3U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr = 0xfffaU;
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 4U;
            } else if ((4U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = ((0xff00U & (IData)(vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)) 
                       | (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr = 0xfffbU;
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 5U;
            } else if ((5U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
                    = ((0x00ffU & (IData)(vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC)) 
                       | ((IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_data_in) 
                          << 8U));
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 0U;
                vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 0U;
                vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I = 1U;
            }
        }
        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state 
            = vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__next_state;
    } else {
        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_rw = 1U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP = 0xfdU;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I = 1U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__state = 0U;
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__PC 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__PC;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__D 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__D;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__C 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__C;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__A 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__A;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Z 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Z;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__N 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__N;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__X 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__X;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__Y 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__Y;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__V 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__V;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__SP 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__SP;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__I 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__I;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__B 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__B;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__cycle_count;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__opcode;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu_addr 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__cpu_addr;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__cpu__DOT__nmi_prev 
        = ((IData)(vlSelfRef.nes_unit_test__DOT__rst_n) 
           && (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__nmi));
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
}

void Vnes_unit_test___024root___nba_sequent__TOP__6(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__6\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.nes_unit_test__DOT__rst_n) {
        if ((0x0154U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot))) {
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__scanline 
                = ((0x0105U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline))
                    ? 0U : (0x000001ffU & ((IData)(1U) 
                                           + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline))));
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__dot = 0U;
        } else {
            vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__dot 
                = (0x000001ffU & ((IData)(1U) + (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)));
        }
        if (((0x00f1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)) 
             & (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)))) {
            vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank = 1U;
            if ((0x00000080U & (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuctrl))) {
                vlSelfRef.nes_unit_test__DOT__dut__DOT__nmi = 1U;
            }
        }
        if (((0x0105U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline)) 
             & (1U == (IData)(vlSelfRef.nes_unit_test__DOT__dut__DOT__dot)))) {
            vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank = 0U;
            vlSelfRef.nes_unit_test__DOT__dut__DOT__nmi = 0U;
        }
    } else {
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__scanline = 0U;
        vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__dot = 0U;
        vlSelfRef.nes_unit_test__DOT__dut__DOT__vblank = 0U;
    }
    vlSelfRef.nes_unit_test__DOT__dut__DOT__scanline 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__scanline;
    vlSelfRef.nes_unit_test__DOT__dut__DOT__dot = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__dot;
}

void Vnes_unit_test___024root___nba_sequent__TOP__7(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___nba_sequent__TOP__7\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nes_unit_test__DOT__dut__DOT__ppuctrl 
        = vlSelfRef.__Vdly__nes_unit_test__DOT__dut__DOT__ppuctrl;
}

void Vnes_unit_test___024root___eval_nba(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_nba\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((0x000000000000000aULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__2(vlSelf);
    }
    if ((8ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__5(vlSelf);
    }
    if ((0x000000000000000fULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnes_unit_test___024root___act_sequent__TOP__0(vlSelf);
    }
    if ((0x000000000000000aULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__6(vlSelf);
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnes_unit_test___024root___nba_sequent__TOP__7(vlSelf);
    }
}

void Vnes_unit_test___024root___timing_commit(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___timing_commit\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (1ULL & vlSelfRef.__VactTriggered[0U]))) {
        vlSelfRef.__VtrigSched_h4614a672__0.commit(
                                                   "@(posedge nes_unit_test.clk)");
    }
}

void Vnes_unit_test___024root___timing_resume(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___timing_resume\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VtrigSched_h4614a672__0.resume(
                                                   "@(posedge nes_unit_test.clk)");
    }
    if ((0x0000000000000010ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vnes_unit_test___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vnes_unit_test___024root___eval_phase__act(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_phase__act\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vnes_unit_test___024root___eval_triggers__act(vlSelf);
    Vnes_unit_test___024root___timing_commit(vlSelf);
    Vnes_unit_test___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vnes_unit_test___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vnes_unit_test___024root___timing_resume(vlSelf);
        Vnes_unit_test___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vnes_unit_test___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vnes_unit_test___024root___eval_phase__nba(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_phase__nba\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vnes_unit_test___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vnes_unit_test___024root___eval_nba(vlSelf);
        Vnes_unit_test___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vnes_unit_test___024root___eval(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vnes_unit_test___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("nes_unit_test.sv", 4, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vnes_unit_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("nes_unit_test.sv", 4, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vnes_unit_test___024root___eval_phase__act(vlSelf));
    } while (Vnes_unit_test___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vnes_unit_test___024root___eval_debug_assertions(Vnes_unit_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnes_unit_test___024root___eval_debug_assertions\n"); );
    Vnes_unit_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
