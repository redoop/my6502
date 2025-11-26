package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 加载/存储指令: LDA, LDX, LDY, STA, STX, STY
object LoadStoreInstructions {
  val immediateOpcodes = Seq(0xA9, 0xA2, 0xA0)
  val zeroPageOpcodes = Seq(0xA5, 0x85, 0x86, 0x84)
  val zeroPageXOpcodes = Seq(0xB5, 0x95)
  val absoluteOpcodes = Seq(0xAD, 0x8D)
  val absoluteXOpcodes = Seq(0xBD)
  val absoluteYOpcodes = Seq(0xB9)
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes ++ zeroPageXOpcodes ++ 
                absoluteOpcodes ++ absoluteXOpcodes ++ absoluteYOpcodes
  
  // 立即寻址 (LDA, LDX, LDY)
  def executeImmediate(opcode: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    switch(opcode) {
      is(0xA9.U) { newRegs.a := memDataIn }  // LDA
      is(0xA2.U) { newRegs.x := memDataIn }  // LDX
      is(0xA0.U) { newRegs.y := memDataIn }  // LDY
    }
    
    newRegs.flagN := memDataIn(7)
    newRegs.flagZ := memDataIn === 0.U
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
  
  // 零页寻址 (LDA, STA, STX, STY)
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
    
    val isLoad = opcode === 0xA5.U
    val isStoreA = opcode === 0x85.U
    val isStoreX = opcode === 0x86.U
    val isStoreY = opcode === 0x84.U
    
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
        when(isLoad) {
          result.memRead := true.B
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := Mux(isStoreA, regs.a, Mux(isStoreX, regs.x, regs.y))
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 零页 X 索引
  def executeZeroPageX(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
    
    val isLoad = opcode === 0xB5.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := operand
        when(isLoad) {
          result.memRead := true.B
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := regs.a
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 绝对寻址
  def executeAbsolute(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
    
    val isLoad = opcode === 0xAD.U
    
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
        result.memAddr := operand
        when(isLoad) {
          result.memRead := true.B
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := regs.a
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 绝对 X/Y 索引
  def executeAbsoluteIndexed(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
    
    val indexReg = Mux(opcode === 0xBD.U, regs.x, regs.y)
    
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
        result.operand := Cat(memDataIn, operand(7, 0)) + indexReg
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := operand
        result.memRead := true.B
        newRegs.a := memDataIn
        newRegs.flagN := memDataIn(7)
        newRegs.flagZ := memDataIn === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
