package cpu6502.core

import chisel3._

// 调试信息 Bundle
class DebugBundle extends Bundle {
  val regA   = UInt(8.W)
  val regX   = UInt(8.W)
  val regY   = UInt(8.W)
  val regPC  = UInt(16.W)
  val regSP  = UInt(8.W)
  val flagC  = Bool()
  val flagZ  = Bool()
  val flagN  = Bool()
  val flagV  = Bool()
  val opcode = UInt(8.W)
  val state  = UInt(2.W)
  val cycle  = UInt(3.W)
}

object DebugBundle {
  def fromRegisters(regs: Registers, opcode: UInt, state: UInt, cycle: UInt): DebugBundle = {
    val debug = Wire(new DebugBundle)
    debug.regA := regs.a
    debug.regX := regs.x
    debug.regY := regs.y
    debug.regPC := regs.pc
    debug.regSP := regs.sp
    debug.flagC := regs.flagC
    debug.flagZ := regs.flagZ
    debug.flagN := regs.flagN
    debug.flagV := regs.flagV
    debug.opcode := opcode
    debug.state := state
    debug.cycle := cycle
    debug
  }
}
