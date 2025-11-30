// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vcpu_instruction_test.h for the primary calling header

#include "Vcpu_instruction_test__pch.h"

VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__0(Vcpu_instruction_test___024root* vlSelf);
VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__1(Vcpu_instruction_test___024root* vlSelf);
VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__2(Vcpu_instruction_test___024root* vlSelf);

void Vcpu_instruction_test___024root___eval_initial(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_initial\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__2(vlSelf);
}

VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__0(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk2__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk2__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk3__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk3__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk4__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk4__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk5__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk5__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk6__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk6__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk7__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk7__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk8__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk8__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk9__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk9__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk10__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk10__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> cpu_instruction_test__DOT__unnamedblk11__DOT__prog;
    cpu_instruction_test__DOT__unnamedblk11__DOT__prog.atDefault() = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__0__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__0__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__0__size;
    __Vtask_cpu_instruction_test__DOT__load_program__0__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__0__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__0__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__2__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__2__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__3__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__3__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__3__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__3__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__3__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__4__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__4__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__4__size;
    __Vtask_cpu_instruction_test__DOT__load_program__4__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__4__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__4__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__6__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__6__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__7__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__7__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__7__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__7__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__7__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__8__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__8__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__8__size;
    __Vtask_cpu_instruction_test__DOT__load_program__8__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__8__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__8__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__10__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__10__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__11__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__11__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__11__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__11__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__11__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__12__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__12__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__12__size;
    __Vtask_cpu_instruction_test__DOT__load_program__12__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__12__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__12__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__14__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__14__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__15__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__15__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__15__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__15__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__15__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__16__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__16__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__16__size;
    __Vtask_cpu_instruction_test__DOT__load_program__16__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__16__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__16__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__18__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__18__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__19__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__19__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__19__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__19__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__19__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__20__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__20__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__20__size;
    __Vtask_cpu_instruction_test__DOT__load_program__20__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__20__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__20__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__22__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__22__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__23__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__23__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__23__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__23__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__23__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__24__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__24__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__24__size;
    __Vtask_cpu_instruction_test__DOT__load_program__24__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__24__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__24__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__26__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__26__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__27__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__27__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__27__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__27__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__27__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__28__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__28__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__28__size;
    __Vtask_cpu_instruction_test__DOT__load_program__28__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__28__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__28__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__30__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__30__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__31__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__31__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__31__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__31__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__31__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__32__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__32__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__32__size;
    __Vtask_cpu_instruction_test__DOT__load_program__32__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__32__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__32__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__34__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__34__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__35__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__35__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__35__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__35__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__35__actual = 0;
    VlQueue<CData/*7:0*/> __Vtask_cpu_instruction_test__DOT__load_program__36__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__36__prog.atDefault() = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__36__size;
    __Vtask_cpu_instruction_test__DOT__load_program__36__size = 0;
    SData/*15:0*/ __Vtask_cpu_instruction_test__DOT__load_program__36__start_addr;
    __Vtask_cpu_instruction_test__DOT__load_program__36__start_addr = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i;
    __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__38__n;
    __Vtask_cpu_instruction_test__DOT__run_cycles__38__n = 0;
    IData/*31:0*/ __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2;
    __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    std::string __Vtask_cpu_instruction_test__DOT__check_register__39__name;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__39__expected;
    __Vtask_cpu_instruction_test__DOT__check_register__39__expected = 0;
    CData/*7:0*/ __Vtask_cpu_instruction_test__DOT__check_register__39__actual;
    __Vtask_cpu_instruction_test__DOT__check_register__39__actual = 0;
    // Body
    VL_WRITEF_NX("=== CPU 6502 Instruction Tests ===\n\n",0);
    cpu_instruction_test__DOT__unnamedblk2__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0x42U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})));
    VL_WRITEF_NX("Test 1: LDA #$42\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__0__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__0__size = 3U;
    __Vtask_cpu_instruction_test__DOT__load_program__0__prog 
        = cpu_instruction_test__DOT__unnamedblk2__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__0__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__0__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__0__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__0__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__0__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__0__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__1__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__2__n = 0x00000014U;
    __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__2__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__2__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__3__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__3__expected = 0x42U;
    __Vtask_cpu_instruction_test__DOT__check_register__3__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__3__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__3__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__3__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__3__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__3__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk3__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0x10U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0xa5U, 
                                                                                VlQueue<CData/*7:0*/>{})));
    VL_WRITEF_NX("Test 2: LDA $10\n",0);
    vlSelfRef.cpu_instruction_test__DOT__mem[0x0010U] = 0x55U;
    __Vtask_cpu_instruction_test__DOT__load_program__4__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__4__size = 3U;
    __Vtask_cpu_instruction_test__DOT__load_program__4__prog 
        = cpu_instruction_test__DOT__unnamedblk3__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__4__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__4__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__4__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__4__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__4__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__4__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__5__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__6__n = 0x00000014U;
    __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__6__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__6__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__7__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__7__expected = 0x55U;
    __Vtask_cpu_instruction_test__DOT__check_register__7__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__7__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__7__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__7__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__7__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__7__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk4__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0x20U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0x85U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0x33U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})))));
    VL_WRITEF_NX("Test 3: STA $20\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__8__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__8__size = 5U;
    __Vtask_cpu_instruction_test__DOT__load_program__8__prog 
        = cpu_instruction_test__DOT__unnamedblk4__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__8__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__8__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__8__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__8__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__8__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__8__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__9__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__10__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__10__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__10__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__11__actual 
        = vlSelfRef.cpu_instruction_test__DOT__mem[0x0020U];
    __Vtask_cpu_instruction_test__DOT__check_register__11__expected = 0x33U;
    __Vtask_cpu_instruction_test__DOT__check_register__11__name = "MEM[$20]"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__11__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__11__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__11__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__11__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__11__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk5__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(5U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0x69U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0x10U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})))));
    VL_WRITEF_NX("Test 4: ADC #$05\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__12__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__12__size = 5U;
    __Vtask_cpu_instruction_test__DOT__load_program__12__prog 
        = cpu_instruction_test__DOT__unnamedblk5__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__12__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__12__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__12__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__12__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__12__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__12__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__13__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__14__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__14__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__14__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__15__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__15__expected = 0x15U;
    __Vtask_cpu_instruction_test__DOT__check_register__15__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__15__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__15__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__15__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__15__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__15__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk6__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(8U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0xe9U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0x20U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0x38U, 
                                                                                VlQueue<CData/*7:0*/>{}))))));
    VL_WRITEF_NX("Test 5: SBC #$08\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__16__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__16__size = 6U;
    __Vtask_cpu_instruction_test__DOT__load_program__16__prog 
        = cpu_instruction_test__DOT__unnamedblk6__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__16__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__16__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__16__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__16__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__16__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__16__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__17__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__18__n = 0x00000028U;
    __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__18__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__18__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__19__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__19__expected = 0x18U;
    __Vtask_cpu_instruction_test__DOT__check_register__19__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__19__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__19__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__19__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__19__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__19__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk7__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0x0fU, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0x29U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xffU, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})))));
    VL_WRITEF_NX("Test 6: AND #$0F\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__20__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__20__size = 5U;
    __Vtask_cpu_instruction_test__DOT__load_program__20__prog 
        = cpu_instruction_test__DOT__unnamedblk7__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__20__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__20__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__20__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__20__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__20__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__20__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__21__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__22__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__22__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__22__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__23__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__23__expected = 0x0fU;
    __Vtask_cpu_instruction_test__DOT__check_register__23__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__23__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__23__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__23__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__23__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__23__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk8__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0xf0U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(9U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0x0fU, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})))));
    VL_WRITEF_NX("Test 7: ORA #$F0\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__24__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__24__size = 5U;
    __Vtask_cpu_instruction_test__DOT__load_program__24__prog 
        = cpu_instruction_test__DOT__unnamedblk8__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__24__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__24__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__24__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__24__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__24__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__24__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__25__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__26__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__26__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__26__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__27__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__27__expected = 0xffU;
    __Vtask_cpu_instruction_test__DOT__check_register__27__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__27__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__27__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__27__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__27__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__27__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk9__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0xaaU, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0x77U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{}))));
    VL_WRITEF_NX("Test 8: TAX\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__28__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__28__size = 4U;
    __Vtask_cpu_instruction_test__DOT__load_program__28__prog 
        = cpu_instruction_test__DOT__unnamedblk9__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__28__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__28__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__28__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__28__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__28__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__28__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__29__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__30__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__30__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__30__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__31__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
    __Vtask_cpu_instruction_test__DOT__check_register__31__expected = 0x77U;
    __Vtask_cpu_instruction_test__DOT__check_register__31__name = "X"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__31__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__31__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__31__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__31__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__31__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk10__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0xe8U, 
                                                                             VlQueue<CData/*7:0*/>::consVC(5U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa2U, 
                                                                                VlQueue<CData/*7:0*/>{}))));
    VL_WRITEF_NX("Test 9: INX\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__32__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__32__size = 4U;
    __Vtask_cpu_instruction_test__DOT__load_program__32__prog 
        = cpu_instruction_test__DOT__unnamedblk10__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__32__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__32__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__32__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__32__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__32__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__32__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__33__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__34__n = 0x0000001eU;
    __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__34__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__34__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__35__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
    __Vtask_cpu_instruction_test__DOT__check_register__35__expected = 6U;
    __Vtask_cpu_instruction_test__DOT__check_register__35__name = "X"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__35__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__35__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__35__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__35__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__35__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n",0);
    cpu_instruction_test__DOT__unnamedblk11__DOT__prog 
        = VlQueue<CData/*7:0*/>::consVC(0xeaU, VlQueue<CData/*7:0*/>::consVC(0xffU, 
                                                                             VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(2U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xf0U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0U, 
                                                                                VlQueue<CData/*7:0*/>::consVC(0xa9U, 
                                                                                VlQueue<CData/*7:0*/>{})))))));
    VL_WRITEF_NX("Test 10: BEQ (taken)\n",0);
    __Vtask_cpu_instruction_test__DOT__load_program__36__start_addr = 0xc000U;
    __Vtask_cpu_instruction_test__DOT__load_program__36__size = 6U;
    __Vtask_cpu_instruction_test__DOT__load_program__36__prog 
        = cpu_instruction_test__DOT__unnamedblk11__DOT__prog;
    __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i = 0;
    __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i = 0U;
    while (VL_LTS_III(32, __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i, __Vtask_cpu_instruction_test__DOT__load_program__36__size)) {
        vlSelfRef.cpu_instruction_test__DOT__mem[(0x0000ffffU 
                                                  & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__36__start_addr) 
                                                     + __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i))] 
            = __Vtask_cpu_instruction_test__DOT__load_program__36__prog.at(__Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i);
        __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i 
            = ((IData)(1U) + __Vtask_cpu_instruction_test__DOT__load_program__36__unnamedblk1__DOT__i);
    }
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffcU] 
        = (0x000000ffU & (IData)(__Vtask_cpu_instruction_test__DOT__load_program__36__start_addr));
    vlSelfRef.cpu_instruction_test__DOT__mem[0xfffdU] 
        = (0x000000ffU & ((IData)(__Vtask_cpu_instruction_test__DOT__load_program__36__start_addr) 
                          >> 8U));
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 0;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0;
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 0U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 = 5U;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             43);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_1__DOT____Vrepeat0 
               - (IData)(1U));
    }
    vlSelfRef.cpu_instruction_test__DOT__rst_n = 1U;
    __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 = 0x0000000aU;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             45);
        __Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
            = (__Vtask_cpu_instruction_test__DOT__reset_cpu__37__cpu_instruction_test__DOT__unnamedblk1_2__DOT____Vrepeat1 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__run_cycles__38__n = 0x00000028U;
    __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 = 0;
    __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
        = __Vtask_cpu_instruction_test__DOT__run_cycles__38__n;
    while (VL_LTS_III(32, 0U, __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2)) {
        co_await vlSelfRef.__VtrigSched_hafe93069__0.trigger(0U, 
                                                             nullptr, 
                                                             "@(posedge cpu_instruction_test.clk)", 
                                                             "cpu_instruction_test.sv", 
                                                             58);
        __Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
            = (__Vtask_cpu_instruction_test__DOT__run_cycles__38__cpu_instruction_test__DOT__unnamedblk1_3__DOT____Vrepeat2 
               - (IData)(1U));
    }
    __Vtask_cpu_instruction_test__DOT__check_register__39__actual 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    __Vtask_cpu_instruction_test__DOT__check_register__39__expected = 0U;
    __Vtask_cpu_instruction_test__DOT__check_register__39__name = "A"s;
    if (VL_UNLIKELY((((IData)(__Vtask_cpu_instruction_test__DOT__check_register__39__expected) 
                      != (IData)(__Vtask_cpu_instruction_test__DOT__check_register__39__actual))))) {
        VL_WRITEF_NX("FAIL: %@ expected=$%02x actual=$%02x\n",0,
                     -1,&(__Vtask_cpu_instruction_test__DOT__check_register__39__name),
                     8,(IData)(__Vtask_cpu_instruction_test__DOT__check_register__39__expected),
                     8,__Vtask_cpu_instruction_test__DOT__check_register__39__actual);
        VL_FINISH_MT("cpu_instruction_test.sv", 64, "");
    }
    VL_WRITEF_NX("  PASS\n\n=== All Tests Passed! ===\n",0);
    VL_FINISH_MT("cpu_instruction_test.sv", 224, "");
}

VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__1(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__1\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    co_await vlSelfRef.__VdlySched.delay(0x00000000000186a0ULL, 
                                         nullptr, "cpu_instruction_test.sv", 
                                         229);
    VL_WRITEF_NX("ERROR: Test timeout!\n",0);
    VL_FINISH_MT("cpu_instruction_test.sv", 231, "");
}

VlCoroutine Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__2(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_initial__TOP__Vtiming__2\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "cpu_instruction_test.sv", 
                                             9);
        vlSelfRef.cpu_instruction_test__DOT__clk = 
            (1U & (~ (IData)(vlSelfRef.cpu_instruction_test__DOT__clk)));
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vcpu_instruction_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void Vcpu_instruction_test___024root___eval_triggers__act(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_triggers__act\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    ((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                      << 2U) 
                                                     | ((((~ (IData)(vlSelfRef.cpu_instruction_test__DOT__rst_n)) 
                                                          & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__rst_n__0)) 
                                                         << 1U) 
                                                        | ((IData)(vlSelfRef.cpu_instruction_test__DOT__clk) 
                                                           & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__clk__0)))))));
    vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__clk__0 
        = vlSelfRef.cpu_instruction_test__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__rst_n__0 
        = vlSelfRef.cpu_instruction_test__DOT__rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vcpu_instruction_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool Vcpu_instruction_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___trigger_anySet__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void Vcpu_instruction_test___024root___act_sequent__TOP__0(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___act_sequent__TOP__0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.cpu_instruction_test__DOT__data_in = 
        vlSelfRef.cpu_instruction_test__DOT__mem[vlSelfRef.cpu_instruction_test__DOT__addr];
}

void Vcpu_instruction_test___024root___eval_act(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_act\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered[0U])) {
        Vcpu_instruction_test___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vcpu_instruction_test___024root___nba_sequent__TOP__0(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___nba_sequent__TOP__0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__B 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
        = vlSelfRef.cpu_instruction_test__DOT__addr;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__opcode 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode;
    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_prev = 0U;
}

void Vcpu_instruction_test___024root___nba_sequent__TOP__1(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___nba_sequent__TOP__1\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ __VdlyVal__cpu_instruction_test__DOT__mem__v0;
    __VdlyVal__cpu_instruction_test__DOT__mem__v0 = 0;
    SData/*15:0*/ __VdlyDim0__cpu_instruction_test__DOT__mem__v0;
    __VdlyDim0__cpu_instruction_test__DOT__mem__v0 = 0;
    CData/*0:0*/ __VdlySet__cpu_instruction_test__DOT__mem__v0;
    __VdlySet__cpu_instruction_test__DOT__mem__v0 = 0;
    // Body
    __VdlySet__cpu_instruction_test__DOT__mem__v0 = 0U;
    if ((1U & (~ (IData)(vlSelfRef.cpu_instruction_test__DOT__rw)))) {
        __VdlyVal__cpu_instruction_test__DOT__mem__v0 
            = vlSelfRef.cpu_instruction_test__DOT__data_out;
        __VdlyDim0__cpu_instruction_test__DOT__mem__v0 
            = vlSelfRef.cpu_instruction_test__DOT__addr;
        __VdlySet__cpu_instruction_test__DOT__mem__v0 = 1U;
    }
    if (__VdlySet__cpu_instruction_test__DOT__mem__v0) {
        vlSelfRef.cpu_instruction_test__DOT__mem[__VdlyDim0__cpu_instruction_test__DOT__mem__v0] 
            = __VdlyVal__cpu_instruction_test__DOT__mem__v0;
    }
}

void Vcpu_instruction_test___024root___nba_sequent__TOP__2(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___nba_sequent__TOP__2\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.cpu_instruction_test__DOT__rst_n) {
        if ((0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr = 0xfffcU;
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
            } else if ((1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr = 0xfffdU;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 2U;
            } else {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__ 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 0U;
            }
        } else if ((1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 0U;
            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
        } else if ((2U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__opcode 
                = vlSelfRef.cpu_instruction_test__DOT__data_in;
            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
        } else if ((3U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            if ((0x00000080U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((0x00000040U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((0x00000020U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                    } else if ((1U 
                                                & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                            = (0x0000ffffU 
                                               & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                            = (0x0000ffffU 
                                               & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                    << 8U) 
                                                   | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                    } else {
                                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                    }
                                } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D = 1U;
                                }
                            } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                }
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                           : ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                               : ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))))));
                            }
                        } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff 
                                    = (0x000001ffU 
                                       & (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                           - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)) 
                                          - (1U & (~ (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)))));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                    = (1U & (~ ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff) 
                                                >> 8U)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                    = (0x000000ffU 
                                       & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                    = (0U == (0x000000ffU 
                                              & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff) 
                                             >> 7U));
                            } else {
                                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = vlSelfRef.cpu_instruction_test__DOT__data_in;
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X) 
                                                  - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X) 
                                   >= (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X) 
                                   == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D = 0U;
                            }
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((4U 
                                                   & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((2U 
                                                    & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                     ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                     : 
                                                    ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z)
                                                      ? 
                                                     ((IData)(1U) 
                                                      + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))
                                                      : 
                                                     ((IData)(1U) 
                                                      + 
                                                      ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                       + 
                                                       ((0x0000ff00U 
                                                         & ((- (IData)(
                                                                       (1U 
                                                                        & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                           >> 7U)))) 
                                                            << 8U)) 
                                                        | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)))))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X) 
                                          - (IData)(1U)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                                  - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                   >= (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                   == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        } else {
                            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                                              - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                            = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                               >= (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                               == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((0x00000020U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP;
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                        = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                        = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                                 >> 7U));
                                }
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V = 0U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (0x000000ffU 
                                           & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)
                                                   ? 
                                                  ((IData)(1U) 
                                                   + 
                                                   ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                    + 
                                                    ((0x0000ff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in))))
                                                   : 
                                                  ((IData)(1U) 
                                                   + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                }
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                         >> 7U));
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                     >> 7U));
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                vlSelfRef.cpu_instruction_test__DOT__data_out 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            }
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                                         >> 7U));
                        }
                    } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                                vlSelfRef.cpu_instruction_test__DOT__data_out 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                            vlSelfRef.cpu_instruction_test__DOT__data_out 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                            vlSelfRef.cpu_instruction_test__DOT__data_out 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)
                                               ? ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))
                                               : ((IData)(1U) 
                                                  + 
                                                  ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                   + 
                                                   ((0x0000ff00U 
                                                     & ((- (IData)(
                                                                   (1U 
                                                                    & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                       >> 7U)))) 
                                                        << 8U)) 
                                                    | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                vlSelfRef.cpu_instruction_test__DOT__data_out 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
                                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                    << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                            vlSelfRef.cpu_instruction_test__DOT__data_out 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                    << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                            vlSelfRef.cpu_instruction_test__DOT__data_out 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        }
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                            = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                                              - (IData)(1U)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    }
                } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__data_out 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        }
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.cpu_instruction_test__DOT__data_out 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.cpu_instruction_test__DOT__data_out 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                    }
                } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000040U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((0x00000020U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = (0x0000ffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                        = (0x0000ffffU 
                                           & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                << 8U) 
                                               | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                                } else {
                                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                }
                            } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x0000ffffU 
                                       & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                            << 8U) 
                                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand)) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I = 1U;
                            }
                        } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (0x000000ffU 
                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            }
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((2U 
                                                   & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))))));
                        }
                    } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            } else {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand));
                                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                            }
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            } else {
                                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C) 
                                        << 7U) | (0x0000007fU 
                                                  & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                                     >> 1U)));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                    = (1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                             >> 7U));
                            }
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum 
                                = (0x000001ffU & (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                                   + (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                                         >> 8U));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (0x000000ffU 
                                          & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                                         >> 7U));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V 
                                = (((1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                           >> 7U)) 
                                    == (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                              >> 7U))) 
                                   & ((1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                             >> 7U)) 
                                      != (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                                                >> 7U))));
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                                = (0x000000ffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        }
                    } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = (0x0000ffffU & ((IData)(1U) 
                                                  + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                                = vlSelfRef.cpu_instruction_test__DOT__data_in;
                            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        }
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    }
                } else if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I = 0U;
                        }
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))
                                                     : 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)))))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                : ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                    ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                    : (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand))));
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                = (1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N = 0U;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = (0x0000007fU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                                  >> 1U));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (0x0000007fU 
                                          & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                             >> 1U)));
                        }
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                               ^ (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                        vlSelfRef.cpu_instruction_test__DOT__data_out 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                              - (IData)(1U)));
                    }
                } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                }
            } else if ((0x00000020U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C = 1U;
                        }
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                               : ((2U 
                                                   & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((1U 
                                                    & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                    ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                    : 
                                                   ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N)
                                                     ? 
                                                    ((IData)(1U) 
                                                     + 
                                                     ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                      + 
                                                      ((0x0000ff00U 
                                                        & ((- (IData)(
                                                                      (1U 
                                                                       & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                          >> 7U)))) 
                                                           << 8U)) 
                                                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in))))
                                                     : 
                                                    ((IData)(1U) 
                                                     + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)))))));
                    }
                } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        } else {
                            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                                = ((0x000000feU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                                   << 1U)) 
                                   | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                         >> 7U));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                                = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                                = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                            vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                                = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                         >> 7U));
                        }
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                            = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                               & (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                     >> 7U));
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                            = (0x000000ffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP)));
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    }
                } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    }
                } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                    vlSelfRef.cpu_instruction_test__DOT__data_out 
                        = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                          >> 8U));
                    vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                }
            } else if ((0x00000010U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C = 0U;
                    }
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                           ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                           : ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                               ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                               : ((1U 
                                                   & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))
                                                   ? (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)
                                                   : 
                                                  ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N)
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC))
                                                    : 
                                                   ((IData)(1U) 
                                                    + 
                                                    ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                                     + 
                                                     ((0x0000ff00U 
                                                       & ((- (IData)(
                                                                     (1U 
                                                                      & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                                         >> 7U)))) 
                                                          << 8U)) 
                                                      | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)))))))));
                }
            } else if ((8U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                     >> 7U));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                            = (0x000000feU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                              << 1U));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                            = (0U == (0x0000007fU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                            = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                     >> 6U));
                    }
                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                        = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                           | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                        = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                        = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                                 >> 7U));
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                    vlSelfRef.cpu_instruction_test__DOT__data_out 
                        = (0x00000020U | ((((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N) 
                                              << 3U) 
                                             | ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V) 
                                                << 2U)) 
                                            | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B)) 
                                           << 4U) | 
                                          ((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D) 
                                             << 3U) 
                                            | ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I) 
                                               << 2U)) 
                                           | (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z) 
                                               << 1U) 
                                              | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)))));
                    vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                        = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                          - (IData)(1U)));
                }
            } else if ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                    } else {
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                            = (0x0000ffffU & ((IData)(1U) 
                                              + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                        vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                            = vlSelfRef.cpu_instruction_test__DOT__data_in;
                        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                    }
                } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = (0x0000ffffU & ((IData)(1U) 
                                          + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                        = vlSelfRef.cpu_instruction_test__DOT__data_in;
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                } else {
                    vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
                }
            } else if ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
            } else if ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                      + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X)));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 1U;
            } else {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                vlSelfRef.cpu_instruction_test__DOT__data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__B = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC;
            }
            vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__operand 
                = vlSelfRef.cpu_instruction_test__DOT__data_in;
        } else if ((4U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            if ((((((((0xa1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                      | (0x81U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                     | (1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                    | (0x21U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                   | (0xb1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                  | (0x91U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                 & (1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.cpu_instruction_test__DOT__addr)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 2U;
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((((((0xa1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                           | (0x81U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                          | (1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                         | (0x21U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x81U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.cpu_instruction_test__DOT__data_out 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                    vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                } else {
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                }
            } else if ((((0xb1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                         | (0x91U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        & (2U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count)))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x0000ffffU & ((((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                        << 8U) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo)) 
                                      + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 0U;
                if ((0x91U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                    vlSelfRef.cpu_instruction_test__DOT__data_out 
                        = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A;
                    vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                } else {
                    vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                }
            } else if ((((((((0xa5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                             | (0xadU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                            | (0xb5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                           | (0xbdU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                          | (0xb9U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                         | (0xa1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        | (0xb1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((((0xa6U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                         | (0xb6U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        | (0xaeU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if (((0xa4U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                        | (0xb4U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((0x68U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = vlSelfRef.cpu_instruction_test__DOT__data_in;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((0x28U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 6U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__B 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 4U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 3U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 2U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 1U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = (1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x21U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                       & (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0x24U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                              & (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 6U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
            } else if ((6U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 7U));
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__alu_result 
                    = (0x000000feU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                      << 1U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (0x0000007fU & (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                             >> 6U));
                vlSelfRef.cpu_instruction_test__DOT__data_out 
                    = (0x000000feU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                      << 1U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
            } else if ((0xc5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                      - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                       >= (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                       == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((0xc4U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                                      - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                       >= (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y) 
                       == (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_result) 
                             >> 7U));
            } else if ((((((0x65U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                           | (0x75U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                          | (0x6dU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                         | (0x7dU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        | (0x79U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum 
                    = (0x000001ffU & (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                       + (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)) 
                                      + (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                             >> 8U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                             >> 7U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V 
                    = (((1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                               >> 7U)) == (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                                                 >> 7U))) 
                       & ((1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                 >> 7U)) != (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_sum) 
                                                   >> 7U))));
            } else if ((((((0xe5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                           | (0xf5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                          | (0xedU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                         | (0xfdU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                        | (0xf9U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)))) {
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff 
                    = (0x000001ffU & (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A) 
                                       - (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in)) 
                                      - (1U & (~ (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)))));
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C 
                    = (1U & (~ ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff) 
                                >> 8U)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A 
                    = (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z 
                    = (0U == (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff)));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N 
                    = (1U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__temp_diff) 
                             >> 7U));
            }
        } else if ((5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
        } else if ((6U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))) {
            if ((0U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                vlSelfRef.cpu_instruction_test__DOT__data_out 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC) 
                                      >> 8U));
                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((1U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                vlSelfRef.cpu_instruction_test__DOT__data_out 
                    = (0x000000ffU & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC));
                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 2U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((2U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr 
                    = (0x00000100U | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP));
                vlSelfRef.cpu_instruction_test__DOT__data_out 
                    = (0x00000020U | ((((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N) 
                                          << 3U) | 
                                         ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V) 
                                          << 2U)) | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B)) 
                                       << 4U) | ((((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D) 
                                                   << 3U) 
                                                  | ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I) 
                                                     << 2U)) 
                                                 | (((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z) 
                                                     << 1U) 
                                                    | (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C)))));
                vlSelfRef.cpu_instruction_test__DOT__rw = 0U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 3U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP 
                    = (0x000000ffU & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP) 
                                      - (IData)(1U)));
            } else if ((3U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr = 0xfffaU;
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 4U;
            } else if ((4U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = ((0xff00U & (IData)(vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC)) 
                       | (IData)(vlSelfRef.cpu_instruction_test__DOT__data_in));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr = 0xfffbU;
                vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 5U;
            } else if ((5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))) {
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC 
                    = ((0x00ffU & (IData)(vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC)) 
                       | ((IData)(vlSelfRef.cpu_instruction_test__DOT__data_in) 
                          << 8U));
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 0U;
                vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_pending = 0U;
                vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I = 1U;
            }
        }
        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state 
            = vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__next_state;
    } else {
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = 0U;
        vlSelfRef.cpu_instruction_test__DOT__rw = 1U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP = 0xfdU;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I = 1U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__B = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N = 0U;
        vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = 0U;
        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_pending = 0U;
        vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state = 0U;
    }
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__PC 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__D 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__D;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__C 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__C;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__A 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__A;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Z 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__N 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__N;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__X 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__X;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__Y 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__V 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__V;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__SP 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__I 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__I;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__B 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__B;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo;
    vlSelfRef.cpu_instruction_test__DOT__addr = vlSelfRef.__Vdly__cpu_instruction_test__DOT__addr;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__opcode;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle 
        = vlSelfRef.__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle;
    vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__next_state 
        = ((4U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
            ? ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                    ? 1U : ((5U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_cycle))
                             ? 1U : 6U)) : ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                                             ? 1U : 
                                            ((0U < (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count))
                                              ? 4U : 5U)))
            : ((2U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                ? ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                    ? ((((1U == (3U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                         & (4U != (7U & ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode) 
                                         >> 2U)))) 
                        | ((0x85U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                           | (((0x8dU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                               | (0x95U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))) 
                              | ((0x9dU == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                 | ((0x86U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                    | ((0x96U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                       | ((0x84U == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                          | ((0x94U 
                                              == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                             | ((0xa5U 
                                                 == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                | ((0xadU 
                                                    == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                   | ((0xb5U 
                                                       == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                      | ((0xbdU 
                                                          == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                         | ((0xb9U 
                                                             == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                            | ((0xa6U 
                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                               | ((0xb6U 
                                                                   == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                  | ((0xaeU 
                                                                      == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                     | ((0xa4U 
                                                                         == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                        | ((0xb4U 
                                                                            == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                           | ((5U 
                                                                               == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                              | ((0x24U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((6U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc5U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xc4U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x65U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x75U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x6dU 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x7dU 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x79U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xe5U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf5U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xedU 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xfdU 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xf9U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xa1U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0xb1U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x81U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((0x91U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | ((1U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode)) 
                                                                                | (0x21U 
                                                                                == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__opcode))))))))))))))))))))))))))))))))))))))))
                        ? 4U : 1U) : 3U) : ((1U & (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__state))
                                             ? ((IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__nmi_pending)
                                                 ? 6U
                                                 : 2U)
                                             : ((2U 
                                                 == (IData)(vlSelfRef.cpu_instruction_test__DOT__cpu__DOT__cycle_count))
                                                 ? 1U
                                                 : 0U))));
}

void Vcpu_instruction_test___024root___eval_nba(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_nba\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vcpu_instruction_test___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vcpu_instruction_test___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vcpu_instruction_test___024root___nba_sequent__TOP__2(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        Vcpu_instruction_test___024root___act_sequent__TOP__0(vlSelf);
    }
}

void Vcpu_instruction_test___024root___timing_commit(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___timing_commit\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((! (1ULL & vlSelfRef.__VactTriggered[0U]))) {
        vlSelfRef.__VtrigSched_hafe93069__0.commit(
                                                   "@(posedge cpu_instruction_test.clk)");
    }
}

void Vcpu_instruction_test___024root___timing_resume(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___timing_resume\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VtrigSched_hafe93069__0.resume(
                                                   "@(posedge cpu_instruction_test.clk)");
    }
    if ((4ULL & vlSelfRef.__VactTriggered[0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vcpu_instruction_test___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vcpu_instruction_test___024root___eval_phase__act(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_phase__act\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    Vcpu_instruction_test___024root___eval_triggers__act(vlSelf);
    Vcpu_instruction_test___024root___timing_commit(vlSelf);
    Vcpu_instruction_test___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = Vcpu_instruction_test___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        Vcpu_instruction_test___024root___timing_resume(vlSelf);
        Vcpu_instruction_test___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

void Vcpu_instruction_test___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool Vcpu_instruction_test___024root___eval_phase__nba(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_phase__nba\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = Vcpu_instruction_test___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        Vcpu_instruction_test___024root___eval_nba(vlSelf);
        Vcpu_instruction_test___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void Vcpu_instruction_test___024root___eval(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vcpu_instruction_test___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("cpu_instruction_test.sv", 4, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vcpu_instruction_test___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("cpu_instruction_test.sv", 4, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (Vcpu_instruction_test___024root___eval_phase__act(vlSelf));
    } while (Vcpu_instruction_test___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void Vcpu_instruction_test___024root___eval_debug_assertions(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_debug_assertions\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
