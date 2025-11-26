package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class TransferInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "TransferInstructions"

  it should "TAX transfers A to X and updates flags" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0xAA.U)
      dut.io.aIn.poke(0x42.U)
      dut.clock.step()
      dut.io.xOut.expect(0x42.U)
      dut.io.flagNOut.expect(false.B)
      dut.io.flagZOut.expect(false.B)
    }
  }

  it should "TAX sets zero flag when A is 0" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0xAA.U)
      dut.io.aIn.poke(0x00.U)
      dut.clock.step()
      dut.io.xOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "TAX sets negative flag when A is negative" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0xAA.U)
      dut.io.aIn.poke(0x80.U)
      dut.clock.step()
      dut.io.xOut.expect(0x80.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "TAY transfers A to Y" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0xA8.U)
      dut.io.aIn.poke(0x55.U)
      dut.clock.step()
      dut.io.yOut.expect(0x55.U)
    }
  }

  it should "TXA transfers X to A" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0x8A.U)
      dut.io.xIn.poke(0x33.U)
      dut.clock.step()
      dut.io.aOut.expect(0x33.U)
    }
  }

  it should "TYA transfers Y to A" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0x98.U)
      dut.io.yIn.poke(0x77.U)
      dut.clock.step()
      dut.io.aOut.expect(0x77.U)
    }
  }

  it should "TSX transfers SP to X" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0xBA.U)
      dut.io.spIn.poke(0xFD.U)
      dut.clock.step()
      dut.io.xOut.expect(0xFD.U)
      dut.io.flagNOut.expect(true.B)  // 0xFD has bit 7 set
    }
  }

  it should "TXS transfers X to SP without affecting flags" in {
    test(new TransferTestModule) { dut =>
      dut.io.opcode.poke(0x9A.U)
      dut.io.xIn.poke(0xAB.U)
      dut.io.flagNIn.poke(false.B)
      dut.io.flagZIn.poke(false.B)
      dut.clock.step()
      dut.io.spOut.expect(0xAB.U)
      // TXS 不影响标志位
      dut.io.flagNOut.expect(false.B)
      dut.io.flagZOut.expect(false.B)
    }
  }
}

class TransferTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val aIn      = Input(UInt(8.W))
    val xIn      = Input(UInt(8.W))
    val yIn      = Input(UInt(8.W))
    val spIn     = Input(UInt(8.W))
    val flagNIn  = Input(Bool())
    val flagZIn  = Input(Bool())
    val aOut     = Output(UInt(8.W))
    val xOut     = Output(UInt(8.W))
    val yOut     = Output(UInt(8.W))
    val spOut    = Output(UInt(8.W))
    val flagNOut = Output(Bool())
    val flagZOut = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn
  regs.sp := io.spIn
  regs.flagN := io.flagNIn
  regs.flagZ := io.flagZIn

  val result = TransferInstructions.execute(io.opcode, regs)

  io.aOut     := result.regs.a
  io.xOut     := result.regs.x
  io.yOut     := result.regs.y
  io.spOut    := result.regs.sp
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}
