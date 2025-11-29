package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// Instructions: PHA, PHP, PLA, PLP
object StackInstructions {
  val pushOpcodes = Seq(0x48, 0x08)
  val pullOpcodes = Seq(0x68, 0x28)
  
  val opcodes = pushOpcodes ++ pullOpcodes
  
  // PHA, PHP (Cycle push)
  def executePush(opcode: UInt, regs: Registers): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    val pushData = Wire(UInt(8.W))
    pushData := regs.a
    
    when(opcode === 0x08.U) {  // PHP
      pushData := Registers.getStatus(regs)
    }
    
    newRegs.sp := regs.sp - 1.U
    
    result.done := true.B
    result.nextCycle := 0.U
    result.regs := newRegs
    result.memAddr := Cat(0x01.U(8.W), regs.sp)
    result.memData := pushData
    result.memWrite := true.B
    result.memRead := false.B
    result.operand := 0.U
    result
  }
  
  // PLA, PLP (Cycle pull)
  def executePull(opcode: UInt, cycle: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
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
    result.operand := 0.U
    
    switch(cycle) {
      is(0.U) {
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        
        when(opcode === 0x68.U) {  // PLA
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {  // PLP
          newRegs.flagC := memDataIn(0)
          newRegs.flagZ := memDataIn(1)
          newRegs.flagI := memDataIn(2)
          newRegs.flagD := memDataIn(3)
          newRegs.flagV := memDataIn(6)
          newRegs.flagN := memDataIn(7)
        }
        
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
