package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// Instruction: JMP, JSR, RTS, BRK, RTI
object JumpInstructions {
  val opcodes = Seq(0x4C, 0x6C, 0x20, 0x60, 0x00, 0x40)
  
  // JMP Absolute
  def executeJMP(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := Cat(memDataIn, operand(7, 0))
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // JMP Indirect
  def executeJMPIndirect(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        // ReadAddress
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // ReadAddress
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(2.U) {
        // ReadAddress
        result.memAddr := operand
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(3.U) {
        // ReadAddress ( 6502  JMP indirect bug: )
        val indirectAddrHigh = Mux(operand(7, 0) === 0xFF.U,
          Cat(operand(15, 8), 0.U(8.W)),  // Bug: to
          operand + 1.U)
        result.memAddr := indirectAddrHigh
        result.memRead := true.B
        newRegs.pc := Cat(memDataIn, operand(7, 0))
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // JSR - Jump to Subroutine
  def executeJSR(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        // PC-1 （Address JSR ）
        val returnAddr = regs.pc - 1.U
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memData := returnAddr(15, 8)
        result.memWrite := true.B
        newRegs.sp := regs.sp - 1.U
        result.regs := newRegs
        result.nextCycle := 3.U
      }
      is(3.U) {
        // PC-1
        val returnAddr = regs.pc - 1.U
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memData := returnAddr(7, 0)
        result.memWrite := true.B
        newRegs.sp := regs.sp - 1.U
        newRegs.pc := operand
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // RTS - Return from Subroutine
  def executeRTS(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := Cat(memDataIn, operand(7, 0)) + 1.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // BRK - Break
  def executeBRK(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memData := regs.pc(15, 8)
        result.memWrite := true.B
        newRegs.sp := regs.sp - 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memData := regs.pc(7, 0)
        result.memWrite := true.B
        newRegs.sp := regs.sp - 1.U
        result.regs := newRegs
        result.nextCycle := 3.U
      }
      is(3.U) {
        val status = Registers.getStatus(regs)
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memData := status
        result.memWrite := true.B
        newRegs.sp := regs.sp - 1.U
        newRegs.flagI := true.B
        newRegs.flagB := true.B
        result.regs := newRegs
        result.nextCycle := 4.U
      }
      is(4.U) {
        result.memAddr := 0xFFFE.U
        result.memRead := true.B
        result.operand := memDataIn
        result.nextCycle := 5.U
      }
      is(5.U) {
        result.memAddr := 0xFFFF.U
        result.memRead := true.B
        newRegs.pc := Cat(memDataIn, operand(7, 0))
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // RTI - Return from Interrupt
  def executeRTI(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        newRegs.flagC := memDataIn(0)
        newRegs.flagZ := memDataIn(1)
        newRegs.flagI := memDataIn(2)
        newRegs.flagD := memDataIn(3)
        newRegs.flagV := memDataIn(6)
        newRegs.flagN := memDataIn(7)
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.sp := regs.sp + 1.U
        result.regs := newRegs
        result.nextCycle := 3.U
      }
      is(3.U) {
        result.memAddr := Cat(0x01.U(8.W), regs.sp)
        result.memRead := true.B
        newRegs.pc := Cat(memDataIn, operand(7, 0))
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
