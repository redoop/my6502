// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtest_ppu.h for the primary calling header

#ifndef VERILATED_VTEST_PPU___024ROOT_H_
#define VERILATED_VTEST_PPU___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtest_ppu__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtest_ppu___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ test_ppu__DOT__clk;
    CData/*0:0*/ test_ppu__DOT__rst_n;
    CData/*7:0*/ test_ppu__DOT__ppuctrl;
    CData/*7:0*/ test_ppu__DOT__ppumask;
    CData/*7:0*/ test_ppu__DOT__ppuscroll_x;
    CData/*7:0*/ test_ppu__DOT__ppuscroll_y;
    CData/*0:0*/ test_ppu__DOT__video_de;
    CData/*0:0*/ test_ppu__DOT__vblank;
    CData/*0:0*/ test_ppu__DOT__sprite0_hit;
    CData/*0:0*/ test_ppu__DOT__rendering;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__pattern_lo_reg;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__pattern_hi_reg;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__sprite_y;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__sprite_tile;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__sprite_attr;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__sprite_x;
    CData/*1:0*/ test_ppu__DOT__dut__DOT__sprite_pixel;
    CData/*4:0*/ test_ppu__DOT__dut__DOT__sprite_palette_idx;
    CData/*0:0*/ test_ppu__DOT__dut__DOT__sprite_active;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__tile_index;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__attr_byte;
    CData/*1:0*/ test_ppu__DOT__dut__DOT__attr_bits;
    CData/*1:0*/ test_ppu__DOT__dut__DOT__pixel_value;
    CData/*4:0*/ test_ppu__DOT__dut__DOT__bg_palette_idx;
    CData/*4:0*/ test_ppu__DOT__dut__DOT__tile_x;
    CData/*4:0*/ test_ppu__DOT__dut__DOT__tile_y;
    CData/*4:0*/ test_ppu__DOT__dut__DOT__final_palette_idx;
    CData/*7:0*/ test_ppu__DOT__dut__DOT__palette_color;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_ppu__DOT__vblank__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_ppu__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__test_ppu__DOT__rst_n__0;
    CData/*0:0*/ __Vtrigprevexpr_h8ca0d663__1;
    CData/*0:0*/ __VactDidInit;
    SData/*15:0*/ test_ppu__DOT__ppuaddr;
    SData/*13:0*/ test_ppu__DOT__chr_rom_addr;
    SData/*8:0*/ test_ppu__DOT__dut__DOT__scanline;
    SData/*8:0*/ test_ppu__DOT__dut__DOT__dot;
    SData/*8:0*/ test_ppu__DOT__dut__DOT__scroll_x;
    SData/*8:0*/ test_ppu__DOT__dut__DOT__scroll_y;
    SData/*9:0*/ test_ppu__DOT__dut__DOT__attr_addr;
    SData/*8:0*/ __Vdly__test_ppu__DOT__dut__DOT__scanline;
    SData/*8:0*/ __Vdly__test_ppu__DOT__dut__DOT__dot;
    IData/*31:0*/ test_ppu__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ test_ppu__DOT__unnamedblk2__DOT__i;
    IData/*31:0*/ test_ppu__DOT__unnamedblk3__DOT__i;
    IData/*23:0*/ test_ppu__DOT__dut__DOT__nes_color;
    IData/*31:0*/ test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 2048> test_ppu__DOT__vram;
    VlUnpacked<CData/*7:0*/, 256> test_ppu__DOT__oam;
    VlUnpacked<CData/*7:0*/, 32> test_ppu__DOT__palette;
    VlUnpacked<CData/*7:0*/, 32> test_ppu__DOT__dut__DOT__palette;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlUnpacked<CData/*0:0*/, 8> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_h25c96872__0;
    VlTriggerScheduler __VtrigSched_h189696ad__0;

    // INTERNAL VARIABLES
    Vtest_ppu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtest_ppu___024root(Vtest_ppu__Syms* symsp, const char* v__name);
    ~Vtest_ppu___024root();
    VL_UNCOPYABLE(Vtest_ppu___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
