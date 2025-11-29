package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// FlagInstructions: CLC, SEC, CLD, SED, CLI, SEI, CLV, NOP
object FlagInstructions {
  val opcodes = Seq(0x18, 0x38, 0xD8, 0xF8, 0x58, 0x78, 0xB8, 0xEA)
  
  def execute(opcode: UInt, regs: Registers): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    // PC already incremented in Fetch state, no need to increment again
    
    result.done := true.B
    result.nextCycle := 0.U
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := 0.U
    
    switch(opcode) {
      is(0x18.U) { newRegs.flagC := false.B }  // CLC
      is(0x38.U) { newRegs.flagC := true.B }   // SEC
      is(0xD8.U) { newRegs.flagD := false.B }  // CLD
      is(0xF8.U) { newRegs.flagD := true.B }   // SED
      is(0x58.U) { newRegs.flagI := false.B }  // CLI
      is(0x78.U) { newRegs.flagI := true.B }   // SEI
      is(0xB8.U) { newRegs.flagV := false.B }  // CLV
      is(0xEA.U) { }                            // NOP
    }
    
    result.regs := newRegs
    result
  }
}
