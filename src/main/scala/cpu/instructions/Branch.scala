package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 分支指令: BEQ, BNE, BCS, BCC, BMI, BPL, BVC, BVS
object BranchInstructions {
  val opcodes = Seq(0xF0, 0xD0, 0xB0, 0x90, 0x30, 0x10, 0x50, 0x70)
  
  def execute(opcode: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    // 判断分支条件
    val takeBranch = Wire(Bool())
    takeBranch := false.B
    
    switch(opcode) {
      is(0xF0.U) { takeBranch := regs.flagZ }   // BEQ
      is(0xD0.U) { takeBranch := !regs.flagZ }  // BNE
      is(0xB0.U) { takeBranch := regs.flagC }   // BCS
      is(0x90.U) { takeBranch := !regs.flagC }  // BCC
      is(0x30.U) { takeBranch := regs.flagN }   // BMI
      is(0x10.U) { takeBranch := !regs.flagN }  // BPL
      is(0x70.U) { takeBranch := regs.flagV }   // BVS
      is(0x50.U) { takeBranch := !regs.flagV }  // BVC
    }
    
    // 计算新 PC
    val offset = memDataIn.asSInt
    // regs.pc 指向操作数（偏移量），分支目标 = PC + 1 + offset
    // 因为 PC 需要先跳过操作数字节
    val nextPC = regs.pc + 1.U
    newRegs.pc := Mux(takeBranch, (nextPC.asSInt + offset).asUInt, nextPC)
    
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
}
