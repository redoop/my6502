package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class ArithmeticInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ArithmeticInstructions"

  it should "INX increments X register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xE8.U)
      dut.io.xIn.poke(0x41.U)
      dut.clock.step()
      dut.io.xOut.expect(0x42.U)
      dut.io.flagZOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "INX wraps from 0xFF to 0x00 and sets zero flag" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xE8.U)
      dut.io.xIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.xOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "INY increments Y register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xC8.U)
      dut.io.yIn.poke(0x10.U)
      dut.clock.step()
      dut.io.yOut.expect(0x11.U)
    }
  }

  it should "DEX decrements X register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xCA.U)
      dut.io.xIn.poke(0x42.U)
      dut.clock.step()
      dut.io.xOut.expect(0x41.U)
    }
  }

  it should "DEX wraps from 0x00 to 0xFF and sets negative flag" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xCA.U)
      dut.io.xIn.poke(0x00.U)
      dut.clock.step()
      dut.io.xOut.expect(0xFF.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "DEY decrements Y register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x88.U)
      dut.io.yIn.poke(0x01.U)
      dut.clock.step()
      dut.io.yOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "INC A (65C02) increments accumulator" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x1A.U)
      dut.io.aIn.poke(0x7F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "DEC A (65C02) decrements accumulator" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x3A.U)
      dut.io.aIn.poke(0x80.U)
      dut.clock.step()
      dut.io.aOut.expect(0x7F.U)
      dut.io.flagNOut.expect(false.B)
    }
  }
}

class ArithmeticTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val aIn      = Input(UInt(8.W))
    val xIn      = Input(UInt(8.W))
    val yIn      = Input(UInt(8.W))
    val aOut     = Output(UInt(8.W))
    val xOut     = Output(UInt(8.W))
    val yOut     = Output(UInt(8.W))
    val flagNOut = Output(Bool())
    val flagZOut = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = ArithmeticInstructions.executeImplied(io.opcode, regs)

  io.aOut     := result.regs.a
  io.xOut     := result.regs.x
  io.yOut     := result.regs.y
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}
