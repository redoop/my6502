// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_dma.h for the primary calling header

#include "Vtest_dma__pch.h"

void Vtest_dma___024root___ctor_var_reset(Vtest_dma___024root* vlSelf);

Vtest_dma___024root::Vtest_dma___024root(Vtest_dma__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtest_dma___024root___ctor_var_reset(this);
}

void Vtest_dma___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtest_dma___024root::~Vtest_dma___024root() {
}
