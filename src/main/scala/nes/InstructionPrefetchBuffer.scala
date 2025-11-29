package nes

import chisel3._
import chisel3.util._

// Simple 1-cycle delay buffer to break combinational loop
class InstructionPrefetchBuffer extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(16.W))
    val cpuData = Output(UInt(8.W))
    
    // ROM Interface
    val romAddr = Output(UInt(16.W))
    val romData = Input(UInt(8.W))
  })
  
  // Register ROM address and data
  val romAddrReg = RegNext(io.cpuAddr)
  val romDataReg = RegNext(io.romData)
  
  io.romAddr := romAddrReg
  io.cpuData := romDataReg
}
