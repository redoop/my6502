// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vcpu_instruction_test__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vcpu_instruction_test::Vcpu_instruction_test(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vcpu_instruction_test__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
    contextp()->traceBaseModelCbAdd(
        [this](VerilatedTraceBaseC* tfp, int levels, int options) { traceBaseModel(tfp, levels, options); });
}

Vcpu_instruction_test::Vcpu_instruction_test(const char* _vcname__)
    : Vcpu_instruction_test(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vcpu_instruction_test::~Vcpu_instruction_test() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vcpu_instruction_test___024root___eval_debug_assertions(Vcpu_instruction_test___024root* vlSelf);
#endif  // VL_DEBUG
void Vcpu_instruction_test___024root___eval_static(Vcpu_instruction_test___024root* vlSelf);
void Vcpu_instruction_test___024root___eval_initial(Vcpu_instruction_test___024root* vlSelf);
void Vcpu_instruction_test___024root___eval_settle(Vcpu_instruction_test___024root* vlSelf);
void Vcpu_instruction_test___024root___eval(Vcpu_instruction_test___024root* vlSelf);

void Vcpu_instruction_test::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vcpu_instruction_test::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vcpu_instruction_test___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vcpu_instruction_test___024root___eval_static(&(vlSymsp->TOP));
        Vcpu_instruction_test___024root___eval_initial(&(vlSymsp->TOP));
        Vcpu_instruction_test___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vcpu_instruction_test___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vcpu_instruction_test::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vcpu_instruction_test::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vcpu_instruction_test::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vcpu_instruction_test___024root___eval_final(Vcpu_instruction_test___024root* vlSelf);

VL_ATTR_COLD void Vcpu_instruction_test::final() {
    Vcpu_instruction_test___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vcpu_instruction_test::hierName() const { return vlSymsp->name(); }
const char* Vcpu_instruction_test::modelName() const { return "Vcpu_instruction_test"; }
unsigned Vcpu_instruction_test::threads() const { return 1; }
void Vcpu_instruction_test::prepareClone() const { contextp()->prepareClone(); }
void Vcpu_instruction_test::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vcpu_instruction_test::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vcpu_instruction_test___024root__trace_decl_types(VerilatedVcd* tracep);

void Vcpu_instruction_test___024root__trace_init_top(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vcpu_instruction_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vcpu_instruction_test___024root*>(voidSelf);
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    Vcpu_instruction_test___024root__trace_decl_types(tracep);
    Vcpu_instruction_test___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vcpu_instruction_test___024root__trace_register(Vcpu_instruction_test___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vcpu_instruction_test::traceBaseModel(VerilatedTraceBaseC* tfp, int levels, int options) {
    (void)levels; (void)options;
    VerilatedVcdC* const stfp = dynamic_cast<VerilatedVcdC*>(tfp);
    if (VL_UNLIKELY(!stfp)) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vcpu_instruction_test::trace()' called on non-VerilatedVcdC object;"
            " use --trace-fst with VerilatedFst object, and --trace-vcd with VerilatedVcd object");
    }
    stfp->spTrace()->addModel(this);
    stfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vcpu_instruction_test___024root__trace_register(&(vlSymsp->TOP), stfp->spTrace());
}
