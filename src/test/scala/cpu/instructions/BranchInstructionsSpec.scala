package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class BranchInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "BranchInstructions"

  it should "BEQ branches when zero flag is set" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0xF0.U)
      dut.io.pcIn.poke(0x1000.U)
      dut.io.flagZIn.poke(true.B)
      dut.io.offset.poke(0x10.U)  // +16
      dut.clock.step()
      dut.io.pcOut.expect(0x1011.U)  // 0x1000 + 1 + 0x10
    }
  }

  it should "BEQ does not branch when zero flag is clear" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0xF0.U)
      dut.io.pcIn.poke(0x1000.U)
      dut.io.flagZIn.poke(false.B)
      dut.io.offset.poke(0x10.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x1001.U)  // just PC + 1
    }
  }

  it should "BNE branches when zero flag is clear" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0xD0.U)
      dut.io.pcIn.poke(0x2000.U)
      dut.io.flagZIn.poke(false.B)
      dut.io.offset.poke(0x05.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x2006.U)
    }
  }

  it should "BCS branches when carry flag is set" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0xB0.U)
      dut.io.pcIn.poke(0x3000.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.offset.poke(0x20.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x3021.U)
    }
  }

  it should "BCC branches when carry flag is clear" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0x90.U)
      dut.io.pcIn.poke(0x4000.U)
      dut.io.flagCIn.poke(false.B)
      dut.io.offset.poke(0x08.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x4009.U)
    }
  }

  it should "BMI branches when negative flag is set" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0x30.U)
      dut.io.pcIn.poke(0x5000.U)
      dut.io.flagNIn.poke(true.B)
      dut.io.offset.poke(0x0A.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x500B.U)
    }
  }

  it should "BPL branches when negative flag is clear" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0x10.U)
      dut.io.pcIn.poke(0x6000.U)
      dut.io.flagNIn.poke(false.B)
      dut.io.offset.poke(0x15.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x6016.U)
    }
  }

  it should "BVS branches when overflow flag is set" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0x70.U)
      dut.io.pcIn.poke(0x7000.U)
      dut.io.flagVIn.poke(true.B)
      dut.io.offset.poke(0x03.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x7004.U)
    }
  }

  it should "BVC branches when overflow flag is clear" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0x50.U)
      dut.io.pcIn.poke(0x8000.U)
      dut.io.flagVIn.poke(false.B)
      dut.io.offset.poke(0x07.U)
      dut.clock.step()
      dut.io.pcOut.expect(0x8008.U)
    }
  }

  it should "handle negative offset (backward branch)" in {
    test(new BranchTestModule) { dut =>
      dut.io.opcode.poke(0xF0.U)  // BEQ
      dut.io.pcIn.poke(0x1010.U)
      dut.io.flagZIn.poke(true.B)
      dut.io.offset.poke(0xF0.U)  // -16 in signed byte
      dut.clock.step()
      dut.io.pcOut.expect(0x1001.U)  // 0x1010 + 1 - 16
    }
  }
}

class BranchTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val pcIn     = Input(UInt(16.W))
    val flagZIn  = Input(Bool())
    val flagCIn  = Input(Bool())
    val flagNIn  = Input(Bool())
    val flagVIn  = Input(Bool())
    val offset   = Input(UInt(8.W))
    val pcOut    = Output(UInt(16.W))
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn
  regs.flagZ := io.flagZIn
  regs.flagC := io.flagCIn
  regs.flagN := io.flagNIn
  regs.flagV := io.flagVIn

  val result = BranchInstructions.execute(io.opcode, regs, io.offset)

  io.pcOut := result.regs.pc
}
