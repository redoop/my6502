package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 比较指令: CMP, CPX, CPY
object CompareInstructions {
  val immediateOpcodes = Seq(0xC9, 0xE0, 0xC0)
  val zeroPageOpcodes = Seq(0xC5, 0xE4, 0xC4)  // CMP, CPX, CPY
  val zeroPageXOpcodes = Seq(0xD5)  // CMP zp,X
  val absoluteOpcodes = Seq(0xCD, 0xEC, 0xCC)  // CMP, CPX, CPY abs
  val absoluteXOpcodes = Seq(0xDD)  // CMP abs,X
  val absoluteYOpcodes = Seq(0xD9)  // CMP abs,Y
  val indirectXOpcodes = Seq(0xC1)  // CMP (ind,X)
  val indirectYOpcodes = Seq(0xD1)  // CMP (ind),Y
  val indirectOpcodes = Seq(0xD2)  // CMP (indirect) - 65C02
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes ++ zeroPageXOpcodes ++
                absoluteOpcodes ++ absoluteXOpcodes ++ absoluteYOpcodes ++
                indirectXOpcodes ++ indirectYOpcodes ++ indirectOpcodes
  
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
  
  // 通用比较操作
  private def doCompare(opcode: UInt, regs: Registers, data: UInt): (Bool, Bool, Bool) = {
    val regValue = MuxCase(regs.a, Seq(
      (opcode === 0xE0.U || opcode === 0xE4.U || opcode === 0xEC.U) -> regs.x,  // CPX
      (opcode === 0xC0.U || opcode === 0xC4.U || opcode === 0xCC.U) -> regs.y   // CPY
    ))
    val diff = regValue -& data
    val flagC = regValue >= data
    val flagZ = regValue === data
    val flagN = diff(7)
    (flagC, flagZ, flagN)
  }
  
  // 零页寻址（通用）
  def executeZeroPageGeneric(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
      }
      is(1.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
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
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
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
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(2.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 绝对索引 (X 或 Y)
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
    
    val useY = opcode === 0xD9.U
    val index = Mux(useY, regs.y, regs.x)
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0)) + index
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(2.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 间接 X 索引
  def executeIndirectX(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
      }
      is(3.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 间接 Y 索引
  def executeIndirectY(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
      }
      is(1.U) {
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0)) + regs.y
      }
      is(3.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 间接寻址 (65C02) - CMP (indirect)
  def executeIndirect(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
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
      }
      is(1.U) {
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
      }
      is(3.U) {
        result.memAddr := operand
        result.memRead := true.B
        val (flagC, flagZ, flagN) = doCompare(opcode, regs, memDataIn)
        newRegs.flagC := flagC
        newRegs.flagZ := flagZ
        newRegs.flagN := flagN
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
