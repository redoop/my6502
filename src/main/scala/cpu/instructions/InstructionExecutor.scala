package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 指令执行结果
class ExecutionResult extends Bundle {
  val done     = Bool()           // 指令执行完成
  val nextCycle = UInt(3.W)       // 下一周期
  val regs     = new Registers    // 更新后的寄存器
  val memAddr  = UInt(16.W)       // 内存地址
  val memData  = UInt(8.W)        // 写入数据
  val memWrite = Bool()           // 写使能
  val memRead  = Bool()           // 读使能
  val operand  = UInt(16.W)       // 操作数 (用于多周期指令)
}

object ExecutionResult {
  // 创建默认结果 (保持当前状态)
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
  
  // 创建完成结果
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

// 辅助函数
object ALUOps {
  // 更新 N 和 Z 标志
  def updateNZ(regs: Registers, value: UInt): Registers = {
    val newRegs = Wire(new Registers)
    newRegs := regs
    newRegs.flagN := value(7)
    newRegs.flagZ := value === 0.U
    newRegs
  }
}
