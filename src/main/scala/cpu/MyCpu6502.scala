package cpu6502

import chisel3._
import cpu6502.core.DebugBundle

// Module： CPU
class MyCpu6502 extends Module {
  val io = IO(new Bundle {
    val debug = Output(new DebugBundle)
  })

  val cpu = Module(new CPU6502Refactored)
  val mem = Module(new Memory())

  // CPU
  mem.io.addr := cpu.io.memAddr
  mem.io.dataIn := cpu.io.memDataOut
  mem.io.write := cpu.io.memWrite
  mem.io.read := cpu.io.memRead
  cpu.io.memDataIn := mem.io.dataOut

  // Output
  io.debug := cpu.io.debug
}

// Verilog
object MyCpu6502 extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new MyCpu6502,
    Array("--target-dir", "generated")
  )
}
