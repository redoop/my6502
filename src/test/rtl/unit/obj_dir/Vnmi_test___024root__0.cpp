// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnmi_test.h for the primary calling header

#include "Vnmi_test__pch.h"

VL_ATTR_COLD void Vnmi_test___024root___eval_initial__TOP(Vnmi_test___024root* vlSelf);
VlCoroutine Vnmi_test___024root___eval_initial__TOP__Vtiming__0(Vnmi_test___024root* vlSelf);
VlCoroutine Vnmi_test___024root___eval_initial__TOP__Vtiming__1(Vnmi_test___024root* vlSelf);

void Vnmi_test___024root___eval_initial(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_initial\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vnmi_test___024root___eval_initial__TOP(vlSelf);
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    Vnmi_test___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vnmi_test___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine Vnmi_test___024root___eval_initial__TOP__Vtiming__0(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSymsp->_vm_contextp__->dumpfile("waveforms/nmi_test.vcd"s);
    vlSymsp->_traceDumpOpen();
    vlSelfRef.nmi_test__DOT__rst_n = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000064ULL, 
                                         nullptr, "../nmi_test.sv", 
                                         93);
    vlSelfRef.nmi_test__DOT__rst_n = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x0000000000989680ULL, 
                                         nullptr, "../nmi_test.sv", 
                                         97);
    if ((0U < (IData)(vlSelfRef.nmi_test__DOT__nmi_trigger_count))) {
        VL_WRITEF_NX("[TEST] PASS: NMI triggered %0# times\n",0,
                     16,vlSelfRef.nmi_test__DOT__nmi_trigger_count);
    } else {
        VL_WRITEF_NX("[TEST] FAIL: NMI never triggered\n",0);
    }
    VL_FINISH_MT("../nmi_test.sv", 105, "");
}

VlCoroutine Vnmi_test___024root___eval_initial__TOP__Vtiming__1(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "../nmi_test.sv", 
                                             85);
        vlSelfRef.nmi_test__DOT__clk = (1U & (~ (IData)(vlSelfRef.nmi_test__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vnmi_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vnmi_test___024root___eval_triggers__act(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_triggers__act\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                      << 4U) 
                                                     | (((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu_clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__ppu_clk__0))) 
                                                          << 3U) 
                                                         | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_clk) 
                                                             & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__cpu_clk__0))) 
                                                            << 2U)) 
                                                        | ((((~ (IData)(vlSelfRef.nmi_test__DOT__rst_n)) 
                                                             & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__rst_n__0)) 
                                                            << 1U) 
                                                           | ((IData)(vlSelfRef.nmi_test__DOT__clk) 
                                                              & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__clk__0))))))));
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__clk__0 
        = vlSelfRef.nmi_test__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__rst_n__0 
        = vlSelfRef.nmi_test__DOT__rst_n;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__cpu_clk__0 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_clk;
    vlSelfRef.__Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__ppu_clk__0 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppu_clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vnmi_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vnmi_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___trigger_anySet__act\n"); );
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

void Vnmi_test___024root___nba_sequent__TOP__0(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter = 0;
    CData/*3:0*/ __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty = 0;
    SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer = 0;
    CData/*3:0*/ __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty = 0;
    SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer = 0;
    // Body
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty;
    __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer 
        = vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__operand 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__opcode 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__total_write_count 
        = vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppumask 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppumask;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse1__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse2__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_triangle__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_noise__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_dmc__v0 = 0U;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__oamaddr 
        = vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__palette__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__ram__v0 = 0U;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuctrl 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__vram__v0 = 0U;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v1 = 0U;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma_active 
        = vlSelfRef.nmi_test__DOT__dut__DOT__dma_active;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset 
        = vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
    vlSelfRef.__Vdly__nmi_test__DOT__nmi_trigger_count 
        = vlSelfRef.nmi_test__DOT__nmi_trigger_count;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch;
    vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v0 = 0U;
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter 
            = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter)));
        if ((0x07f2U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone 
                = ((0x00008000U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone))
                    ? 0U : 0x1000U);
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter = 0U;
        }
        if (vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2) {
            vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus 
                = (0x00000080U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus));
        }
        if (vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus_read_last) {
            vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus 
                = (0x7fU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus));
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch = 0U;
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out 
            = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled) 
                & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit))
                ? ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume) 
                   << 0x0000000cU) : 0U);
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out 
            = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled) 
                & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit))
                ? ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume) 
                   << 0x0000000cU) : 0U);
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume 
            = (0x0000000fU & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
               [0U]);
        if ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer))) {
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty 
                = (0x0000000fU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty)));
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer 
                = ((0x00000700U & (vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
                                   [3U] << 8U)) | vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
                   [2U]);
        } else {
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer 
                = (0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer) 
                                  - (IData)(1U)));
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit 
            = ((0x00000080U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
                [0U]) ? ((0x00000040U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
                          [0U]) ? (2U <= (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty)))
                          : (4U > (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty))))
                : ((0x00000040U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1
                    [0U]) ? (2U > (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty)))
                    : (0U == (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty)))));
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume 
            = (0x0000000fU & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
               [0U]);
        if ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer))) {
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty 
                = (0x0000000fU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty)));
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer 
                = ((0x00000700U & (vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
                                   [3U] << 8U)) | vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
                   [2U]);
        } else {
            __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer 
                = (0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer) 
                                  - (IData)(1U)));
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit 
            = ((0x00000080U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
                [0U]) ? ((0x00000040U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
                          [0U]) ? (2U <= (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty)))
                          : (4U > (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty))))
                : ((0x00000040U & vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2
                    [0U]) ? (2U > (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty)))
                    : (0U == (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty)))));
    } else {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone = 0U;
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus = 0U;
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer = 0U;
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty = 0U;
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer = 0U;
        __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter 
        = __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__audio_counter;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus_read_last 
        = ((IData)(vlSelfRef.nmi_test__DOT__rst_n) 
           && ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw) 
               & (0x2002U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))));
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled 
        = ((IData)(vlSelfRef.nmi_test__DOT__rst_n) 
           && (1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu_status)));
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled 
        = ((IData)(vlSelfRef.nmi_test__DOT__rst_n) 
           && (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu_status) 
                     >> 1U)));
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty 
        = __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty;
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer 
        = __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer;
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty 
        = __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty;
    vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer 
        = __Vdly__nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer;
}

void Vnmi_test___024root___nba_sequent__TOP__1(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__1\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nmi_test__DOT__dut__DOT__clk_div = ((IData)(vlSelfRef.nmi_test__DOT__rst_n)
                                                   ? 
                                                  (0x0000000fU 
                                                   & ((IData)(1U) 
                                                      + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div)))
                                                   : 0U);
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_clk = (1U 
                                                  & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                                     >> 3U));
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu_clk = (1U 
                                                  & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                                     >> 1U));
}

void Vnmi_test___024root___nba_sequent__TOP__2(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__2\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline;
    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot;
}

void Vnmi_test___024root___nba_sequent__TOP__3(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__3\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x00f0U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline))) {
        if ((6U == (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg = 0U;
        }
        if ((6U != (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))) {
            if ((0U == (7U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg = 0U;
            }
        }
    }
    if (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw) 
         & (0x2007U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
        vlSelfRef.nmi_test__DOT__dut__DOT__ppudata_buffer 
            = ((0x3f00U <= (0x00003fffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr)))
                ? vlSelfRef.nmi_test__DOT__dut__DOT__palette
               [(0x0000001fU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr))]
                : vlSelfRef.nmi_test__DOT__dut__DOT__vram
               [(0x000007ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr))]);
    }
}

void Vnmi_test___024root___nba_sequent__TOP__4(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__4\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write) {
        vlSelfRef.__VdlyVal__nmi_test__DOT__dut__DOT__oam__v0 
            = vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_data;
        vlSelfRef.__VdlyDim0__nmi_test__DOT__dut__DOT__oam__v0 
            = vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_addr;
        vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v0 = 1U;
    }
}

void Vnmi_test___024root___nba_sequent__TOP__5(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__5\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__ram__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__ram__v0 = 0;
    SData/*10:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__ram__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__ram__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__oam__v1;
    __VdlyVal__nmi_test__DOT__dut__DOT__oam__v1 = 0;
    CData/*7:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__oam__v1;
    __VdlyDim0__nmi_test__DOT__dut__DOT__oam__v1 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__vram__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__vram__v0 = 0;
    SData/*10:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__vram__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__vram__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__palette__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__palette__v0 = 0;
    CData/*4:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__palette__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__palette__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse1__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse1__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse1__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse2__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse2__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse2__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__apu_triangle__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__apu_triangle__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__apu_triangle__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__apu_noise__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__apu_noise__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__apu_noise__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__apu_noise__v0 = 0;
    CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__apu_dmc__v0;
    __VdlyVal__nmi_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    CData/*1:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__apu_dmc__v0;
    __VdlyDim0__nmi_test__DOT__dut__DOT__apu_dmc__v0 = 0;
    // Body
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        if (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_start) 
             & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_active)))) {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma_active = 1U;
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset = 0U;
        } else if (vlSelfRef.nmi_test__DOT__dut__DOT__dma_active) {
            vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low 
                = vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
            vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_data 
                = vlSelfRef.nmi_test__DOT__dut__DOT____Vcellinp__dma__ram_data;
            vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_addr 
                = vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
            vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write = 1U;
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset 
                = (0x000000ffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset)));
            if ((0xffU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma_active = 0U;
                vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write = 0U;
            }
        } else {
            vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write = 0U;
        }
    } else {
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma_active = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__dma_active = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma_active;
    vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        vlSelfRef.nmi_test__DOT__dut__DOT__dma_start = 0U;
        if ((1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw)))) {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__total_write_count 
                = ((IData)(1U) + vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count);
            if (VL_UNLIKELY((((0x6000U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                              & (0x7000U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))))) {
                VL_WRITEF_NX("[TEST] Write $%04x = $%02x\n",0,
                             16,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr,
                             8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out));
            }
            if (VL_UNLIKELY((((0x2000U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                              & (0x4020U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))))) {
                VL_WRITEF_NX("[IO_WRITE] #%10# addr=$%04x data=$%02x\n",0,
                             32,vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count,
                             16,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr),
                             8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out);
            }
            if ((0x1fffU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__ram__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__ram__v0 
                    = (0x000007ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__ram__v0 = 1U;
            } else if (VL_UNLIKELY(((0x2000U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))))) {
                VL_WRITEF_NX("[PPU] PPUCTRL=$%02x (NMI=%b BG=$%x SPR=$%x)\n",0,
                             8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out,
                             1,(1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out) 
                                      >> 7U)),1,(1U 
                                                 & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out) 
                                                    >> 4U)),
                             1,(1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out) 
                                      >> 3U)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuctrl 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
            } else if (VL_UNLIKELY(((0x2001U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))))) {
                VL_WRITEF_NX("[PPU] PPUMASK=$%02x\n",0,
                             8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out);
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppumask 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
            } else if ((0x2003U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__oamaddr 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
            } else if ((0x2004U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__oam__v1 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__oam__v1 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr;
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v1 = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__oamaddr 
                    = (0x000000ffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr)));
            } else if ((0x2005U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                if (vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch) {
                    vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_y 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                } else {
                    vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_x 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                }
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch 
                    = (1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch)));
            } else if ((0x2006U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch)
                        ? ((0xff00U & (IData)(vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr)) 
                           | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out))
                        : ((0x00ffU & (IData)(vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr)) 
                           | ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out) 
                              << 8U)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch 
                    = (1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch)));
            } else if ((0x2007U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                if ((0x2000U <= (0x00003fffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr)))) {
                    if ((0x3f00U > (0x00003fffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr)))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__vram_write_count 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__vram_write_count)));
                        __VdlyVal__nmi_test__DOT__dut__DOT__vram__v0 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                        __VdlyDim0__nmi_test__DOT__dut__DOT__vram__v0 
                            = (0x000007ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr));
                        vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__vram__v0 = 1U;
                    } else {
                        __VdlyVal__nmi_test__DOT__dut__DOT__palette__v0 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                        __VdlyDim0__nmi_test__DOT__dut__DOT__palette__v0 
                            = (0x0000001fU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr));
                        vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__palette__v0 = 1U;
                    }
                }
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr 
                    = (0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr) 
                                      + ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl))
                                          ? 0x00000020U
                                          : 1U)));
            } else if (((0x4000U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                        & (0x4003U >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse1__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse1__v0 
                    = (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse1__v0 = 1U;
            } else if (((0x4004U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                        & (0x4007U >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse2__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse2__v0 
                    = (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse2__v0 = 1U;
            } else if (((0x4008U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                        & (0x400bU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__apu_triangle__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__apu_triangle__v0 
                    = (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_triangle__v0 = 1U;
            } else if (((0x400cU <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                        & (0x400fU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__apu_noise__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__apu_noise__v0 
                    = (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_noise__v0 = 1U;
            } else if (((0x4010U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)) 
                        & (0x4013U >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)))) {
                __VdlyVal__nmi_test__DOT__dut__DOT__apu_dmc__v0 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                __VdlyDim0__nmi_test__DOT__dut__DOT__apu_dmc__v0 
                    = (3U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr));
                vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_dmc__v0 = 1U;
            } else if ((0x4014U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__dma_page 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
                vlSelfRef.nmi_test__DOT__dut__DOT__dma_start = 1U;
            } else if ((0x4015U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__apu_status 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
            } else if ((0x4017U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__apu_frame_counter 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out;
            }
        }
    } else {
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__vram_write_count = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuctrl = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppumask = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__oamaddr = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__dma_start = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_x = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_y = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__total_write_count = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__nmi_trigger_count = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_status = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_frame_counter = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__total_write_count;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch;
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse1__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[__VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse1__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse1__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_pulse2__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[__VdlyDim0__nmi_test__DOT__dut__DOT__apu_pulse2__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__apu_pulse2__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_triangle__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[__VdlyDim0__nmi_test__DOT__dut__DOT__apu_triangle__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__apu_triangle__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_noise__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[__VdlyDim0__nmi_test__DOT__dut__DOT__apu_noise__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__apu_noise__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__apu_dmc__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[__VdlyDim0__nmi_test__DOT__dut__DOT__apu_dmc__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__apu_dmc__v0;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__oamaddr;
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__palette__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__palette[__VdlyDim0__nmi_test__DOT__dut__DOT__palette__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__palette__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__ram__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__ram[__VdlyDim0__nmi_test__DOT__dut__DOT__ram__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__ram__v0;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuaddr;
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__vram__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__vram[__VdlyDim0__nmi_test__DOT__dut__DOT__vram__v0] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__vram__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v0) {
        vlSelfRef.nmi_test__DOT__dut__DOT__oam[vlSelfRef.__VdlyDim0__nmi_test__DOT__dut__DOT__oam__v0] 
            = vlSelfRef.__VdlyVal__nmi_test__DOT__dut__DOT__oam__v0;
    }
    if (vlSelfRef.__VdlySet__nmi_test__DOT__dut__DOT__oam__v1) {
        vlSelfRef.nmi_test__DOT__dut__DOT__oam[__VdlyDim0__nmi_test__DOT__dut__DOT__oam__v1] 
            = __VdlyVal__nmi_test__DOT__dut__DOT__oam__v1;
    }
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
    vlSelfRef.nmi_test__DOT__dut__DOT____Vcellinp__dma__ram_data 
        = vlSelfRef.nmi_test__DOT__dut__DOT__ram[((0x00000700U 
                                                   & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page) 
                                                      << 8U)) 
                                                  | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low))];
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        if (((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__nmi) 
               & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev))) 
              & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending))) 
             & (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state)))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 1U;
        }
        if ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr = 0xfffcU;
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
            } else if (VL_LIKELY(((1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count))))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr = 0xfffdU;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 2U;
            } else {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__ 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                        << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                VL_WRITEF_NX("[CPU] Reset vector: $%04x\n",0,
                             16,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                  << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__)));
            }
        } else if ((1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
            if (VL_UNLIKELY((((0xc7a8U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                              & (0xc7adU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)))))) {
                VL_WRITEF_NX("[CPU] FETCH: PC=$%04x\n",0,
                             16,vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC);
            }
        } else if ((2U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__opcode 
                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
        } else if ((3U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            if (VL_UNLIKELY((((0xc7a8U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                              & (0xc7adU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)))))) {
                VL_WRITEF_NX("[CPU] Execute PC=$%04x opcode=$%02x data_in=$%02x A=$%02x\n",0,
                             16,vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC,
                             8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode),
                             8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in,
                             8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A));
            }
            if ((0x00000080U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000040U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000020U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                    } else if ((1U 
                                                & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                            = (0x0000ffffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = (0x0000ffffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    } else {
                                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                    }
                                } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D = 1U;
                                }
                            } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                           : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))))));
                            }
                        } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff 
                                    = (0x000001ffU 
                                       & (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                           - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)) 
                                          - (1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)))));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                    = (1U & (~ ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                                >> 8U)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                    = (0x000000ffU 
                                       & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (0x000000ffU 
                                              & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                             >> 7U));
                            } else {
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X) 
                                                  - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X) 
                                   >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X) 
                                   == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D = 0U;
                            }
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((4U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                     ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                     : 
                                                    ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z)
                                                      ? 
                                                     ((IData)(1U) 
                                                      + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))
                                                      : 
                                                     ((IData)(1U) 
                                                      + 
                                                      ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                       + 
                                                       ((0x0000ff00U 
                                                         & ((- (IData)(
                                                                       (1U 
                                                                        & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                           >> 7U)))) 
                                                            << 8U)) 
                                                        | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)))))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X) 
                                          - (IData)(1U)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                                  - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                   >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                   == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        } else {
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                                              - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                            = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                               >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                               == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((0x00000020U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                        = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                        = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                                 >> 7U));
                                }
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V = 0U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                }
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                         >> 7U));
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                     >> 7U));
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)
                                               ? ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))
                                               : ((IData)(1U) 
                                                  + 
                                                  ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                   + 
                                                   ((0x0000ff00U 
                                                     & ((- (IData)(
                                                                   (1U 
                                                                    & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                       >> 7U)))) 
                                                        << 8U)) 
                                                    | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        }
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                                              - (IData)(1U)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                        }
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                    }
                } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000040U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000020U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                } else {
                                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I = 1U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            }
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((2U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            } else {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                    = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand));
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                    = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C) 
                                        << 7U) | (0x0000007fU 
                                                  & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                                     >> 1U)));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                    = (1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum 
                                = (0x000001ffU & (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                                   + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                         >> 8U));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (0x000000ffU 
                                          & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                         >> 7U));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V 
                                = (((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                           >> 7U)) 
                                    == (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                                >> 7U))));
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        }
                    } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        }
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I = 0U;
                        }
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))
                                                     : 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)))))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                : ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                    : (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand))));
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N = 0U;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = (0x0000007fU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                                  >> 1U));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (0x0000007fU 
                                          & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                             >> 1U)));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                               ^ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                              - (IData)(1U)));
                    }
                } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((0x00000020U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C = 1U;
                        }
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                                = ((0x000000feU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                                   << 1U)) 
                                   | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                         >> 7U));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                               & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP)));
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                        = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                          >> 8U));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000010U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C = 0U;
                    }
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                           : ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                               : ((1U 
                                                   & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N)
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC))
                                                    : 
                                                   ((IData)(1U) 
                                                    + 
                                                    ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                                     + 
                                                     ((0x0000ff00U 
                                                       & ((- (IData)(
                                                                     (1U 
                                                                      & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                                         >> 7U)))) 
                                                          << 8U)) 
                                                      | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)))))))));
                }
            } else if ((8U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                     >> 7U));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                            = (0x000000feU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                              << 1U));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                            = (0U == (0x0000007fU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                     >> 6U));
                    }
                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                        = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                           | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                        = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                        = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                                 >> 7U));
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                        = (0x00000020U | ((((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N) 
                                              << 3U) 
                                             | ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V) 
                                                << 2U)) 
                                            | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B)) 
                                           << 4U) | 
                                          ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D) 
                                             << 3U) 
                                            | ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I) 
                                               << 2U)) 
                                           | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z) 
                                               << 1U) 
                                              | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)))));
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                }
            } else if ((4U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                    }
                } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                } else {
                    vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
                }
            } else if ((2U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
            } else if ((1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                      + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X)));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 1U;
            } else {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC;
            }
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__operand 
                = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
        } else if ((4U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            if (VL_UNLIKELY((((0xc7a8U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                              & (0xc7adU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)))))) {
                VL_WRITEF_NX("[CPU] MEMORY: PC=$%04x opcode=$%02x cycle_count=%1# addr=$%04x data_in=$%02x operand=$%02x\n",0,
                             16,vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC,
                             8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode),
                             3,vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count,
                             16,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr),
                             8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in,
                             8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand));
            }
            if ((((((((((((((((0xadU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                              | (0xbdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                             | (0xb9U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                            | (0x8dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                           | (0x9dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xaeU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x8eU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0x8cU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                       | (0x6dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                      | (0x7dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                     | (0x79U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                    | (0xedU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                   | (0xfdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                  | (0xf9U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                 & (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x0000ffffU & (((((0xbdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                         | (0x9dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                                        | (0x7dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                                       | (0xfdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))
                                       ? ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X))
                                       : ((((0xb9U 
                                             == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                                            | (0x79U 
                                               == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                                           | (0xf9U 
                                              == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))
                                           ? ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y))
                                           : (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                               << 8U) 
                                              | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand)))));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                if (VL_UNLIKELY((((0xc7a8U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                                  & (0xc7adU >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)))))) {
                    VL_WRITEF_NX("[CPU] MEMORY: forming addr=$%04x from {$%02x, $%02x}\n",0,
                                 16,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                      << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand)),
                                 8,(IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in),
                                 8,vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand);
                }
                if (((((0x8dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                       | (0x9dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                      | (0x8eU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                     | (0x8cU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                    if (((0x8dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                         | (0x9dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                    } else if ((0x8eU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X;
                    } else if ((0x8cU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y;
                    }
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                } else {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                }
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC)));
            } else if ((((((((0xa1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                             | (0x81U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                            | (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                           | (0x21U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xb1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x91U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        & (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 2U;
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((((((0xa1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0x81U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x21U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                        << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x81U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                } else {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((((0xb1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                         | (0x91U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x0000ffffU & ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                        << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo)) 
                                      + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x91U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                        = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A;
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                } else {
                    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                }
            } else if ((((((((0xa5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                             | (0xadU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                            | (0xb5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                           | (0xbdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xb9U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0xa1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xb1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((((0xa6U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                         | (0xb6U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xaeU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if (((0xa4U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                        | (0xb4U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((0x68U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((0x28U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 4U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 3U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 2U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 1U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x21U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                       & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x24U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                              & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
            } else if ((6U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 7U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__alu_result 
                    = (0x000000feU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                      << 1U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x0000007fU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                             >> 6U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000feU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                      << 1U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
            } else if ((0xc5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                      - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                       >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                       == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0xc4U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                                      - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                       >= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y) 
                       == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((((((0x65U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0x75U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0x6dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0x7dU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0x79U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum 
                    = (0x000001ffU & (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                       + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)) 
                                      + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                             >> 8U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                             >> 7U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V 
                    = (((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                               >> 7U)) == (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                                                 >> 7U))) 
                       & ((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                 >> 7U)) != (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum) 
                                                   >> 7U))));
            } else if ((((((0xe5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)) 
                           | (0xf5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                          | (0xedU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                         | (0xfdU == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode))) 
                        | (0xf9U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff 
                    = (0x000001ffU & (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A) 
                                       - (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in)) 
                                      - (1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)))));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C 
                    = (1U & (~ ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                                >> 8U)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff)));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff) 
                             >> 7U));
            }
        } else if ((5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
        } else if ((6U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                    = (0x000000ffU & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 2U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((2U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr 
                    = (0x00000100U | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out 
                    = (0x00000020U | ((((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N) 
                                          << 3U) | 
                                         ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V) 
                                          << 2U)) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B)) 
                                       << 4U) | ((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D) 
                                                   << 3U) 
                                                  | ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I) 
                                                     << 2U)) 
                                                 | (((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z) 
                                                     << 1U) 
                                                    | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C)))));
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 0U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 3U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((3U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr = 0xfffaU;
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 4U;
            } else if ((4U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = ((0xff00U & (IData)(vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                       | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr = 0xfffbU;
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 5U;
            } else if ((5U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC 
                    = ((0x00ffU & (IData)(vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC)) 
                       | ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in) 
                          << 8U));
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 0U;
                vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 0U;
                vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I = 1U;
            }
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev 
            = vlSelfRef.nmi_test__DOT__dut__DOT__nmi;
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state 
            = vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__next_state;
    } else {
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw = 1U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP = 0xfdU;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I = 1U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__operand;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__opcode;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__cpu_addr;
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
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        if (VL_UNLIKELY((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2) 
                          & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl) 
                             >> 7U))))) {
            vlSelfRef.__Vdly__nmi_test__DOT__nmi_trigger_count 
                = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__nmi_trigger_count)));
            VL_WRITEF_NX("[NMI] Triggered at cycle, ppuctrl=$%02x\n",0,
                         8,vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl);
            vlSelfRef.nmi_test__DOT__dut__DOT__nmi = 1U;
        } else if ((1U & (~ (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2)))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__nmi = 0U;
        }
    } else {
        vlSelfRef.nmi_test__DOT__dut__DOT__nmi = 0U;
    }
    vlSelfRef.nmi_test__DOT__nmi_trigger_count = vlSelfRef.__Vdly__nmi_test__DOT__nmi_trigger_count;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppuctrl;
    vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2 
        = ((IData)(vlSelfRef.nmi_test__DOT__rst_n) 
           && (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync1));
    vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync1 
        = ((IData)(vlSelfRef.nmi_test__DOT__rst_n) 
           && (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__vblank));
}

void Vnmi_test___024root___nba_comb__TOP__0(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_comb__TOP__0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
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
}

void Vnmi_test___024root___nba_sequent__TOP__6(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__6\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.nmi_test__DOT__rst_n) {
        if ((0x0154U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot))) {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline 
                = ((0x0105U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline))
                    ? 0U : (0x000001ffU & ((IData)(1U) 
                                           + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline))));
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot = 0U;
        } else {
            vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot 
                = (0x000001ffU & ((IData)(1U) + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)));
        }
        if (VL_UNLIKELY((((0x00f1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
                          & (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))))) {
            VL_WRITEF_NX("[PPU] VBlank START at frame cycle\n",0);
            vlSelfRef.nmi_test__DOT__dut__DOT__vblank = 1U;
        }
        if (((0x0105U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
             & (1U == (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))) {
            vlSelfRef.nmi_test__DOT__dut__DOT__vblank = 0U;
        }
        vlSelfRef.nmi_test__DOT__dut__DOT__rendering 
            = ((0x00f0U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
               & (IData)((0U != (0x18U & (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppumask)))));
    } else {
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline = 0U;
        vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__vblank = 0U;
        vlSelfRef.nmi_test__DOT__dut__DOT__sprite0_hit = 0U;
    }
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot;
    vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline 
        = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline;
    vlSelfRef.nmi_test__DOT__dut__DOT__video_de = (
                                                   (0x00f0U 
                                                    > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
                                                   & (0x0100U 
                                                      > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)));
}

void Vnmi_test___024root___nba_sequent__TOP__7(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_sequent__TOP__7\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.nmi_test__DOT__dut__DOT__ppumask = vlSelfRef.__Vdly__nmi_test__DOT__dut__DOT__ppumask;
}

void Vnmi_test___024root___nba_comb__TOP__1(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___nba_comb__TOP__1\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
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

void Vnmi_test___024root___eval_nba(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_nba\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__1(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
    if ((0x000000000000000aULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnmi_test___024root___nba_sequent__TOP__2(vlSelf);
    }
    if ((8ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__3(vlSelf);
        vlSelfRef.__Vm_traceActivity[4U] = 1U;
    }
    if ((4ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__4(vlSelf);
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__5(vlSelf);
        vlSelfRef.__Vm_traceActivity[5U] = 1U;
    }
    if ((0x000000000000000eULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnmi_test___024root___nba_comb__TOP__0(vlSelf);
    }
    if ((0x000000000000000aULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnmi_test___024root___nba_sequent__TOP__6(vlSelf);
        vlSelfRef.__Vm_traceActivity[6U] = 1U;
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vnmi_test___024root___nba_sequent__TOP__7(vlSelf);
    }
    if ((0x000000000000000eULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        Vnmi_test___024root___nba_comb__TOP__1(vlSelf);
        vlSelfRef.__Vm_traceActivity[7U] = 1U;
    }
}

void Vnmi_test___024root___timing_resume(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___timing_resume\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x0000000000000010ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vnmi_test___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vnmi_test___024root___eval_phase__act(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_phase__act\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vnmi_test___024root___eval_triggers__act(vlSelf);
    Vnmi_test___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vnmi_test___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vnmi_test___024root___timing_resume(vlSelf);
    }
    return (__VactExecute);
}

void Vnmi_test___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vnmi_test___024root___eval_phase__nba(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_phase__nba\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vnmi_test___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vnmi_test___024root___eval_nba(vlSelf);
        Vnmi_test___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vnmi_test___024root___eval(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vnmi_test___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("../nmi_test.sv", 3, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vnmi_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("../nmi_test.sv", 3, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vnmi_test___024root___eval_phase__act(vlSelf));
    } while (Vnmi_test___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vnmi_test___024root___eval_debug_assertions(Vnmi_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root___eval_debug_assertions\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
