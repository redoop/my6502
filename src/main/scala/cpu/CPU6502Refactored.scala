package cpu6502

import chisel3._
import cpu6502.core._

// 6502 CPU 顶层模块 (重构版)
// 保持与原 CPU6502 相同的接口，内部使用模块化实现
class CPU6502Refactored extends Module {
  val io = IO(new Bundle {
    val memAddr    = Output(UInt(16.W))
    val memDataOut = Output(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val memWrite   = Output(Bool())
    val memRead    = Output(Bool())
    val debug      = Output(new DebugBundle)
    val reset      = Input(Bool())  // Reset 信号
  })

  val core = Module(new CPU6502Core)
  
  io.memAddr    := core.io.memAddr
  io.memDataOut := core.io.memDataOut
  core.io.memDataIn := io.memDataIn
  io.memWrite   := core.io.memWrite
  io.memRead    := core.io.memRead
  io.debug      := core.io.debug
  core.io.reset := io.reset
}

object CPU6502Refactored extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new CPU6502Refactored)
}
