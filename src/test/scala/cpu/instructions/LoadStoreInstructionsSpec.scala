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

  behavior of "LoadStoreInstructions - Zero Page"

  it should "LDA zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xA5.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x42.U)
      dut.io.memDataIn.poke(0x99.U)
      dut.clock.step()
      dut.io.aOut.expect(0x99.U)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "LDX zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xA6.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x50.U)
      dut.io.memDataIn.poke(0x77.U)
      dut.clock.step()
      dut.io.xOut.expect(0x77.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "LDY zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xA4.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x30.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.yOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "STA zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x85.U)
      dut.io.aIn.poke(0x42.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x20.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x42.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "STX zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x86.U)
      dut.io.xIn.poke(0x55.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x10.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x55.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "STY zero page" in {
    test(new LoadStoreZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x84.U)
      dut.io.yIn.poke(0xAA.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x08.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x08.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0xAA.U)
      dut.io.done.expect(true.B)
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

class LoadStoreZeroPageTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val xIn        = Input(UInt(8.W))
    val yIn        = Input(UInt(8.W))
    val memAddr    = Output(UInt(16.W))
    val memRead    = Output(Bool())
    val memWrite   = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val xOut       = Output(UInt(8.W))
    val yOut       = Output(UInt(8.W))
    val flagN      = Output(Bool())
    val flagZ      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = LoadStoreInstructions.executeZeroPage(io.opcode, io.cycle, regs, io.operand, io.memDataIn)

  io.memAddr    := result.memAddr
  io.memRead    := result.memRead
  io.memWrite   := result.memWrite
  io.memDataOut := result.memData
  io.aOut       := result.regs.a
  io.xOut       := result.regs.x
  io.yOut       := result.regs.y
  io.flagN      := result.regs.flagN
  io.flagZ      := result.regs.flagZ
  io.done       := result.done
}

class LoadStoreAbsoluteTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(16.W))
    val memDataIn  = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val xIn        = Input(UInt(8.W))
    val yIn        = Input(UInt(8.W))
    val memAddr    = Output(UInt(16.W))
    val memWrite   = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val xOut       = Output(UInt(8.W))
    val yOut       = Output(UInt(8.W))
    val flagN      = Output(Bool())
    val flagZ      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = LoadStoreInstructions.executeAbsolute(io.opcode, io.cycle, regs, io.operand, io.memDataIn)

  io.memAddr    := result.memAddr
  io.memWrite   := result.memWrite
  io.memDataOut := result.memData
  io.aOut       := result.regs.a
  io.xOut       := result.regs.x
  io.yOut       := result.regs.y
  io.flagN      := result.regs.flagN
  io.flagZ      := result.regs.flagZ
  io.done       := result.done
}
