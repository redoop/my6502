// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vcpu_instruction_test__pch.h"
#include "Vcpu_instruction_test.h"
#include "Vcpu_instruction_test___024root.h"

// FUNCTIONS
Vcpu_instruction_test__Syms::~Vcpu_instruction_test__Syms()
{
}

Vcpu_instruction_test__Syms::Vcpu_instruction_test__Syms(VerilatedContext* contextp, const char* namep, Vcpu_instruction_test* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
    // Check resources
    Verilated::stackCheck(602);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
