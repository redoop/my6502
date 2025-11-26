package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 逻辑指令: AND, ORA, EOR, BIT
object LogicInstructions {
  val immediateOpcodes = Seq(0x29, 0x09, 0x49)
  val zeroPageOpcodes = Seq(0x24)  // BIT
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes
  
  // 立即寻址
  def executeImmediate(opcode: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    val res = Wire(UInt(8.W))
    res := 0.U
    
    switch(opcode) {
      is(0x29.U) { res := regs.a & memDataIn }  // AND
      is(0x09.U) { res := regs.a | memDataIn }  // ORA
      is(0x49.U) { res := regs.a ^ memDataIn }  // EOR
    }
    
    newRegs.a := res
    newRegs.flagN := res(7)
    newRegs.flagZ := res === 0.U
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
  
  // BIT 零页 - 多周期
  def executeBIT(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        newRegs.flagZ := (regs.a & memDataIn) === 0.U
        newRegs.flagN := memDataIn(7)
        newRegs.flagV := memDataIn(6)
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
