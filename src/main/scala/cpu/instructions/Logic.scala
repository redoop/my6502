package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// Instruction: AND, ORA, EOR, BIT
object LogicInstructions {
  val immediateOpcodes = Seq(0x29, 0x09, 0x49)
  val zeroPageOpcodes = Seq(0x24, 0x25, 0x05, 0x45)  // BIT, AND, ORA, EOR
  val zeroPageXOpcodes = Seq(0x35, 0x15, 0x55)  // AND, ORA, EOR zp,X
  val absoluteOpcodes = Seq(0x2C, 0x2D, 0x0D, 0x4D)  // BIT, AND, ORA, EOR abs
  val absoluteXOpcodes = Seq(0x3D, 0x1D, 0x5D)  // AND, ORA, EOR abs,X
  val absoluteYOpcodes = Seq(0x39, 0x19, 0x59)  // AND, ORA, EOR abs,Y
  val indirectXOpcodes = Seq(0x21, 0x01, 0x41)  // AND, ORA, EOR (ind,X)
  val indirectYOpcodes = Seq(0x31, 0x11, 0x51)  // AND, ORA, EOR (ind),Y
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes ++ zeroPageXOpcodes ++ 
                absoluteOpcodes ++ absoluteXOpcodes ++ absoluteYOpcodes ++
                indirectXOpcodes ++ indirectYOpcodes
  

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
  
  // BIT  - Cycle
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
  

  private def doLogicOp(opcode: UInt, a: UInt, data: UInt): UInt = {
    MuxCase(a, Seq(
      (opcode === 0x29.U || opcode === 0x25.U || opcode === 0x35.U || opcode === 0x2D.U || 
       opcode === 0x3D.U || opcode === 0x39.U || opcode === 0x21.U || opcode === 0x31.U) -> (a & data),  // AND
      (opcode === 0x09.U || opcode === 0x05.U || opcode === 0x15.U || opcode === 0x0D.U || 
       opcode === 0x1D.U || opcode === 0x19.U || opcode === 0x01.U || opcode === 0x11.U) -> (a | data),  // ORA
      (opcode === 0x49.U || opcode === 0x45.U || opcode === 0x55.U || opcode === 0x4D.U || 
       opcode === 0x5D.U || opcode === 0x59.U || opcode === 0x41.U || opcode === 0x51.U) -> (a ^ data)   // EOR
    ))
  }
  
  // (AND, ORA, EOR)
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
      }
      is(1.U) {
        result.memAddr := operand
        result.memRead := true.B
        val res = doLogicOp(opcode, regs.a, memDataIn)
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // X
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
        val res = doLogicOp(opcode, regs.a, memDataIn)
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  

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
        
        // BIT InstructionProcess
        when(opcode === 0x2C.U) {
          newRegs.flagZ := (regs.a & memDataIn) === 0.U
          newRegs.flagN := memDataIn(7)
          newRegs.flagV := memDataIn(6)
        }.otherwise {
          val res = doLogicOp(opcode, regs.a, memDataIn)
          newRegs.a := res
          newRegs.flagN := res(7)
          newRegs.flagZ := res === 0.U
        }
        
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // (X or Y)
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
    
    // X  Y
    val useY = (opcode === 0x39.U) || (opcode === 0x19.U) || (opcode === 0x59.U)
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
        val res = doLogicOp(opcode, regs.a, memDataIn)
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // X  (ind,X)
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
        // ReadAddress
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // ReadAddress
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        // ReadAddress
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
      }
      is(3.U) {
        // ReadData
        result.memAddr := operand
        result.memRead := true.B
        val res = doLogicOp(opcode, regs.a, memDataIn)
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // Y  (ind),Y
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
        // ReadAddress
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // ReadAddress
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        // ReadAddress
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0)) + regs.y
      }
      is(3.U) {
        // ReadData
        result.memAddr := operand
        result.memRead := true.B
        val res = doLogicOp(opcode, regs.a, memDataIn)
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
