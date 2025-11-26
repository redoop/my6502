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
