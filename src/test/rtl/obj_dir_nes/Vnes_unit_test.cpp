// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vnes_unit_test__pch.h"

//============================================================
// Constructors

Vnes_unit_test::Vnes_unit_test(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vnes_unit_test__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vnes_unit_test::Vnes_unit_test(const char* _vcname__)
    : Vnes_unit_test(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vnes_unit_test::~Vnes_unit_test() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vnes_unit_test___024root___eval_debug_assertions(Vnes_unit_test___024root* vlSelf);
#endif  // VL_DEBUG
void Vnes_unit_test___024root___eval_static(Vnes_unit_test___024root* vlSelf);
void Vnes_unit_test___024root___eval_initial(Vnes_unit_test___024root* vlSelf);
void Vnes_unit_test___024root___eval_settle(Vnes_unit_test___024root* vlSelf);
void Vnes_unit_test___024root___eval(Vnes_unit_test___024root* vlSelf);

void Vnes_unit_test::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vnes_unit_test::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vnes_unit_test___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vnes_unit_test___024root___eval_static(&(vlSymsp->TOP));
        Vnes_unit_test___024root___eval_initial(&(vlSymsp->TOP));
        Vnes_unit_test___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vnes_unit_test___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vnes_unit_test::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vnes_unit_test::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vnes_unit_test::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vnes_unit_test___024root___eval_final(Vnes_unit_test___024root* vlSelf);

VL_ATTR_COLD void Vnes_unit_test::final() {
    Vnes_unit_test___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vnes_unit_test::hierName() const { return vlSymsp->name(); }
const char* Vnes_unit_test::modelName() const { return "Vnes_unit_test"; }
unsigned Vnes_unit_test::threads() const { return 1; }
void Vnes_unit_test::prepareClone() const { contextp()->prepareClone(); }
void Vnes_unit_test::atClone() const {
    contextp()->threadPoolpOnClone();
}
