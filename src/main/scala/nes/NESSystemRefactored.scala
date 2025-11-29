package nes

import chisel3._
import chisel3.util._
import cpu6502.CPU6502Refactored

/**
// * NES Refactored Version
// *  CPU6502Refactored Module
// *  CPU + PPU + APU + Memory
 */
class NESSystemRefactored(enableDebug: Boolean = false) extends Module {
  val io = IO(new Bundle {
    // Output
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    
    // Output
    val audioOut = Output(UInt(16.W))
    
    // ROM Interface
    val prgLoadEn = Input(Bool())
    val prgLoadAddr = Input(UInt(19.W))  // 512KB
    val prgLoadData = Input(UInt(8.W))
    val chrLoadEn = Input(Bool())
    val chrLoadAddr = Input(UInt(13.W))
    val chrLoadData = Input(UInt(8.W))
    
    // Mapper selection
    val mapperNum = Input(UInt(8.W))
    
    // ControlInterface
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // Debug Interface
    val debug = Output(new Bundle {
      val cpuPC = UInt(16.W)
      val cpuA = UInt(8.W)
      val cpuX = UInt(8.W)
      val cpuY = UInt(8.W)
      val ppuCtrl = UInt(8.W)
      val ppuMask = UInt(8.W)
      val vblank = Bool()
      val nmi = Bool()
      val apuPulse1Active = Bool()
      val apuPulse2Active = Bool()
      val cpuState = UInt(3.W)  // CPU State MachineState
      val cpuCycle = UInt(3.W)  // CPU Cycle
      val cpuOpcode = UInt(8.W) // Instructions
      val cpuMemAddr = UInt(16.W) // CPU Address
      val cpuMemDataIn = UInt(8.W) // CPU ReadData
      val cpuMemRead = Bool() // CPU ReadSignal
    })
  })
  
  // CPU
  // CPU
  val cpu = Module(new CPU6502Refactored)
  
  // PPU
  val ppu = Module(new PPURefactored(enableDebug))
  
  // APU - whenDisable，Wait
  // val apu = Module(new APURefactored)
  
  // PRG ROM - 512KB for Mapper 4 only
  // Use Mem (async) for Verilator compatibility
  val prgRom = Mem(524288, UInt(8.W))
  
  when(io.prgLoadEn) {
    prgRom.write(io.prgLoadAddr, io.prgLoadData)
  }
  
  // MMC3 Mapper (Mapper 4)
  val mmc3 = Module(new MMC3Mapper)
  
  // RAM (2KB)
  val ram = Mem(2048, UInt(8.W))
  

  val cpuAddr = cpu.io.memAddr
  when(cpuAddr >= 0x2000.U && cpuAddr <= 0x2010.U) {
    printf("[NES] cpuAddr=$%x memRead=%d\n", cpuAddr, cpu.io.memRead)
  }
  
  val isRam = cpuAddr < 0x2000.U
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  val isApuReg = cpuAddr >= 0x4000.U && cpuAddr < 0x4018.U
  val isController = cpuAddr === 0x4016.U || cpuAddr === 0x4017.U
  val isPrgRom = cpuAddr >= 0x8000.U
  
  // MMC3 Mapper connections
  mmc3.io.cpuAddr := cpuAddr
  mmc3.io.cpuDataIn := cpu.io.memDataOut
  mmc3.io.cpuWrite := cpu.io.memWrite && isPrgRom
  mmc3.io.cpuRead := cpu.io.memRead && isPrgRom
  mmc3.io.ppuAddr := 0.U
  
  // PRG ROM read through MMC3
  val prgData = prgRom.read(mmc3.io.prgAddr)
  mmc3.io.prgData := prgData
  
  // Memory ready: Always ready
  cpu.io.memReady := true.B
  
  // Memory ready logic: Always ready (use async ROM)
  cpu.io.memReady := true.B
  
  // Control strobe
  val controller1Shift = RegInit(0.U(8.W))
  val controller2Shift = RegInit(0.U(8.W))
  val controllerStrobe = RegInit(false.B)
  
  when(cpu.io.memWrite && cpuAddr === 0x4016.U) {
    controllerStrobe := cpu.io.memDataOut(0)
    when(cpu.io.memDataOut(0)) {
      // Strobe = 1: ControlState
      controller1Shift := io.controller1
      controller2Shift := io.controller2
    }
  }
  
  // ControlRead：Read，
  val controller1Data = controller1Shift(0)
  val controller2Data = controller2Shift(0)
  
  when(cpu.io.memRead && isController && !controllerStrobe) {
    when(cpuAddr === 0x4016.U) {
      controller1Shift := controller1Shift >> 1
    }.otherwise {
      controller2Shift := controller2Shift >> 1
    }
  }
  
  val controllerData = Mux(cpuAddr(0), controller2Data, controller1Data)
  
  // Register control signals to match memory delay
  // val isRamReg = RegNext(isRam)
  // val isPpuRegReg = RegNext(isPpuReg)
  // val isControllerReg = RegNext(isController)
  // val isPrgRomReg = RegNext(isPrgRom)
  
  // CPU Read
  val ramData = ram.read(cpuAddr(10, 0))
  val ppuData = ppu.io.cpuDataOut
  
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isRam -> ramData,
    isPpuReg -> ppuData,
    isController -> controllerData,
    isPrgRom -> mmc3.io.cpuDataOut
  ))
  
  // Debug: CPU Read PPU
  when(isPpuReg) {
    printf("[NES] isPpuReg=true: addr=$%x data=0x%x\n", cpuAddr, ppuData)
  }
  when(cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U) {
    printf("[NES] PPU addr range: addr=$%x isPpuReg=%d\n", cpuAddr, isPpuReg)
  }
  // CPU Write
  when(cpu.io.memWrite) {
    printf("[CPU Write] Addr=$%x Data=0x%x isRam=%d isPpuReg=%d\n", 
           cpuAddr, cpu.io.memDataOut, isRam, isPpuReg)
    when(isRam) {
      // $0200-$020F Write
      when(cpuAddr >= 0x0200.U && cpuAddr < 0x0210.U) {
        printf("[RAM Write] Addr=$%x Data=0x%x PC=0x%x\n", cpuAddr, cpu.io.memDataOut, cpu.io.debug.regPC)
      }
      ram.write(cpuAddr(10, 0), cpu.io.memDataOut)
    }
  }
  
  // PPU
  ppu.io.cpuAddr := cpuAddr(2, 0)
  ppu.io.cpuDataIn := cpu.io.memDataOut
  ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg
  ppu.io.cpuRead := cpu.io.memRead && isPpuReg
  
  // Debug: PPU Write
  when(cpu.io.memWrite && isPpuReg) {
    printf("[PPU Write] Addr=$%x RegAddr=%d Data=0x%x cpuWrite=%d isPpuReg=%d\n", 
           cpuAddr, cpuAddr(2, 0), cpu.io.memDataOut, cpu.io.memWrite, isPpuReg)
  }
  when(cpu.io.memRead && isPpuReg) {
    printf("[PPU Read] Addr=$%x RegAddr=%d cpuRead=%d ppuData=0x%x\n", 
           cpuAddr, cpuAddr(2, 0), cpu.io.memRead, ppuData)
  }
  ppu.io.oamDmaAddr := 0.U
  ppu.io.oamDmaData := 0.U
  ppu.io.oamDmaWrite := false.B
  ppu.io.chrLoadEn := io.chrLoadEn
  ppu.io.chrLoadAddr := io.chrLoadAddr
  ppu.io.chrLoadData := io.chrLoadData
  
  // Connect MMC3 CHR interface (not used yet, but must be connected)
  mmc3.io.chrData := 0.U
  
  // APU  - whenDisable
  // apu.io.cpuAddr := cpuAddr(7, 0)
  // apu.io.cpuDataIn := cpu.io.memDataOut
  // apu.io.cpuWrite := cpu.io.memWrite && isApuReg
  // apu.io.cpuRead := cpu.io.memRead && isApuReg
  
  // CPU
  cpu.io.reset := reset.asBool  // to reset
  cpu.io.nmi := ppu.io.nmiOut
  
  // Output
  io.pixelX := ppu.io.pixelX
  io.pixelY := ppu.io.pixelY
  io.pixelColor := ppu.io.pixelColor
  io.vblank := ppu.io.vblank
  io.audioOut := 0.U // apu.io.audioOut
  
  // Output
  io.debug.cpuPC := cpu.io.debug.regPC
  io.debug.cpuA := cpu.io.debug.regA
  io.debug.cpuX := cpu.io.debug.regX
  io.debug.cpuY := cpu.io.debug.regY
  io.debug.cpuState := cpu.io.debug.state
  io.debug.cpuCycle := cpu.io.debug.cycle
  io.debug.cpuOpcode := cpu.io.debug.opcode
  io.debug.cpuMemAddr := cpu.io.memAddr
  io.debug.cpuMemDataIn := cpu.io.memDataIn
  io.debug.cpuMemRead := cpu.io.memRead
  io.debug.ppuCtrl := ppu.io.debug.ppuCtrl
  io.debug.ppuMask := ppu.io.debug.ppuMask
  io.debug.vblank := ppu.io.vblank
  io.debug.nmi := ppu.io.nmiOut
  io.debug.apuPulse1Active := false.B // apu.io.debug.pulse1Active
  io.debug.apuPulse2Active := false.B // apu.io.debug.pulse2Active
}

object NESSystemRefactored extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new NESSystemRefactored)
}
