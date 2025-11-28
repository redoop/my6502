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

  behavior of "CompareInstructions - Zero Page"

  it should "CMP zero page" in {
    test(new CompareZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xC5.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x10.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CPX zero page" in {
    test(new CompareZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xE4.U)
      dut.io.xIn.poke(0x42.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x20.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.flagZ.expect(true.B)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CPY zero page" in {
    test(new CompareZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xC4.U)
      dut.io.yIn.poke(0x10.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x30.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
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

class CompareZeroPageTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val xIn        = Input(UInt(8.W))
    val yIn        = Input(UInt(8.W))
    val flagC      = Output(Bool())
    val flagZ      = Output(Bool())
    val flagN      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = CompareInstructions.executeZeroPageGeneric(io.opcode, io.cycle, regs, io.operand, io.memDataIn)

  io.flagC := result.regs.flagC
  io.flagZ := result.regs.flagZ
  io.flagN := result.regs.flagN
  io.done  := result.done
}

class CompareAbsoluteSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CompareInstructions - Absolute"

  it should "CMP absolute equal" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCD.U)
      dut.io.aIn.poke(0x42.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x34.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x34.U)
      dut.io.memDataIn.poke(0x12.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x1234.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.flagZ.expect(true.B)
      dut.io.flagC.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CMP absolute greater" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCD.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x2000.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.flagZ.expect(false.B)
      dut.io.flagC.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CMP absolute less" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCD.U)
      dut.io.aIn.poke(0x30.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x3000.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.flagZ.expect(false.B)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CPX absolute equal" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xEC.U)
      dut.io.xIn.poke(0x55.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x4000.U)
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      dut.io.flagZ.expect(true.B)
      dut.io.flagC.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CPX absolute greater" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xEC.U)
      dut.io.xIn.poke(0x80.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x5000.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.flagZ.expect(false.B)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "CPY absolute equal" in {
    test(new CompareAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCC.U)
      dut.io.yIn.poke(0xAA.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x60.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x6000.U)
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.io.flagZ.expect(true.B)
      dut.io.flagC.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }
}
