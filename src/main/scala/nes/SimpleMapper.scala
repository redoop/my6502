package nes

import chisel3._

// Simple passthrough mapper - no bank switching
class SimpleMapper extends Module {
  val io = IO(new Bundle {
    val cpuAddr = Input(UInt(16.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    val prgAddr = Output(UInt(19.W))
    val prgData = Input(UInt(8.W))
    
    val chrAddr = Output(UInt(17.W))
    val chrData = Input(UInt(8.W))
    
    val ppuAddr = Input(UInt(14.W))
    val irqOut = Output(Bool())
    val mirrorMode = Output(UInt(1.W))
  })
  
  // Direct passthrough
  io.prgAddr := io.cpuAddr
  io.cpuDataOut := io.prgData
  io.chrAddr := io.ppuAddr
  io.irqOut := false.B
  io.mirrorMode := 0.U
}
