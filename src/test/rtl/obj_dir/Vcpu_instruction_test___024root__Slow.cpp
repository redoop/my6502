// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vcpu_instruction_test.h for the primary calling header

#include "Vcpu_instruction_test__pch.h"

void Vcpu_instruction_test___024root___ctor_var_reset(Vcpu_instruction_test___024root* vlSelf);

Vcpu_instruction_test___024root::Vcpu_instruction_test___024root(Vcpu_instruction_test__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vcpu_instruction_test___024root___ctor_var_reset(this);
}

void Vcpu_instruction_test___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vcpu_instruction_test___024root::~Vcpu_instruction_test___024root() {
}
