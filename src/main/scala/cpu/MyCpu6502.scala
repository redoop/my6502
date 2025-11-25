package cpu6502

import chisel3._

// 顶层模块：连接 CPU 和内存
class MyCpu6502 extends Module {
  val io = IO(new Bundle {
    val debug = Output(new DebugBundle)
  })

  val cpu = Module(new CPU6502)
  val mem = Module(new Memory())

  // 连接 CPU 和内存
  mem.io.addr := cpu.io.memAddr
  mem.io.dataIn := cpu.io.memDataOut
  mem.io.write := cpu.io.memWrite
  mem.io.read := cpu.io.memRead
  cpu.io.memDataIn := mem.io.dataOut

  // 调试输出
  io.debug := cpu.io.debug
}

// 生成 Verilog
object MyCpu6502 extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new MyCpu6502,
    Array("--target-dir", "generated")
  )
}
