package nes

import chisel3._
import chisel3.util._

// NES Control
class MemoryController extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(16.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // PPU Interface
    val ppuAddr = Output(UInt(3.W))
    val ppuDataIn = Output(UInt(8.W))
    val ppuDataOut = Input(UInt(8.W))
    val ppuWrite = Output(Bool())
    val ppuRead = Output(Bool())
    
    // OAM DMA Interface
    val oamDmaAddr = Output(UInt(8.W))
    val oamDmaData = Output(UInt(8.W))
    val oamDmaWrite = Output(Bool())
    val oamDmaActive = Output(Bool())  // DMA in，CPU
    
    // ControlInterface ()
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // ROM Interface ( Verilator)
    val romLoadEn = Input(Bool())
    val romLoadAddr = Input(UInt(16.W))
    val romLoadData = Input(UInt(8.W))
    val romLoadPRG = Input(Bool())
  })

  // RAM (2KB) - Read
  val internalRAM = SyncReadMem(2048, UInt(8.W))
  
  // ROM (32KB) -  Vec Read
  // toinCycleReadData，when
  val prgROM = Mem(32768, UInt(8.W))
  
  // ROM Read（Read）
  val romReadData = Wire(UInt(8.W))
  romReadData := 0.U
  
  // OAM DMA State Machine
  val dmaActive = RegInit(false.B)
  val dmaPage = RegInit(0.U(8.W))
  val dmaOffset = RegInit(0.U(8.W))
  
  // Output
  io.cpuDataOut := 0.U
  io.ppuAddr := 0.U
  io.ppuDataIn := 0.U
  io.ppuWrite := false.B
  io.ppuRead := false.B
  io.oamDmaAddr := 0.U
  io.oamDmaData := 0.U
  io.oamDmaWrite := false.B
  io.oamDmaActive := dmaActive
  
  // NES
  // $0000-$07FF: 2KB  RAM
  // $0800-$1FFF: RAM
  // $2000-$2007: PPU Registers
  // $2008-$3FFF: PPU Registers
  // $4000-$4017: APU  I/O Registers
  // $4018-$401F: APU  I/O
  // $4020-$FFFF:
  
  when(io.cpuRead) {
    when(io.cpuAddr < 0x2000.U) {
      // RAM ()
      val ramAddr = io.cpuAddr(10, 0)
      io.cpuDataOut := internalRAM.read(ramAddr)
    }.elsewhen(io.cpuAddr >= 0x2000.U && io.cpuAddr < 0x4000.U) {
      // PPU Registers ()
      io.ppuAddr := io.cpuAddr(2, 0)
      io.ppuRead := true.B
      io.cpuDataOut := io.ppuDataOut
    }.elsewhen(io.cpuAddr === 0x4016.U) {
      // Control 1
      io.cpuDataOut := io.controller1
    }.elsewhen(io.cpuAddr === 0x4017.U) {
      // Control 2
      io.cpuDataOut := io.controller2
    }.elsewhen(io.cpuAddr >= 0x8000.U) {
      // PRG ROM (Support 16KB  32KB)
      // 16KB ROM: 0x8000-0xBFFF  0xC000-0xFFFF to ROM 0x0000-0x3FFF ( 14 )
      // 32KB ROM: 0x8000-0xFFFF to ROM 0x0000-0x7FFF ( 15 )
      // 14  (0-13) Support 16KB ROM
      val romAddr = (io.cpuAddr - 0x8000.U)(13, 0)
      io.cpuDataOut := prgROM(romAddr)  // Read

    }
  }
  
  // OAM DMA Process
  when(dmaActive) {
    // DMA in，fromReadandWrite OAM
    val dmaAddr = Cat(dmaPage, dmaOffset)
    val dmaData = WireDefault(0.U(8.W))
    
    // fromReadData
    when(dmaAddr < 0x2000.U) {
      dmaData := internalRAM.read(dmaAddr(10, 0))
    }.elsewhen(dmaAddr >= 0x8000.U) {
      val romAddr = (dmaAddr - 0x8000.U)(13, 0)
      dmaData := prgROM.read(romAddr)
    }
    
    // Write OAM
    io.oamDmaAddr := dmaOffset
    io.oamDmaData := dmaData
    io.oamDmaWrite := true.B
    
    // Update
    dmaOffset := dmaOffset + 1.U
    
    // Complete 256
    when(dmaOffset === 255.U) {
      dmaActive := false.B
    }
  }
  
  when(io.cpuWrite && !dmaActive) {
    when(io.cpuAddr < 0x2000.U) {
      // RAM ()
      val ramAddr = io.cpuAddr(10, 0)
      internalRAM.write(ramAddr, io.cpuDataIn)
    }.elsewhen(io.cpuAddr >= 0x2000.U && io.cpuAddr < 0x4000.U) {
      // PPU Registers ()
      io.ppuAddr := io.cpuAddr(2, 0)
      io.ppuDataIn := io.cpuDataIn
      io.ppuWrite := true.B
    }.elsewhen(io.cpuAddr === 0x4014.U) {
      // OAM DMA Registers
      dmaActive := true.B
      dmaPage := io.cpuDataIn
      dmaOffset := 0.U
    }.elsewhen(io.cpuAddr >= 0x8000.U) {
      // PRG ROM (when)
      val romAddr = io.cpuAddr - 0x8000.U
      prgROM.write(romAddr, io.cpuDataIn)
    }
  }
  
  // ROM  ( Verilator )
  when(io.romLoadEn && io.romLoadPRG) {
    // PRG ROM
    // testbench  ROM Address (0-32767)，
    val romAddr = io.romLoadAddr(14, 0)  // 15
    when(romAddr < 32768.U) {
      prgROM.write(romAddr, io.romLoadData)
    }
  }
}
