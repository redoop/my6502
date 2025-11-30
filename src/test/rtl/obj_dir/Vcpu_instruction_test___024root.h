// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vcpu_instruction_test.h for the primary calling header

#ifndef VERILATED_VCPU_INSTRUCTION_TEST___024ROOT_H_
#define VERILATED_VCPU_INSTRUCTION_TEST___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vcpu_instruction_test__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vcpu_instruction_test___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ cpu_instruction_test__DOT__clk;
    CData/*0:0*/ cpu_instruction_test__DOT__rst_n;
    CData/*7:0*/ cpu_instruction_test__DOT__data_in;
    CData/*7:0*/ cpu_instruction_test__DOT__data_out;
    CData/*0:0*/ cpu_instruction_test__DOT__rw;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__A;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__X;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__Y;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__SP;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__C;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__Z;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__I;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__D;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__B;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__V;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__N;
    CData/*2:0*/ cpu_instruction_test__DOT__cpu__DOT__state;
    CData/*2:0*/ cpu_instruction_test__DOT__cpu__DOT__next_state;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__opcode;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__operand;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__alu_result;
    CData/*2:0*/ cpu_instruction_test__DOT__cpu__DOT__cycle_count;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    CData/*2:0*/ cpu_instruction_test__DOT__cpu__DOT__nmi_cycle;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__nmi_pending;
    CData/*0:0*/ cpu_instruction_test__DOT__cpu__DOT__nmi_prev;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi;
    CData/*7:0*/ cpu_instruction_test__DOT__cpu__DOT__temp_result;
    CData/*2:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__opcode;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__D;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__C;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__A;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__Z;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__N;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__X;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__Y;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__V;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__SP;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__I;
    CData/*0:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__B;
    CData/*7:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo;
    CData/*2:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__cpu_instruction_test__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__cpu_instruction_test__DOT__rst_n__0;
    SData/*15:0*/ cpu_instruction_test__DOT__addr;
    SData/*15:0*/ cpu_instruction_test__DOT__cpu__DOT__PC;
    SData/*15:0*/ cpu_instruction_test__DOT__cpu__DOT__ea;
    SData/*8:0*/ cpu_instruction_test__DOT__cpu__DOT__temp_sum;
    SData/*8:0*/ cpu_instruction_test__DOT__cpu__DOT__temp_diff;
    SData/*15:0*/ __Vdly__cpu_instruction_test__DOT__addr;
    SData/*15:0*/ __Vdly__cpu_instruction_test__DOT__cpu__DOT__PC;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 65536> cpu_instruction_test__DOT__mem;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hafe93069__0;

    // INTERNAL VARIABLES
    Vcpu_instruction_test__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vcpu_instruction_test___024root(Vcpu_instruction_test__Syms* symsp, const char* v__name);
    ~Vcpu_instruction_test___024root();
    VL_UNCOPYABLE(Vcpu_instruction_test___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
