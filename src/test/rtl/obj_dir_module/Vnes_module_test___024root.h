// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vnes_module_test.h for the primary calling header

#ifndef VERILATED_VNES_MODULE_TEST___024ROOT_H_
#define VERILATED_VNES_MODULE_TEST___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vnes_module_test__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vnes_module_test___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ nes_module_test__DOT__clk;
        CData/*0:0*/ nes_module_test__DOT__rst_n;
        CData/*7:0*/ nes_module_test__DOT__controller1;
        CData/*3:0*/ nes_module_test__DOT__dut__DOT__clk_div;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu_clk;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__ppu_clk;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu_data_out;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu_data_in;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu_rw;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__nmi;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__ppuctrl;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__ppustatus;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__oamaddr;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__ppudata;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__ppuaddr_latch;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__ppudata_buffer;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__apu_status;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__vblank;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__dma_active;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__dma_page;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__dma_offset;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__vblank_sync;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__A;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__X;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__Y;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__SP;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__C;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__Z;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__I;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__D;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__B;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__V;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__N;
        CData/*2:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__state;
        CData/*2:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__next_state;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__opcode;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__operand;
        CData/*2:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__cycle_count;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*2:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__nmi_pending;
        CData/*0:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__nmi_prev;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
        CData/*7:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__temp_result;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__ppuctrl;
        CData/*2:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__cycle_count;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__opcode;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__D;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__C;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__A;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__Z;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__N;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__X;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__Y;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__V;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__SP;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__I;
        CData/*0:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__B;
        CData/*7:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
        CData/*2:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
        CData/*7:0*/ __VdlyVal__nes_module_test__DOT__dut__DOT__palette__v0;
        CData/*4:0*/ __VdlyDim0__nes_module_test__DOT__dut__DOT__palette__v0;
        CData/*0:0*/ __VdlySet__nes_module_test__DOT__dut__DOT__palette__v0;
    };
    struct {
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nes_module_test__DOT__clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nes_module_test__DOT__rst_n__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nes_module_test__DOT__dut__DOT__cpu_clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nes_module_test__DOT__dut__DOT__ppu_clk__0;
        SData/*15:0*/ nes_module_test__DOT__dut__DOT__cpu_addr;
        SData/*15:0*/ nes_module_test__DOT__dut__DOT__ppuaddr;
        SData/*8:0*/ nes_module_test__DOT__dut__DOT__scanline;
        SData/*8:0*/ nes_module_test__DOT__dut__DOT__dot;
        SData/*15:0*/ nes_module_test__DOT__dut__DOT__vram_write_count;
        SData/*15:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__PC;
        SData/*8:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__temp_sum;
        SData/*8:0*/ nes_module_test__DOT__dut__DOT__cpu__DOT__temp_diff;
        SData/*15:0*/ __Vdly__nes_module_test__DOT__dut__DOT__ppuaddr;
        SData/*15:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu_addr;
        SData/*15:0*/ __Vdly__nes_module_test__DOT__dut__DOT__cpu__DOT__PC;
        SData/*8:0*/ __Vdly__nes_module_test__DOT__dut__DOT__scanline;
        SData/*8:0*/ __Vdly__nes_module_test__DOT__dut__DOT__dot;
        IData/*31:0*/ nes_module_test__DOT__pass;
        IData/*31:0*/ nes_module_test__DOT__fail;
        IData/*31:0*/ nes_module_test__DOT__dut__DOT__total_write_count;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*7:0*/, 16384> nes_module_test__DOT__prg_rom;
        VlUnpacked<CData/*7:0*/, 8192> nes_module_test__DOT__chr_rom;
        VlUnpacked<CData/*7:0*/, 2048> nes_module_test__DOT__dut__DOT__ram;
        VlUnpacked<CData/*7:0*/, 256> nes_module_test__DOT__dut__DOT__oam;
        VlUnpacked<CData/*7:0*/, 2048> nes_module_test__DOT__dut__DOT__vram;
        VlUnpacked<CData/*7:0*/, 32> nes_module_test__DOT__dut__DOT__palette;
        VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    };
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hef9d1729__0;

    // INTERNAL VARIABLES
    Vnes_module_test__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vnes_module_test___024root(Vnes_module_test__Syms* symsp, const char* v__name);
    ~Vnes_module_test___024root();
    VL_UNCOPYABLE(Vnes_module_test___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
