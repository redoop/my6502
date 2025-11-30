// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtest_dma.h for the primary calling header

#ifndef VERILATED_VTEST_DMA___024ROOT_H_
#define VERILATED_VTEST_DMA___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtest_dma__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtest_dma___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ test_dma__DOT__clk;
    CData/*0:0*/ test_dma__DOT__rst_n;
    CData/*0:0*/ test_dma__DOT__dma_start;
    CData/*0:0*/ test_dma__DOT__dma_active;
    CData/*7:0*/ test_dma__DOT__dma_page;
    CData/*7:0*/ test_dma__DOT__ram_data;
    CData/*7:0*/ test_dma__DOT__ram_addr_low;
    CData/*7:0*/ test_dma__DOT__oam_addr;
    CData/*7:0*/ test_dma__DOT__oam_data;
    CData/*0:0*/ test_dma__DOT__oam_write;
    CData/*7:0*/ test_dma__DOT__dut__DOT__dma_offset;
    CData/*0:0*/ __Vdly__test_dma__DOT__dma_active;
    CData/*7:0*/ __Vdly__test_dma__DOT__dut__DOT__dma_offset;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_dma__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_dma__DOT__rst_n__0;
    CData/*0:0*/ __Vtrigprevexpr_hcd016d00__1;
    CData/*0:0*/ __VactDidInit;
    IData/*31:0*/ test_dma__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 256> test_dma__DOT__test_ram;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_h58b62cd4__0;

    // INTERNAL VARIABLES
    Vtest_dma__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtest_dma___024root(Vtest_dma__Syms* symsp, const char* v__name);
    ~Vtest_dma___024root();
    VL_UNCOPYABLE(Vtest_dma___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
