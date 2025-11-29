package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 寄存器传输指令: TAX, TAY, TXA, TYA, TSX, TXS
object TransferInstructions {
  val opcodes = Seq(0xAA, 0xA8, 0x8A, 0x98, 0xBA, 0x9A)
  
  def execute(opcode: UInt, regs: Registers): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    // PC already incremented in Fetch state
    
    result.done := true.B
    result.nextCycle := 0.U
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := 0.U
    
    switch(opcode) {
      is(0xAA.U) {  // TAX
        newRegs.x := regs.a
        newRegs.flagN := regs.a(7)
        newRegs.flagZ := regs.a === 0.U
      }
      is(0xA8.U) {  // TAY
        newRegs.y := regs.a
        newRegs.flagN := regs.a(7)
        newRegs.flagZ := regs.a === 0.U
      }
      is(0x8A.U) {  // TXA
        newRegs.a := regs.x
        newRegs.flagN := regs.x(7)
        newRegs.flagZ := regs.x === 0.U
      }
      is(0x98.U) {  // TYA
        newRegs.a := regs.y
        newRegs.flagN := regs.y(7)
        newRegs.flagZ := regs.y === 0.U
      }
      is(0xBA.U) {  // TSX
        newRegs.x := regs.sp
        newRegs.flagN := regs.sp(7)
        newRegs.flagZ := regs.sp === 0.U
      }
      is(0x9A.U) {  // TXS (不影响标志位)
        newRegs.sp := regs.x
      }
    }
    
    result.regs := newRegs
    result
  }
}
