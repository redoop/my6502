// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtest_ppu__Syms.h"


VL_ATTR_COLD void Vtest_ppu___024root__trace_init_sub__TOP__0(Vtest_ppu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_init_sub__TOP__0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("test_ppu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+104,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"rst_n",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+2,0,"ppuctrl",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+3,0,"ppumask",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+4,0,"ppuscroll_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+5,0,"ppuscroll_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+6,0,"ppuaddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("palette", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+7+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+110,0,"chr_rom_data",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+74,0,"chr_rom_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 13,0);
    tracep->declBus(c+105,0,"video_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+106,0,"video_g",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+107,0,"video_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+99,0,"video_hsync",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+100,0,"video_vsync",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+101,0,"video_de",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+96,0,"vblank",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+97,0,"sprite0_hit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+98,0,"rendering",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+104,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"rst_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+2,0,"ppuctrl",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+3,0,"ppumask",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+4,0,"ppuscroll_x",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+5,0,"ppuscroll_y",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+6,0,"ppuaddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("palette", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+42+i*1,0,"",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, true,(i+0), 7,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+110,0,"chr_rom_data",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+74,0,"chr_rom_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 13,0);
    tracep->declBus(c+105,0,"video_r",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+106,0,"video_g",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+107,0,"video_b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+99,0,"video_hsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+100,0,"video_vsync",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+101,0,"video_de",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+96,0,"vblank",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+97,0,"sprite0_hit",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+98,0,"rendering",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+102,0,"scanline",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+103,0,"dot",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+108,0,"pattern_lo_reg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+109,0,"pattern_hi_reg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+75,0,"sprite_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+76,0,"sprite_tile",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+77,0,"sprite_attr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+78,0,"sprite_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+79,0,"sprite_pixel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+80,0,"sprite_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+81,0,"sprite_active",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+82,0,"tile_index",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+83,0,"attr_byte",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+84,0,"attr_bits",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+85,0,"pixel_value",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+86,0,"bg_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+87,0,"tile_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+88,0,"tile_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+89,0,"scroll_x",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+90,0,"scroll_y",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBus(c+91,0,"attr_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+92,0,"nes_color",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 23,0);
    tracep->declBus(c+93,0,"final_palette_idx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+94,0,"palette_color",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+95,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+39,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk2", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+40,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk3", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+41,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_init_top(Vtest_ppu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_init_top\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vtest_ppu___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vtest_ppu___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtest_ppu___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtest_ppu___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vtest_ppu___024root__trace_register(Vtest_ppu___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_register\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vtest_ppu___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&Vtest_ppu___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&Vtest_ppu___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&Vtest_ppu___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_const_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtest_ppu___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_const_0\n"); );
    // Body
    Vtest_ppu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_ppu___024root*>(voidSelf);
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vtest_ppu___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_const_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_const_0_sub_0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullCData(oldp+110,(0xaaU),8);
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_full_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtest_ppu___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_full_0\n"); );
    // Body
    Vtest_ppu___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtest_ppu___024root*>(voidSelf);
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vtest_ppu___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtest_ppu___024root__trace_full_0_sub_0(Vtest_ppu___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_ppu___024root__trace_full_0_sub_0\n"); );
    Vtest_ppu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullBit(oldp+1,(vlSelfRef.test_ppu__DOT__rst_n));
    bufp->fullCData(oldp+2,(vlSelfRef.test_ppu__DOT__ppuctrl),8);
    bufp->fullCData(oldp+3,(vlSelfRef.test_ppu__DOT__ppumask),8);
    bufp->fullCData(oldp+4,(vlSelfRef.test_ppu__DOT__ppuscroll_x),8);
    bufp->fullCData(oldp+5,(vlSelfRef.test_ppu__DOT__ppuscroll_y),8);
    bufp->fullSData(oldp+6,(vlSelfRef.test_ppu__DOT__ppuaddr),16);
    bufp->fullCData(oldp+7,(vlSelfRef.test_ppu__DOT__palette[0]),8);
    bufp->fullCData(oldp+8,(vlSelfRef.test_ppu__DOT__palette[1]),8);
    bufp->fullCData(oldp+9,(vlSelfRef.test_ppu__DOT__palette[2]),8);
    bufp->fullCData(oldp+10,(vlSelfRef.test_ppu__DOT__palette[3]),8);
    bufp->fullCData(oldp+11,(vlSelfRef.test_ppu__DOT__palette[4]),8);
    bufp->fullCData(oldp+12,(vlSelfRef.test_ppu__DOT__palette[5]),8);
    bufp->fullCData(oldp+13,(vlSelfRef.test_ppu__DOT__palette[6]),8);
    bufp->fullCData(oldp+14,(vlSelfRef.test_ppu__DOT__palette[7]),8);
    bufp->fullCData(oldp+15,(vlSelfRef.test_ppu__DOT__palette[8]),8);
    bufp->fullCData(oldp+16,(vlSelfRef.test_ppu__DOT__palette[9]),8);
    bufp->fullCData(oldp+17,(vlSelfRef.test_ppu__DOT__palette[10]),8);
    bufp->fullCData(oldp+18,(vlSelfRef.test_ppu__DOT__palette[11]),8);
    bufp->fullCData(oldp+19,(vlSelfRef.test_ppu__DOT__palette[12]),8);
    bufp->fullCData(oldp+20,(vlSelfRef.test_ppu__DOT__palette[13]),8);
    bufp->fullCData(oldp+21,(vlSelfRef.test_ppu__DOT__palette[14]),8);
    bufp->fullCData(oldp+22,(vlSelfRef.test_ppu__DOT__palette[15]),8);
    bufp->fullCData(oldp+23,(vlSelfRef.test_ppu__DOT__palette[16]),8);
    bufp->fullCData(oldp+24,(vlSelfRef.test_ppu__DOT__palette[17]),8);
    bufp->fullCData(oldp+25,(vlSelfRef.test_ppu__DOT__palette[18]),8);
    bufp->fullCData(oldp+26,(vlSelfRef.test_ppu__DOT__palette[19]),8);
    bufp->fullCData(oldp+27,(vlSelfRef.test_ppu__DOT__palette[20]),8);
    bufp->fullCData(oldp+28,(vlSelfRef.test_ppu__DOT__palette[21]),8);
    bufp->fullCData(oldp+29,(vlSelfRef.test_ppu__DOT__palette[22]),8);
    bufp->fullCData(oldp+30,(vlSelfRef.test_ppu__DOT__palette[23]),8);
    bufp->fullCData(oldp+31,(vlSelfRef.test_ppu__DOT__palette[24]),8);
    bufp->fullCData(oldp+32,(vlSelfRef.test_ppu__DOT__palette[25]),8);
    bufp->fullCData(oldp+33,(vlSelfRef.test_ppu__DOT__palette[26]),8);
    bufp->fullCData(oldp+34,(vlSelfRef.test_ppu__DOT__palette[27]),8);
    bufp->fullCData(oldp+35,(vlSelfRef.test_ppu__DOT__palette[28]),8);
    bufp->fullCData(oldp+36,(vlSelfRef.test_ppu__DOT__palette[29]),8);
    bufp->fullCData(oldp+37,(vlSelfRef.test_ppu__DOT__palette[30]),8);
    bufp->fullCData(oldp+38,(vlSelfRef.test_ppu__DOT__palette[31]),8);
    bufp->fullIData(oldp+39,(vlSelfRef.test_ppu__DOT__unnamedblk1__DOT__i),32);
    bufp->fullIData(oldp+40,(vlSelfRef.test_ppu__DOT__unnamedblk2__DOT__i),32);
    bufp->fullIData(oldp+41,(vlSelfRef.test_ppu__DOT__unnamedblk3__DOT__i),32);
    bufp->fullCData(oldp+42,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[0]),8);
    bufp->fullCData(oldp+43,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[1]),8);
    bufp->fullCData(oldp+44,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[2]),8);
    bufp->fullCData(oldp+45,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[3]),8);
    bufp->fullCData(oldp+46,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[4]),8);
    bufp->fullCData(oldp+47,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[5]),8);
    bufp->fullCData(oldp+48,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[6]),8);
    bufp->fullCData(oldp+49,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[7]),8);
    bufp->fullCData(oldp+50,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[8]),8);
    bufp->fullCData(oldp+51,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[9]),8);
    bufp->fullCData(oldp+52,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[10]),8);
    bufp->fullCData(oldp+53,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[11]),8);
    bufp->fullCData(oldp+54,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[12]),8);
    bufp->fullCData(oldp+55,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[13]),8);
    bufp->fullCData(oldp+56,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[14]),8);
    bufp->fullCData(oldp+57,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[15]),8);
    bufp->fullCData(oldp+58,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[16]),8);
    bufp->fullCData(oldp+59,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[17]),8);
    bufp->fullCData(oldp+60,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[18]),8);
    bufp->fullCData(oldp+61,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[19]),8);
    bufp->fullCData(oldp+62,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[20]),8);
    bufp->fullCData(oldp+63,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[21]),8);
    bufp->fullCData(oldp+64,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[22]),8);
    bufp->fullCData(oldp+65,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[23]),8);
    bufp->fullCData(oldp+66,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[24]),8);
    bufp->fullCData(oldp+67,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[25]),8);
    bufp->fullCData(oldp+68,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[26]),8);
    bufp->fullCData(oldp+69,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[27]),8);
    bufp->fullCData(oldp+70,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[28]),8);
    bufp->fullCData(oldp+71,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[29]),8);
    bufp->fullCData(oldp+72,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[30]),8);
    bufp->fullCData(oldp+73,(vlSelfRef.test_ppu__DOT__dut__DOT__palette[31]),8);
    bufp->fullSData(oldp+74,(vlSelfRef.test_ppu__DOT__chr_rom_addr),14);
    bufp->fullCData(oldp+75,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_y),8);
    bufp->fullCData(oldp+76,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_tile),8);
    bufp->fullCData(oldp+77,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_attr),8);
    bufp->fullCData(oldp+78,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_x),8);
    bufp->fullCData(oldp+79,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_pixel),2);
    bufp->fullCData(oldp+80,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_palette_idx),5);
    bufp->fullBit(oldp+81,(vlSelfRef.test_ppu__DOT__dut__DOT__sprite_active));
    bufp->fullCData(oldp+82,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_index),8);
    bufp->fullCData(oldp+83,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_byte),8);
    bufp->fullCData(oldp+84,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_bits),2);
    bufp->fullCData(oldp+85,(vlSelfRef.test_ppu__DOT__dut__DOT__pixel_value),2);
    bufp->fullCData(oldp+86,(vlSelfRef.test_ppu__DOT__dut__DOT__bg_palette_idx),5);
    bufp->fullCData(oldp+87,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_x),5);
    bufp->fullCData(oldp+88,(vlSelfRef.test_ppu__DOT__dut__DOT__tile_y),5);
    bufp->fullSData(oldp+89,(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_x),9);
    bufp->fullSData(oldp+90,(vlSelfRef.test_ppu__DOT__dut__DOT__scroll_y),9);
    bufp->fullSData(oldp+91,(vlSelfRef.test_ppu__DOT__dut__DOT__attr_addr),10);
    bufp->fullIData(oldp+92,(vlSelfRef.test_ppu__DOT__dut__DOT__nes_color),24);
    bufp->fullCData(oldp+93,(vlSelfRef.test_ppu__DOT__dut__DOT__final_palette_idx),5);
    bufp->fullCData(oldp+94,(vlSelfRef.test_ppu__DOT__dut__DOT__palette_color),8);
    bufp->fullIData(oldp+95,(vlSelfRef.test_ppu__DOT__dut__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+96,(vlSelfRef.test_ppu__DOT__vblank));
    bufp->fullBit(oldp+97,(vlSelfRef.test_ppu__DOT__sprite0_hit));
    bufp->fullBit(oldp+98,(vlSelfRef.test_ppu__DOT__rendering));
    bufp->fullBit(oldp+99,(((0x0118U <= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)) 
                            & (0x0130U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__dot)))));
    bufp->fullBit(oldp+100,(((0x00f3U <= (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)) 
                             & (0x00f6U > (IData)(vlSelfRef.test_ppu__DOT__dut__DOT__scanline)))));
    bufp->fullBit(oldp+101,(vlSelfRef.test_ppu__DOT__video_de));
    bufp->fullSData(oldp+102,(vlSelfRef.test_ppu__DOT__dut__DOT__scanline),9);
    bufp->fullSData(oldp+103,(vlSelfRef.test_ppu__DOT__dut__DOT__dot),9);
    bufp->fullBit(oldp+104,(vlSelfRef.test_ppu__DOT__clk));
    bufp->fullCData(oldp+105,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                                ? (0x000000ffU & (vlSelfRef.test_ppu__DOT__dut__DOT__nes_color 
                                                  >> 0x00000010U))
                                : 0U)),8);
    bufp->fullCData(oldp+106,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                                ? (0x000000ffU & (vlSelfRef.test_ppu__DOT__dut__DOT__nes_color 
                                                  >> 8U))
                                : 0U)),8);
    bufp->fullCData(oldp+107,(((IData)(vlSelfRef.test_ppu__DOT__video_de)
                                ? (0x000000ffU & vlSelfRef.test_ppu__DOT__dut__DOT__nes_color)
                                : 0U)),8);
    bufp->fullCData(oldp+108,(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_lo_reg),8);
    bufp->fullCData(oldp+109,(vlSelfRef.test_ppu__DOT__dut__DOT__pattern_hi_reg),8);
}
