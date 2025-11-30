// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vnmi_test__Syms.h"


VL_ATTR_COLD void Vnmi_test___024root__trace_init_sub__TOP__0(Vnmi_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_init_sub__TOP__0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("nmi_test", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+217,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+5,0,"prg_rom_data",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+224,0,"chr_rom_data",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+61,0,"prg_rom_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 14,0);
    tracep->declBus(c+195,0,"chr_rom_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 13,0);
    tracep->declBus(c+62,0,"nmi_trigger_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+217,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+219,0,"video_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+220,0,"video_g",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+221,0,"video_b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+187,0,"video_hsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+188,0,"video_vsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+189,0,"video_de",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+38,0,"audio_l",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+38,0,"audio_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+224,0,"controller1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+224,0,"controller2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+5,0,"prg_rom_data",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+61,0,"prg_rom_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 14,0);
    tracep->declBus(c+224,0,"chr_rom_data",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+195,0,"chr_rom_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 13,0);
    tracep->declBus(c+63,0,"vram_write_count",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+62,0,"nmi_trigger_count",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+64,0,"debug_cpu_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+65,0,"debug_cpu_rw",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+39,0,"debug_ppustatus",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+190,0,"debug_vblank",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+66,0,"debug_vblank_sync1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"debug_vblank_sync2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+68,0,"debug_nmi",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+69,0,"debug_ppuctrl",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+55,0,"clk_div",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+56,0,"cpu_clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+57,0,"ppu_clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("palette", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+6+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+64,0,"cpu_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+70,0,"cpu_data_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+222,0,"cpu_data_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+65,0,"cpu_rw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+68,0,"nmi",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+225,0,"irq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+69,0,"ppuctrl",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+223,0,"ppumask",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+39,0,"ppustatus",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+71,0,"oamaddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+72,0,"ppuscroll_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+73,0,"ppuscroll_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+74,0,"ppuaddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+75,0,"ppuaddr_latch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+58,0,"ppudata_buffer",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+190,0,"vblank",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+191,0,"sprite0_hit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+192,0,"rendering",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("apu_pulse1", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+76+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_pulse2", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+80+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_triangle", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+84+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_noise", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+88+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_dmc", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+92+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+96,0,"apu_status",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+97,0,"apu_frame_counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+98,0,"dma_active",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"dma_start",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"dma_page",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+226,0,"dma_offset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+101,0,"dma_ram_addr_low",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+102,0,"dma_oam_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+103,0,"dma_oam_data",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+104,0,"dma_oam_write",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+105,0,"total_write_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+66,0,"vblank_sync1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"vblank_sync2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+40,0,"ppustatus_read_last",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("apu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+56,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("apu_pulse1", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+106+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_pulse2", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+110+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_triangle", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+114+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_noise", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+118+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("apu_dmc", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+122+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+96,0,"apu_status",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+38,0,"audio_l",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+38,0,"audio_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+41,0,"audio_counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+42,0,"test_tone",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+43,0,"pulse1_timer",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+44,0,"pulse1_duty",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+45,0,"pulse1_volume",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+46,0,"pulse1_enabled",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+47,0,"pulse1_out_bit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+48,0,"pulse1_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+49,0,"pulse2_timer",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+50,0,"pulse2_duty",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+51,0,"pulse2_volume",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+52,0,"pulse2_enabled",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+53,0,"pulse2_out_bit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+54,0,"pulse2_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->popPrefix();
    tracep->pushPrefix("cpu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+56,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+64,0,"addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+222,0,"data_in",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+70,0,"data_out",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+65,0,"rw",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+68,0,"nmi",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+225,0,"irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+126,0,"A",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+127,0,"X",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+128,0,"Y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+129,0,"SP",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+130,0,"PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+131,0,"C",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+132,0,"Z",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+133,0,"I",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+134,0,"D",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+135,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+136,0,"V",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+137,0,"N",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+138,0,"state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+139,0,"next_state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+140,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+141,0,"operand",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+142,0,"alu_result",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+227,0,"ea",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+143,0,"cycle_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+144,0,"reset_vector",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+145,0,"nmi_cycle",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+146,0,"nmi_pending",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"nmi_prev",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+148,0,"indirect_addr_lo",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+149,0,"indirect_addr_hi",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+150,0,"temp_sum",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+151,0,"temp_diff",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+152,0,"temp_result",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->popPrefix();
    tracep->pushPrefix("dma", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+56,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"dma_start",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"dma_page",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+98,0,"dma_active",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+153,0,"ram_data",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+101,0,"ram_addr_low",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+102,0,"oam_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+103,0,"oam_data",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+104,0,"oam_write",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+154,0,"dma_offset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->popPrefix();
    tracep->pushPrefix("ppu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+57,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+218,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+69,0,"ppuctrl",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+223,0,"ppumask",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+72,0,"ppuscroll_x",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+73,0,"ppuscroll_y",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+74,0,"ppuaddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("palette", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+155+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+224,0,"chr_rom_data",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+195,0,"chr_rom_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 13,0);
    tracep->declBus(c+219,0,"video_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+220,0,"video_g",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+221,0,"video_b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+187,0,"video_hsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+188,0,"video_vsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+189,0,"video_de",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+190,0,"vblank",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+191,0,"sprite0_hit",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+192,0,"rendering",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+193,0,"scanline",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+194,0,"dot",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+59,0,"pattern_lo_reg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+60,0,"pattern_hi_reg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+196,0,"sprite_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+197,0,"sprite_tile",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+198,0,"sprite_attr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+199,0,"sprite_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+200,0,"sprite_pixel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+201,0,"sprite_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+202,0,"sprite_active",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+203,0,"tile_index",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+204,0,"attr_byte",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+205,0,"attr_bits",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+206,0,"pixel_value",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+207,0,"bg_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+208,0,"tile_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+209,0,"tile_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+210,0,"scroll_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+211,0,"scroll_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+212,0,"attr_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+213,0,"nes_color",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 23,0);
    tracep->declBus(c+214,0,"final_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+215,0,"palette_color",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+216,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+1,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk2", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+2,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk3", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+3,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+4,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vnmi_test___024root__trace_init_top(Vnmi_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_init_top\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vnmi_test___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vnmi_test___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vnmi_test___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vnmi_test___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vnmi_test___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vnmi_test___024root__trace_register(Vnmi_test___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_register\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vnmi_test___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&Vnmi_test___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&Vnmi_test___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&Vnmi_test___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vnmi_test___024root__trace_const_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vnmi_test___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_const_0\n"); );
    // Body
    Vnmi_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vnmi_test___024root*>(voidSelf);
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vnmi_test___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vnmi_test___024root__trace_const_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_const_0_sub_0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullCData(oldp+224,(0U),8);
    bufp->fullBit(oldp+225,(vlSelfRef.nmi_test__DOT__dut__DOT__irq));
    bufp->fullCData(oldp+226,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_offset),8);
    bufp->fullSData(oldp+227,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__ea),16);
}

VL_ATTR_COLD void Vnmi_test___024root__trace_full_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vnmi_test___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_full_0\n"); );
    // Body
    Vnmi_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vnmi_test___024root*>(voidSelf);
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vnmi_test___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vnmi_test___024root__trace_full_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_full_0_sub_0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullIData(oldp+1,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i),32);
    bufp->fullIData(oldp+2,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i),32);
    bufp->fullIData(oldp+3,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk3__DOT__i),32);
    bufp->fullIData(oldp+4,(vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i),32);
    bufp->fullCData(oldp+5,(((0x4000U > (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))
                              ? vlSelfRef.nmi_test__DOT__test_rom
                             [(0x00003fffU & (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))]
                              : 0U)),8);
    bufp->fullCData(oldp+6,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[0]),8);
    bufp->fullCData(oldp+7,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[1]),8);
    bufp->fullCData(oldp+8,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[2]),8);
    bufp->fullCData(oldp+9,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[3]),8);
    bufp->fullCData(oldp+10,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[4]),8);
    bufp->fullCData(oldp+11,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[5]),8);
    bufp->fullCData(oldp+12,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[6]),8);
    bufp->fullCData(oldp+13,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[7]),8);
    bufp->fullCData(oldp+14,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[8]),8);
    bufp->fullCData(oldp+15,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[9]),8);
    bufp->fullCData(oldp+16,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[10]),8);
    bufp->fullCData(oldp+17,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[11]),8);
    bufp->fullCData(oldp+18,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[12]),8);
    bufp->fullCData(oldp+19,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[13]),8);
    bufp->fullCData(oldp+20,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[14]),8);
    bufp->fullCData(oldp+21,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[15]),8);
    bufp->fullCData(oldp+22,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[16]),8);
    bufp->fullCData(oldp+23,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[17]),8);
    bufp->fullCData(oldp+24,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[18]),8);
    bufp->fullCData(oldp+25,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[19]),8);
    bufp->fullCData(oldp+26,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[20]),8);
    bufp->fullCData(oldp+27,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[21]),8);
    bufp->fullCData(oldp+28,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[22]),8);
    bufp->fullCData(oldp+29,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[23]),8);
    bufp->fullCData(oldp+30,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[24]),8);
    bufp->fullCData(oldp+31,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[25]),8);
    bufp->fullCData(oldp+32,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[26]),8);
    bufp->fullCData(oldp+33,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[27]),8);
    bufp->fullCData(oldp+34,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[28]),8);
    bufp->fullCData(oldp+35,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[29]),8);
    bufp->fullCData(oldp+36,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[30]),8);
    bufp->fullCData(oldp+37,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[31]),8);
    bufp->fullSData(oldp+38,((0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone) 
                                             + ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out) 
                                                + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out))))),16);
    bufp->fullCData(oldp+39,(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus),8);
    bufp->fullBit(oldp+40,(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus_read_last));
    bufp->fullSData(oldp+41,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter),16);
    bufp->fullSData(oldp+42,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone),16);
    bufp->fullSData(oldp+43,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer),16);
    bufp->fullCData(oldp+44,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty),4);
    bufp->fullCData(oldp+45,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume),4);
    bufp->fullBit(oldp+46,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled));
    bufp->fullBit(oldp+47,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit));
    bufp->fullSData(oldp+48,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out),16);
    bufp->fullSData(oldp+49,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer),16);
    bufp->fullCData(oldp+50,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty),4);
    bufp->fullCData(oldp+51,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume),4);
    bufp->fullBit(oldp+52,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled));
    bufp->fullBit(oldp+53,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit));
    bufp->fullSData(oldp+54,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out),16);
    bufp->fullCData(oldp+55,(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div),4);
    bufp->fullBit(oldp+56,((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                  >> 3U))));
    bufp->fullBit(oldp+57,((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                  >> 1U))));
    bufp->fullCData(oldp+58,(vlSelfRef.nmi_test__DOT__dut__DOT__ppudata_buffer),8);
    bufp->fullCData(oldp+59,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg),8);
    bufp->fullCData(oldp+60,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg),8);
    bufp->fullSData(oldp+61,(vlSelfRef.nmi_test__DOT__prg_rom_addr),15);
    bufp->fullSData(oldp+62,(vlSelfRef.nmi_test__DOT__nmi_trigger_count),16);
    bufp->fullSData(oldp+63,(vlSelfRef.nmi_test__DOT__dut__DOT__vram_write_count),16);
    bufp->fullSData(oldp+64,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr),16);
    bufp->fullBit(oldp+65,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw));
    bufp->fullBit(oldp+66,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync1));
    bufp->fullBit(oldp+67,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2));
    bufp->fullBit(oldp+68,(vlSelfRef.nmi_test__DOT__dut__DOT__nmi));
    bufp->fullCData(oldp+69,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl),8);
    bufp->fullCData(oldp+70,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out),8);
    bufp->fullCData(oldp+71,(vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr),8);
    bufp->fullCData(oldp+72,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_x),8);
    bufp->fullCData(oldp+73,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_y),8);
    bufp->fullSData(oldp+74,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr),16);
    bufp->fullBit(oldp+75,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch));
    bufp->fullCData(oldp+76,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[0]),8);
    bufp->fullCData(oldp+77,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[1]),8);
    bufp->fullCData(oldp+78,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[2]),8);
    bufp->fullCData(oldp+79,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[3]),8);
    bufp->fullCData(oldp+80,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[0]),8);
    bufp->fullCData(oldp+81,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[1]),8);
    bufp->fullCData(oldp+82,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[2]),8);
    bufp->fullCData(oldp+83,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[3]),8);
    bufp->fullCData(oldp+84,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[0]),8);
    bufp->fullCData(oldp+85,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[1]),8);
    bufp->fullCData(oldp+86,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[2]),8);
    bufp->fullCData(oldp+87,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[3]),8);
    bufp->fullCData(oldp+88,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[0]),8);
    bufp->fullCData(oldp+89,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[1]),8);
    bufp->fullCData(oldp+90,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[2]),8);
    bufp->fullCData(oldp+91,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[3]),8);
    bufp->fullCData(oldp+92,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[0]),8);
    bufp->fullCData(oldp+93,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[1]),8);
    bufp->fullCData(oldp+94,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[2]),8);
    bufp->fullCData(oldp+95,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[3]),8);
    bufp->fullCData(oldp+96,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_status),8);
    bufp->fullCData(oldp+97,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_frame_counter),8);
    bufp->fullBit(oldp+98,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_active));
    bufp->fullBit(oldp+99,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_start));
    bufp->fullCData(oldp+100,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page),8);
    bufp->fullCData(oldp+101,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low),8);
    bufp->fullCData(oldp+102,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_addr),8);
    bufp->fullCData(oldp+103,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_data),8);
    bufp->fullBit(oldp+104,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write));
    bufp->fullIData(oldp+105,(vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count),32);
    bufp->fullCData(oldp+106,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[0]),8);
    bufp->fullCData(oldp+107,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[1]),8);
    bufp->fullCData(oldp+108,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[2]),8);
    bufp->fullCData(oldp+109,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[3]),8);
    bufp->fullCData(oldp+110,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[0]),8);
    bufp->fullCData(oldp+111,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[1]),8);
    bufp->fullCData(oldp+112,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[2]),8);
    bufp->fullCData(oldp+113,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[3]),8);
    bufp->fullCData(oldp+114,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[0]),8);
    bufp->fullCData(oldp+115,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[1]),8);
    bufp->fullCData(oldp+116,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[2]),8);
    bufp->fullCData(oldp+117,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[3]),8);
    bufp->fullCData(oldp+118,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[0]),8);
    bufp->fullCData(oldp+119,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[1]),8);
    bufp->fullCData(oldp+120,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[2]),8);
    bufp->fullCData(oldp+121,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[3]),8);
    bufp->fullCData(oldp+122,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[0]),8);
    bufp->fullCData(oldp+123,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[1]),8);
    bufp->fullCData(oldp+124,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[2]),8);
    bufp->fullCData(oldp+125,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[3]),8);
    bufp->fullCData(oldp+126,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A),8);
    bufp->fullCData(oldp+127,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X),8);
    bufp->fullCData(oldp+128,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y),8);
    bufp->fullCData(oldp+129,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP),8);
    bufp->fullSData(oldp+130,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC),16);
    bufp->fullBit(oldp+131,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C));
    bufp->fullBit(oldp+132,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z));
    bufp->fullBit(oldp+133,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I));
    bufp->fullBit(oldp+134,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D));
    bufp->fullBit(oldp+135,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B));
    bufp->fullBit(oldp+136,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V));
    bufp->fullBit(oldp+137,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N));
    bufp->fullCData(oldp+138,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state),3);
    bufp->fullCData(oldp+139,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__next_state),3);
    bufp->fullCData(oldp+140,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode),8);
    bufp->fullCData(oldp+141,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand),8);
    bufp->fullCData(oldp+142,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__alu_result),8);
    bufp->fullCData(oldp+143,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count),3);
    bufp->fullSData(oldp+144,((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__) 
                                << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__))),16);
    bufp->fullCData(oldp+145,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle),3);
    bufp->fullBit(oldp+146,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending));
    bufp->fullBit(oldp+147,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev));
    bufp->fullCData(oldp+148,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo),8);
    bufp->fullCData(oldp+149,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi),8);
    bufp->fullSData(oldp+150,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum),9);
    bufp->fullSData(oldp+151,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff),9);
    bufp->fullCData(oldp+152,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result),8);
    bufp->fullCData(oldp+153,(vlSelfRef.nmi_test__DOT__dut__DOT__ram
                              [((0x00000700U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page) 
                                                << 8U)) 
                                | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low))]),8);
    bufp->fullCData(oldp+154,(vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset),8);
    bufp->fullCData(oldp+155,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0]),8);
    bufp->fullCData(oldp+156,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[1]),8);
    bufp->fullCData(oldp+157,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[2]),8);
    bufp->fullCData(oldp+158,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[3]),8);
    bufp->fullCData(oldp+159,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[4]),8);
    bufp->fullCData(oldp+160,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[5]),8);
    bufp->fullCData(oldp+161,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[6]),8);
    bufp->fullCData(oldp+162,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[7]),8);
    bufp->fullCData(oldp+163,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[8]),8);
    bufp->fullCData(oldp+164,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[9]),8);
    bufp->fullCData(oldp+165,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[10]),8);
    bufp->fullCData(oldp+166,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[11]),8);
    bufp->fullCData(oldp+167,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[12]),8);
    bufp->fullCData(oldp+168,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[13]),8);
    bufp->fullCData(oldp+169,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[14]),8);
    bufp->fullCData(oldp+170,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[15]),8);
    bufp->fullCData(oldp+171,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[16]),8);
    bufp->fullCData(oldp+172,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[17]),8);
    bufp->fullCData(oldp+173,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[18]),8);
    bufp->fullCData(oldp+174,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[19]),8);
    bufp->fullCData(oldp+175,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[20]),8);
    bufp->fullCData(oldp+176,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[21]),8);
    bufp->fullCData(oldp+177,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[22]),8);
    bufp->fullCData(oldp+178,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[23]),8);
    bufp->fullCData(oldp+179,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[24]),8);
    bufp->fullCData(oldp+180,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[25]),8);
    bufp->fullCData(oldp+181,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[26]),8);
    bufp->fullCData(oldp+182,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[27]),8);
    bufp->fullCData(oldp+183,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[28]),8);
    bufp->fullCData(oldp+184,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[29]),8);
    bufp->fullCData(oldp+185,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[30]),8);
    bufp->fullCData(oldp+186,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[31]),8);
    bufp->fullBit(oldp+187,(((0x0118U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)) 
                             & (0x0130U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))));
    bufp->fullBit(oldp+188,(((0x00f3U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
                             & (0x00f6U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)))));
    bufp->fullBit(oldp+189,(vlSelfRef.nmi_test__DOT__dut__DOT__video_de));
    bufp->fullBit(oldp+190,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank));
    bufp->fullBit(oldp+191,(vlSelfRef.nmi_test__DOT__dut__DOT__sprite0_hit));
    bufp->fullBit(oldp+192,(vlSelfRef.nmi_test__DOT__dut__DOT__rendering));
    bufp->fullSData(oldp+193,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline),9);
    bufp->fullSData(oldp+194,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot),9);
    bufp->fullSData(oldp+195,(vlSelfRef.nmi_test__DOT__chr_rom_addr),14);
    bufp->fullCData(oldp+196,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y),8);
    bufp->fullCData(oldp+197,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_tile),8);
    bufp->fullCData(oldp+198,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr),8);
    bufp->fullCData(oldp+199,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x),8);
    bufp->fullCData(oldp+200,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel),2);
    bufp->fullCData(oldp+201,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx),5);
    bufp->fullBit(oldp+202,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active));
    bufp->fullCData(oldp+203,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index),8);
    bufp->fullCData(oldp+204,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte),8);
    bufp->fullCData(oldp+205,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits),2);
    bufp->fullCData(oldp+206,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value),2);
    bufp->fullCData(oldp+207,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx),5);
    bufp->fullCData(oldp+208,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x),5);
    bufp->fullCData(oldp+209,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y),5);
    bufp->fullSData(oldp+210,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x),9);
    bufp->fullSData(oldp+211,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y),9);
    bufp->fullSData(oldp+212,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr),10);
    bufp->fullIData(oldp+213,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color),24);
    bufp->fullCData(oldp+214,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx),5);
    bufp->fullCData(oldp+215,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color),8);
    bufp->fullIData(oldp+216,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+217,(vlSelfRef.nmi_test__DOT__clk));
    bufp->fullBit(oldp+218,(vlSelfRef.nmi_test__DOT__rst_n));
    bufp->fullCData(oldp+219,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                                ? (0x000000ffU & (vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color 
                                                  >> 0x00000010U))
                                : 0U)),8);
    bufp->fullCData(oldp+220,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                                ? (0x000000ffU & (vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color 
                                                  >> 8U))
                                : 0U)),8);
    bufp->fullCData(oldp+221,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                                ? (0x000000ffU & vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color)
                                : 0U)),8);
    bufp->fullCData(oldp+222,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in),8);
    bufp->fullCData(oldp+223,(vlSelfRef.nmi_test__DOT__dut__DOT__ppumask),8);
}
