package cpu6502.core

import chisel3._
import chisel3.util._

// 6502 CPU Registers
class Registers extends Bundle {
  val a  = UInt(8.W)
  val x  = UInt(8.W)   // X Registers
  val y  = UInt(8.W)   // Y Registers
  val sp = UInt(8.W)
  val pc = UInt(16.W)
  
  // StateFlag (P Registers)
  val flagC = Bool()   // Carry
  val flagZ = Bool()   // Zero
  val flagI = Bool()   // Interrupt Disable
  val flagD = Bool()   // Decimal Mode
  val flagB = Bool()   // Break
  val flagV = Bool()   // Overflow
  val flagN = Bool()   // Negative
}

object Registers {
  def default(): Registers = {
    val regs = Wire(new Registers)
    regs.a := 0.U
    regs.x := 0.U
    regs.y := 0.U
    regs.sp := 0xFF.U
    regs.pc := 0.U
    regs.flagC := false.B
    regs.flagZ := false.B
    regs.flagI := false.B
    regs.flagD := false.B
    regs.flagB := false.B
    regs.flagV := false.B
    regs.flagN := false.B
    regs
  }
  
  // StateRegisters (NV1BDIZC format)
  def getStatus(regs: Registers): UInt = {
    Cat(regs.flagN, regs.flagV, 1.U(1.W), 1.U(1.W), regs.flagD, regs.flagI, regs.flagZ, regs.flagC)
  }
  
  // fromSetStateFlag
  def setStatus(regs: Registers, status: UInt): Registers = {
    val newRegs = Wire(new Registers)
    newRegs := regs
    newRegs.flagC := status(0)
    newRegs.flagZ := status(1)
    newRegs.flagI := status(2)
    newRegs.flagD := status(3)
    newRegs.flagV := status(6)
    newRegs.flagN := status(7)
    newRegs
  }
}
