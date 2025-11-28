package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class ShiftInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ShiftInstructions"

  it should "ASL A shifts left and sets carry" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x0A.U)
      dut.io.aIn.poke(0x81.U)  // 10000001
      dut.clock.step()
      dut.io.aOut.expect(0x02.U)  // 00000010
      dut.io.flagCOut.expect(true.B)  // bit 7 was set
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "ASL A sets zero flag" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x0A.U)
      dut.io.aIn.poke(0x80.U)  // 10000000
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
      dut.io.flagCOut.expect(true.B)
    }
  }

  it should "LSR A shifts right and sets carry" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x4A.U)
      dut.io.aIn.poke(0x81.U)  // 10000001
      dut.clock.step()
      dut.io.aOut.expect(0x40.U)  // 01000000
      dut.io.flagCOut.expect(true.B)  // bit 0 was set
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "LSR A clears negative flag" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x4A.U)
      dut.io.aIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.aOut.expect(0x7F.U)
      dut.io.flagNOut.expect(false.B)  // LSR always clears N
      dut.io.flagCOut.expect(true.B)
    }
  }

  it should "ROL A rotates left through carry" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x2A.U)
      dut.io.aIn.poke(0x81.U)  // 10000001
      dut.io.flagCIn.poke(true.B)
      dut.clock.step()
      dut.io.aOut.expect(0x03.U)  // 00000011 (carry rotated in)
      dut.io.flagCOut.expect(true.B)  // bit 7 rotated out
    }
  }

  it should "ROL A with carry clear" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x2A.U)
      dut.io.aIn.poke(0x40.U)  // 01000000
      dut.io.flagCIn.poke(false.B)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)  // 10000000
      dut.io.flagCOut.expect(false.B)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "ROR A rotates right through carry" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x6A.U)
      dut.io.aIn.poke(0x81.U)  // 10000001
      dut.io.flagCIn.poke(true.B)
      dut.clock.step()
      dut.io.aOut.expect(0xC0.U)  // 11000000 (carry rotated in)
      dut.io.flagCOut.expect(true.B)  // bit 0 rotated out
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "ROR A with carry clear" in {
    test(new ShiftTestModule) { dut =>
      dut.io.opcode.poke(0x6A.U)
      dut.io.aIn.poke(0x02.U)  // 00000010
      dut.io.flagCIn.poke(false.B)
      dut.clock.step()
      dut.io.aOut.expect(0x01.U)  // 00000001
      dut.io.flagCOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  behavior of "ShiftInstructions - Zero Page"

  it should "ASL zero page" in {
    test(new ShiftZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x06.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x10.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x80.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "LSR zero page" in {
    test(new ShiftZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x46.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x20.U)
      dut.io.memDataIn.poke(0x81.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x40.U)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROL zero page" in {
    test(new ShiftZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x26.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x30.U)
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x01.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROR zero page" in {
    test(new ShiftZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x66.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x40.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x80.U)
      dut.io.done.expect(true.B)
    }
  }
}

class ShiftTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val aIn      = Input(UInt(8.W))
    val flagCIn  = Input(Bool())
    val aOut     = Output(UInt(8.W))
    val flagCOut = Output(Bool())
    val flagNOut = Output(Bool())
    val flagZOut = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.flagC := io.flagCIn

  val result = ShiftInstructions.executeAccumulator(io.opcode, regs)

  io.aOut     := result.regs.a
  io.flagCOut := result.regs.flagC
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}

class ShiftZeroPageTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val flagCIn    = Input(Bool())
    val memAddr    = Output(UInt(16.W))
    val memWrite   = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val flagC      = Output(Bool())
    val flagN      = Output(Bool())
    val flagZ      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.flagC := io.flagCIn

  val result = ShiftInstructions.executeZeroPage(io.opcode, io.cycle, regs, io.operand, io.memDataIn)

  io.memAddr    := result.memAddr
  io.memWrite   := result.memWrite
  io.memDataOut := result.memData
  io.flagC      := result.regs.flagC
  io.flagN      := result.regs.flagN
  io.flagZ      := result.regs.flagZ
  io.done       := result.done
}

class ShiftAbsoluteSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ShiftInstructions - Absolute"

  it should "ASL absolute" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x0E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0xAA.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.flagZ.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "LSR absolute" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x4E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x55.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(false.B)
      dut.io.flagZ.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROL absolute" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2E.U)
      dut.io.flagCIn.poke(true.B)
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
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0xAB.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.flagZ.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROR absolute" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x6E.U)
      dut.io.flagCIn.poke(true.B)
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
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0xD5.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.flagZ.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ASL absolute with carry" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x0E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "LSR absolute with carry" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x4E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROL absolute with carry out" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x2E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0x80.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ROR absolute with carry out" in {
    test(new ShiftAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x6E.U)
      dut.io.flagCIn.poke(false.B)
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
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }
}
