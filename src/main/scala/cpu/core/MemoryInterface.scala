package cpu6502.core

import chisel3._

// 内存接口 Bundle
class MemoryIO extends Bundle {
  val addr    = Output(UInt(16.W))
  val dataOut = Output(UInt(8.W))
  val dataIn  = Input(UInt(8.W))
  val write   = Output(Bool())
  val read    = Output(Bool())
}

object MemoryIO {
  def default(): MemoryIO = {
    val mem = Wire(new MemoryIO)
    mem.addr := 0.U
    mem.dataOut := 0.U
    mem.write := false.B
    mem.read := false.B
    mem
  }
}
