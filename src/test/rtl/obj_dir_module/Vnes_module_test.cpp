// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vnes_module_test__pch.h"

//============================================================
// Constructors

Vnes_module_test::Vnes_module_test(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vnes_module_test__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vnes_module_test::Vnes_module_test(const char* _vcname__)
    : Vnes_module_test(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vnes_module_test::~Vnes_module_test() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vnes_module_test___024root___eval_debug_assertions(Vnes_module_test___024root* vlSelf);
#endif  // VL_DEBUG
void Vnes_module_test___024root___eval_static(Vnes_module_test___024root* vlSelf);
void Vnes_module_test___024root___eval_initial(Vnes_module_test___024root* vlSelf);
void Vnes_module_test___024root___eval_settle(Vnes_module_test___024root* vlSelf);
void Vnes_module_test___024root___eval(Vnes_module_test___024root* vlSelf);

void Vnes_module_test::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vnes_module_test::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vnes_module_test___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vnes_module_test___024root___eval_static(&(vlSymsp->TOP));
        Vnes_module_test___024root___eval_initial(&(vlSymsp->TOP));
        Vnes_module_test___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vnes_module_test___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vnes_module_test::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vnes_module_test::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vnes_module_test::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vnes_module_test___024root___eval_final(Vnes_module_test___024root* vlSelf);

VL_ATTR_COLD void Vnes_module_test::final() {
    Vnes_module_test___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vnes_module_test::hierName() const { return vlSymsp->name(); }
const char* Vnes_module_test::modelName() const { return "Vnes_module_test"; }
unsigned Vnes_module_test::threads() const { return 1; }
void Vnes_module_test::prepareClone() const { contextp()->prepareClone(); }
void Vnes_module_test::atClone() const {
    contextp()->threadPoolpOnClone();
}
