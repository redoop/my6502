// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_apu.h for the primary calling header

#include "Vtest_apu__pch.h"

void Vtest_apu___024root___ctor_var_reset(Vtest_apu___024root* vlSelf);

Vtest_apu___024root::Vtest_apu___024root(Vtest_apu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtest_apu___024root___ctor_var_reset(this);
}

void Vtest_apu___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtest_apu___024root::~Vtest_apu___024root() {
}
