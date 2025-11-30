// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vnmi_test.h for the primary calling header

#include "Vnmi_test__pch.h"

void Vnmi_test___024root___ctor_var_reset(Vnmi_test___024root* vlSelf);

Vnmi_test___024root::Vnmi_test___024root(Vnmi_test__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vnmi_test___024root___ctor_var_reset(this);
}

void Vnmi_test___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vnmi_test___024root::~Vnmi_test___024root() {
}
