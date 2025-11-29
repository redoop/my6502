package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class ANDInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "AND Immediate" should "compute 0x40 AND 0x80 = 0x00" in {
    test(new LogicInstructionsModule) { dut =>
      // Setup: A = 0x40
      dut.io.aIn.poke(0x40.U)
      dut.io.opcode.poke(0x29.U)  // AND #
      dut.io.operand.poke(0x80.U)
      
      dut.clock.step(1)
      
      // Result: 0x40 AND 0x80 = 0x00
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)   // Zero flag set
      dut.io.flagN.expect(false.B)  // Negative flag clear
    }
  }
  
  it should "compute 0x10 AND 0x10 = 0x10" in {
    test(new LogicInstructionsModule) { dut =>
      dut.io.aIn.poke(0x10.U)
      dut.io.opcode.poke(0x29.U)
      dut.io.operand.poke(0x10.U)
      
      dut.clock.step(1)
      
      dut.io.aOut.expect(0x10.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(false.B)
    }
  }
  
  it should "compute 0xFF AND 0x80 = 0x80 (negative)" in {
    test(new LogicInstructionsModule) { dut =>
      dut.io.aIn.poke(0xFF.U)
      dut.io.opcode.poke(0x29.U)
      dut.io.operand.poke(0x80.U)
      
      dut.clock.step(1)
      
      dut.io.aOut.expect(0x80.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)  // Bit 7 set = negative
    }
  }
  
  it should "set zero flag when result is 0" in {
    test(new LogicInstructionsModule) { dut =>
      dut.io.aIn.poke(0x0F.U)
      dut.io.opcode.poke(0x29.U)
      dut.io.operand.poke(0xF0.U)
      
      dut.clock.step(1)
      
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
    }
  }
}

// Test module for Logic instructions
class LogicInstructionsModule extends Module {
  val io = IO(new Bundle {
    val aIn = Input(UInt(8.W))
    val opcode = Input(UInt(8.W))
    val operand = Input(UInt(8.W))
    val aOut = Output(UInt(8.W))
    val flagZ = Output(Bool())
    val flagN = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  
  val result = LogicInstructions.executeImmediate(io.opcode, regs, io.operand)
  
  io.aOut := result.regs.a
  io.flagZ := result.regs.flagZ
  io.flagN := result.regs.flagN
}
