// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtest_cpu.h for the primary calling header

#include "Vtest_cpu__pch.h"

VL_ATTR_COLD void Vtest_cpu___024root___eval_static(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_static\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__clk__0 
        = vlSelfRef.test_cpu__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__test_cpu__DOT__rst_n__0 
        = vlSelfRef.test_cpu__DOT__rst_n;
}

VL_ATTR_COLD void Vtest_cpu___024root___eval_initial__TOP(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_initial__TOP\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_cpu__DOT__clk = 0U;
}

VL_ATTR_COLD void Vtest_cpu___024root___eval_final(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_final\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_cpu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtest_cpu___024root___eval_phase__stl(Vtest_cpu___024root* vlSelf);

VL_ATTR_COLD void Vtest_cpu___024root___eval_settle(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_settle\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vtest_cpu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("test_cpu.sv", 3, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (Vtest_cpu___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void Vtest_cpu___024root___eval_triggers__stl(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_triggers__stl\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtest_cpu___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool Vtest_cpu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_cpu___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_cpu___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool Vtest_cpu___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void Vtest_cpu___024root___stl_sequent__TOP__0(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___stl_sequent__TOP__0\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.test_cpu__DOT__data_in = ((IData)(vlSelfRef.test_cpu__DOT__rw)
                                         ? vlSelfRef.test_cpu__DOT__mem
                                        [vlSelfRef.test_cpu__DOT__addr]
                                         : 0U);
    vlSelfRef.test_cpu__DOT__dut__DOT__next_state = 
        ((4U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
          ? ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
              ? ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                  ? 1U : ((5U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_cycle))
                           ? 1U : 6U)) : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                                           ? 1U : (
                                                   (0U 
                                                    < (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))
                                                    ? 4U
                                                    : 5U)))
          : ((2U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
              ? ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                  ? ((((1U == (3U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                       & (4U != (7U & ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode) 
                                       >> 2U)))) | 
                      ((0x85U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                       | (((0x8dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                           | (0x95U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))) 
                          | ((0x9dU == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                             | ((0x86U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                | ((0x96U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                   | ((0x84U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                      | ((0x94U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                         | ((0xa5U 
                                             == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                            | ((0xadU 
                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                               | ((0xb5U 
                                                   == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                  | ((0xbdU 
                                                      == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                     | ((0xb9U 
                                                         == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                        | ((0xa6U 
                                                            == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                           | ((0xb6U 
                                                               == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                              | ((0xaeU 
                                                                  == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                 | ((0xa4U 
                                                                     == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                    | ((0xb4U 
                                                                        == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                       | ((5U 
                                                                           == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                          | ((0x24U 
                                                                              == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                             | ((6U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xc5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xc4U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x65U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x75U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x6dU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x7dU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x79U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xe5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xf5U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xedU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xfdU 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xf9U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xa1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0xb1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x81U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((0x91U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | ((1U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode)) 
                                                                                | (0x21U 
                                                                                == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__opcode))))))))))))))))))))))))))))))))))))))))
                      ? 4U : 1U) : 3U) : ((1U & (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__state))
                                           ? ((IData)(vlSelfRef.test_cpu__DOT__dut__DOT__nmi_pending)
                                               ? 6U
                                               : 2U)
                                           : ((2U == (IData)(vlSelfRef.test_cpu__DOT__dut__DOT__cycle_count))
                                               ? 1U
                                               : 0U))));
}

VL_ATTR_COLD void Vtest_cpu___024root____Vm_traceActivitySetAll(Vtest_cpu___024root* vlSelf);

VL_ATTR_COLD void Vtest_cpu___024root___eval_stl(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_stl\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        Vtest_cpu___024root___stl_sequent__TOP__0(vlSelf);
        Vtest_cpu___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool Vtest_cpu___024root___eval_phase__stl(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___eval_phase__stl\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtest_cpu___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = Vtest_cpu___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        Vtest_cpu___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool Vtest_cpu___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtest_cpu___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(Vtest_cpu___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge test_cpu.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge test_cpu.rst_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtest_cpu___024root____Vm_traceActivitySetAll(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root____Vm_traceActivitySetAll\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
}

VL_ATTR_COLD void Vtest_cpu___024root___ctor_var_reset(Vtest_cpu___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtest_cpu___024root___ctor_var_reset\n"); );
    Vtest_cpu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->test_cpu__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 3302612664435796037ull);
    vlSelf->test_cpu__DOT__rst_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14059447231237213506ull);
    vlSelf->test_cpu__DOT__addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 16376366816146652155ull);
    vlSelf->test_cpu__DOT__data_in = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 18414148850174529630ull);
    vlSelf->test_cpu__DOT__data_out = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 5363732845580154564ull);
    vlSelf->test_cpu__DOT__rw = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14699170193086143371ull);
    vlSelf->test_cpu__DOT__nmi = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9509385864796835421ull);
    vlSelf->test_cpu__DOT__irq = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 9115883921124512629ull);
    for (int __Vi0 = 0; __Vi0 < 65536; ++__Vi0) {
        vlSelf->test_cpu__DOT__mem[__Vi0] = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 9725889495160521975ull);
    }
    vlSelf->test_cpu__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->test_cpu__DOT__dut__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4775251181289112391ull);
    vlSelf->test_cpu__DOT__dut__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10904924255478793524ull);
    vlSelf->test_cpu__DOT__dut__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 712490020430232090ull);
    vlSelf->test_cpu__DOT__dut__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17381123929889225778ull);
    vlSelf->test_cpu__DOT__dut__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 6020564470887961357ull);
    vlSelf->test_cpu__DOT__dut__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14345270626920035071ull);
    vlSelf->test_cpu__DOT__dut__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8798336277150193430ull);
    vlSelf->test_cpu__DOT__dut__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1816158409635594878ull);
    vlSelf->test_cpu__DOT__dut__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 12150025098970817571ull);
    vlSelf->test_cpu__DOT__dut__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13029561019949920181ull);
    vlSelf->test_cpu__DOT__dut__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11952252294995706668ull);
    vlSelf->test_cpu__DOT__dut__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14188969570578404177ull);
    vlSelf->test_cpu__DOT__dut__DOT__state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 9449717874871764826ull);
    vlSelf->test_cpu__DOT__dut__DOT__next_state = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 9121803941707881713ull);
    vlSelf->test_cpu__DOT__dut__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4431310962777752535ull);
    vlSelf->test_cpu__DOT__dut__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1036695192387367115ull);
    vlSelf->test_cpu__DOT__dut__DOT__alu_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4140427742685951735ull);
    vlSelf->test_cpu__DOT__dut__DOT__ea = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 6631408946440760322ull);
    vlSelf->test_cpu__DOT__dut__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 13729274788686128504ull);
    vlSelf->test_cpu__DOT__dut__DOT__reset_vector__BRA__15__03a8__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 4812097350791815880ull);
    vlSelf->test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7631417395796229703ull);
    vlSelf->test_cpu__DOT__dut__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 3314887293964972651ull);
    vlSelf->test_cpu__DOT__dut__DOT__nmi_pending = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11552975709970017416ull);
    vlSelf->test_cpu__DOT__dut__DOT__nmi_prev = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10261426011933192862ull);
    vlSelf->test_cpu__DOT__dut__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 17703627839199223481ull);
    vlSelf->test_cpu__DOT__dut__DOT__indirect_addr_hi = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 7620246852173359793ull);
    vlSelf->test_cpu__DOT__dut__DOT__temp_sum = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 13943095586733762352ull);
    vlSelf->test_cpu__DOT__dut__DOT__temp_diff = VL_SCOPED_RAND_RESET_I(9, __VscopeHash, 17080737519489116880ull);
    vlSelf->test_cpu__DOT__dut__DOT__temp_result = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12668975154297016608ull);
    vlSelf->__Vdly__test_cpu__DOT__addr = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 11221964813736516029ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__cycle_count = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 10051732622245456259ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__reset_vector__BRA__7__03a0__KET__ = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14298348014644052231ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__PC = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 7019936440066706112ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__opcode = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 10222099223030081462ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__D = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 11322514738771598169ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__C = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14439132780758655516ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__A = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 14148816555310662095ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__Z = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6363789668911662903ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__N = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 194159429125848566ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__X = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 12402431435543574276ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__Y = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 15292729459075986436ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__V = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 5374250956348111355ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__SP = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 8106371680367001836ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__I = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 13199059214576970639ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__B = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8988061164873310155ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__operand = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 1185134842633849558ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__indirect_addr_lo = VL_SCOPED_RAND_RESET_I(8, __VscopeHash, 2466516969936969026ull);
    vlSelf->__Vdly__test_cpu__DOT__dut__DOT__nmi_cycle = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 7269242086401729421ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__test_cpu__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4737475725296159722ull);
    vlSelf->__Vtrigprevexpr___TOP__test_cpu__DOT__rst_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 15031013641542821066ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
