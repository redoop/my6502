// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtest_cpu.h for the primary calling header

#ifndef VERILATED_VTEST_CPU___024ROOT_H_
#define VERILATED_VTEST_CPU___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vtest_cpu__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtest_cpu___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ test_cpu__DOT__clk;
        CData/*0:0*/ test_cpu__DOT__rst_n;
        CData/*7:0*/ test_cpu__DOT__data_in;
        CData/*7:0*/ test_cpu__DOT__data_out;
        CData/*0:0*/ test_cpu__DOT__rw;
        CData/*0:0*/ test_cpu__DOT__nmi;
        CData/*0:0*/ test_cpu__DOT__irq;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__A;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__X;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__Y;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__SP;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__C;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__Z;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__I;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__D;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__B;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__V;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__N;
        CData/*2:0*/ test_cpu__DOT__dut__DOT__state;
        CData/*2:0*/ test_cpu__DOT__dut__DOT__next_state;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__opcode;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__operand;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__alu_result;
        CData/*2:0*/ test_cpu__DOT__dut__DOT__cycle_count;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__reset_vector__BRA__15__03a8__KET__;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*2:0*/ test_cpu__DOT__dut__DOT__nmi_cycle;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__nmi_pending;
        CData/*0:0*/ test_cpu__DOT__dut__DOT__nmi_prev;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__indirect_addr_lo;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__indirect_addr_hi;
        CData/*7:0*/ test_cpu__DOT__dut__DOT__temp_result;
        CData/*2:0*/ __Vdly__test_cpu__DOT__dut__DOT__cycle_count;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__opcode;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__D;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__C;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__A;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__Z;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__N;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__X;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__Y;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__V;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__SP;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__I;
        CData/*0:0*/ __Vdly__test_cpu__DOT__dut__DOT__B;
        CData/*7:0*/ __Vdly__test_cpu__DOT__dut__DOT__indirect_addr_lo;
        CData/*2:0*/ __Vdly__test_cpu__DOT__dut__DOT__nmi_cycle;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__test_cpu__DOT__clk__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__test_cpu__DOT__rst_n__0;
        SData/*15:0*/ test_cpu__DOT__addr;
        SData/*15:0*/ test_cpu__DOT__dut__DOT__PC;
        SData/*15:0*/ test_cpu__DOT__dut__DOT__ea;
        SData/*8:0*/ test_cpu__DOT__dut__DOT__temp_sum;
        SData/*8:0*/ test_cpu__DOT__dut__DOT__temp_diff;
        SData/*15:0*/ __Vdly__test_cpu__DOT__addr;
        SData/*15:0*/ __Vdly__test_cpu__DOT__dut__DOT__PC;
        IData/*31:0*/ test_cpu__DOT__unnamedblk1__DOT__i;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*7:0*/, 65536> test_cpu__DOT__mem;
        VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
        VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    };
    struct {
        VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    };
    VlDelayScheduler __VdlySched;

    // INTERNAL VARIABLES
    Vtest_cpu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtest_cpu___024root(Vtest_cpu__Syms* symsp, const char* v__name);
    ~Vtest_cpu___024root();
    VL_UNCOPYABLE(Vtest_cpu___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
