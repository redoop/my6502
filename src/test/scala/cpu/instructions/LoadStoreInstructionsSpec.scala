package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class LoadStoreInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "LoadStoreInstructions - Immediate"

  it should "LDA immediate loads accumulator" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA9.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.aOut.expect(0x42.U)
      dut.io.flagZOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "LDA immediate sets zero flag" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA9.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "LDA immediate sets negative flag" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA9.U)
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "LDX immediate loads X register" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA2.U)
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      dut.io.xOut.expect(0x55.U)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "LDY immediate loads Y register" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA0.U)
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.io.yOut.expect(0xAA.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "update PC correctly" in {
    test(new LoadStoreImmediateTestModule) { dut =>
      dut.io.opcode.poke(0xA9.U)
      dut.io.pcIn.poke(0x1000.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x1001.U)
    }
  }
}

class LoadStoreImmediateTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val pcIn       = Input(UInt(16.W))
    val memDataIn  = Input(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val xOut       = Output(UInt(8.W))
    val yOut       = Output(UInt(8.W))
    val pcOut      = Output(UInt(16.W))
    val flagNOut   = Output(Bool())
    val flagZOut   = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn

  val result = LoadStoreInstructions.executeImmediate(io.opcode, regs, io.memDataIn)

  io.aOut     := result.regs.a
  io.xOut     := result.regs.x
  io.yOut     := result.regs.y
  io.pcOut    := result.regs.pc
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}
