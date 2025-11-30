// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_ppu__Syms.h"


void Vtest_ppu___024root__trace_chg_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtest_ppu___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_chg_0\n"); );
    // Body
    Vtest_ppu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_ppu___024root*>(voidSelf);
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vtest_ppu___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtest_ppu___024root__trace_chg_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_chg_0_sub_0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[1U] 
                      | vlSelfRef.__Vm_traceActivity
                      [2U])))) {
        bufp->chgBit(oldp+0,(vlSelfRef.test_ppu__DOT__rst_n));
        bufp->chgCData(oldp+1,(vlSelfRef.test_ppu__DOT__ppuctrl),8);
        bufp->chgCData(oldp+2,(vlSelfRef.test_ppu__DOT__ppumask),8);
        bufp->chgCData(oldp+3,(vlSelfRef.test_ppu__DOT__ppuscroll_x),8);
        bufp->chgCData(oldp+4,(vlSelfRef.test_ppu__DOT__ppuscroll_y),8);
        bufp->chgSData(oldp+5,(vlSelfRef.test_ppu__DOT__ppuaddr),16);
        bufp->chgCData(oldp+6,(vlSelfRef.test_ppu__DOT__palette[0]),8);
        bufp->chgCData(oldp+7,(vlSelfRef.test_ppu__DOT__palette[1]),8);
        bufp->chgCData(oldp+8,(vlSelfRef.test_ppu__DOT__palette[2]),8);
        bufp->chgCData(oldp+9,(vlSelfRef.test_ppu__DOT__palette[3]),8);
        bufp->chgCData(oldp+10,(vlSelfRef.test_ppu__DOT__palette[4]),8);
        bufp->chgCData(oldp+11,(vlSelfRef.test_ppu__DOT__palette[5]),8);
        bufp->chgCData(oldp+12,(vlSelfRef.test_ppu__DOT__palette[6]),8);
        bufp->chgCData(oldp+13,(vlSelfRef.test_ppu__DOT__palette[7]),8);
        bufp->chgCData(oldp+14,(vlSelfRef.test_ppu__DOT__palette[8]),8);
        bufp->chgCData(oldp+15,(vlSelfRef.test_ppu__DOT__palette[9]),8);
        bufp->chgCData(oldp+16,(vlSelfRef.test_ppu__DOT__palette[10]),8);
        bufp->chgCData(oldp+17,(vlSelfRef.test_ppu__DOT__palette[11]),8);
        bufp->chgCData(oldp+18,(vlSelfRef.test_ppu__DOT__palette[12]),8);
        bufp->chgCData(oldp+19,(vlSelfRef.test_ppu__DOT__palette[13]),8);
        bufp->chgCData(oldp+20,(vlSelfRef.test_ppu__DOT__palette[14]),8);
        bufp->chgCData(oldp+21,(vlSelfRef.test_ppu__DOT__palette[15]),8);
        bufp->chgCData(oldp+22,(vlSelfRef.test_ppu__DOT__palette[16]),8);
        bufp->chgCData(oldp+23,(vlSelfRef.test_ppu__DOT__palette[17]),8);
        bufp->chgCData(oldp+24,(vlSelfRef.test_ppu__DOT__palette[18]),8);
        bufp->chgCData(oldp+25,(vlSelfRef.test_ppu__DOT__palette[19]),8);
        bufp->chgCData(oldp+26,(vlSelfRef.test_ppu__DOT__palette[20]),8);
        bufp->chgCData(oldp+27,(vlSelfRef.test_ppu__DOT__palette[21]),8);
        bufp->chgCData(oldp+28,(vlSelfRef.test_ppu__DOT__palette[22]),8);
        bufp->chgCData(oldp+29,(vlSelfRef.test_ppu__DOT__palette[23]),8);
        bufp->chgCData(oldp+30,(vlSelfRef.test_ppu__DOT__palette[24]),8);
        bufp->chgCData(oldp+31,(vlSelfRef.test_ppu__DOT__palette[25]),8);
        bufp->chgCData(oldp+32,(vlSelfRef.test_ppu__DOT__palette[26]),8);
        bufp->chgCData(oldp+33,(vlSelfRef.test_ppu__DOT__palette[27]),8);
        bufp->chgCData(oldp+34,(vlSelfRef.test_ppu__DOT__palette[28]),8);
        bufp->chgCData(oldp+35,(vlSelfRef.test_ppu__DOT__palette[29]),8);
        bufp->chgCData(oldp+36,(vlSelfRef.test_ppu__DOT__palette[30]),8);
        bufp->chgCData(oldp+37,(vlSelfRef.test_ppu__DOT__palette[31]),8);
        bufp->chgIData(oldp+38,(vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i),32);
        bufp->chgIData(oldp+39,(vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i),32);
        bufp->chgIData(oldp+40,(vlSelfRef.test_ppu__DOT__unnamedblk3__DOT__i),32);
    }
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[3U] 
                      | vlSelfRef.__Vm_traceActivity
                      [5U])))) {
        bufp->chgCData(oldp+41,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[0]),8);
        bufp->chgCData(oldp+42,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[1]),8);
        bufp->chgCData(oldp+43,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[2]),8);
        bufp->chgCData(oldp+44,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[3]),8);
        bufp->chgCData(oldp+45,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[4]),8);
        bufp->chgCData(oldp+46,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[5]),8);
        bufp->chgCData(oldp+47,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[6]),8);
        bufp->chgCData(oldp+48,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[7]),8);
        bufp->chgCData(oldp+49,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[8]),8);
        bufp->chgCData(oldp+50,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[9]),8);
        bufp->chgCData(oldp+51,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[10]),8);
        bufp->chgCData(oldp+52,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[11]),8);
        bufp->chgCData(oldp+53,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[12]),8);
        bufp->chgCData(oldp+54,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[13]),8);
        bufp->chgCData(oldp+55,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[14]),8);
        bufp->chgCData(oldp+56,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[15]),8);
        bufp->chgCData(oldp+57,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[16]),8);
        bufp->chgCData(oldp+58,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[17]),8);
        bufp->chgCData(oldp+59,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[18]),8);
        bufp->chgCData(oldp+60,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[19]),8);
        bufp->chgCData(oldp+61,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[20]),8);
        bufp->chgCData(oldp+62,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[21]),8);
        bufp->chgCData(oldp+63,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[22]),8);
        bufp->chgCData(oldp+64,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[23]),8);
        bufp->chgCData(oldp+65,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[24]),8);
        bufp->chgCData(oldp+66,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[25]),8);
        bufp->chgCData(oldp+67,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[26]),8);
        bufp->chgCData(oldp+68,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[27]),8);
        bufp->chgCData(oldp+69,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[28]),8);
        bufp->chgCData(oldp+70,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[29]),8);
        bufp->chgCData(oldp+71,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[30]),8);
        bufp->chgCData(oldp+72,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[31]),8);
    }
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[3U] 
                      | vlSelfRef.__Vm_traceActivity
                      [7U])))) {
        bufp->chgSData(oldp+73,(vlSelfRef.test_ppu__DOT__chr_rom_addr),14);
        bufp->chgCData(oldp+74,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y),8);
        bufp->chgCData(oldp+75,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_tile),8);
        bufp->chgCData(oldp+76,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_attr),8);
        bufp->chgCData(oldp+77,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x),8);
        bufp->chgCData(oldp+78,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel),2);
        bufp->chgCData(oldp+79,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_palette_idx),5);
        bufp->chgBit(oldp+80,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_active));
        bufp->chgCData(oldp+81,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_index),8);
        bufp->chgCData(oldp+82,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte),8);
        bufp->chgCData(oldp+83,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_bits),2);
        bufp->chgCData(oldp+84,(vlSelfRef.test_ppu__DOT__dut__DOT__pixel_value),2);
        bufp->chgCData(oldp+85,(vlSelfRef.test_ppu__DOT__dut__DOT__bg_palette_idx),5);
        bufp->chgCData(oldp+86,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x),5);
        bufp->chgCData(oldp+87,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_y),5);
        bufp->chgSData(oldp+88,(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x),9);
        bufp->chgSData(oldp+89,(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y),9);
        bufp->chgSData(oldp+90,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_addr),10);
        bufp->chgIData(oldp+91,(vlSelfRef.test_ppu__DOT__dut__DOT__nes_color),24);
        bufp->chgCData(oldp+92,(vlSelfRef.test_ppu__DOT__dut__DOT__final_palette_idx),5);
        bufp->chgCData(oldp+93,(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color),8);
        bufp->chgIData(oldp+94,(vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i),32);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[4U]))) {
        bufp->chgBit(oldp+95,(vlSelfRef.test_ppu__DOT__vblank));
        bufp->chgBit(oldp+96,(vlSelfRef.test_ppu__DOT__sprite0_hit));
        bufp->chgBit(oldp+97,(vlSelfRef.test_ppu__DOT__rendering));
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[6U]))) {
        bufp->chgBit(oldp+98,(((0x0118U <= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)) 
                               & (0x0130U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))));
        bufp->chgBit(oldp+99,(((0x00f3U <= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
                               & (0x00f6U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)))));
        bufp->chgBit(oldp+100,(vlSelfRef.test_ppu__DOT__video_de));
        bufp->chgSData(oldp+101,(vlSelfRef.test_ppu__DOT__dut__DOT__scanline),9);
        bufp->chgSData(oldp+102,(vlSelfRef.test_ppu__DOT__dut__DOT__dot),9);
    }
    bufp->chgBit(oldp+103,(vlSelfRef.test_ppu__DOT__clk));
    bufp->chgCData(oldp+104,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                               ? (0x000000ffU & (vlSelfRef.test_ppu__DOT__dut__DOT__nes_color 
                                                 >> 0x00000010U))
                               : 0U)),8);
    bufp->chgCData(oldp+105,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                               ? (0x000000ffU & (vlSelfRef.test_ppu__DOT__dut__DOT__nes_color 
                                                 >> 8U))
                               : 0U)),8);
    bufp->chgCData(oldp+106,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                               ? (0x000000ffU & vlSelfRef.test_ppu__DOT__dut__DOT__nes_color)
                               : 0U)),8);
    bufp->chgCData(oldp+107,(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_lo_reg),8);
    bufp->chgCData(oldp+108,(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_hi_reg),8);
}

void Vtest_ppu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_cleanup\n"); );
    // Body
    Vtest_ppu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_ppu___024root*>(voidSelf);
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
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
