package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class LDAMemReadTimingSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "LDA Absolute" should "have correct memRead timing" in {
    test(new LDAAbsoluteModule) { dut =>
      println("=== LDA Absolute memRead Timing ===")
      
      // Setup: LDA $2002
      dut.io.opcode.poke(0xAD.U)  // LDA absolute
      dut.io.memDataIn.poke(0x02.U)  // Low byte
      
      // Cycle 0: Read low byte
      dut.io.cycle.poke(0.U)
      dut.clock.step(1)
      val memRead0 = dut.io.memRead.peek().litValue
      val memAddr0 = dut.io.memAddr.peek().litValue
      println(f"Cycle 0: memRead=$memRead0 memAddr=0x$memAddr0%04x")
      
      // Cycle 1: Read high byte
      dut.io.cycle.poke(1.U)
      dut.io.memDataIn.poke(0x20.U)  // High byte
      dut.clock.step(1)
      val memRead1 = dut.io.memRead.peek().litValue
      val memAddr1 = dut.io.memAddr.peek().litValue
      println(f"Cycle 1: memRead=$memRead1 memAddr=0x$memAddr1%04x")
      
      // Cycle 2: Read data
      dut.io.cycle.poke(2.U)
      dut.io.memDataIn.poke(0x80.U)  // PPUSTATUS value
      dut.clock.step(1)
      val memRead2 = dut.io.memRead.peek().litValue
      val memAddr2 = dut.io.memAddr.peek().litValue
      println(f"Cycle 2: memRead=$memRead2 memAddr=0x$memAddr2%04x")
      
      // Cycle 3: Complete (if exists)
      dut.io.cycle.poke(3.U)
      dut.clock.step(1)
      val memRead3 = dut.io.memRead.peek().litValue
      val memAddr3 = dut.io.memAddr.peek().litValue
      val done = dut.io.done.peek().litValue
      val aOut = dut.io.aOut.peek().litValue
      println(f"Cycle 3: memRead=$memRead3 memAddr=0x$memAddr3%04x done=$done A=0x$aOut%02x")
      
      // 验证
      assert(memRead2 == 1, "Cycle 2 should have memRead=1")
      println(f"\n✓ memRead timing verified")
      println(f"  Critical: Cycle 2 memRead=$memRead2")
      println(f"  Critical: Cycle 3 memRead=$memRead3")
    }
  }
}

// Test module for LDA absolute
class LDAAbsoluteModule extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(8.W))
    val cycle = Input(UInt(3.W))
    val memDataIn = Input(UInt(8.W))
    val memRead = Output(Bool())
    val memAddr = Output(UInt(16.W))
    val done = Output(Bool())
    val aOut = Output(UInt(8.W))
  })
  
  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.pc := 0x1000.U
  
  val operand = RegInit(0.U(16.W))
  
  val result = LoadStoreInstructions.executeAbsolute(
    io.opcode, io.cycle, regs, operand, io.memDataIn
  )
  
  operand := result.operand
  
  io.memRead := result.memRead
  io.memAddr := result.memAddr
  io.done := result.done
  io.aOut := result.regs.a
}
