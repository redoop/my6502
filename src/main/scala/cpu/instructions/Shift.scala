package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 移位指令: ASL, LSR, ROL, ROR
object ShiftInstructions {
  val accumulatorOpcodes = Seq(0x0A, 0x4A, 0x2A, 0x6A)
  val zeroPageOpcodes = Seq(0x06, 0x46, 0x26, 0x66)
  
  val opcodes = accumulatorOpcodes ++ zeroPageOpcodes
  
  // 累加器模式 (单周期)
  def executeAccumulator(opcode: UInt, regs: Registers): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := true.B
    result.nextCycle := 0.U
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := 0.U
    
    val res = Wire(UInt(8.W))
    res := regs.a
    val oldCarry = regs.flagC.asUInt
    
    switch(opcode) {
      is(0x0A.U) {  // ASL A
        newRegs.flagC := regs.a(7)
        res := (regs.a << 1)(7, 0)
      }
      is(0x4A.U) {  // LSR A
        newRegs.flagC := regs.a(0)
        res := regs.a >> 1
      }
      is(0x2A.U) {  // ROL A
        newRegs.flagC := regs.a(7)
        res := Cat(regs.a(6, 0), oldCarry)
      }
      is(0x6A.U) {  // ROR A
        newRegs.flagC := regs.a(0)
        res := Cat(oldCarry, regs.a(7, 1))
      }
    }
    
    newRegs.a := res
    newRegs.flagN := res(7)
    newRegs.flagZ := res === 0.U
    result.regs := newRegs
    result
  }
  
  // 零页模式 (多周期)
  def executeZeroPage(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := operand
        val res = Wire(UInt(8.W))
        res := 0.U
        
        switch(opcode) {
          is(0x06.U) {  // ASL
            newRegs.flagC := memDataIn(7)
            res := (memDataIn << 1)(7, 0)
          }
          is(0x46.U) {  // LSR
            newRegs.flagC := memDataIn(0)
            res := memDataIn >> 1
          }
          is(0x26.U) {  // ROL
            val oldCarry = regs.flagC.asUInt
            newRegs.flagC := memDataIn(7)
            res := Cat(memDataIn(6, 0), oldCarry)
          }
          is(0x66.U) {  // ROR
            val oldCarry = regs.flagC.asUInt
            newRegs.flagC := memDataIn(0)
            res := Cat(oldCarry, memDataIn(7, 1))
          }
        }
        
        result.memData := res
        result.memWrite := true.B
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
