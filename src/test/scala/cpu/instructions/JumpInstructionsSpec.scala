package cpu6502.instructions

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class JumpInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "JumpInstructions - JMP"

  it should "JMP cycle 0 reads low byte" in {
    test(new JumpTestModule) { dut =>
      dut.io.opcode.poke(0x4C.U)
      dut.io.cycle.poke(0.U)
      dut.io.pcIn.poke(0x1000.U)
      dut.io.memDataIn.poke(0x34.U)  // Low byte
      dut.clock.step()
      dut.io.memAddr.expect(0x1000.U)
      dut.io.memRead.expect(true.B)
      dut.io.pcOut.expect(0x1001.U)
      dut.io.done.expect(false.B)
      dut.io.nextCycle.expect(1.U)
    }
  }

  it should "JMP cycle 1 reads high byte and jumps" in {
    test(new JumpTestModule) { dut =>
      dut.io.opcode.poke(0x4C.U)
      dut.io.cycle.poke(1.U)
      dut.io.pcIn.poke(0x1001.U)
      dut.io.operandIn.poke(0x34.U)  // Low byte from cycle 0
      dut.io.memDataIn.poke(0x12.U)  // High byte
      dut.clock.step()
      dut.io.memAddr.expect(0x1001.U)
      dut.io.memRead.expect(true.B)
      dut.io.pcOut.expect(0x1234.U)  // Jump to 0x1234
      dut.io.done.expect(true.B)
    }
  }
}

class JumpTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(3.W))
    val pcIn       = Input(UInt(16.W))
    val operandIn  = Input(UInt(16.W))
    val memDataIn  = Input(UInt(8.W))
    val memAddr    = Output(UInt(16.W))
    val memRead    = Output(Bool())
    val pcOut      = Output(UInt(16.W))
    val done       = Output(Bool())
    val nextCycle  = Output(UInt(3.W))
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := io.pcIn

  val result = WireDefault(ExecutionResult.hold(regs, io.operandIn))
  
  switch(io.opcode) {
    is(0x4C.U) {
      result := JumpInstructions.executeJMP(io.cycle, regs, io.operandIn, io.memDataIn)
    }
  }

  io.memAddr   := result.memAddr
  io.memRead   := result.memRead
  io.pcOut     := result.regs.pc
  io.done      := result.done
  io.nextCycle := result.nextCycle
}
