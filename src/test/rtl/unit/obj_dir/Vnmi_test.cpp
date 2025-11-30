// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vnmi_test__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vnmi_test::Vnmi_test(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vnmi_test__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
    contextp()->traceBaseModelCbAdd(
        [this](VerilatedTraceBaseC* tfp, int levels, int options) { traceBaseModel(tfp, levels, options); });
}

Vnmi_test::Vnmi_test(const char* _vcname__)
    : Vnmi_test(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vnmi_test::~Vnmi_test() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vnmi_test___024root___eval_debug_assertions(Vnmi_test___024root* vlSelf);
#endif  // VL_DEBUG
void Vnmi_test___024root___eval_static(Vnmi_test___024root* vlSelf);
void Vnmi_test___024root___eval_initial(Vnmi_test___024root* vlSelf);
void Vnmi_test___024root___eval_settle(Vnmi_test___024root* vlSelf);
void Vnmi_test___024root___eval(Vnmi_test___024root* vlSelf);

void Vnmi_test::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vnmi_test::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vnmi_test___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vnmi_test___024root___eval_static(&(vlSymsp->TOP));
        Vnmi_test___024root___eval_initial(&(vlSymsp->TOP));
        Vnmi_test___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vnmi_test___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

void Vnmi_test::eval_end_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+eval_end_step Vnmi_test::eval_end_step\n"); );
#ifdef VM_TRACE
    // Tracing
    if (VL_UNLIKELY(vlSymsp->__Vm_dumping)) vlSymsp->_traceDump();
#endif  // VM_TRACE
}

//============================================================
// Events and timing
bool Vnmi_test::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vnmi_test::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vnmi_test::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vnmi_test___024root___eval_final(Vnmi_test___024root* vlSelf);

VL_ATTR_COLD void Vnmi_test::final() {
    Vnmi_test___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vnmi_test::hierName() const { return vlSymsp->name(); }
const char* Vnmi_test::modelName() const { return "Vnmi_test"; }
unsigned Vnmi_test::threads() const { return 1; }
void Vnmi_test::prepareClone() const { contextp()->prepareClone(); }
void Vnmi_test::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vnmi_test::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vnmi_test___024root__trace_decl_types(VerilatedVcd* tracep);

void Vnmi_test___024root__trace_init_top(Vnmi_test___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vnmi_test___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vnmi_test___024root*>(voidSelf);
    Vnmi_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    Vnmi_test___024root__trace_decl_types(tracep);
    Vnmi_test___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vnmi_test___024root__trace_register(Vnmi_test___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vnmi_test::traceBaseModel(VerilatedTraceBaseC* tfp, int levels, int options) {
    (void)levels; (void)options;
    VerilatedVcdC* const stfp = dynamic_cast<VerilatedVcdC*>(tfp);
    if (VL_UNLIKELY(!stfp)) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vnmi_test::trace()' called on non-VerilatedVcdC object;"
            " use --trace-fst with VerilatedFst object, and --trace-vcd with VerilatedVcd object");
    }
    stfp->spTrace()->addModel(this);
    stfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vnmi_test___024root__trace_register(&(vlSymsp->TOP), stfp->spTrace());
}
