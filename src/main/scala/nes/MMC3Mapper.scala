package nes

import chisel3._
import chisel3.util._

// MMC3 Mapper (Mapper 4) - Fully pipelined architecture
class MMC3Mapper extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(16.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // PRG ROM Interface
    val prgAddr = Output(UInt(19.W))
    val prgData = Input(UInt(8.W))
    
    // CHR ROM Interface
    val chrAddr = Output(UInt(17.W))
    val chrData = Input(UInt(8.W))
    
    // PPU Interface
    val ppuAddr = Input(UInt(14.W))
    
    // IRQ Output
    val irqOut = Output(Bool())
    
    // Mirroring
    val mirrorMode = Output(UInt(1.W))
  })
  
  // Bank Registers - all registered
  val r6 = RegInit(0.U(8.W))  // PRG bank 0
  val r7 = RegInit(0.U(8.W))  // PRG bank 1
  val prgMode = RegInit(false.B)
  
  // Mirroring
  val mirroring = RegInit(0.U(1.W))
  io.mirrorMode := mirroring
  
  // IRQ disabled for simplicity
  io.irqOut := false.B
  
  // Register writes - fully pipelined
  val bankSelect = RegInit(0.U(3.W))
  
  when(io.cpuWrite) {
    when(io.cpuAddr(15, 13) === 4.U) {  // $8000-$9FFF
      when(io.cpuAddr(0) === 0.U) {
        // Bank select
        bankSelect := io.cpuDataIn(2, 0)
        prgMode := io.cpuDataIn(6)
      }.otherwise {
        // Bank data
        when(bankSelect === 6.U) { r6 := io.cpuDataIn }
        when(bankSelect === 7.U) { r7 := io.cpuDataIn }
      }
    }
    when(io.cpuAddr(15, 13) === 5.U && io.cpuAddr(0) === 0.U) {  // $A000
      mirroring := io.cpuDataIn(0)
    }
  }
  
  // PRG bank selection - fully registered
  val bank0 = RegNext(Mux(prgMode, 0xFE.U, r6))
  val bank1 = RegNext(r7)
  val bank2 = RegNext(Mux(prgMode, r6, 0xFE.U))
  val bank3 = RegNext(0xFF.U)
  
  // Address decode - fully registered
  val addrSel = RegNext(io.cpuAddr(14, 13))
  val addrOffset = RegNext(io.cpuAddr(12, 0))
  
  val selectedBank = RegNext(MuxLookup(addrSel, bank0, Seq(
    0.U -> bank0,
    1.U -> bank1,
    2.U -> bank2,
    3.U -> bank3
  )))
  
  // Final address - registered
  io.prgAddr := RegNext(Cat(selectedBank, addrOffset))
  
  // Data output - registered
  io.cpuDataOut := RegNext(io.prgData)
  
  // CHR passthrough - registered
  io.chrAddr := RegNext(io.ppuAddr)
}
