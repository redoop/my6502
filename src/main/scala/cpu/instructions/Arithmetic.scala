package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 算术指令: ADC, SBC, INC, DEC, INX, INY, DEX, DEY
object ArithmeticInstructions {
  // 单周期指令 (隐含寻址)
  val impliedOpcodes = Seq(0xE8, 0xC8, 0xCA, 0x88, 0x1A, 0x3A)
  // 立即寻址
  val immediateOpcodes = Seq(0x69, 0xE9)
  // 零页寻址
  val zeroPageOpcodes = Seq(0xE6, 0xC6)
  // 绝对寻址
  val absoluteOpcodes = Seq(0xEE, 0xCE)
  // 绝对索引寻址
  val absoluteIndexedOpcodes = Seq(0x79, 0xF9, 0x7D, 0xFD)  // ADC/SBC abs,Y/X
  
  val opcodes = impliedOpcodes ++ immediateOpcodes ++ zeroPageOpcodes ++ absoluteOpcodes ++ absoluteIndexedOpcodes
  
  // 单周期指令执行
  def executeImplied(opcode: UInt, regs: Registers): ExecutionResult = {
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
    
    switch(opcode) {
      is(0xE8.U) {  // INX
        val res = regs.x + 1.U
        newRegs.x := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
      is(0xC8.U) {  // INY
        val res = regs.y + 1.U
        newRegs.y := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
      is(0xCA.U) {  // DEX
        val res = regs.x - 1.U
        newRegs.x := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
      is(0x88.U) {  // DEY
        val res = regs.y - 1.U
        newRegs.y := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
      is(0x1A.U) {  // INC A (65C02)
        val res = regs.a + 1.U
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
      is(0x3A.U) {  // DEC A (65C02)
        val res = regs.a - 1.U
        newRegs.a := res
        newRegs.flagN := res(7)
        newRegs.flagZ := res === 0.U
      }
    }
    
    result.regs := newRegs
    result
  }
  
  // ADC 立即寻址
  def executeADCImmediate(regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    val sum = regs.a +& memDataIn +& regs.flagC.asUInt
    newRegs.a := sum(7, 0)
    newRegs.flagC := sum(8)
    newRegs.flagN := sum(7)
    newRegs.flagZ := sum(7, 0) === 0.U
    newRegs.flagV := (regs.a(7) === memDataIn(7)) && (regs.a(7) =/= sum(7))
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
  
  // SBC 立即寻址
  def executeSBCImmediate(regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    val diff = regs.a -& memDataIn -& (~regs.flagC).asUInt
    newRegs.a := diff(7, 0)
    newRegs.flagC := ~diff(8)
    newRegs.flagN := diff(7)
    newRegs.flagZ := diff(7, 0) === 0.U
    newRegs.flagV := (regs.a(7) =/= memDataIn(7)) && (regs.a(7) =/= diff(7))
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
  
  // INC/DEC 零页 - 多周期
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
        val res = Mux(opcode === 0xE6.U, memDataIn + 1.U, memDataIn - 1.U)
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
  
  // INC/DEC 绝对寻址 - 多周期
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
        // 读取地址低字节
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // 读取地址高字节
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(2.U) {
        // 读取数据
        result.memAddr := operand
        result.memRead := true.B
      }
      is(3.U) {
        // 修改并写回
        result.memAddr := operand
        val res = Mux(opcode === 0xEE.U, memDataIn + 1.U, memDataIn - 1.U)
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
  
  // ADC/SBC 绝对索引寻址 (abs,X 或 abs,Y) - 多周期
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
    
    // 确定使用 X 还是 Y 索引
    val useY = (opcode === 0x79.U) || (opcode === 0xF9.U)  // ADC/SBC abs,Y
    val index = Mux(useY, regs.y, regs.x)
    
    switch(cycle) {
      is(0.U) {
        // 读取地址低字节
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // 读取地址高字节
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(2.U) {
        // 计算最终地址并读取数据
        val addr = operand + index
        result.memAddr := addr
        result.memRead := true.B
      }
      is(3.U) {
        // 执行 ADC 或 SBC
        val isADC = (opcode === 0x79.U) || (opcode === 0x7D.U)
        
        when(isADC) {
          // ADC
          val sum = regs.a +& memDataIn +& regs.flagC.asUInt
          newRegs.a := sum(7, 0)
          newRegs.flagC := sum(8)
          newRegs.flagN := sum(7)
          newRegs.flagZ := sum(7, 0) === 0.U
          newRegs.flagV := (regs.a(7) === memDataIn(7)) && (regs.a(7) =/= sum(7))
        }.otherwise {
          // SBC
          val diff = regs.a -& memDataIn -& (~regs.flagC).asUInt
          newRegs.a := diff(7, 0)
          newRegs.flagC := ~diff(8)
          newRegs.flagN := diff(7)
          newRegs.flagZ := diff(7, 0) === 0.U
          newRegs.flagV := (regs.a(7) =/= memDataIn(7)) && (regs.a(7) =/= diff(7))
        }
        
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
}
