// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vnmi_test__Syms.h"


void Vnmi_test___024root__trace_chg_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vnmi_test___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_chg_0\n"); );
    // Body
    Vnmi_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vnmi_test___024root*>(voidSelf);
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vnmi_test___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vnmi_test___024root__trace_chg_0_sub_0(Vnmi_test___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_chg_0_sub_0\n"); );
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgIData(oldp+0,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk1__DOT__i),32);
        bufp->chgIData(oldp+1,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk2__DOT__i),32);
        bufp->chgIData(oldp+2,(vlSelfRef.nmi_test__DOT__dut__DOT__unnamedblk3__DOT__i),32);
        bufp->chgIData(oldp+3,(vlSelfRef.nmi_test__DOT__unnamedblk1__DOT__i),32);
    }
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[1U] 
                      | vlSelfRef.__Vm_traceActivity
                      [5U])))) {
        bufp->chgCData(oldp+4,(((0x4000U > (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))
                                 ? vlSelfRef.nmi_test__DOT__test_rom
                                [(0x00003fffU & (IData)(vlSelfRef.nmi_test__DOT__prg_rom_addr))]
                                 : 0U)),8);
        bufp->chgCData(oldp+5,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[0]),8);
        bufp->chgCData(oldp+6,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[1]),8);
        bufp->chgCData(oldp+7,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[2]),8);
        bufp->chgCData(oldp+8,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[3]),8);
        bufp->chgCData(oldp+9,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[4]),8);
        bufp->chgCData(oldp+10,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[5]),8);
        bufp->chgCData(oldp+11,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[6]),8);
        bufp->chgCData(oldp+12,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[7]),8);
        bufp->chgCData(oldp+13,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[8]),8);
        bufp->chgCData(oldp+14,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[9]),8);
        bufp->chgCData(oldp+15,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[10]),8);
        bufp->chgCData(oldp+16,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[11]),8);
        bufp->chgCData(oldp+17,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[12]),8);
        bufp->chgCData(oldp+18,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[13]),8);
        bufp->chgCData(oldp+19,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[14]),8);
        bufp->chgCData(oldp+20,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[15]),8);
        bufp->chgCData(oldp+21,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[16]),8);
        bufp->chgCData(oldp+22,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[17]),8);
        bufp->chgCData(oldp+23,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[18]),8);
        bufp->chgCData(oldp+24,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[19]),8);
        bufp->chgCData(oldp+25,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[20]),8);
        bufp->chgCData(oldp+26,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[21]),8);
        bufp->chgCData(oldp+27,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[22]),8);
        bufp->chgCData(oldp+28,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[23]),8);
        bufp->chgCData(oldp+29,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[24]),8);
        bufp->chgCData(oldp+30,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[25]),8);
        bufp->chgCData(oldp+31,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[26]),8);
        bufp->chgCData(oldp+32,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[27]),8);
        bufp->chgCData(oldp+33,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[28]),8);
        bufp->chgCData(oldp+34,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[29]),8);
        bufp->chgCData(oldp+35,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[30]),8);
        bufp->chgCData(oldp+36,(vlSelfRef.nmi_test__DOT__dut__DOT__palette[31]),8);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[2U]))) {
        bufp->chgSData(oldp+37,((0x0000ffffU & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone) 
                                                + ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out) 
                                                   + (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out))))),16);
        bufp->chgCData(oldp+38,(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus),8);
        bufp->chgBit(oldp+39,(vlSelfRef.nmi_test__DOT__dut__DOT__ppustatus_read_last));
        bufp->chgSData(oldp+40,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__audio_counter),16);
        bufp->chgSData(oldp+41,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__test_tone),16);
        bufp->chgSData(oldp+42,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_timer),16);
        bufp->chgCData(oldp+43,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_duty),4);
        bufp->chgCData(oldp+44,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_volume),4);
        bufp->chgBit(oldp+45,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_enabled));
        bufp->chgBit(oldp+46,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out_bit));
        bufp->chgSData(oldp+47,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse1_out),16);
        bufp->chgSData(oldp+48,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_timer),16);
        bufp->chgCData(oldp+49,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_duty),4);
        bufp->chgCData(oldp+50,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_volume),4);
        bufp->chgBit(oldp+51,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_enabled));
        bufp->chgBit(oldp+52,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out_bit));
        bufp->chgSData(oldp+53,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__pulse2_out),16);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[3U]))) {
        bufp->chgCData(oldp+54,(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div),4);
        bufp->chgBit(oldp+55,((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                     >> 3U))));
        bufp->chgBit(oldp+56,((1U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__clk_div) 
                                     >> 1U))));
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[4U]))) {
        bufp->chgCData(oldp+57,(vlSelfRef.nmi_test__DOT__dut__DOT__ppudata_buffer),8);
        bufp->chgCData(oldp+58,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_lo_reg),8);
        bufp->chgCData(oldp+59,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pattern_hi_reg),8);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[5U]))) {
        bufp->chgSData(oldp+60,(vlSelfRef.nmi_test__DOT__prg_rom_addr),15);
        bufp->chgSData(oldp+61,(vlSelfRef.nmi_test__DOT__nmi_trigger_count),16);
        bufp->chgSData(oldp+62,(vlSelfRef.nmi_test__DOT__dut__DOT__vram_write_count),16);
        bufp->chgSData(oldp+63,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_addr),16);
        bufp->chgBit(oldp+64,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_rw));
        bufp->chgBit(oldp+65,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync1));
        bufp->chgBit(oldp+66,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank_sync2));
        bufp->chgBit(oldp+67,(vlSelfRef.nmi_test__DOT__dut__DOT__nmi));
        bufp->chgCData(oldp+68,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuctrl),8);
        bufp->chgCData(oldp+69,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_out),8);
        bufp->chgCData(oldp+70,(vlSelfRef.nmi_test__DOT__dut__DOT__oamaddr),8);
        bufp->chgCData(oldp+71,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_x),8);
        bufp->chgCData(oldp+72,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuscroll_y),8);
        bufp->chgSData(oldp+73,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr),16);
        bufp->chgBit(oldp+74,(vlSelfRef.nmi_test__DOT__dut__DOT__ppuaddr_latch));
        bufp->chgCData(oldp+75,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[0]),8);
        bufp->chgCData(oldp+76,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[1]),8);
        bufp->chgCData(oldp+77,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[2]),8);
        bufp->chgCData(oldp+78,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse1[3]),8);
        bufp->chgCData(oldp+79,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[0]),8);
        bufp->chgCData(oldp+80,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[1]),8);
        bufp->chgCData(oldp+81,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[2]),8);
        bufp->chgCData(oldp+82,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_pulse2[3]),8);
        bufp->chgCData(oldp+83,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[0]),8);
        bufp->chgCData(oldp+84,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[1]),8);
        bufp->chgCData(oldp+85,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[2]),8);
        bufp->chgCData(oldp+86,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_triangle[3]),8);
        bufp->chgCData(oldp+87,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[0]),8);
        bufp->chgCData(oldp+88,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[1]),8);
        bufp->chgCData(oldp+89,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[2]),8);
        bufp->chgCData(oldp+90,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_noise[3]),8);
        bufp->chgCData(oldp+91,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[0]),8);
        bufp->chgCData(oldp+92,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[1]),8);
        bufp->chgCData(oldp+93,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[2]),8);
        bufp->chgCData(oldp+94,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_dmc[3]),8);
        bufp->chgCData(oldp+95,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_status),8);
        bufp->chgCData(oldp+96,(vlSelfRef.nmi_test__DOT__dut__DOT__apu_frame_counter),8);
        bufp->chgBit(oldp+97,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_active));
        bufp->chgBit(oldp+98,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_start));
        bufp->chgCData(oldp+99,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page),8);
        bufp->chgCData(oldp+100,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low),8);
        bufp->chgCData(oldp+101,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_addr),8);
        bufp->chgCData(oldp+102,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_data),8);
        bufp->chgBit(oldp+103,(vlSelfRef.nmi_test__DOT__dut__DOT__dma_oam_write));
        bufp->chgIData(oldp+104,(vlSelfRef.nmi_test__DOT__dut__DOT__total_write_count),32);
        bufp->chgCData(oldp+105,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[0]),8);
        bufp->chgCData(oldp+106,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[1]),8);
        bufp->chgCData(oldp+107,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[2]),8);
        bufp->chgCData(oldp+108,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse1[3]),8);
        bufp->chgCData(oldp+109,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[0]),8);
        bufp->chgCData(oldp+110,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[1]),8);
        bufp->chgCData(oldp+111,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[2]),8);
        bufp->chgCData(oldp+112,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_pulse2[3]),8);
        bufp->chgCData(oldp+113,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[0]),8);
        bufp->chgCData(oldp+114,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[1]),8);
        bufp->chgCData(oldp+115,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[2]),8);
        bufp->chgCData(oldp+116,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_triangle[3]),8);
        bufp->chgCData(oldp+117,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[0]),8);
        bufp->chgCData(oldp+118,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[1]),8);
        bufp->chgCData(oldp+119,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[2]),8);
        bufp->chgCData(oldp+120,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_noise[3]),8);
        bufp->chgCData(oldp+121,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[0]),8);
        bufp->chgCData(oldp+122,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[1]),8);
        bufp->chgCData(oldp+123,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[2]),8);
        bufp->chgCData(oldp+124,(vlSelfRef.nmi_test__DOT__dut__DOT__apu__DOT__apu_dmc[3]),8);
        bufp->chgCData(oldp+125,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__A),8);
        bufp->chgCData(oldp+126,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__X),8);
        bufp->chgCData(oldp+127,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Y),8);
        bufp->chgCData(oldp+128,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__SP),8);
        bufp->chgSData(oldp+129,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__PC),16);
        bufp->chgBit(oldp+130,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__C));
        bufp->chgBit(oldp+131,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__Z));
        bufp->chgBit(oldp+132,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__I));
        bufp->chgBit(oldp+133,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__D));
        bufp->chgBit(oldp+134,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__B));
        bufp->chgBit(oldp+135,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__V));
        bufp->chgBit(oldp+136,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__N));
        bufp->chgCData(oldp+137,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__state),3);
        bufp->chgCData(oldp+138,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__next_state),3);
        bufp->chgCData(oldp+139,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__opcode),8);
        bufp->chgCData(oldp+140,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__operand),8);
        bufp->chgCData(oldp+141,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__alu_result),8);
        bufp->chgCData(oldp+142,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__cycle_count),3);
        bufp->chgSData(oldp+143,((((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__) 
                                   << 8U) | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__))),16);
        bufp->chgCData(oldp+144,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_cycle),3);
        bufp->chgBit(oldp+145,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_pending));
        bufp->chgBit(oldp+146,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__nmi_prev));
        bufp->chgCData(oldp+147,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_lo),8);
        bufp->chgCData(oldp+148,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__indirect_addr_hi),8);
        bufp->chgSData(oldp+149,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_sum),9);
        bufp->chgSData(oldp+150,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_diff),9);
        bufp->chgCData(oldp+151,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu__DOT__temp_result),8);
        bufp->chgCData(oldp+152,(vlSelfRef.nmi_test__DOT__dut__DOT__ram
                                 [((0x00000700U & ((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_page) 
                                                   << 8U)) 
                                   | (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__dma_ram_addr_low))]),8);
        bufp->chgCData(oldp+153,(vlSelfRef.nmi_test__DOT__dut__DOT__dma__DOT__dma_offset),8);
        bufp->chgCData(oldp+154,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[0]),8);
        bufp->chgCData(oldp+155,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[1]),8);
        bufp->chgCData(oldp+156,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[2]),8);
        bufp->chgCData(oldp+157,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[3]),8);
        bufp->chgCData(oldp+158,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[4]),8);
        bufp->chgCData(oldp+159,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[5]),8);
        bufp->chgCData(oldp+160,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[6]),8);
        bufp->chgCData(oldp+161,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[7]),8);
        bufp->chgCData(oldp+162,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[8]),8);
        bufp->chgCData(oldp+163,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[9]),8);
        bufp->chgCData(oldp+164,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[10]),8);
        bufp->chgCData(oldp+165,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[11]),8);
        bufp->chgCData(oldp+166,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[12]),8);
        bufp->chgCData(oldp+167,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[13]),8);
        bufp->chgCData(oldp+168,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[14]),8);
        bufp->chgCData(oldp+169,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[15]),8);
        bufp->chgCData(oldp+170,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[16]),8);
        bufp->chgCData(oldp+171,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[17]),8);
        bufp->chgCData(oldp+172,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[18]),8);
        bufp->chgCData(oldp+173,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[19]),8);
        bufp->chgCData(oldp+174,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[20]),8);
        bufp->chgCData(oldp+175,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[21]),8);
        bufp->chgCData(oldp+176,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[22]),8);
        bufp->chgCData(oldp+177,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[23]),8);
        bufp->chgCData(oldp+178,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[24]),8);
        bufp->chgCData(oldp+179,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[25]),8);
        bufp->chgCData(oldp+180,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[26]),8);
        bufp->chgCData(oldp+181,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[27]),8);
        bufp->chgCData(oldp+182,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[28]),8);
        bufp->chgCData(oldp+183,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[29]),8);
        bufp->chgCData(oldp+184,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[30]),8);
        bufp->chgCData(oldp+185,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette[31]),8);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[6U]))) {
        bufp->chgBit(oldp+186,(((0x0118U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)) 
                                & (0x0130U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot)))));
        bufp->chgBit(oldp+187,(((0x00f3U <= (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)) 
                                & (0x00f6U > (IData)(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline)))));
        bufp->chgBit(oldp+188,(vlSelfRef.nmi_test__DOT__dut__DOT__video_de));
        bufp->chgBit(oldp+189,(vlSelfRef.nmi_test__DOT__dut__DOT__vblank));
        bufp->chgBit(oldp+190,(vlSelfRef.nmi_test__DOT__dut__DOT__sprite0_hit));
        bufp->chgBit(oldp+191,(vlSelfRef.nmi_test__DOT__dut__DOT__rendering));
        bufp->chgSData(oldp+192,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scanline),9);
        bufp->chgSData(oldp+193,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__dot),9);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[7U]))) {
        bufp->chgSData(oldp+194,(vlSelfRef.nmi_test__DOT__chr_rom_addr),14);
        bufp->chgCData(oldp+195,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_y),8);
        bufp->chgCData(oldp+196,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_tile),8);
        bufp->chgCData(oldp+197,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_attr),8);
        bufp->chgCData(oldp+198,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_x),8);
        bufp->chgCData(oldp+199,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_pixel),2);
        bufp->chgCData(oldp+200,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_palette_idx),5);
        bufp->chgBit(oldp+201,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__sprite_active));
        bufp->chgCData(oldp+202,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_index),8);
        bufp->chgCData(oldp+203,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_byte),8);
        bufp->chgCData(oldp+204,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_bits),2);
        bufp->chgCData(oldp+205,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__pixel_value),2);
        bufp->chgCData(oldp+206,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__bg_palette_idx),5);
        bufp->chgCData(oldp+207,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_x),5);
        bufp->chgCData(oldp+208,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__tile_y),5);
        bufp->chgSData(oldp+209,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_x),9);
        bufp->chgSData(oldp+210,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__scroll_y),9);
        bufp->chgSData(oldp+211,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__attr_addr),10);
        bufp->chgIData(oldp+212,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color),24);
        bufp->chgCData(oldp+213,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__final_palette_idx),5);
        bufp->chgCData(oldp+214,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__palette_color),8);
        bufp->chgIData(oldp+215,(vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__unnamedblk1__DOT__i),32);
    }
    bufp->chgBit(oldp+216,(vlSelfRef.nmi_test__DOT__clk));
    bufp->chgBit(oldp+217,(vlSelfRef.nmi_test__DOT__rst_n));
    bufp->chgCData(oldp+218,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                               ? (0x000000ffU & (vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color 
                                                 >> 0x00000010U))
                               : 0U)),8);
    bufp->chgCData(oldp+219,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                               ? (0x000000ffU & (vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color 
                                                 >> 8U))
                               : 0U)),8);
    bufp->chgCData(oldp+220,(((IData)(vlSelfRef.nmi_test__DOT__dut__DOT__video_de)
                               ? (0x000000ffU & vlSelfRef.nmi_test__DOT__dut__DOT__ppu__DOT__nes_color)
                               : 0U)),8);
    bufp->chgCData(oldp+221,(vlSelfRef.nmi_test__DOT__dut__DOT__cpu_data_in),8);
    bufp->chgCData(oldp+222,(vlSelfRef.nmi_test__DOT__dut__DOT__ppumask),8);
}

void Vnmi_test___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vnmi_test___024root__trace_cleanup\n"); );
    // Body
    Vnmi_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vnmi_test___024root*>(voidSelf);
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[5U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[6U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[7U] = 0U;
}
