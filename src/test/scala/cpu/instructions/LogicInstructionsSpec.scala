package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class LogicInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "LogicInstructions"

  it should "AND performs bitwise AND" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x29.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x0F.U)
      dut.io.flagZOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "AND sets zero flag when result is zero" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x29.U)
      dut.io.aIn.poke(0xF0.U)
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "AND sets negative flag when bit 7 is set" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x29.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "ORA performs bitwise OR" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x09.U)
      dut.io.aIn.poke(0xF0.U)
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "ORA with zero sets zero flag" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x09.U)
      dut.io.aIn.poke(0x00.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "EOR performs bitwise XOR" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x49.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "EOR toggles bits" in {
    test(new LogicTestModule) { dut =>
      dut.io.opcode.poke(0x49.U)
      dut.io.aIn.poke(0xAA.U)  // 10101010
      dut.io.memDataIn.poke(0x55.U)  // 01010101
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)  // 11111111
      dut.io.flagNOut.expect(true.B)
    }
  }
}

class LogicTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val flagNOut   = Output(Bool())
    val flagZOut   = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn

  val result = LogicInstructions.executeImmediate(io.opcode, regs, io.memDataIn)

  io.aOut     := result.regs.a
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}
