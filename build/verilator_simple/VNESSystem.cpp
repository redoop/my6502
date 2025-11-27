// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VNESSystem.h for the primary calling header

#include "VNESSystem.h"
#include "VNESSystem__Syms.h"

//==========

void VNESSystem::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VNESSystem::eval\n"); );
    VNESSystem__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/opt/github/my6502/generated/nes/NESSystem.v", 1651, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VNESSystem::_eval_initial_loop(VNESSystem__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/opt/github/my6502/generated/nes/NESSystem.v", 1651, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void VNESSystem::_sequent__TOP__2(VNESSystem__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_sequent__TOP__2\n"); );
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    CData/*1:0*/ __Vdly__NESSystem__DOT__cpu__DOT__core__DOT__state;
    CData/*7:0*/ __Vdlyvdim0__NESSystem__DOT__ppu__DOT__oam__v0;
    CData/*7:0*/ __Vdlyvval__NESSystem__DOT__ppu__DOT__oam__v0;
    CData/*0:0*/ __Vdlyvset__NESSystem__DOT__ppu__DOT__oam__v0;
    CData/*7:0*/ __Vdlyvval__NESSystem__DOT__ppu__DOT__vram__v0;
    CData/*0:0*/ __Vdlyvset__NESSystem__DOT__ppu__DOT__vram__v0;
    CData/*7:0*/ __Vdlyvval__NESSystem__DOT__memory__DOT__internalRAM__v0;
    CData/*0:0*/ __Vdlyvset__NESSystem__DOT__memory__DOT__internalRAM__v0;
    CData/*7:0*/ __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v0;
    CData/*0:0*/ __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v0;
    CData/*7:0*/ __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v1;
    CData/*0:0*/ __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v1;
    SData/*8:0*/ __Vdly__NESSystem__DOT__ppu__DOT__scanlineX;
    SData/*8:0*/ __Vdly__NESSystem__DOT__ppu__DOT__scanlineY;
    SData/*10:0*/ __Vdlyvdim0__NESSystem__DOT__ppu__DOT__vram__v0;
    SData/*10:0*/ __Vdlyvdim0__NESSystem__DOT__memory__DOT__internalRAM__v0;
    SData/*14:0*/ __Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v0;
    SData/*14:0*/ __Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v1;
    // Body
    __Vdly__NESSystem__DOT__ppu__DOT__scanlineY = vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY;
    __Vdly__NESSystem__DOT__ppu__DOT__scanlineX = vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX;
    __Vdlyvset__NESSystem__DOT__ppu__DOT__oam__v0 = 0U;
    __Vdlyvset__NESSystem__DOT__ppu__DOT__vram__v0 = 0U;
    __Vdlyvset__NESSystem__DOT__memory__DOT__internalRAM__v0 = 0U;
    __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v0 = 0U;
    __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v1 = 0U;
    __Vdly__NESSystem__DOT__cpu__DOT__core__DOT__state 
        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state;
    __Vdly__NESSystem__DOT__ppu__DOT__scanlineX = ((IData)(vlTOPp->reset)
                                                    ? 0U
                                                    : 
                                                   ((0x154U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX))
                                                     ? 0U
                                                     : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___scanlineX_T_1)));
    if (vlTOPp->reset) {
        __Vdly__NESSystem__DOT__ppu__DOT__scanlineY = 0U;
    } else {
        if ((0x154U == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX))) {
            __Vdly__NESSystem__DOT__ppu__DOT__scanlineY 
                = ((0x105U == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY))
                    ? 0U : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___scanlineY_T_1));
        }
    }
    vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch 
        = ((~ (IData)(vlTOPp->reset)) & ((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite)
                                          ? ((0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                              ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39)
                                              : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39)
                                                  : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_95)))
                                          : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39)));
    vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag = 
        ((~ (IData)(vlTOPp->reset)) & ((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead)
                                        ? ((2U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                           & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_6))
                                        : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_6)));
    if (((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead) 
         & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_30))) {
        vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0 
            = vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr;
    }
    if (((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead) 
         & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_33))) {
        vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0 
            = (0x7ffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg));
    }
    if (((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
         & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
            & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
               & ((3U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                  & (4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))))))) {
        __Vdlyvval__NESSystem__DOT__ppu__DOT__oam__v0 
            = vlTOPp->NESSystem__DOT__memory_io_ppuDataIn;
        __Vdlyvset__NESSystem__DOT__ppu__DOT__oam__v0 = 1U;
        __Vdlyvdim0__NESSystem__DOT__ppu__DOT__oam__v0 
            = vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr;
    }
    if (((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite) 
         & ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
            & ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
               & ((3U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                  & ((4U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                     & ((5U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                        & ((6U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                           & (7U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)))))))))) {
        __Vdlyvval__NESSystem__DOT__ppu__DOT__vram__v0 
            = vlTOPp->NESSystem__DOT__memory_io_ppuDataIn;
        __Vdlyvset__NESSystem__DOT__ppu__DOT__vram__v0 = 1U;
        __Vdlyvdim0__NESSystem__DOT__ppu__DOT__vram__v0 
            = (0x7ffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg));
    }
    if (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
         & (0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))) {
        __Vdlyvval__NESSystem__DOT__memory__DOT__internalRAM__v0 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut;
        __Vdlyvset__NESSystem__DOT__memory__DOT__internalRAM__v0 = 1U;
        __Vdlyvdim0__NESSystem__DOT__memory__DOT__internalRAM__v0 
            = (0x7ffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr));
    }
    if (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead) 
         & (0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))) {
        vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0 
            = (0x7ffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr));
    }
    if (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead) 
         & (IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_30))) {
        vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0 
            = (0x7fffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr));
    }
    if (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) 
         & ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
            & ((~ (IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3)) 
               & (0x8000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))))) {
        __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v0 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut;
        __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v0 = 1U;
        __Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v0 
            = (0x7fffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr));
    }
    if ((((IData)(vlTOPp->io_romLoadEn) & (IData)(vlTOPp->io_romLoadPRG)) 
         & (0x8000U > (IData)(vlTOPp->io_romLoadAddr)))) {
        __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v1 
            = vlTOPp->io_romLoadData;
        __Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v1 = 1U;
        __Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v1 
            = (0x7fffU & (IData)(vlTOPp->io_romLoadAddr));
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_a;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_x;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_y;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp = 0xffU;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_sp;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc = 0U;
    } else {
        if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
                if ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector;
                }
            }
        } else {
            if ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc 
                    = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___regs_pc_T_1;
            } else {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_pc;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagC;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagI;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagD;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagV;
                }
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagN;
                }
            }
        }
    }
    __Vdly__NESSystem__DOT__cpu__DOT__core__DOT__state 
        = ((IData)(vlTOPp->reset) ? 0U : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0)
                                               : ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 1U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0)))
                                           : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? 2U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_done)
                                                    ? 1U
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0)))));
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode = 0U;
    } else {
        if ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode 
                    = vlTOPp->NESSystem__DOT__memory_io_cpuDataOut;
            }
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand = 0U;
    } else {
        if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
            if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
                vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand 
                    = vlTOPp->NESSystem__DOT__memory_io_cpuDataOut;
            }
        } else {
            if ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
                    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand 
                        = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_operand;
                }
            }
        }
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle 
        = ((IData)(vlTOPp->reset) ? 0U : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                           ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? 1U
                                               : ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 0U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1)))
                                           : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? 0U
                                               : ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1442)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1)))));
    vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX = __Vdly__NESSystem__DOT__ppu__DOT__scanlineX;
    vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY = __Vdly__NESSystem__DOT__ppu__DOT__scanlineY;
    if (__Vdlyvset__NESSystem__DOT__ppu__DOT__oam__v0) {
        vlTOPp->NESSystem__DOT__ppu__DOT__oam[__Vdlyvdim0__NESSystem__DOT__ppu__DOT__oam__v0] 
            = __Vdlyvval__NESSystem__DOT__ppu__DOT__oam__v0;
    }
    if (__Vdlyvset__NESSystem__DOT__ppu__DOT__vram__v0) {
        vlTOPp->NESSystem__DOT__ppu__DOT__vram[__Vdlyvdim0__NESSystem__DOT__ppu__DOT__vram__v0] 
            = __Vdlyvval__NESSystem__DOT__ppu__DOT__vram__v0;
    }
    if (__Vdlyvset__NESSystem__DOT__memory__DOT__internalRAM__v0) {
        vlTOPp->NESSystem__DOT__memory__DOT__internalRAM[__Vdlyvdim0__NESSystem__DOT__memory__DOT__internalRAM__v0] 
            = __Vdlyvval__NESSystem__DOT__memory__DOT__internalRAM__v0;
    }
    if (__Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v0) {
        vlTOPp->NESSystem__DOT__memory__DOT__prgROM[__Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v0] 
            = __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v0;
    }
    if (__Vdlyvset__NESSystem__DOT__memory__DOT__prgROM__v1) {
        vlTOPp->NESSystem__DOT__memory__DOT__prgROM[__Vdlyvdim0__NESSystem__DOT__memory__DOT__prgROM__v1] 
            = __Vdlyvval__NESSystem__DOT__memory__DOT__prgROM__v1;
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state 
        = __Vdly__NESSystem__DOT__cpu__DOT__core__DOT__state;
    vlTOPp->io_pixelX = vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX;
    vlTOPp->NESSystem__DOT__ppu__DOT___scanlineX_T_1 
        = (0x1ffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX)));
    vlTOPp->io_pixelY = vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY;
    vlTOPp->NESSystem__DOT__ppu__DOT___scanlineY_T_1 
        = (0x1ffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY)));
    vlTOPp->io_vblank = vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag;
    vlTOPp->NESSystem__DOT__ppu__DOT___GEN_6 = ((~ 
                                                 ((0x105U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY)) 
                                                  & (1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX)))) 
                                                & (((0xf1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineY)) 
                                                    & (1U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__scanlineX))) 
                                                   | (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag)));
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr = 0U;
    } else {
        if (vlTOPp->NESSystem__DOT__memory_io_ppuWrite) {
            if ((0U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))) {
                if ((1U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))) {
                    vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr 
                        = vlTOPp->NESSystem__DOT__ppu__DOT___GEN_87;
                }
            }
        }
    }
    vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg = 
        ((IData)(vlTOPp->reset) ? 0U : ((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuWrite)
                                         ? ((0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                             ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46)
                                             : ((1U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46)
                                                 : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_96)))
                                         : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46)));
    vlTOPp->io_debug_regY = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y;
    vlTOPp->io_debug_regX = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x;
    vlTOPp->io_debug_flagV = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV;
    vlTOPp->io_debug_flagZ = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ;
    vlTOPp->io_debug_flagN = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN;
    vlTOPp->io_debug_flagC = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC;
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T 
        = (0x30U | (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN) 
                     << 7U) | (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV) 
                                << 6U) | (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD) 
                                           << 3U) | 
                                          (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI) 
                                            << 2U) 
                                           | (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ) 
                                               << 1U) 
                                              | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))));
    vlTOPp->io_debug_regA = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a;
    vlTOPp->io_debug_opcode = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode;
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8 
        = ((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (0xfeU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                        << 1U)) : ((0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (0x7fU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                >> 1U))
                                    : ((0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? ((0xfeU & 
                                            ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                             << 1U)) 
                                           | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                        : ((0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC) 
                                                << 7U) 
                                               | (0x7fU 
                                                  & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                     >> 1U)))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue 
        = ((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
            : ((0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                : ((0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))));
    vlTOPp->io_debug_regSP = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp;
    vlTOPp->io_debug_regPC = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc;
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___regs_pc_T_1 
        = (0xffffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc 
            = (0xffffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc 
            = (0xffffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle = 1U;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc 
            = (0xffffU & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                           ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc 
            = (0xffffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? 2U : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                         ? 3U : (7U & ((IData)(1U) 
                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647 
        = (0xffU & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                     ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                        - (IData)(1U)) : ((3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                              - (IData)(1U))
                                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle = 1U;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle = 1U;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle 
            = (7U & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? 2U : (7U & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
              & ((2U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                 & (3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
              & (2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501 
        = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           | (2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           & (1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           | (1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                : 0U));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_646 
        = ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           | (3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)));
    if ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644 
            = (0x100U | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_84 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644 
            = ((3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (0x100U | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                : 0U);
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_84 = 0U;
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1115 
        = (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
            | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : (0xffU & (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? ((8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T)
                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                              : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? 0U : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? 0U : (
                                                   (0x20U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 0U
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? 
                                                      ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                                                       >> 8U)
                                                       : 
                                                      ((3U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                        : 0U))))
                                                    : 
                                                   ((0x60U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 0U
                                                     : 
                                                    ((0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((0U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? 0U
                                                       : 
                                                      ((1U 
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
                                                          : 0U))))
                                                      : 0U))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1086 
        = (0xffU & (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                     | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                        - (IData)(1U)) : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           | (0x28U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? ((IData)(1U) 
                                                  + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                           : ((0x4cU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                               : ((0x20U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647)))
                                                   : 
                                                  ((0x60U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
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
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))
                                                    : 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                                      : 
                                                     ((1U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? 
                                                      ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp) 
                                                       - (IData)(1U))
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_647)))
                                                     : 
                                                    ((0x40U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? 
                                                     ((0U 
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
                                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))))
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))))));
    if (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
           | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
          | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
         | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1158 
            = (7U & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1157 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1158 
            = (7U & (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle)
                      : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle)
                          : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle)
                              : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? 0U : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           | (0x28U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle)
                                           : ((0x4cU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle)
                                               : ((0x20U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle)
                                                   : 
                                                  ((0x60U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle)
                                                    : 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? 
                                                    ((0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 1U
                                                      : 
                                                     ((1U 
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
                                                         ((IData)(1U) 
                                                          + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))
                                                     : 
                                                    ((0x40U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle)
                                                      : 0U)))))))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1157 
            = (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
                : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                    : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                        : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                               | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
                               : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
                                   : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done)
                                       : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                           : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? ((0U 
                                                   != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                  & ((1U 
                                                      != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                     & ((2U 
                                                         != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                        & ((3U 
                                                            != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                           & ((4U 
                                                               != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                              & (5U 
                                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))
                                               : ((0x40U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done)))))))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
           & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
              | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_646)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1057 
        = ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                    : 0U)) : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                               ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                   : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))
                               : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? 0U : ((1U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                ? (0x100U 
                                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                : (
                                                   (2U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? 
                                                   (0x100U 
                                                    | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                    : 0U)))
                                   : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? 0U : (
                                                   (1U 
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
                                                        : 0U))))))
                                       : ((0x40U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? 0U
                                               : ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  (0x100U 
                                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_644)))
                                           : 0U)))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_84));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_84));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1191 
        = ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                         ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? ((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? 0U : ((0x85U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                               : ((0x86U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                  : 0U)) : (((0xb5U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x95U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                             ? ((0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                 ? 0U
                                                 : 
                                                ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 
                                                 ((0xb5U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 0U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                                  : 0U))
                                             : (((0xadU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0x8dU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                 ? 
                                                ((0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? 0U
                                                  : 
                                                 ((1U 
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
                                                    : 0U)))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1115)))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1238 
        = ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
            : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                    : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                        : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                            : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                    | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                    : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1086)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1291 
        = ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle)
            : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? 0U : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle)
                         : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                             ? 0U : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle)
                                      : (((((((((0xf0U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (0xd0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0xb0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x90U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x30U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x10U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x50U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x70U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                          ? 0U : ((
                                                   ((0xa9U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xa2U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xa0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 0U
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1158))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1309 
        = ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
           | ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
               : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                     | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                      : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
                             : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                       | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1157)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1173 
        = (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
              | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
               & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                  & (0xa5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))
            : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                   & ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                      & (0xb5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))
                : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                       & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                          & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                             & (0xadU != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))
                    : ((~ ((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                       & (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | ((~ ((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                             & ((0x4cU != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                & ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                       & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                          & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_646)))
                                    : ((0x60U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                       & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite)))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1136 
        = (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
            | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
               | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                  | ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                     & (0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))))
            : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))
                : ((~ ((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                   & (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done)
                       : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
                           : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
                               : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                      & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_501))
                                   : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                          & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                             & ((2U 
                                                 != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                & ((3U 
                                                    != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                   & ((4U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                      | (5U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))))))
                                       : ((0x40U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1209 
        = (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
            : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                 | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr)
                    : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr)
                        : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr)
                            : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr)
                                : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                    | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (0x100U | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                    : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? 0U : 
                                           ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                             ? (0x100U 
                                                | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                             : 0U))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1057)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409 
        = (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                    : ((0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                        : ((0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                            : ((0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                : ((0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)))))))
            : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                    : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                        : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                            : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                    : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x4aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                        : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (0x46U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x26U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x66U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1238))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle 
        = (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? 0U : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? 0U : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? 0U : ((0xe9U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? 0U
                                                : (
                                                   ((0xe6U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xc6U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle)
                                                    : 
                                                   ((((0x29U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (9U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x49U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                     ? 0U
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1291))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1488 
        = ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
           & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
              & (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1309)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1325 
        = ((~ (((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
           & ((0x24U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
              & ((~ ((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                 & (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                     : ((~ (((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                        & ((0xc5U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           & ((~ ((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                              & ((~ (((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                 & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1173)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1250 
        = ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
           | ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
               : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                         ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                            | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                               & (0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))
                         : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                             ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                | ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                   & (0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))))
                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1136)))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399 
        = (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                     : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                         : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr)
                             : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                 : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr)
                                     : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           | (0x4aU 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                          | (0x2aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? 0U : (((
                                                   ((6U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0x46U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x26U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x66U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr)
                                                  : 
                                                 ((((0xc9U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xe0U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xc0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : 
                                                  ((0xc5U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1209)))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_sp 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_done 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
           & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1488));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1460 
        = ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
           & ((~ ((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
              & ((~ ((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                 & ((~ ((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                    & ((0x69U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       & ((0xe9U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          & (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done)
                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1325))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421 
        = ((~ ((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                   | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
           & ((~ ((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
              & ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                 | ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
                        : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
                               : ((~ ((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                                  & (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1250))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? 0xfffcU : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? 0xfffdU : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                        ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                 ? 0U : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                          ? (((((((
                                                   ((0x18U 
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
                                              ? 0U : 
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
                                          : 0U))) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1442 
        = ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_done)
            ? 0U : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                     ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                              ? 0U : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle)
                                       : 0U))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite 
        = ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
           & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
              & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                 & ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                    & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                       & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1460))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
               | (1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)))
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
               | ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                  & ((0U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                     & ((1U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                        & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state)) 
                           & ((~ ((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                      | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) 
                              & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421))))))));
    vlTOPp->NESSystem__DOT__memory__DOT___GEN_30 = 
        ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
         & ((~ ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                & (0x4000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))) 
            & ((0x4016U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
               & ((0x4017U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                  & (0x8000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))))));
    vlTOPp->NESSystem__DOT__memory__DOT___T_3 = ((0x2000U 
                                                  <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                                                 & (0x4000U 
                                                    > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)));
    vlTOPp->NESSystem__DOT__memory__DOT___GEN_37 = 
        ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead)
          ? ((0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
              ? 0U : (((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                       & (0x4000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))
                       ? (7U & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                       : 0U)) : 0U);
    vlTOPp->NESSystem__DOT__memory__DOT___GEN_29 = 
        ((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
         & (IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3));
    if (vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite) {
        vlTOPp->NESSystem__DOT__memory_io_ppuAddr = 
            (7U & ((0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                    ? (IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_37)
                    : ((IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3)
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)
                        : (IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_37))));
        vlTOPp->NESSystem__DOT__memory_io_ppuWrite 
            = ((IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_29) 
               & 1U);
    } else {
        vlTOPp->NESSystem__DOT__memory_io_ppuAddr = 
            (7U & (IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_37));
        vlTOPp->NESSystem__DOT__memory_io_ppuWrite = 0U;
    }
    vlTOPp->NESSystem__DOT__memory_io_ppuRead = ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead) 
                                                 & (IData)(vlTOPp->NESSystem__DOT__memory__DOT___GEN_29));
    vlTOPp->NESSystem__DOT__ppu__DOT___GEN_30 = ((2U 
                                                  != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                 & (4U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)));
    vlTOPp->NESSystem__DOT__ppu__DOT___GEN_33 = ((2U 
                                                  != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                 & ((4U 
                                                     != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
                                                    & (7U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))));
    if (vlTOPp->NESSystem__DOT__memory_io_ppuRead) {
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39 = 
            ((2U != (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr)) 
             & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch));
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46 = 
            (0xffffU & ((2U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                         ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg)
                         : ((4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                             ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg)
                             : ((7U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                 ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg))
                                 : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg)))));
    } else {
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39 = vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch;
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46 = 
            (0xffffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg));
    }
    vlTOPp->NESSystem__DOT__ppu__DOT___GEN_95 = (1U 
                                                 & ((3U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39)
                                                     : 
                                                    ((4U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39)
                                                      : 
                                                     ((5U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                       ? 
                                                      (~ (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch))
                                                       : 
                                                      ((6U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                                        ? 
                                                       (~ (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch))
                                                        : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_39))))));
}

VL_INLINE_OPT void VNESSystem::_combo__TOP__4(VNESSystem__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_combo__TOP__4\n"); );
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->reset) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0 = 0U;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1 = 0U;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_0 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle;
    }
    vlTOPp->NESSystem__DOT__memory_io_cpuDataOut = 
        ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memRead)
          ? ((0x2000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
              ? vlTOPp->NESSystem__DOT__memory__DOT__internalRAM
             [vlTOPp->NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0]
              : (((0x2000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)) 
                  & (0x4000U > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr)))
                  ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuRead)
                      ? ((2U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                          ? ((IData)(vlTOPp->NESSystem__DOT__ppu__DOT__vblankFlag) 
                             << 7U) : ((4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                        ? vlTOPp->NESSystem__DOT__ppu__DOT__oam
                                       [vlTOPp->NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0]
                                        : ((7U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                            ? vlTOPp->NESSystem__DOT__ppu__DOT__vram
                                           [vlTOPp->NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0]
                                            : 0U)))
                      : 0U) : ((0x4016U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                                ? (IData)(vlTOPp->io_controller1)
                                : ((0x4017U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                                    ? (IData)(vlTOPp->io_controller2)
                                    : ((0x8000U <= (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                                        ? vlTOPp->NESSystem__DOT__memory__DOT__prgROM
                                       [vlTOPp->NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0]
                                        : 0U))))) : 0U);
    if (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
           | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
          | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
         | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1275 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1274 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1275 
            = (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                     | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                    : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                        : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                            : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? ((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                    : ((0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                        : ((0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1274 
            = (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                     | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                    : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                        : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                            : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? ((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                    : ((0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1167 
        = (1U & (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                  : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                      : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                          : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                              : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                  : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 3U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))
                                      : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                          : ((0x20U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                              : ((0x60U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                  : 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                   : 
                                                  ((0x40U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                      >> 3U)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1109 
        = (1U & (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                  : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                      : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                              : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? ((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                      : ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                         >> 2U)) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))
                          : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                              : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                  : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                      : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                              : ((1U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                  : 
                                                 ((2U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                   : 
                                                  ((3U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle)) 
                                                   | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))
                                          : ((0x40U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? ((0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                                  : 
                                                 ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 2U)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1164 
        = (1U & (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                  : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                      : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                          : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                              : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                  : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                  : (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                      : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((0x20U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                              : ((0x60U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                  : 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                   : 
                                                  ((0x40U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1140 
        = (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
            | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                    ? ((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))
            : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? ((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))
                : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                            : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))
                    : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                        : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? ((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum 
        = (0x3ffU & ((0x1ffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                + (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))) 
                     + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV 
        = (1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                  : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                      ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                         >> 6U) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1108 
        = (1U & (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))
                  : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                      : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                              : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? ((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                      : ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                         >> 1U)) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                          : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                              : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                  : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                      : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                          : ((0x40U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? ((0U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                                  : 
                                                 ((1U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 1U)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
            ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6 
        = (0xffU & ((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                     ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                     : ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                        - (IData)(1U))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11 
        = ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
           & (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T 
        = (0x1ffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                     - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9 
        = ((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (0xfeU & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                        << 1U)) : ((0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (0x7fU & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                >> 1U))
                                    : ((0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? ((0xfeU & 
                                            ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                             << 1U)) 
                                           | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                        : ((0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC) 
                                                << 7U) 
                                               | (0x7fU 
                                                  & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                     >> 1U)))
                                            : 0U))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector 
        = (((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
            << 8U) | (0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN 
        = (1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                  : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                      ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                         >> 7U) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))));
    if (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
           | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
          | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
         | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408 
            = (0xffU & ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                         : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407 
            = (0xffU & ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                         : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                             : ((0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                 : ((0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                     : ((0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp)
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))))));
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408 
            = (0xffU & (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                         ? ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                             : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                 : ((0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                     : ((0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                            - (IData)(1U))
                                         : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))))
                         : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                             : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                 : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                     : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                         : ((0x24U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1275))))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407 
            = (0xffU & (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                         ? ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                             : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                 : ((0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                        - (IData)(1U))
                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))
                         : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                             : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                 : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                     : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                         : ((0x24U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1274))))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1300 
        = ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
            : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                    : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                        : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                            : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1167))))))));
    if (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
           | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
          | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
         | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1261 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1259 
            = (1U & ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? ((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                     >> 7U) : ((0x46U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                : (
                                                   (0x26U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                    >> 7U)
                                                    : 
                                                   ((0x66U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))
                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1254 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1261 
            = ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                 | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                    : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                        : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                            : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                    | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                    : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1109))))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1259 
            = (1U & ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                         >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                      : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                          ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                              : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                     >= (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                          : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                    | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                              : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                   | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1164))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1254 
            = ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                 | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                    : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                        : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? ((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                            : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? ((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1140))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1169 
        = (1U & (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                  : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                      : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                          : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                              : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                  : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                      ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                              ? ((0x68U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                  : 
                                                 ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                  >> 6U))
                                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))
                                      : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                          : ((0x20U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                              : ((0x60U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                  : 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                   : 
                                                  ((0x40U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)))))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1184 
        = ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
            : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                        ? ((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? ((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                    : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? ((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (0U == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1108)))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7 
        = ((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11)
            : ((9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                   | (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                : ((0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                       ^ (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                    : 0U)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff 
        = (0x3ffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T) 
                     - (1U & (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1305 
        = ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? 0U : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? 0U : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? 0U : (
                                                   (2U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9)
                                                    : 0U)))
                              : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                   | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? 0U : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? 0U : (
                                                   ((((((((0xf0U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                          | (0xd0U 
                                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                         | (0xb0U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0x90U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x30U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x10U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x50U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x70U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 0U
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1191)))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1030 
        = (0xffffU & ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                       ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                           ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                           : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                               : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                   : ((3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))
                       : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                           ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                               : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                   : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? ((IData)(1U) 
                                          + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector))
                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))
                           : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                               ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                   ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                   : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                       : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                           : ((3U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                               : ((4U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : 
                                                  ((5U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))))
                               : ((0x40U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                   ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                       : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                           : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                               : ((3U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))))
                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
            ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1132 
        = (1U & (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                      : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                          : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? ((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                     >> 7U) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                              : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))
                  : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                          : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                              : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                     >> 7U) : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))
                      : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                          : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                  : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                      ? ((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                             >> 7U)
                                          : ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                             >> 7U))
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))
                              : ((0x4cU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                  : ((0x20U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                      : ((0x60U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                          : ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                              : ((0x40U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN)
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))))))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_y 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_x 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_y 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_x 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD 
        = (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                    : ((0xd8U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       & ((0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                          | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)))))
            : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                    : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                        : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                            : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1300))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413 
        = (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
            : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                    : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                        : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                            : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                    : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (0x4aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                        | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1261)))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1302 
        = ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV)
            : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                    : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                        : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                            : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                   | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1169))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1279 
        = (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
              | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8))
            : (((((6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x46U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x26U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x66U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                        : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))
                : ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                     | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                    ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                       == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                    : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                   == (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                        : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1184))))));
    if (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
           | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
          | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
         | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392 
            = (1U & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387 
            = (0xffU & ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                         : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                             : ((0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                 : ((0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                     : ((0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? ((IData)(1U) 
                                            + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                         : ((0x3aU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                - (IData)(1U))
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))))));
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392 
            = (1U & ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                      ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                         >> 8U) : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (~ ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                          >> 8U)) : 
                                   (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                     | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                     : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                          | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                         | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                         : ((0x24U 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                             : ((((
                                                   (0xaU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0x4aU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x2aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                 | (0x6aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                 ? 
                                                ((0xaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                  >> 7U)
                                                  : 
                                                 ((0x4aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                   : 
                                                  ((0x2aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                    >> 7U)
                                                    : 
                                                   ((0x6aU 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))))
                                                 : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1259))))))));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387 
            = (0xffU & ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum)
                         : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff)
                             : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                 : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7)
                                     : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                         ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                         : (((((0xaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x4aU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                              | (0x2aU 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                             | (0x6aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8)
                                             : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1254))))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData 
        = (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                  | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? 0U : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                  | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                 | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                              ? 0U : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? 0U : ((0xe9U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? 0U
                                                : (
                                                   ((0xe6U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xc6U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 0U
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 0U
                                                      : 
                                                     ((2U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6)
                                                       : 0U)))
                                                    : 
                                                   ((((0x29U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                      | (9U 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                     | (0x49U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                     ? 0U
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1305))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1201 
        = (0xffffU & (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                       ? ((1U & ((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                  : ((0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))
                                      : ((0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                          ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                                          : ((0x90U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                              ? (~ (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC))
                                              : ((0x30U 
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
                           ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc) 
                              + ((0xff00U & ((- (IData)(
                                                        (1U 
                                                         & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                            >> 7U)))) 
                                             << 8U)) 
                                 | (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)))
                           : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                       : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                           ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                           : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                               : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                   | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                                   : (((0xadU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                       | (0x8dU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc)
                                       : (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           | (0xb9U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc)
                                           : (((0x48U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (8U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                               : ((
                                                   (0x68U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0x28U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                                   : 
                                                  ((0x4cU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 
                                                    ((IData)(1U) 
                                                     + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1030)))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1118 
        = (0xffffU & (((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0xb9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                       ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                           ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                           : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                               ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__resetVector) 
                                  + ((0xbdU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)))
                               : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)))
                       : (((0x48U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                           ? 0U : (((0x68U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                    | (0x28U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? 0U : ((0x4cU 
                                             == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                             ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                                             : ((0x20U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                 ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand)
                                                 : 
                                                ((0x60U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                  ? 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                   : 
                                                  ((1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)))
                                                  : 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                   ? 
                                                  ((0U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                    : 
                                                   ((1U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                     : 
                                                    ((2U 
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
                                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))))
                                                   : 
                                                  ((0x40U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                                                      : 
                                                     ((2U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1208 
        = (1U & (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                  : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                       | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                         >> 7U) : (((((0xa5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0x85U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x86U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x84U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                        : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? ((0xa5U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                   >> 7U)
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))
                                    : (((0xb5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (0x95U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                        ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                            : ((1U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                ? (
                                                   (0xb5U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                    >> 7U)
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1132))))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagD 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagI 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagD 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD)
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagI 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                            : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                : ((0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                    : ((0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)
                                        : ((0x58U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                           & ((0x78U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                              | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)))))))
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI)));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416 
        = (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
            : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                    | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                 | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                               >> 7U)) == (1U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                 >> 7U))) 
                       & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                 >> 7U)) != (1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                                                   >> 7U))))
                    : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                   >> 7U)) != (1U & 
                                               ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                >> 7U))) 
                           & ((1U & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                     >> 7U)) != (1U 
                                                 & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                                    >> 7U))))
                        : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                            : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                 | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1302)))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1393 
        = (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (0U == (0xffU & ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))))
                : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (0U == (0xffU & ((IData)(1U) 
                                       + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))))
                    : ((0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                        ? (0U == (0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                           - (IData)(1U))))
                        : ((0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (0U == (0xffU & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y) 
                                               - (IData)(1U))))
                            : ((0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (0U == (0xffU & ((IData)(1U) 
                                                   + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))))
                                : ((0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (0U == (0xffU 
                                              & ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                                 - (IData)(1U))))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))))))
            : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                ? (0U == (0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum)))
                : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                    ? (0U == (0xffU & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff)))
                    : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                        | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6))
                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))
                        : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                             | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7))
                            : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                                    : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                        ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11))
                                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)))
                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1279)))))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagC 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_a 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a;
        vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut = 0U;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagC 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? ((0x18U != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           & ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)))
                        : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392)))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_a 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                        : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)
                                    : ((0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)
                                        : ((0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)
                                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)))))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387)))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? 0U : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                         ? ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                             ? 0U : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                      ? 0U : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData)
                                               : 0U)))
                         : 0U));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391 
        = (0xffffU & (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                           | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                       : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                           ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                           : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                               ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                               : (((0xe6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                   | (0xc6U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                                   : ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                        | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                       | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                       ? ((IData)(1U) 
                                          + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                       : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                                           : (((((0xaU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                 | (0x4aU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                | (0x2aU 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                               | (0x6aU 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                               ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                                               : ((
                                                   (((6U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (0x46U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x26U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x66U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                                                   : 
                                                  ((((0xc9U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (0xe0U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0xc0U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 
                                                   ((IData)(1U) 
                                                    + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))
                                                    : 
                                                   ((0xc5U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1201))))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1251 
        = ((((0xc9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
             | (0xe0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0xc0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : ((0xc5U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                     : (((((((((0xf0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                               | (0xd0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0xb0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x90U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x30U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x10U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x50U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x70U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                         ? 0U : ((((0xa9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                   | (0xa2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                  | (0xa0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                  ? 0U : (((((0xa5U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                             | (0x85U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                            | (0x86U 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                           | (0x84U 
                                              == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                           ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                                           : (((0xb5U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                               | (0x95U 
                                                  == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                               ? ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? 
                                                  (0xffU 
                                                   & ((IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut) 
                                                      + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)))
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))
                                               : ((
                                                   (0xadU 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   | (0x8dU 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand)
                                                   : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1118))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1322 
        = (1U & ((((0x29U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                   | (9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x49U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7) 
                     >> 7U) : ((0x24U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN)
                                : (((((0xaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                      | (0x4aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                     | (0x2aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                    | (0x6aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                    ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8) 
                                       >> 7U) : (((
                                                   ((6U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0x46U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0x26U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                  | (0x66U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                   : 
                                                  ((1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                    : 
                                                   ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9) 
                                                     >> 7U)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))
                                                  : 
                                                 ((((0xc9U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                    | (0xe0U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                   | (0xc0U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                   ? 
                                                  (3U 
                                                   & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue) 
                                                       - (IData)(vlTOPp->NESSystem__DOT__memory_io_cpuDataOut)) 
                                                      >> 7U))
                                                   : 
                                                  ((0xc5U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                    ? 
                                                   ((0U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                     : 
                                                    ((1U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                      ? 
                                                     ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T) 
                                                      >> 7U)
                                                      : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))
                                                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1208))))))));
    if ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))) {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagV 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV;
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ 
            = vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ;
    } else {
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagV 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? ((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                            : ((0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                : ((0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                    : ((0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                        : ((0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                            : ((0x78U 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)
                                                : (
                                                   (0xb8U 
                                                    != (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                   & (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV))))))))
                        : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV)));
        vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ 
            = ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)
                        : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a))
                                    : ((0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                        ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x))
                                        : ((0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? (0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y))
                                            : ((0xbaU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? (0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_sp))
                                                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ))))))
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1393)))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ)));
    }
    vlTOPp->NESSystem__DOT__memory_io_ppuDataIn = ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memWrite)
                                                    ? 
                                                   ((0x2000U 
                                                     > (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memAddr))
                                                     ? 0U
                                                     : 
                                                    ((IData)(vlTOPp->NESSystem__DOT__memory__DOT___T_3)
                                                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core_io_memDataOut)
                                                      : 0U))
                                                    : 0U);
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_pc 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                        : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc)
                            : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391)))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_pc))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422 
        = (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
               | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
              | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
             | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
            | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
            ? 0U : (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                         | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                     ? 0U : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                              ? 0U : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                       ? 0U : (((0xe6U 
                                                 == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                | (0xc6U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                                                : (
                                                   (((0x29U 
                                                      == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                     | (9U 
                                                        == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                    | (0x49U 
                                                       == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                    ? 0U
                                                    : 
                                                   ((0x24U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                     ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                                                     : 
                                                    (((((0xaU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                        | (0x4aU 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x2aU 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                      | (0x6aU 
                                                         == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                      ? 0U
                                                      : 
                                                     (((((6U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                         | (0x46U 
                                                            == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                        | (0x26U 
                                                           == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                                                       | (0x66U 
                                                          == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                       ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand)
                                                       : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1251))))))))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1398 
        = (1U & (((((((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                      | (0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                     | (0xcaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                    | (0x88U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                   | (0x1aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                  | (0x3aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                  ? ((0xe8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                      ? (1U & (((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x)) 
                               >> 7U)) : ((0xc8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                           ? (1U & 
                                              (((IData)(1U) 
                                                + (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_y)) 
                                               >> 7U))
                                           : ((0xcaU 
                                               == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                               ? (1U 
                                                  & (((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                      - (IData)(1U)) 
                                                     >> 7U))
                                               : ((0x88U 
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
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)))))))
                  : ((0x69U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                      ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum) 
                         >> 7U) : ((0xe9U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                    ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff) 
                                       >> 7U) : (((0xe6U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                                                  | (0xc6U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                                                  ? 
                                                 ((0U 
                                                   == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                   ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                   : 
                                                  ((1U 
                                                    == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                    ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                                                    : 
                                                   ((2U 
                                                     == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__cycle))
                                                     ? 
                                                    ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6) 
                                                     >> 7U)
                                                     : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN))))
                                                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1322))))));
    if ((3U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))) {
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_87 = 
            (0xffU & (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuDataIn));
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_96 = 
            (0xffffU & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46));
    } else {
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_87 = 
            (0xffU & ((4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                       ? ((IData)(1U) + (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr))
                       : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__oamAddr)));
        vlTOPp->NESSystem__DOT__ppu__DOT___GEN_96 = 
            (0xffffU & ((4U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                         ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46)
                         : ((5U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                             ? (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46)
                             : ((6U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                 ? ((IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrLatch)
                                     ? ((0xff00U & (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg)) 
                                        | (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuDataIn))
                                     : (0x3f00U & ((IData)(vlTOPp->NESSystem__DOT__memory_io_ppuDataIn) 
                                                   << 8U)))
                                 : ((7U == (IData)(vlTOPp->NESSystem__DOT__memory_io_ppuAddr))
                                     ? ((IData)(1U) 
                                        + (IData)(vlTOPp->NESSystem__DOT__ppu__DOT__ppuAddrReg))
                                     : (IData)(vlTOPp->NESSystem__DOT__ppu__DOT___GEN_46))))));
    }
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_operand 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand)
                : ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                    ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                        ? 0U : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422))
                    : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__operand))));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1457 
        = (1U & ((2U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                  ? (((((((((0x18U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                            | (0x38U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0xd8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0xf8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                         | (0x58U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                        | (0x78U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                       | (0xb8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                      | (0xeaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                      ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                      : (((((((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)) 
                              | (0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                             | (0x8aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                            | (0x98U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                           | (0xbaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))) 
                          | (0x9aU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode)))
                          ? ((0xaaU == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                              ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                 >> 7U) : ((0xa8U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                            ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_a) 
                                               >> 7U)
                                            : ((0x8aU 
                                                == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__opcode))
                                                ? ((IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_x) 
                                                   >> 7U)
                                                : (
                                                   (0x98U 
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
                          : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1398)))
                  : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)));
    vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagN 
        = ((0U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
            ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
            : ((1U == (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__state))
                ? (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN)
                : (IData)(vlTOPp->NESSystem__DOT__cpu__DOT__core__DOT___GEN_1457)));
}

void VNESSystem::_eval(VNESSystem__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_eval\n"); );
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->clock) & (~ (IData)(vlTOPp->__Vclklast__TOP__clock)))) {
        vlTOPp->_sequent__TOP__2(vlSymsp);
    }
    vlTOPp->_combo__TOP__4(vlSymsp);
    // Final
    vlTOPp->__Vclklast__TOP__clock = vlTOPp->clock;
}

VL_INLINE_OPT QData VNESSystem::_change_request(VNESSystem__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_change_request\n"); );
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData VNESSystem::_change_request_1(VNESSystem__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_change_request_1\n"); );
    VNESSystem* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VNESSystem::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VNESSystem::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((io_romLoadEn & 0xfeU))) {
        Verilated::overWidthError("io_romLoadEn");}
    if (VL_UNLIKELY((io_romLoadPRG & 0xfeU))) {
        Verilated::overWidthError("io_romLoadPRG");}
}
#endif  // VL_DEBUG
