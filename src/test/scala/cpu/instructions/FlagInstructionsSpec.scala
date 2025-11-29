package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class FlagInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FlagInstructions"

  it should "CLC clears carry flag" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0x18.U)
      dut.io.flagCIn.poke(true.B)
      dut.clock.step()
      dut.io.flagCOut.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "SEC sets carry flag" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0x38.U)
      dut.io.flagCIn.poke(false.B)
      dut.clock.step()
      dut.io.flagCOut.expect(true.B)
    }
  }

  it should "CLD clears decimal flag" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0xD8.U)
      dut.io.flagDIn.poke(true.B)
      dut.clock.step()
      dut.io.flagDOut.expect(false.B)
    }
  }

  it should "SEI sets interrupt flag" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0x78.U)
      dut.io.flagIIn.poke(false.B)
      dut.clock.step()
      dut.io.flagIOut.expect(true.B)
    }
  }

  it should "CLV clears overflow flag" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0xB8.U)
      dut.io.flagVIn.poke(true.B)
      dut.clock.step()
      dut.io.flagVOut.expect(false.B)
    }
  }

  it should "NOP does nothing" in {
    test(new FlagTestModule) { dut =>
      dut.io.opcode.poke(0xEA.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.flagZIn.poke(true.B)
      dut.clock.step()
      dut.io.flagCOut.expect(true.B)
      dut.io.flagZOut.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }
}

// Module
class FlagTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val flagCIn  = Input(Bool())
    val flagZIn  = Input(Bool())
    val flagIIn  = Input(Bool())
    val flagDIn  = Input(Bool())
    val flagVIn  = Input(Bool())
    val flagNIn  = Input(Bool())
    val flagCOut = Output(Bool())
    val flagZOut = Output(Bool())
    val flagIOut = Output(Bool())
    val flagDOut = Output(Bool())
    val flagVOut = Output(Bool())
    val flagNOut = Output(Bool())
    val done     = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.flagC := io.flagCIn
  regs.flagZ := io.flagZIn
  regs.flagI := io.flagIIn
  regs.flagD := io.flagDIn
  regs.flagV := io.flagVIn
  regs.flagN := io.flagNIn

  val result = FlagInstructions.execute(io.opcode, regs)

  io.flagCOut := result.regs.flagC
  io.flagZOut := result.regs.flagZ
  io.flagIOut := result.regs.flagI
  io.flagDOut := result.regs.flagD
  io.flagVOut := result.regs.flagV
  io.flagNOut := result.regs.flagN
  io.done     := result.done
}
