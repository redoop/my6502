// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vcpu_6502__pch.h"

//============================================================
// Constructors

Vcpu_6502::Vcpu_6502(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vcpu_6502__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , data_in{vlSymsp->TOP.data_in}
    , data_out{vlSymsp->TOP.data_out}
    , rw{vlSymsp->TOP.rw}
    , nmi{vlSymsp->TOP.nmi}
    , irq{vlSymsp->TOP.irq}
    , addr{vlSymsp->TOP.addr}
    , pc_out{vlSymsp->TOP.pc_out}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vcpu_6502::Vcpu_6502(const char* _vcname__)
    : Vcpu_6502(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vcpu_6502::~Vcpu_6502() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vcpu_6502___024root___eval_debug_assertions(Vcpu_6502___024root* vlSelf);
#endif  // VL_DEBUG
void Vcpu_6502___024root___eval_static(Vcpu_6502___024root* vlSelf);
void Vcpu_6502___024root___eval_initial(Vcpu_6502___024root* vlSelf);
void Vcpu_6502___024root___eval_settle(Vcpu_6502___024root* vlSelf);
void Vcpu_6502___024root___eval(Vcpu_6502___024root* vlSelf);

void Vcpu_6502::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vcpu_6502::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vcpu_6502___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vcpu_6502___024root___eval_static(&(vlSymsp->TOP));
        Vcpu_6502___024root___eval_initial(&(vlSymsp->TOP));
        Vcpu_6502___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vcpu_6502___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vcpu_6502::eventsPending() { return false; }

uint64_t Vcpu_6502::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vcpu_6502::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vcpu_6502___024root___eval_final(Vcpu_6502___024root* vlSelf);

VL_ATTR_COLD void Vcpu_6502::final() {
    Vcpu_6502___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vcpu_6502::hierName() const { return vlSymsp->name(); }
const char* Vcpu_6502::modelName() const { return "Vcpu_6502"; }
unsigned Vcpu_6502::threads() const { return 1; }
void Vcpu_6502::prepareClone() const { contextp()->prepareClone(); }
void Vcpu_6502::atClone() const {
    contextp()->threadPoolpOnClone();
}
