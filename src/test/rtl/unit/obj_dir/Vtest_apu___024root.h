// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtest_apu.h for the primary calling header

#ifndef VERILATED_VTEST_APU___024ROOT_H_
#define VERILATED_VTEST_APU___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtest_apu__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtest_apu___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ test_apu__DOT__clk;
    CData/*0:0*/ test_apu__DOT__rst_n;
    CData/*7:0*/ test_apu__DOT__apu_status;
    CData/*3:0*/ test_apu__DOT__dut__DOT__pulse1_duty;
    CData/*3:0*/ test_apu__DOT__dut__DOT__pulse1_volume;
    CData/*0:0*/ test_apu__DOT__dut__DOT__pulse1_enabled;
    CData/*0:0*/ test_apu__DOT__dut__DOT__pulse1_out_bit;
    CData/*3:0*/ test_apu__DOT__dut__DOT__pulse2_duty;
    CData/*3:0*/ test_apu__DOT__dut__DOT__pulse2_volume;
    CData/*0:0*/ test_apu__DOT__dut__DOT__pulse2_enabled;
    CData/*0:0*/ test_apu__DOT__dut__DOT__pulse2_out_bit;
    CData/*3:0*/ __Vdly__test_apu__DOT__dut__DOT__pulse1_duty;
    CData/*3:0*/ __Vdly__test_apu__DOT__dut__DOT__pulse2_duty;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_apu__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_apu__DOT__rst_n__0;
    SData/*15:0*/ test_apu__DOT__dut__DOT__audio_counter;
    SData/*15:0*/ test_apu__DOT__dut__DOT__test_tone;
    SData/*15:0*/ test_apu__DOT__dut__DOT__pulse1_timer;
    SData/*15:0*/ test_apu__DOT__dut__DOT__pulse1_out;
    SData/*15:0*/ test_apu__DOT__dut__DOT__pulse2_timer;
    SData/*15:0*/ test_apu__DOT__dut__DOT__pulse2_out;
    SData/*15:0*/ __Vdly__test_apu__DOT__dut__DOT__test_tone;
    SData/*15:0*/ __Vdly__test_apu__DOT__dut__DOT__pulse1_timer;
    SData/*15:0*/ __Vdly__test_apu__DOT__dut__DOT__pulse2_timer;
    IData/*31:0*/ test_apu__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__apu_pulse1;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__apu_pulse2;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__apu_triangle;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__apu_noise;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__apu_dmc;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__dut__DOT__apu_pulse1;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__dut__DOT__apu_pulse2;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__dut__DOT__apu_triangle;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__dut__DOT__apu_noise;
    VlUnpacked<CData/*7:0*/, 4> test_apu__DOT__dut__DOT__apu_dmc;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlUnpacked<CData/*0:0*/, 6> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;

    // INTERNAL VARIABLES
    Vtest_apu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtest_apu___024root(Vtest_apu__Syms* symsp, const char* v__name);
    ~Vtest_apu___024root();
    VL_UNCOPYABLE(Vtest_apu___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
