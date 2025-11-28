package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core.Registers

class JumpInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "JumpInstructions - JMP"
  
  it should "JMP cycle 0 reads low byte" in {
    test(new JMPTestModule) { dut =>
      dut.io.pcIn.poke(0x1000.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x34.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x1000.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x34.U)
      dut.io.pcOut.expect(0x1001.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "JMP cycle 1 reads high byte and jumps" in {
    test(new JMPTestModule) { dut =>
      dut.io.pcIn.poke(0x1001.U)
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x34.U)
      dut.io.memDataIn.poke(0x12.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x1001.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x1234.U)
      dut.io.pcOut.expect(0x1234.U)
      dut.io.done.expect(true.B)
    }
  }
  
  behavior of "JumpInstructions - JSR"
  
  it should "JSR cycle 0 reads low byte" in {
    test(new JSRTestModule) { dut =>
      dut.io.pcIn.poke(0x1000.U)
      dut.io.spIn.poke(0xFF.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x34.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x1000.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x34.U)
      dut.io.pcOut.expect(0x1001.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "JSR cycle 1 reads high byte" in {
    test(new JSRTestModule) { dut =>
      dut.io.pcIn.poke(0x1001.U)
      dut.io.spIn.poke(0xFF.U)
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x34.U)
      dut.io.memDataIn.poke(0x12.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x1001.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x1234.U)
      dut.io.pcOut.expect(0x1002.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "JSR cycle 2 pushes PC-1 high byte" in {
    test(new JSRTestModule) { dut =>
      dut.io.pcIn.poke(0x1002.U)
      dut.io.spIn.poke(0xFF.U)
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x1234.U)
      dut.io.memDataIn.poke(0.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x01FF.U)
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x10.U)
      dut.io.spOut.expect(0xFE.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "JSR cycle 3 pushes PC-1 low byte and jumps" in {
    test(new JSRTestModule) { dut =>
      dut.io.pcIn.poke(0x1002.U)
      dut.io.spIn.poke(0xFE.U)
      dut.io.cycle.poke(3.U)
      dut.io.operand.poke(0x1234.U)
      dut.io.memDataIn.poke(0.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x01FE.U)
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x01.U)
      dut.io.spOut.expect(0xFD.U)
      dut.io.pcOut.expect(0x1234.U)
      dut.io.done.expect(true.B)
    }
  }
  
  behavior of "JumpInstructions - RTS"
  
  it should "RTS cycle 0 increments SP" in {
    test(new RTSTestModule) { dut =>
      dut.io.pcIn.poke(0x0000.U)
      dut.io.spIn.poke(0xFD.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0.U)
      dut.clock.step()
      
      dut.io.spOut.expect(0xFE.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "RTS cycle 1 reads low byte" in {
    test(new RTSTestModule) { dut =>
      dut.io.pcIn.poke(0x0000.U)
      dut.io.spIn.poke(0xFE.U)
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x01FE.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x01.U)
      dut.io.spOut.expect(0xFF.U)
      dut.io.done.expect(false.B)
    }
  }
  
  it should "RTS cycle 2 reads high byte and returns" in {
    test(new RTSTestModule) { dut =>
      dut.io.pcIn.poke(0x0000.U)
      dut.io.spIn.poke(0xFF.U)
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x01.U)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      
      dut.io.memAddr.expect(0x01FF.U)
      dut.io.memRead.expect(true.B)
      dut.io.operandOut.expect(0x1001.U)
      dut.io.pcOut.expect(0x1002.U)
      dut.io.done.expect(true.B)
    }
  }
}
