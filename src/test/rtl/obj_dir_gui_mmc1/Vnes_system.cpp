// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vnes_system__pch.h"

//============================================================
// Constructors

Vnes_system::Vnes_system(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vnes_system__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , rst_n{vlSymsp->TOP.rst_n}
    , video_r{vlSymsp->TOP.video_r}
    , video_g{vlSymsp->TOP.video_g}
    , video_b{vlSymsp->TOP.video_b}
    , video_hsync{vlSymsp->TOP.video_hsync}
    , video_vsync{vlSymsp->TOP.video_vsync}
    , video_de{vlSymsp->TOP.video_de}
    , audio_ready{vlSymsp->TOP.audio_ready}
    , controller1{vlSymsp->TOP.controller1}
    , controller2{vlSymsp->TOP.controller2}
    , prg_rom_data{vlSymsp->TOP.prg_rom_data}
    , chr_rom_data{vlSymsp->TOP.chr_rom_data}
    , chr_ram_data{vlSymsp->TOP.chr_ram_data}
    , chr_ram_write{vlSymsp->TOP.chr_ram_write}
    , debug_cpu_rw{vlSymsp->TOP.debug_cpu_rw}
    , debug_ppustatus{vlSymsp->TOP.debug_ppustatus}
    , debug_vblank{vlSymsp->TOP.debug_vblank}
    , debug_vblank_sync1{vlSymsp->TOP.debug_vblank_sync1}
    , debug_vblank_sync2{vlSymsp->TOP.debug_vblank_sync2}
    , debug_nmi{vlSymsp->TOP.debug_nmi}
    , debug_ppuctrl{vlSymsp->TOP.debug_ppuctrl}
    , audio_l{vlSymsp->TOP.audio_l}
    , audio_r{vlSymsp->TOP.audio_r}
    , vram_write_count{vlSymsp->TOP.vram_write_count}
    , nmi_trigger_count{vlSymsp->TOP.nmi_trigger_count}
    , debug_cpu_addr{vlSymsp->TOP.debug_cpu_addr}
    , prg_rom_addr{vlSymsp->TOP.prg_rom_addr}
    , chr_rom_addr{vlSymsp->TOP.chr_rom_addr}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vnes_system::Vnes_system(const char* _vcname__)
    : Vnes_system(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vnes_system::~Vnes_system() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vnes_system___024root___eval_debug_assertions(Vnes_system___024root* vlSelf);
#endif  // VL_DEBUG
void Vnes_system___024root___eval_static(Vnes_system___024root* vlSelf);
void Vnes_system___024root___eval_initial(Vnes_system___024root* vlSelf);
void Vnes_system___024root___eval_settle(Vnes_system___024root* vlSelf);
void Vnes_system___024root___eval(Vnes_system___024root* vlSelf);

void Vnes_system::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vnes_system::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vnes_system___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vnes_system___024root___eval_static(&(vlSymsp->TOP));
        Vnes_system___024root___eval_initial(&(vlSymsp->TOP));
        Vnes_system___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vnes_system___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vnes_system::eventsPending() { return false; }

uint64_t Vnes_system::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vnes_system::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vnes_system___024root___eval_final(Vnes_system___024root* vlSelf);

VL_ATTR_COLD void Vnes_system::final() {
    Vnes_system___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vnes_system::hierName() const { return vlSymsp->name(); }
const char* Vnes_system::modelName() const { return "Vnes_system"; }
unsigned Vnes_system::threads() const { return 1; }
void Vnes_system::prepareClone() const { contextp()->prepareClone(); }
void Vnes_system::atClone() const {
    contextp()->threadPoolpOnClone();
}
