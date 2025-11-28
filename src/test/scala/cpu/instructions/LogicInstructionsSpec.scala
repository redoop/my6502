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

  behavior of "LogicInstructions - Zero Page"

  it should "AND zero page" in {
    test(new LogicZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x25.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x10.U)
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x0F.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "ORA zero page" in {
    test(new LogicZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x05.U)
      dut.io.aIn.poke(0xF0.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x20.U)
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "EOR zero page" in {
    test(new LogicZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x45.U)
      dut.io.aIn.poke(0xAA.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x30.U)
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "BIT zero page tests bits" in {
    test(new LogicZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x24.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x40.U)
      dut.io.memDataIn.poke(0xC0.U)  // bit 7=1, bit 6=1
      dut.clock.step()
      dut.io.flagN.expect(true.B)
      dut.io.flagV.expect(true.B)
      dut.io.done.expect(true.B)
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

class LogicZeroPageTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val flagN      = Output(Bool())
    val flagZ      = Output(Bool())
    val flagV      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn

  val isBIT = io.opcode === 0x24.U
  val result = Mux(isBIT,
    LogicInstructions.executeBIT(io.cycle, regs, io.operand, io.memDataIn),
    LogicInstructions.executeZeroPage(io.opcode, io.cycle, regs, io.operand, io.memDataIn)
  )

  io.aOut  := result.regs.a
  io.flagN := result.regs.flagN
  io.flagZ := result.regs.flagZ
  io.flagV := result.regs.flagV
  io.done  := result.done
}

class LogicAbsoluteSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "LogicInstructions - Absolute"

  it should "AND absolute" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2D.U)
      dut.io.aIn.poke(0xFF.U)
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
      dut.io.memDataIn.poke(0x0F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x0F.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ORA absolute" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x0D.U)
      dut.io.aIn.poke(0x0F.U)
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
      dut.io.memDataIn.poke(0xF0.U)
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "EOR absolute" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x4D.U)
      dut.io.aIn.poke(0xFF.U)
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
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "BIT absolute" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2C.U)
      dut.io.aIn.poke(0xFF.U)
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
      dut.io.memDataIn.poke(0xC0.U)
      dut.clock.step()
      dut.io.aOut.expect(0xFF.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.flagV.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "BIT absolute with zero result" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2C.U)
      dut.io.aIn.poke(0x0F.U)
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
      dut.io.memDataIn.poke(0xF0.U)
      dut.clock.step()
      dut.io.aOut.expect(0x0F.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(true.B)
      dut.io.flagV.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "AND absolute with zero result" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2D.U)
      dut.io.aIn.poke(0x0F.U)
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
      dut.io.memDataIn.poke(0xF0.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ORA absolute with zero input" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x0D.U)
      dut.io.aIn.poke(0x00.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x70.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x7000.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "EOR absolute with negative result" in {
    test(new LogicAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x4D.U)
      dut.io.aIn.poke(0x0F.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x8000.U)
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.aOut.expect(0xF0.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }
}
