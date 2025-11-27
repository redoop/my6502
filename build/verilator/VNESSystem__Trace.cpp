// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VNESSystem__Syms.h"


void VNESSystem::traceChgTop0(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        vlTOPp->traceChgSub0(userp, tracep);
    }
}

void VNESSystem::traceChgSub0(void* userp, VerilatedVcd* tracep) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[1U])) {
            tracep->chgSData(oldp+0,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr),16);
            tracep->chgBit(oldp+1,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite));
            tracep->chgBit(oldp+2,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead));
            tracep->chgCData(oldp+3,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a),8);
            tracep->chgCData(oldp+4,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x),8);
            tracep->chgCData(oldp+5,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y),8);
            tracep->chgSData(oldp+6,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc),16);
            tracep->chgCData(oldp+7,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp),8);
            tracep->chgBit(oldp+8,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC));
            tracep->chgBit(oldp+9,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ));
            tracep->chgBit(oldp+10,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN));
            tracep->chgBit(oldp+11,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV));
            tracep->chgCData(oldp+12,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode),8);
            tracep->chgCData(oldp+13,(vlTOPp->NESSystem__DOT__memory_io_ppuAddr),3);
            tracep->chgCData(oldp+14,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead)
                                        ? ((2U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                            ? ((IData)(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag) 
                                               << 7U)
                                            : ((4U 
                                                == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                ? vlTOPp->NESSystem__DOT__ppu__DOT__oam
                                               [vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0]
                                                : (
                                                   (7U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                    ? 
                                                   vlTOPp->NESSystem__DOT__ppu__DOT__vram
                                                   [vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0]
                                                    : 0U)))
                                        : 0U)),8);
            tracep->chgBit(oldp+15,(vlTOPp->NESSystem__DOT__memory_io_ppuWrite));
            tracep->chgBit(oldp+16,(vlTOPp->NESSystem__DOT__memory_io_ppuRead));
            tracep->chgSData(oldp+17,(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX),9);
            tracep->chgSData(oldp+18,(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY),9);
            tracep->chgBit(oldp+19,(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag));
            tracep->chgBit(oldp+20,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI));
            tracep->chgBit(oldp+21,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD));
            tracep->chgCData(oldp+22,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state),2);
            tracep->chgSData(oldp+23,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand),16);
            tracep->chgCData(oldp+24,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle),3);
            tracep->chgBit(oldp+25,(((0x18U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     & ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
            tracep->chgBit(oldp+26,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                      : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                          : ((0xd8U 
                                              != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             & ((0xf8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))))));
            tracep->chgBit(oldp+27,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                      : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                          : ((0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                              : ((0xf8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                  : 
                                                 ((0x58U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  & ((0x78U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))));
            tracep->chgBit(oldp+28,(((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                      : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                          : ((0xd8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                              : ((0xf8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                  : 
                                                 ((0x58U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                   : 
                                                  ((0x78U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0xb8U 
                                                     != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))));
            tracep->chgCData(oldp+29,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                        : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                            : ((0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                : (
                                                   (0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                    : 
                                                   ((0xbaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))))),8);
            tracep->chgBit(oldp+30,((1U & ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                               >> 7U)
                                            : ((0xa8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                   >> 7U)
                                                : (
                                                   (0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                    >> 7U)
                                                    : 
                                                   ((0x98U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                     >> 7U)
                                                     : 
                                                    ((0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                      >> 7U)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))))));
            tracep->chgBit(oldp+31,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                      : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                          : ((0x8aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                              : ((0x98U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                                  : 
                                                 ((0xbaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))));
            tracep->chgCData(oldp+32,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                        : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))),8);
            tracep->chgCData(oldp+33,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                        : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                            : ((0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                : (
                                                   (0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))),8);
            tracep->chgCData(oldp+34,(((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                        : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                            : ((0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                : (
                                                   (0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                    : 
                                                   ((0xbaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                     : 
                                                    ((0x9aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))))),8);
            tracep->chgCData(oldp+35,((0xffU & ((IData)(1U) 
                                                + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))),8);
            tracep->chgCData(oldp+36,((0xffU & ((IData)(1U) 
                                                + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))),8);
            tracep->chgCData(oldp+37,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                - (IData)(1U)))),8);
            tracep->chgCData(oldp+38,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                - (IData)(1U)))),8);
            tracep->chgCData(oldp+39,((0xffU & ((IData)(1U) 
                                                + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
            tracep->chgCData(oldp+40,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                - (IData)(1U)))),8);
            tracep->chgCData(oldp+41,((0xffU & ((0xe8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? 
                                                ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                                 : 
                                                ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                   - (IData)(1U))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))))),8);
            tracep->chgBit(oldp+42,((1U & ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (1U & 
                                               (((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)) 
                                                >> 7U))
                                            : ((0xc8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (1U 
                                                   & (((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)) 
                                                      >> 7U))
                                                : (
                                                   (0xcaU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (1U 
                                                    & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                        - (IData)(1U)) 
                                                       >> 7U))
                                                    : 
                                                   ((0x88U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    (1U 
                                                     & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                         - (IData)(1U)) 
                                                        >> 7U))
                                                     : 
                                                    ((0x1aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     (1U 
                                                      & (((IData)(1U) 
                                                          + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)) 
                                                         >> 7U))
                                                      : 
                                                     ((0x3aU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? 
                                                      (1U 
                                                       & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                           - (IData)(1U)) 
                                                          >> 7U))
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))))))));
            tracep->chgBit(oldp+43,(((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (0U == (0xffU 
                                                & ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))
                                      : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (0U == 
                                             (0xffU 
                                              & ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                          : ((0xcaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (0U 
                                                 == 
                                                 (0xffU 
                                                  & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                     - (IData)(1U))))
                                              : ((0x88U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (0U 
                                                  == 
                                                  (0xffU 
                                                   & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                      - (IData)(1U))))
                                                  : 
                                                 ((0x1aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == 
                                                   (0xffU 
                                                    & ((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))
                                                   : 
                                                  ((0x3aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (0U 
                                                    == 
                                                    (0xffU 
                                                     & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                        - (IData)(1U))))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))))))));
            tracep->chgCData(oldp+44,((0xffU & ((0xe8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                 : 
                                                ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                   : 
                                                  ((0x88U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                    - (IData)(1U))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))))),8);
            tracep->chgCData(oldp+45,((0xffU & ((0xe8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                 : 
                                                ((0xc8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 ((0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                   : 
                                                  ((0x88U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                    : 
                                                   ((0x1aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                     : 
                                                    ((0x3aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                      - (IData)(1U))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))))))),8);
            tracep->chgSData(oldp+46,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc),16);
            tracep->chgSData(oldp+47,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr),16);
            tracep->chgBit(oldp+48,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead));
            tracep->chgCData(oldp+49,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle),3);
            tracep->chgBit(oldp+50,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done));
            tracep->chgSData(oldp+51,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr),16);
            tracep->chgCData(oldp+52,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle),3);
            tracep->chgBit(oldp+53,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done));
            tracep->chgBit(oldp+54,((1U & ((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                               >> 7U)
                                            : ((0x4aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                : (
                                                   (0x2aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                    >> 7U)
                                                    : 
                                                   ((0x6aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))))));
            tracep->chgCData(oldp+55,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8),8);
            tracep->chgBit(oldp+56,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8) 
                                           >> 7U))));
            tracep->chgBit(oldp+57,((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8))));
            tracep->chgCData(oldp+58,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue),8);
            tracep->chgBit(oldp+59,((1U & ((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                            : ((0xd0U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                                : (
                                                   (0xb0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                    : 
                                                   ((0x90U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                                     : 
                                                    ((0x30U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                      : 
                                                     ((0x10U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? 
                                                      (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                       : 
                                                      ((0x70U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                        : 
                                                       ((0x50U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        & (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))))))))))));
            tracep->chgBit(oldp+60,((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
            tracep->chgBit(oldp+61,((0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
            tracep->chgBit(oldp+62,((0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
            tracep->chgBit(oldp+63,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
            tracep->chgBit(oldp+64,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xa5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
            tracep->chgCData(oldp+65,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0xa5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 0U
                                                  : 
                                                 ((0x85U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                   : 
                                                  ((0x86U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                                 : 0U))),8);
            tracep->chgBit(oldp+66,((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
            tracep->chgBit(oldp+67,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
            tracep->chgBit(oldp+68,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (0xb5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))));
            tracep->chgCData(oldp+69,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0xb5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 0U
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                 : 0U))),8);
            tracep->chgBit(oldp+70,((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))));
            tracep->chgSData(oldp+71,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc),16);
            tracep->chgSData(oldp+72,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr),16);
            tracep->chgBit(oldp+73,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        | ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                           & (0xadU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))));
            tracep->chgBit(oldp+74,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                           & (0xadU 
                                              != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))));
            tracep->chgCData(oldp+75,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 0U
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((0xadU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 0U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                  : 0U)))),8);
            tracep->chgCData(oldp+76,(((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))),8);
            tracep->chgBit(oldp+77,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))));
            tracep->chgCData(oldp+78,(((8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))),8);
            tracep->chgCData(oldp+79,((0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                - (IData)(1U)))),8);
            tracep->chgSData(oldp+80,((0x100U | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))),16);
            tracep->chgCData(oldp+81,((0xffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))),8);
            tracep->chgSData(oldp+82,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                 : 0U))),16);
            tracep->chgSData(oldp+83,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                            : 0U))),16);
            tracep->chgCData(oldp+84,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647)))),8);
            tracep->chgSData(oldp+85,((0xffffU & ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                   : 
                                                  ((1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                    : 
                                                   ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((3U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))))),16);
            tracep->chgSData(oldp+86,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))),16);
            tracep->chgCData(oldp+87,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle),3);
            tracep->chgCData(oldp+88,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 0U
                                                 : 
                                                (0xffU 
                                                 & ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                     >> 8U)
                                                     : 
                                                    ((3U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                      : 0U)))))),8);
            tracep->chgBit(oldp+89,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                        & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_646)))));
            tracep->chgBit(oldp+90,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done));
            tracep->chgCData(oldp+91,((0xffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(1U) 
                                                 + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))))),8);
            tracep->chgSData(oldp+92,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : 0U)))),16);
            tracep->chgBit(oldp+93,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                     & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))));
            tracep->chgCData(oldp+94,((0xffU & ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                  - (IData)(1U))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647))))),8);
            tracep->chgBit(oldp+95,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                              : ((3U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))));
            tracep->chgCData(oldp+96,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 1U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 2U
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 3U
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 4U
                                                   : 
                                                  ((4U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 5U
                                                    : 
                                                   (7U 
                                                    & ((IData)(1U) 
                                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))))))))),3);
            tracep->chgSData(oldp+97,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                (0x100U 
                                                 | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  (0x100U 
                                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : 
                                                  ((4U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 0xfffeU
                                                    : 
                                                   ((5U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 0xffffU
                                                     : 0U))))))),16);
            tracep->chgCData(oldp+98,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? 0U : (0xffU 
                                                & ((1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                    >> 8U)
                                                    : 
                                                   ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((3U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T)
                                                      : 0U)))))),8);
            tracep->chgBit(oldp+99,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite));
            tracep->chgBit(oldp+100,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                         & ((2U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                            & ((3U 
                                                != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                               & ((4U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                  | (5U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))));
            tracep->chgBit(oldp+101,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                         & ((2U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                            & ((3U 
                                                != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                               & ((4U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                  & (5U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))));
            tracep->chgCData(oldp+102,((0xffU & ((0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : 
                                                 ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : 
                                                  ((2U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))),8);
            tracep->chgSData(oldp+103,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 (0x100U 
                                                  | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))),16);
            tracep->chgBit(oldp+104,((((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (((((((0xaaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0xa8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x98U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xbaU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x9aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (((((((0xe8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0xc8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0xcaU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x88U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x1aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x3aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | ((0x69U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | ((0xe9U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  | (((0xe6U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0xc6U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1309)))))))));
            tracep->chgCData(oldp+105,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle),3);
            tracep->chgCData(oldp+106,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409))),8);
            tracep->chgSData(oldp+107,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? 0U : (((
                                                   ((((0xaaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0xa8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x8aU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x98U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x9aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? 0U
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399)))),16);
            tracep->chgBit(oldp+108,(((~ ((((((((0x18U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (0x38U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0xd8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xf8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x58U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x78U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xb8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xeaU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                      & ((~ ((((((0xaaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0xa8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x8aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x98U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xbaU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x9aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                         & ((~ ((((
                                                   ((0xe8U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xc8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xcaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x88U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0x1aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x3aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                            & ((0x69U 
                                                != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               & ((0xe9U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  & (((0xe6U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (0xc6U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1325)))))))));
            tracep->chgBit(oldp+109,(((~ ((((((((0x18U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (0x38U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0xd8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xf8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x58U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x78U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xb8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xeaU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                      & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421))));
            tracep->chgBit(oldp+110,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_done));
            tracep->chgCData(oldp+111,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                  ? 0U
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle)
                                                   : 0U)))),3);
            tracep->chgSData(oldp+112,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                  ? 0U
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? 
                                                  (((((((((0x18U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                          | (0x38U 
                                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                         | (0xd8U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xf8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x58U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x78U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xb8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xeaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 0U
                                                    : 
                                                   (((((((0xaaU 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0xa8U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0x8aU 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x98U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xbaU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x9aU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                     ? 0U
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399)))
                                                   : 0U)))),16);
            tracep->chgBit(oldp+113,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                         & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1460)))));
            tracep->chgBit(oldp+114,(((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                      & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                         & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                                            & ((~ (
                                                   (((((((0x18U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0x38U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xd8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xf8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x58U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xb8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xeaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                               & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421)))))));
            tracep->chgCData(oldp+115,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))))),8);
            tracep->chgBit(oldp+116,(vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_en_pipe_0));
            tracep->chgSData(oldp+117,(vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0),11);
            tracep->chgCData(oldp+118,(vlTOPp->NESSystem__DOT__ppu__DOT__vram
                                       [vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0]),8);
            tracep->chgSData(oldp+119,((0x7ffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg))),11);
            tracep->chgBit(oldp+120,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
                                      & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                         & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                            & ((3U 
                                                != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                               & ((4U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                  & ((5U 
                                                      != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                     & ((6U 
                                                         != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                        & (7U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)))))))))));
            tracep->chgBit(oldp+121,(vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_en_pipe_0));
            tracep->chgCData(oldp+122,(vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0),8);
            tracep->chgCData(oldp+123,(vlTOPp->NESSystem__DOT__ppu__DOT__oam
                                       [vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0]),8);
            tracep->chgCData(oldp+124,(vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr),8);
            tracep->chgBit(oldp+125,(((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
                                      & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                         & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                            & ((3U 
                                                != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                               & (4U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))))))));
            tracep->chgBit(oldp+126,(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch));
            tracep->chgSData(oldp+127,(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg),16);
            tracep->chgBit(oldp+128,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_en_pipe_0));
            tracep->chgSData(oldp+129,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0),11);
            tracep->chgCData(oldp+130,(vlTOPp->NESSystem__DOT__memory__DOT__internalRAM
                                       [vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0]),8);
            tracep->chgSData(oldp+131,((0x7ffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))),11);
            tracep->chgBit(oldp+132,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
                                      & (0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))));
            tracep->chgBit(oldp+133,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_en_pipe_0));
            tracep->chgSData(oldp+134,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0),15);
            tracep->chgCData(oldp+135,(vlTOPp->NESSystem__DOT__memory__DOT__prgROM
                                       [vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0]),8);
            tracep->chgSData(oldp+136,((0x7fffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))),15);
            tracep->chgBit(oldp+137,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
                                      & ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                                         & ((~ (IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3)) 
                                            & (0x8000U 
                                               <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))))));
            tracep->chgSData(oldp+138,((0xffffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr) 
                                                   - (IData)(0x8000U)))),16);
        }
        if (VL_UNLIKELY((vlTOPp->__Vm_traceActivity
                         [1U] | vlTOPp->__Vm_traceActivity
                         [2U]))) {
            tracep->chgBit(oldp+139,((((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                              >> 7U)) 
                                       == (1U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 7U))) 
                                      & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                >> 7U)) 
                                         != (1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                                   >> 7U))))));
            tracep->chgBit(oldp+140,((((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                              >> 7U)) 
                                       != (1U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 7U))) 
                                      & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                >> 7U)) 
                                         != (1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                                   >> 7U))))));
            tracep->chgBit(oldp+141,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+142,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
            tracep->chgCData(oldp+143,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 0U
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6)
                                                   : 0U)))),8);
            tracep->chgBit(oldp+144,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
            tracep->chgBit(oldp+145,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((6U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 7U)
                                                   : 
                                                  ((0x46U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                    : 
                                                   ((0x26U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                     >> 7U)
                                                     : 
                                                    ((0x66U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))));
            tracep->chgBit(oldp+146,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+147,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
            tracep->chgCData(oldp+148,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 0U
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9)
                                                   : 0U)))),8);
            tracep->chgSData(oldp+149,((0x1ffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                                  - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)))),9);
            tracep->chgBit(oldp+150,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                      >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
            tracep->chgBit(oldp+151,(((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                      == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
            tracep->chgBit(oldp+152,((1U & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                             - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)) 
                                            >> 7U))));
            tracep->chgBit(oldp+153,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                              >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
            tracep->chgBit(oldp+154,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                              == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
            tracep->chgBit(oldp+155,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T) 
                                                 >> 7U)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
            tracep->chgSData(oldp+156,((0xffffU & (
                                                   (1U 
                                                    & ((0xf0U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                                        : 
                                                       ((0xd0U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                         ? 
                                                        (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                                         : 
                                                        ((0xb0U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                          : 
                                                         ((0x90U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                           ? 
                                                          (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                                           : 
                                                          ((0x30U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                            : 
                                                           ((0x10U 
                                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                             ? 
                                                            (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                             : 
                                                            ((0x70U 
                                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                              : 
                                                             ((0x50U 
                                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                              & (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))))))))))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                    + 
                                                    ((0xff00U 
                                                      & ((- (IData)(
                                                                    (1U 
                                                                     & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                                        >> 7U)))) 
                                                         << 8U)) 
                                                     | (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))),16);
            tracep->chgCData(oldp+157,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))),8);
            tracep->chgCData(oldp+158,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                         : ((0xa2U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))),8);
            tracep->chgCData(oldp+159,(((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                         : ((0xa2U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                             : ((0xa0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))),8);
            tracep->chgCData(oldp+160,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? ((0xa5U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
            tracep->chgBit(oldp+161,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? ((0xa5U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
            tracep->chgBit(oldp+162,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0xa5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
            tracep->chgCData(oldp+163,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? ((0xb5U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
            tracep->chgBit(oldp+164,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? ((0xb5U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))));
            tracep->chgBit(oldp+165,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0xb5U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
            tracep->chgSData(oldp+166,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (0xffU & 
                                            ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                             + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))),16);
            tracep->chgCData(oldp+167,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0xadU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
            tracep->chgBit(oldp+168,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? ((0xadU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+169,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((0xadU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 7U)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
            tracep->chgCData(oldp+170,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
            tracep->chgBit(oldp+171,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+172,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                 : 
                                                ((2U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))));
            tracep->chgSData(oldp+173,((0xffffU & (
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector) 
                                                     + 
                                                     ((0xbdU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
            tracep->chgCData(oldp+174,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? ((0x68U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))),8);
            tracep->chgBit(oldp+175,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                  : (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
            tracep->chgBit(oldp+176,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 1U))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+177,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 2U))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
            tracep->chgBit(oldp+178,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 3U))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
            tracep->chgBit(oldp+179,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 6U))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))));
            tracep->chgBit(oldp+180,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 7U))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))));
            tracep->chgSData(oldp+181,((0xffffU & (
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))),16);
            tracep->chgSData(oldp+182,((0xffffU & (
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((2U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 
                                                     ((IData)(1U) 
                                                      + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))),16);
            tracep->chgSData(oldp+183,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)))),16);
            tracep->chgSData(oldp+184,((0xffffU & (
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                     : 
                                                    ((2U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                      : 
                                                     ((3U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                       : 
                                                      ((4U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                        : 
                                                       ((5U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))))))),16);
            tracep->chgSData(oldp+185,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                 : 
                                                ((3U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                  : 
                                                 ((4U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))))),16);
            tracep->chgSData(oldp+186,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                 : 
                                                ((3U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))),16);
            tracep->chgBit(oldp+187,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
            tracep->chgBit(oldp+188,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 1U)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))));
            tracep->chgBit(oldp+189,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 2U)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
            tracep->chgBit(oldp+190,((1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 
                                                ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 3U)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
            tracep->chgSData(oldp+191,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
            tracep->chgCData(oldp+192,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : (((((((0xaaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0xa8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x8aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x98U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xbaU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x9aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                             ? ((0xaaU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                 : 
                                                ((0xa8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 ((0x8aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                   : 
                                                  ((0x98U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387)))),8);
            tracep->chgCData(oldp+193,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407))),8);
            tracep->chgCData(oldp+194,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408))),8);
            tracep->chgSData(oldp+195,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                         : (((((((0xaaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0xa8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x8aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x98U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xbaU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x9aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391)))),16);
            tracep->chgBit(oldp+196,((((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? ((0x18U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          & ((0x38U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                       : (((((((0xaaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0xa8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x8aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x98U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xbaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x9aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392)))));
            tracep->chgBit(oldp+197,((((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                       : (((((((0xaaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0xa8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x8aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x98U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xbaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x9aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? ((0xaaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                               : ((0xa8U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                   : 
                                                  ((0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   (0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                                    : 
                                                   ((0x98U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    (0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                                     : 
                                                    ((0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     (0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1393)))));
            tracep->chgBit(oldp+198,((((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                           : ((0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                               : ((0xd8U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                   : 
                                                  ((0xf8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                    : 
                                                   ((0x58U 
                                                     != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    & ((0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))
                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413))));
            tracep->chgBit(oldp+199,((((((((((0x18U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x38U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0xd8U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0xf8U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x58U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                           : ((0x38U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                               : ((0xd8U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                   : 
                                                  ((0xf8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0x58U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                     : 
                                                    ((0x78U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                      : 
                                                     ((0xb8U 
                                                       != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))
                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416))));
            tracep->chgBit(oldp+200,((1U & ((((((((
                                                   (0x18U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0x38U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xd8U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0xf8U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x58U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x78U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xb8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xeaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                             : ((((
                                                   (((0xaaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (0xa8U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x8aU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x98U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xbaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0x9aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                 ? 
                                                ((0xaaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                  >> 7U)
                                                  : 
                                                 ((0xa8U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                   >> 7U)
                                                   : 
                                                  ((0x8aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                    >> 7U)
                                                    : 
                                                   ((0x98U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                                     >> 7U)
                                                     : 
                                                    ((0xbaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                      >> 7U)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1398))))));
            tracep->chgSData(oldp+201,((((((((((0x18U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x38U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0xd8U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0xf8U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x58U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x78U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0xb8U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? 0U : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422))),16);
            tracep->chgCData(oldp+202,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? 0U : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                  ? 0U
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData)
                                                   : 0U)))),8);
            tracep->chgCData(oldp+203,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                  : 
                                                 (((((((0xaaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (0xa8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x8aU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x98U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xbaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x9aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  ((0xaaU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                    : 
                                                   ((0xa8U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                     : 
                                                    ((0x8aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                      : 
                                                     ((0x98U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387)))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))),8);
            tracep->chgCData(oldp+204,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))),8);
            tracep->chgCData(oldp+205,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))),8);
            tracep->chgSData(oldp+206,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                  : 
                                                 (((((((0xaaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       | (0xa8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x8aU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x98U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xbaU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x9aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391)))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))),16);
            tracep->chgBit(oldp+207,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? ((
                                                   (((((((0x18U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0x38U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xd8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xf8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x58U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xb8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xeaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  ((0x18U 
                                                    != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   & ((0x38U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                                   : 
                                                  (((((((0xaaU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0xa8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x8aU 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x98U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0xbaU 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x9aU 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392)))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))))));
            tracep->chgBit(oldp+208,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? ((
                                                   (((((((0x18U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0x38U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xd8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xf8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x58U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xb8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xeaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  ((0x18U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                    : 
                                                   ((0x38U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                     : 
                                                    ((0xd8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                      : 
                                                     ((0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                       : 
                                                      ((0x58U 
                                                        != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                       & ((0x78U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                          | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))));
            tracep->chgBit(oldp+209,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD)
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD))))));
            tracep->chgBit(oldp+210,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? ((
                                                   (((((((0x18U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0x38U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0xd8U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xf8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x58U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x78U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xb8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xeaU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  ((0x18U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                    : 
                                                   ((0x38U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                     : 
                                                    ((0xd8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                      : 
                                                     ((0xf8U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                       : 
                                                      ((0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                        : 
                                                       ((0x78U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                         : 
                                                        ((0xb8U 
                                                          != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))));
            tracep->chgBit(oldp+211,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1457)))));
            tracep->chgSData(oldp+212,(((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                         : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                             : ((2U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                 ? 
                                                (((((((((0x18U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x38U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0xd8U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0xf8U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x58U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x78U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xb8U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0xeaU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? 0U
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))),16);
        }
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[2U])) {
            tracep->chgCData(oldp+213,(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut),8);
            tracep->chgCData(oldp+214,(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut),8);
            tracep->chgCData(oldp+215,(vlTOPp->NESSystem__DOT__memory_io_ppuDataIn),8);
            tracep->chgSData(oldp+216,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector),16);
            tracep->chgSData(oldp+217,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum),10);
            tracep->chgCData(oldp+218,((0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum))),8);
            tracep->chgBit(oldp+219,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                            >> 8U))));
            tracep->chgBit(oldp+220,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                            >> 7U))));
            tracep->chgBit(oldp+221,((0U == (0xffU 
                                             & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum)))));
            tracep->chgSData(oldp+222,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff),10);
            tracep->chgCData(oldp+223,((0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff))),8);
            tracep->chgBit(oldp+224,((1U & (~ ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                               >> 8U)))));
            tracep->chgBit(oldp+225,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                            >> 7U))));
            tracep->chgBit(oldp+226,((0U == (0xffU 
                                             & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff)))));
            tracep->chgCData(oldp+227,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6),8);
            tracep->chgSData(oldp+228,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand),16);
            tracep->chgCData(oldp+229,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7),8);
            tracep->chgBit(oldp+230,((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7) 
                                            >> 7U))));
            tracep->chgBit(oldp+231,((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7))));
            tracep->chgBit(oldp+232,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV));
            tracep->chgBit(oldp+233,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN));
            tracep->chgCData(oldp+234,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9),8);
            tracep->chgBit(oldp+235,((0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))));
            tracep->chgSData(oldp+236,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand),16);
            tracep->chgBit(oldp+237,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD));
            tracep->chgCData(oldp+238,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData),8);
            tracep->chgBit(oldp+239,(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ));
        }
        tracep->chgBit(oldp+240,(vlTOPp->clock));
        tracep->chgBit(oldp+241,(vlTOPp->reset));
        tracep->chgSData(oldp+242,(vlTOPp->io_pixelX),9);
        tracep->chgSData(oldp+243,(vlTOPp->io_pixelY),9);
        tracep->chgCData(oldp+244,(vlTOPp->io_pixelColor),6);
        tracep->chgBit(oldp+245,(vlTOPp->io_vblank));
        tracep->chgCData(oldp+246,(vlTOPp->io_controller1),8);
        tracep->chgCData(oldp+247,(vlTOPp->io_controller2),8);
        tracep->chgCData(oldp+248,(vlTOPp->io_debug_regA),8);
        tracep->chgCData(oldp+249,(vlTOPp->io_debug_regX),8);
        tracep->chgCData(oldp+250,(vlTOPp->io_debug_regY),8);
        tracep->chgSData(oldp+251,(vlTOPp->io_debug_regPC),16);
        tracep->chgCData(oldp+252,(vlTOPp->io_debug_regSP),8);
        tracep->chgBit(oldp+253,(vlTOPp->io_debug_flagC));
        tracep->chgBit(oldp+254,(vlTOPp->io_debug_flagZ));
        tracep->chgBit(oldp+255,(vlTOPp->io_debug_flagN));
        tracep->chgBit(oldp+256,(vlTOPp->io_debug_flagV));
        tracep->chgCData(oldp+257,(vlTOPp->io_debug_opcode),8);
        tracep->chgBit(oldp+258,(vlTOPp->io_romLoadEn));
        tracep->chgSData(oldp+259,(vlTOPp->io_romLoadAddr),16);
        tracep->chgCData(oldp+260,(vlTOPp->io_romLoadData),8);
        tracep->chgBit(oldp+261,(vlTOPp->io_romLoadPRG));
        tracep->chgSData(oldp+262,((0x7fffU & (IData)(vlTOPp->io_romLoadAddr))),15);
        tracep->chgBit(oldp+263,((((IData)(vlTOPp->io_romLoadEn) 
                                   & (IData)(vlTOPp->io_romLoadPRG)) 
                                  & (0x8000U > (IData)(vlTOPp->io_romLoadAddr)))));
    }
}

void VNESSystem::traceCleanup(void* userp, VerilatedVcd* /*unused*/) {
    VNESSystem__Syms* __restrict vlSymsp = static_cast<VNESSystem__Syms*>(userp);
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
        vlTOPp->__Vm_traceActivity[2U] = 0U;
    }
}
