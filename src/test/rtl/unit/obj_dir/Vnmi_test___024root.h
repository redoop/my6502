// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vnmi_test.h for the primary calling header

#ifndef VERILATED_VNMI_TEST___024ROOT_H_
#define VERILATED_VNMI_TEST___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vnmi_test__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vnmi_test___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ nmi_test__DOT__clk;
        CData/*0:0*/ nmi_test__DOT__rst_n;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__video_de;
        CData/*3:0*/ nmi_test__DOT__dut__DOT__clk_div;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu_clk;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__ppu_clk;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu_data_out;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu_data_in;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu_rw;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__nmi;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__irq;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppuctrl;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppumask;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppustatus;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__oamaddr;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppuscroll_x;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppuscroll_y;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__ppuaddr_latch;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppudata_buffer;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__vblank;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__sprite0_hit;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__rendering;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__apu_status;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__apu_frame_counter;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__dma_active;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__dma_start;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma_page;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma_offset;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma_ram_addr_low;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma_oam_addr;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma_oam_data;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__dma_oam_write;
        CData/*7:0*/ nmi_test__DOT__dut__DOT____Vcellinp__dma__ram_data;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__vblank_sync1;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__vblank_sync2;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__ppustatus_read_last;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__A;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__X;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__Y;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__SP;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__C;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__Z;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__I;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__D;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__B;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__V;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__N;
        CData/*2:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__state;
        CData/*2:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__next_state;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__opcode;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__operand;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__alu_result;
        CData/*2:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*2:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__temp_result;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y;
    };
    struct {
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_tile;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x;
        CData/*1:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel;
        CData/*4:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__tile_index;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte;
        CData/*1:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits;
        CData/*1:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value;
        CData/*4:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx;
        CData/*4:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__tile_x;
        CData/*4:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__tile_y;
        CData/*4:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__palette_color;
        CData/*3:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty;
        CData/*3:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit;
        CData/*3:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty;
        CData/*3:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled;
        CData/*0:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit;
        CData/*7:0*/ nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppuctrl;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppumask;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__oamaddr;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppuaddr_latch;
        CData/*2:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__opcode;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__D;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__C;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__A;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Z;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__N;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__X;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__Y;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__V;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__SP;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__I;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__B;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__operand;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo;
        CData/*2:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle;
        CData/*0:0*/ __Vdly__nmi_test__DOT__dut__DOT__dma_active;
        CData/*7:0*/ __Vdly__nmi_test__DOT__dut__DOT__dma__DOT__dma_offset;
        CData/*7:0*/ __VdlyVal__nmi_test__DOT__dut__DOT__oam__v0;
        CData/*7:0*/ __VdlyDim0__nmi_test__DOT__dut__DOT__oam__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__oam__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__ram__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__oam__v1;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__vram__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__palette__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__apu_pulse1__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__apu_pulse2__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__apu_triangle__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__apu_noise__v0;
        CData/*0:0*/ __VdlySet__nmi_test__DOT__dut__DOT__apu_dmc__v0;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nmi_test__DOT__clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nmi_test__DOT__rst_n__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__cpu_clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__nmi_test__DOT__dut__DOT__ppu_clk__0;
    };
    struct {
        SData/*14:0*/ nmi_test__DOT__prg_rom_addr;
        SData/*13:0*/ nmi_test__DOT__chr_rom_addr;
        SData/*15:0*/ nmi_test__DOT__nmi_trigger_count;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__vram_write_count;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__cpu_addr;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__ppuaddr;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__PC;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__ea;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__scanline;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__dot;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x;
        SData/*8:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y;
        SData/*9:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__audio_counter;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__test_tone;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer;
        SData/*15:0*/ nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out;
        SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppuaddr;
        SData/*15:0*/ __Vdly__nmi_test__DOT__nmi_trigger_count;
        SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu_addr;
        SData/*15:0*/ __Vdly__nmi_test__DOT__dut__DOT__cpu__DOT__PC;
        SData/*8:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__scanline;
        SData/*8:0*/ __Vdly__nmi_test__DOT__dut__DOT__ppu__DOT__dot;
        IData/*31:0*/ nmi_test__DOT__unnamedblk1__DOT__i;
        IData/*31:0*/ nmi_test__DOT__dut__DOT__total_write_count;
        IData/*31:0*/ nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i;
        IData/*31:0*/ nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i;
        IData/*31:0*/ nmi_test__DOT__dut__DOT__unnamedblk3__DOT__i;
        IData/*23:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__nes_color;
        IData/*31:0*/ nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i;
        IData/*31:0*/ __Vdly__nmi_test__DOT__dut__DOT__total_write_count;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*7:0*/, 16384> nmi_test__DOT__test_rom;
        VlUnpacked<CData/*7:0*/, 2048> nmi_test__DOT__dut__DOT__ram;
        VlUnpacked<CData/*7:0*/, 256> nmi_test__DOT__dut__DOT__oam;
        VlUnpacked<CData/*7:0*/, 2048> nmi_test__DOT__dut__DOT__vram;
        VlUnpacked<CData/*7:0*/, 32> nmi_test__DOT__dut__DOT__palette;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu_pulse1;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu_pulse2;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu_triangle;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu_noise;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu_dmc;
        VlUnpacked<CData/*7:0*/, 32> nmi_test__DOT__dut__DOT__ppu__DOT__palette;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu__DOT__apu_noise;
        VlUnpacked<CData/*7:0*/, 4> nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc;
        VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
        VlUnpacked<CData/*0:0*/, 8> __Vm_traceActivity;
    };
    VlDelayScheduler __VdlySched;

    // INTERNAL VARIABLES
    Vnmi_test__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vnmi_test___024root(Vnmi_test__Syms* symsp, const char* v__name);
    ~Vnmi_test___024root();
    VL_UNCOPYABLE(Vnmi_test___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
