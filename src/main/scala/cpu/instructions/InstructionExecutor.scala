package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// InstructionsExecuteResult
class ExecutionResult extends Bundle {
  val done     = Bool()           // InstructionsExecuteComplete
  val nextCycle = UInt(3.W)       // Cycle
  val regs     = new Registers    // UpdateRegisters
  val memAddr  = UInt(16.W)       // Address
  val memData  = UInt(8.W)        // WriteData
  val memWrite = Bool()
  val memRead  = Bool()
  val operand  = UInt(16.W)       // Operand (CycleInstructions)
}

object ExecutionResult {
  // Result (State)
  def hold(regs: Registers, operand: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    result.done := false.B
    result.nextCycle := 0.U
    result.regs := regs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    result
  }
  
  // CompleteResult
  def complete(regs: Registers): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    result.done := true.B
    result.nextCycle := 0.U
    result.regs := regs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := 0.U
    result
  }
}


object ALUOps {
  // Update N  Z Flag
  def updateNZ(regs: Registers, value: UInt): Registers = {
    val newRegs = Wire(new Registers)
    newRegs := regs
    newRegs.flagN := value(7)
    newRegs.flagZ := value === 0.U
    newRegs
  }
}
