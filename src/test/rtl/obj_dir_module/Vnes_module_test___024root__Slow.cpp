// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnes_module_test.h for the primary calling header

#include "Vnes_module_test__pch.h"

void Vnes_module_test___024root___ctor_var_reset(Vnes_module_test___024root* vlSelf);

Vnes_module_test___024root::Vnes_module_test___024root(Vnes_module_test__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vnes_module_test___024root___ctor_var_reset(this);
}

void Vnes_module_test___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vnes_module_test___024root::~Vnes_module_test___024root() {
}
