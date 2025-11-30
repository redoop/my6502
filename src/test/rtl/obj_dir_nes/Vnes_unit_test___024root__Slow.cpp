// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnes_unit_test.h for the primary calling header

#include "Vnes_unit_test__pch.h"

void Vnes_unit_test___024root___ctor_var_reset(Vnes_unit_test___024root* vlSelf);

Vnes_unit_test___024root::Vnes_unit_test___024root(Vnes_unit_test__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vnes_unit_test___024root___ctor_var_reset(this);
}

void Vnes_unit_test___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vnes_unit_test___024root::~Vnes_unit_test___024root() {
}
