// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_ppu.h for the primary calling header

#include "Vtest_ppu__pch.h"

void Vtest_ppu___024root___ctor_var_reset(Vtest_ppu___024root* vlSelf);

Vtest_ppu___024root::Vtest_ppu___024root(Vtest_ppu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtest_ppu___024root___ctor_var_reset(this);
}

void Vtest_ppu___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtest_ppu___024root::~Vtest_ppu___024root() {
}
