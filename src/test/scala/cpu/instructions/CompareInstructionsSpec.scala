package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class CompareInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CompareInstructions"

  it should "CMP sets carry when A >= operand" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xC9.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.flagCOut.expect(true.B)  // 0x50 >= 0x30
      dut.io.flagZOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "CMP clears carry when A < operand" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xC9.U)
      dut.io.aIn.poke(0x30.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.flagCOut.expect(false.B)  // 0x30 < 0x50
      dut.io.flagNOut.expect(true.B)  // result is negative
    }
  }

  it should "CMP sets zero flag when A == operand" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xC9.U)
      dut.io.aIn.poke(0x42.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.flagZOut.expect(true.B)
      dut.io.flagCOut.expect(true.B)  // equal means >=
    }
  }

  it should "CPX compares X register" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xE0.U)
      dut.io.xIn.poke(0x80.U)
      dut.io.memDataIn.poke(0x7F.U)
      dut.clock.step()
      dut.io.flagCOut.expect(true.B)  // 0x80 >= 0x7F
      dut.io.flagZOut.expect(false.B)
    }
  }

  it should "CPX sets zero when X == operand" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xE0.U)
      dut.io.xIn.poke(0xFF.U)
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.flagZOut.expect(true.B)
      dut.io.flagCOut.expect(true.B)
    }
  }

  it should "CPY compares Y register" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xC0.U)
      dut.io.yIn.poke(0x10.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.flagCOut.expect(false.B)  // 0x10 < 0x20
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "CPY sets zero when Y == operand" in {
    test(new CompareTestModule) { dut =>
      dut.io.opcode.poke(0xC0.U)
      dut.io.yIn.poke(0x00.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.flagZOut.expect(true.B)
      dut.io.flagCOut.expect(true.B)
    }
  }
}

class CompareTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val xIn        = Input(UInt(8.W))
    val yIn        = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val flagCOut   = Output(Bool())
    val flagZOut   = Output(Bool())
    val flagNOut   = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = CompareInstructions.executeImmediate(io.opcode, regs, io.memDataIn)

  io.flagCOut := result.regs.flagC
  io.flagZOut := result.regs.flagZ
  io.flagNOut := result.regs.flagN
}
