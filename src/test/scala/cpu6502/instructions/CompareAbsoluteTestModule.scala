package cpu6502.instructions

import chisel3._
import cpu6502.core.Registers

class CompareAbsoluteTestModule extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(8.W))
    val cycle = Input(UInt(8.W))
    val operand = Input(UInt(16.W))
    val memDataIn = Input(UInt(8.W))
    val aIn = Input(UInt(8.W))
    val xIn = Input(UInt(8.W))
    val yIn = Input(UInt(8.W))
    
    val memAddr = Output(UInt(16.W))
    val memWrite = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val flagN = Output(Bool())
    val flagZ = Output(Bool())
    val flagC = Output(Bool())
    val done = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn
  
  val result = CompareInstructions.executeAbsolute(io.opcode, io.cycle, regs, io.operand, io.memDataIn)
  
  io.memAddr := result.memAddr
  io.memWrite := result.memWrite
  io.memDataOut := result.memData
  io.flagN := result.regs.flagN
  io.flagZ := result.regs.flagZ
  io.flagC := result.regs.flagC
  io.done := result.done
}
