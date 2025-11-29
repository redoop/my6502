package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class BEQInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "BEQ" should "branch when Z=1" in {
    test(new BranchInstructionsModule) { dut =>
      // Setup: Z flag = 1, PC = 0x1000, offset = +5
      dut.io.pcIn.poke(0x1000.U)
      dut.io.flagZ.poke(true.B)
      dut.io.opcode.poke(0xF0.U)  // BEQ
      dut.io.operand.poke(0x05.U)  // +5
      
      dut.clock.step(1)
      
      // PC should be 0x1000 + 1 (next) + 5 (offset) = 0x1006
      dut.io.pcOut.expect(0x1006.U)
      dut.io.branched.expect(true.B)
    }
  }
  
  it should "not branch when Z=0" in {
    test(new BranchInstructionsModule) { dut =>
      dut.io.pcIn.poke(0x1000.U)
      dut.io.flagZ.poke(false.B)
      dut.io.opcode.poke(0xF0.U)
      dut.io.operand.poke(0x05.U)
      
      dut.clock.step(1)
      
      // PC should be 0x1000 + 1 (instruction only)
      dut.io.pcOut.expect(0x1001.U)
      dut.io.branched.expect(false.B)
    }
  }
  
  it should "handle negative offset" in {
    test(new BranchInstructionsModule) { dut =>
      // Offset = 0xFB = -5 in signed byte
      dut.io.pcIn.poke(0x1000.U)
      dut.io.flagZ.poke(true.B)
      dut.io.opcode.poke(0xF0.U)
      dut.io.operand.poke(0xFB.U)  // -5
      
      dut.clock.step(1)
      
      // PC should be 0x1000 + 1 - 5 = 0x0FFC
      dut.io.pcOut.expect(0x0FFC.U)
      dut.io.branched.expect(true.B)
    }
  }
  
  it should "branch backward in loop" in {
    test(new BranchInstructionsModule) { dut =>
      // Simulate: BEQ -8 (loop back)
      dut.io.pcIn.poke(0xC7AE.U)  // Like Donkey Kong
      dut.io.flagZ.poke(true.B)
      dut.io.opcode.poke(0xF0.U)
      dut.io.operand.poke(0xF8.U)  // -8
      
      dut.clock.step(1)
      
      // PC should loop back
      val pcOut = dut.io.pcOut.peek().litValue
      assert(pcOut < 0xC7AE, s"Should branch backward, but PC=$pcOut")
      dut.io.branched.expect(true.B)
    }
  }
}

// Test module for Branch instructions
class BranchInstructionsModule extends Module {
  val io = IO(new Bundle {
    val pcIn = Input(UInt(16.W))
    val flagZ = Input(Bool())
    val opcode = Input(UInt(8.W))
    val operand = Input(UInt(8.W))
    val pcOut = Output(UInt(16.W))
    val branched = Output(Bool())
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn
  regs.flagZ := io.flagZ
  
  val result = BranchInstructions.execute(io.opcode, regs, io.operand)
  
  io.pcOut := result.regs.pc
  io.branched := result.regs.pc =/= (io.pcIn + 1.U)
}
