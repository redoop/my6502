// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VNESSYSTEM_H_
#define _VNESSYSTEM_H_  // guard

#include "verilated.h"

//==========

class VNESSystem__Syms;

//----------

VL_MODULE(VNESSystem) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_OUT8(io_pixelColor,5,0);
    VL_OUT8(io_vblank,0,0);
    VL_IN8(io_controller1,7,0);
    VL_IN8(io_controller2,7,0);
    VL_OUT8(io_debug_regA,7,0);
    VL_OUT8(io_debug_regX,7,0);
    VL_OUT8(io_debug_regY,7,0);
    VL_OUT8(io_debug_regSP,7,0);
    VL_OUT8(io_debug_flagC,0,0);
    VL_OUT8(io_debug_flagZ,0,0);
    VL_OUT8(io_debug_flagN,0,0);
    VL_OUT8(io_debug_flagV,0,0);
    VL_OUT8(io_debug_opcode,7,0);
    VL_IN8(io_romLoadEn,0,0);
    VL_IN8(io_romLoadData,7,0);
    VL_IN8(io_romLoadPRG,0,0);
    VL_OUT16(io_pixelX,8,0);
    VL_OUT16(io_pixelY,8,0);
    VL_OUT16(io_debug_regPC,15,0);
    VL_IN16(io_romLoadAddr,15,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*7:0*/ NESSystem__DOT__memory_io_cpuDataOut;
        CData/*2:0*/ NESSystem__DOT__memory_io_ppuAddr;
        CData/*7:0*/ NESSystem__DOT__memory_io_ppuDataIn;
        CData/*0:0*/ NESSystem__DOT__memory_io_ppuWrite;
        CData/*0:0*/ NESSystem__DOT__memory_io_ppuRead;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core_io_memDataOut;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core_io_memWrite;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core_io_memRead;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_a;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_x;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_y;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_sp;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagC;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagZ;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagI;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagD;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagV;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_flagN;
        CData/*1:0*/ NESSystem__DOT__cpu__DOT__core__DOT__state;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__opcode;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT__cycle;
        CData/*1:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_0;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_6;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memRead;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_nextCycle;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_done;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_res_T_11;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_7;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagV;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_7_flagN;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_nextCycle;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_done;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_8;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_res_9;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_regValue;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_501;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_pushData_T;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_647;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_646;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_nextCycle;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_22_done;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_24_memWrite;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1086;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1108;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1109;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1115;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1132;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1136;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1140;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1157;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1158;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1164;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1167;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1169;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1173;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1184;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1191;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1208;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1238;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1250;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1254;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1259;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1261;
    };
    struct {
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1274;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1275;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1279;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1291;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1300;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1302;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1305;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1309;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1322;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1325;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1387;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1392;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1393;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1398;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1407;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1408;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1409;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1413;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1416;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1421;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_nextCycle;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_regs_flagD;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_1_memData;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1488;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_done;
        CData/*2:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1442;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1457;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1460;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_a;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_x;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_y;
        CData/*7:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_sp;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagC;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagZ;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagI;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagD;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagV;
        CData/*0:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_flagN;
        CData/*7:0*/ NESSystem__DOT__ppu__DOT__oam_io_cpuDataOut_MPORT_addr_pipe_0;
        CData/*7:0*/ NESSystem__DOT__ppu__DOT__oamAddr;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT__ppuAddrLatch;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT__vblankFlag;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT___GEN_6;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT___GEN_30;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT___GEN_33;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT___GEN_39;
        CData/*7:0*/ NESSystem__DOT__ppu__DOT___GEN_87;
        CData/*0:0*/ NESSystem__DOT__ppu__DOT___GEN_95;
        CData/*0:0*/ NESSystem__DOT__memory__DOT___T_3;
        CData/*0:0*/ NESSystem__DOT__memory__DOT___GEN_29;
        CData/*0:0*/ NESSystem__DOT__memory__DOT___GEN_30;
        CData/*2:0*/ NESSystem__DOT__memory__DOT___GEN_37;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core_io_memAddr;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__regs_pc;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__operand;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__resetVector;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___regs_pc_T_1;
        SData/*9:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_sum;
        SData/*8:0*/ NESSystem__DOT__cpu__DOT__core__DOT___execResult_result_diff_T;
        SData/*9:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_diff;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_84;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_5_pc;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_memAddr;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_6_operand;
    };
    struct {
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_8_memAddr;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_newRegs_16_pc;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_memAddr;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_result_result_17_operand;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_644;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1030;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1057;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1118;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1201;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1209;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1251;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1391;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1399;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT___GEN_1422;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_regs_pc;
        SData/*15:0*/ NESSystem__DOT__cpu__DOT__core__DOT__execResult_operand;
        SData/*10:0*/ NESSystem__DOT__ppu__DOT__vram_io_cpuDataOut_MPORT_1_addr_pipe_0;
        SData/*15:0*/ NESSystem__DOT__ppu__DOT__ppuAddrReg;
        SData/*8:0*/ NESSystem__DOT__ppu__DOT__scanlineX;
        SData/*8:0*/ NESSystem__DOT__ppu__DOT__scanlineY;
        SData/*8:0*/ NESSystem__DOT__ppu__DOT___scanlineX_T_1;
        SData/*8:0*/ NESSystem__DOT__ppu__DOT___scanlineY_T_1;
        SData/*15:0*/ NESSystem__DOT__ppu__DOT___GEN_46;
        SData/*15:0*/ NESSystem__DOT__ppu__DOT___GEN_96;
        SData/*10:0*/ NESSystem__DOT__memory__DOT__internalRAM_io_cpuDataOut_MPORT_addr_pipe_0;
        SData/*14:0*/ NESSystem__DOT__memory__DOT__prgROM_io_cpuDataOut_MPORT_1_addr_pipe_0;
        CData/*7:0*/ NESSystem__DOT__ppu__DOT__vram[2048];
        CData/*7:0*/ NESSystem__DOT__ppu__DOT__oam[256];
        CData/*7:0*/ NESSystem__DOT__memory__DOT__internalRAM[2048];
        CData/*7:0*/ NESSystem__DOT__memory__DOT__prgROM[32768];
    };
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*0:0*/ __Vclklast__TOP__clock;
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    VNESSystem__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VNESSystem);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    VNESSystem(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~VNESSystem();
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(VNESSystem__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(VNESSystem__Syms* symsp, bool first);
  private:
    static QData _change_request(VNESSystem__Syms* __restrict vlSymsp);
    static QData _change_request_1(VNESSystem__Syms* __restrict vlSymsp);
  public:
    static void _combo__TOP__4(VNESSystem__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(VNESSystem__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(VNESSystem__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(VNESSystem__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _initial__TOP__1(VNESSystem__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(VNESSystem__Syms* __restrict vlSymsp);
    static void _settle__TOP__3(VNESSystem__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
