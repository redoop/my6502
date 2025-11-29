package cpu6502

import chisel3._
import chisel3.util._

// Module
class Memory(size: Int = 65536) extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(16.W))
    val dataIn = Input(UInt(8.W))
    val dataOut = Output(UInt(8.W))
    val write = Input(Bool())
    val read = Input(Bool())
  })

  val mem = SyncReadMem(size, UInt(8.W))
  
  io.dataOut := 0.U
  
  when(io.write) {
    mem.write(io.addr, io.dataIn)
  }
  
  when(io.read) {
    io.dataOut := mem.read(io.addr)
  }
}
