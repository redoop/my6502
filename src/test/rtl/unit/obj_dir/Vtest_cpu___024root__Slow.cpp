// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_cpu.h for the primary calling header

#include "Vtest_cpu__pch.h"

void Vtest_cpu___024root___ctor_var_reset(Vtest_cpu___024root* vlSelf);

Vtest_cpu___024root::Vtest_cpu___024root(Vtest_cpu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vtest_cpu___024root___ctor_var_reset(this);
}

void Vtest_cpu___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vtest_cpu___024root::~Vtest_cpu___024root() {
}
