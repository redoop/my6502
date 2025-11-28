package cpu6502.instructions

import chisel3._
import cpu6502.core.Registers

class JMPTestModule extends Module {
  val io = IO(new Bundle {
    val cycle = Input(UInt(8.W))
    val operand = Input(UInt(16.W))
    val memDataIn = Input(UInt(8.W))
    val pcIn = Input(UInt(16.W))
    
    val memAddr = Output(UInt(16.W))
    val memRead = Output(Bool())
    val operandOut = Output(UInt(16.W))
    val pcOut = Output(UInt(16.W))
    val done = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn
  
  val result = JumpInstructions.executeJMP(io.cycle, regs, io.operand, io.memDataIn)
  
  io.memAddr := result.memAddr
  io.memRead := result.memRead
  io.operandOut := result.operand
  io.pcOut := result.regs.pc
  io.done := result.done
}

class JSRTestModule extends Module {
  val io = IO(new Bundle {
    val cycle = Input(UInt(8.W))
    val operand = Input(UInt(16.W))
    val memDataIn = Input(UInt(8.W))
    val pcIn = Input(UInt(16.W))
    val spIn = Input(UInt(8.W))
    
    val memAddr = Output(UInt(16.W))
    val memRead = Output(Bool())
    val memWrite = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val operandOut = Output(UInt(16.W))
    val pcOut = Output(UInt(16.W))
    val spOut = Output(UInt(8.W))
    val done = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn
  regs.sp := io.spIn
  
  val result = JumpInstructions.executeJSR(io.cycle, regs, io.operand, io.memDataIn)
  
  io.memAddr := result.memAddr
  io.memRead := result.memRead
  io.memWrite := result.memWrite
  io.memDataOut := result.memData
  io.operandOut := result.operand
  io.pcOut := result.regs.pc
  io.spOut := result.regs.sp
  io.done := result.done
}

class RTSTestModule extends Module {
  val io = IO(new Bundle {
    val cycle = Input(UInt(8.W))
    val operand = Input(UInt(16.W))
    val memDataIn = Input(UInt(8.W))
    val pcIn = Input(UInt(16.W))
    val spIn = Input(UInt(8.W))
    
    val memAddr = Output(UInt(16.W))
    val memRead = Output(Bool())
    val operandOut = Output(UInt(16.W))
    val pcOut = Output(UInt(16.W))
    val spOut = Output(UInt(8.W))
    val done = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn
  regs.sp := io.spIn
  
  val result = JumpInstructions.executeRTS(io.cycle, regs, io.operand, io.memDataIn)
  
  io.memAddr := result.memAddr
  io.memRead := result.memRead
  io.operandOut := result.operand
  io.pcOut := result.regs.pc
  io.spOut := result.regs.sp
  io.done := result.done
}
