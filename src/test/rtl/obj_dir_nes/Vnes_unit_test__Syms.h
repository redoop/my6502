// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VNES_UNIT_TEST__SYMS_H_
#define VERILATED_VNES_UNIT_TEST__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vnes_unit_test.h"

// INCLUDE MODULE CLASSES
#include "Vnes_unit_test___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vnes_unit_test__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vnes_unit_test* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vnes_unit_test___024root       TOP;

    // CONSTRUCTORS
    Vnes_unit_test__Syms(VerilatedContext* contextp, const char* namep, Vnes_unit_test* modelp);
    ~Vnes_unit_test__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
