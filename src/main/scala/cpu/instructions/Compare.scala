package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 比较指令: CMP, CPX, CPY
object CompareInstructions {
  val immediateOpcodes = Seq(0xC9, 0xE0, 0xC0)
  val zeroPageOpcodes = Seq(0xC5)
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes
  
  // 立即寻址
  def executeImmediate(opcode: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    val regValue = Wire(UInt(8.W))
    regValue := regs.a
    
    switch(opcode) {
      is(0xC9.U) { regValue := regs.a }  // CMP
      is(0xE0.U) { regValue := regs.x }  // CPX
      is(0xC0.U) { regValue := regs.y }  // CPY
    }
    
    val diff = regValue -& memDataIn
    newRegs.flagC := regValue >= memDataIn
    newRegs.flagZ := regValue === memDataIn
    newRegs.flagN := diff(7)
    newRegs.pc := regs.pc + 1.U
    
    result.done := true.B
    result.nextCycle := 0.U
    result.regs := newRegs
    result.memAddr := regs.pc
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := true.B
    result.operand := 0.U
    result
  }
  
  // CMP 零页 - 多周期
  def executeZeroPage(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := operand
        result.memRead := true.B
        val diff = regs.a -& memDataIn
        newRegs.flagC := regs.a >= memDataIn
        newRegs.flagZ := regs.a === memDataIn
        newRegs.flagN := diff(7)
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
