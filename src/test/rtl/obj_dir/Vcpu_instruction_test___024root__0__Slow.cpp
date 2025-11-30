// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vcpu_instruction_test.h for the primary calling header

#include "Vcpu_instruction_test__pch.h"

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_static__TOP(Vcpu_instruction_test___024root* vlSelf);

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_static(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_static\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vcpu_instruction_test___024root___eval_static__TOP(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__clk__0 = 0U;
    vlSelfRef.__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__rst_n__0 
        = vlSelfRef.cpu_instruction_test__DOT__rst_n;
}

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_static__TOP(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_static__TOP\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.cpu_instruction_test__DOT__clk = 0U;
}

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_final(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_final\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vcpu_instruction_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vcpu_instruction_test___024root___eval_phase__stl(Vcpu_instruction_test___024root* vlSelf);

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_settle(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_settle\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vcpu_instruction_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("cpu_instruction_test.sv", 4, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vcpu_instruction_test___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_triggers__stl(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_triggers__stl\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vcpu_instruction_test___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vcpu_instruction_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vcpu_instruction_test___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vcpu_instruction_test___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vcpu_instruction_test___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vcpu_instruction_test___024root___stl_sequent__TOP__0(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___stl_sequent__TOP__0\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.cpu_instruction_test__DOT__data_in = 
        vlSelfRef.cpu_instruction_test__DOT__mem[vlSelfRef.cpu_instruction_test__DOT__addr];
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

VL_ATTR_COLD void Vcpu_instruction_test___024root____Vm_traceActivitySetAll(Vcpu_instruction_test___024root* vlSelf);

VL_ATTR_COLD void Vcpu_instruction_test___024root___eval_stl(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_stl\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vcpu_instruction_test___024root___stl_sequent__TOP__0(vlSelf);
        Vcpu_instruction_test___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool Vcpu_instruction_test___024root___eval_phase__stl(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___eval_phase__stl\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vcpu_instruction_test___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vcpu_instruction_test___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vcpu_instruction_test___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vcpu_instruction_test___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vcpu_instruction_test___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vcpu_instruction_test___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge cpu_instruction_test.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge cpu_instruction_test.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vcpu_instruction_test___024root____Vm_traceActivitySetAll(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root____Vm_traceActivitySetAll\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
}

VL_ATTR_COLD void Vcpu_instruction_test___024root___ctor_var_reset(Vcpu_instruction_test___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vcpu_instruction_test___024root___ctor_var_reset\n"); );
    Vcpu_instruction_test__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->cpu_instruction_test__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18196802079051124532ull);
    vlSelf->cpu_instruction_test__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 648363253138169393ull);
    vlSelf->cpu_instruction_test__DOT__addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 6441332646620454950ull);
    vlSelf->cpu_instruction_test__DOT__data_in = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4058972067358270224ull);
    vlSelf->cpu_instruction_test__DOT__data_out = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10937386814820169719ull);
    vlSelf->cpu_instruction_test__DOT__rw = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13767448271831983509ull);
    for (int __Vi0 = 0; __Vi0 < 65536; ++__Vi0) {
        vlSelf->cpu_instruction_test__DOT__mem[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10430289319711979568ull);
    }
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 6813736271056160571ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16806057197266342561ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16626274253187643370ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17675660275100936200ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 9814942415778791905ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3697757089594966521ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 502988212977679736ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4718151603738430284ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15003162114315760834ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5396857487241993386ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14558292460714742300ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14654601427290762189ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 13145423398542157554ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__next_state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 5575272232083443360ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14943729711277453867ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7716850414396870863ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__alu_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17801632786390565908ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__ea = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 8234943834794886907ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 2335305816950925248ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__15__03a8__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2615412891604008011ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1185032221492457674ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 14666577048991641485ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__nmi_pending = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1781768942177510444ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__nmi_prev = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4484590113276198025ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 13646947024489060357ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__indirect_addr_hi = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12468559545774535949ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__temp_sum = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 9678741545948467765ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__temp_diff = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 17094369498519879928ull);
    vlSelf->cpu_instruction_test__DOT__cpu__DOT__temp_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14280572764996713571ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 1396621775189069032ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 3725344748079850427ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 18421876581265129985ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 15355097924744214663ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2831499029363365437ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2305682305746980120ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1537347362981516745ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 16481929116636029024ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6347409983259175916ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2074590279659143499ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5710895684838979209ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 3212012173795168102ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18241277601384625806ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 13908086745372159756ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6095830409913300843ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 918223211180858081ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7940441482646647353ull);
    vlSelf->__Vdly__cpu_instruction_test__DOT__cpu__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 16548088062342203571ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11994152503526198355ull);
    vlSelf->__Vtrigprevexpr___TOP__cpu_instruction_test__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2598863135277077762ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
