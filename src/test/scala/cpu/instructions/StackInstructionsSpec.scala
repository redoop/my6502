package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class StackInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "StackInstructions - Push"

  it should "PHA pushes accumulator to stack" in {
    test(new StackPushTestModule) { dut =>
      dut.io.opcode.poke(0x48.U)
      dut.io.aIn.poke(0x42.U)
      dut.io.spIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.memAddr.expect(0x01FF.U)  // Stack page 0x0100 + SP
      dut.io.memData.expect(0x42.U)
      dut.io.memWrite.expect(true.B)
      dut.io.spOut.expect(0xFE.U)  // SP decremented
    }
  }

  it should "PHP pushes processor status to stack" in {
    test(new StackPushTestModule) { dut =>
      dut.io.opcode.poke(0x08.U)
      dut.io.spIn.poke(0xFD.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.flagZIn.poke(false.B)
      dut.io.flagNIn.poke(true.B)
      dut.clock.step()
      dut.io.memAddr.expect(0x01FD.U)
      // Status byte: NV1BDIZC = 10110001 = 0xB1
      dut.io.memData.expect(0xB1.U)
      dut.io.memWrite.expect(true.B)
      dut.io.spOut.expect(0xFC.U)
    }
  }

  it should "PHA handles stack wrap" in {
    test(new StackPushTestModule) { dut =>
      dut.io.opcode.poke(0x48.U)
      dut.io.aIn.poke(0x99.U)
      dut.io.spIn.poke(0x00.U)
      dut.clock.step()
      dut.io.memAddr.expect(0x0100.U)
      dut.io.spOut.expect(0xFF.U)  // Wraps to 0xFF
    }
  }
}

class StackPushTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val aIn      = Input(UInt(8.W))
    val spIn     = Input(UInt(8.W))
    val flagCIn  = Input(Bool())
    val flagZIn  = Input(Bool())
    val flagNIn  = Input(Bool())
    val memAddr  = Output(UInt(16.W))
    val memData  = Output(UInt(8.W))
    val memWrite = Output(Bool())
    val spOut    = Output(UInt(8.W))
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.sp := io.spIn
  regs.flagC := io.flagCIn
  regs.flagZ := io.flagZIn
  regs.flagN := io.flagNIn

  val result = StackInstructions.executePush(io.opcode, regs)

  io.memAddr  := result.memAddr
  io.memData  := result.memData
  io.memWrite := result.memWrite
  io.spOut    := result.regs.sp
}
