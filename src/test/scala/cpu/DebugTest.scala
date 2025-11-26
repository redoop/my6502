package cpu6502

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DebugTest extends AnyFlatSpec with ChiselScalatestTester {
  "CPU6502Refactored" should "debug INX" in {
    test(new CPU6502Refactored) { dut =>
      println("=== Initial State ===")
      println(s"PC: ${dut.io.debug.regPC.peek()}")
      println(s"X: ${dut.io.debug.regX.peek()}")
      println(s"State: Fetch")
      
      // LDX #$10
      dut.io.memDataIn.poke(0xA2.U)
      dut.clock.step(1)
      println("\n=== After LDX opcode fetch ===")
      println(s"PC: ${dut.io.debug.regPC.peek()}")
      println(s"Opcode: ${dut.io.debug.opcode.peek()}")
      
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step(1)
      println("\n=== After LDX operand ===")
      println(s"PC: ${dut.io.debug.regPC.peek()}")
      println(s"X: ${dut.io.debug.regX.peek()}")
      
      // INX
      dut.io.memDataIn.poke(0xE8.U)
      dut.clock.step(1)
      println("\n=== After INX opcode fetch ===")
      println(s"PC: ${dut.io.debug.regPC.peek()}")
      println(s"Opcode: ${dut.io.debug.opcode.peek()}")
      println(s"X: ${dut.io.debug.regX.peek()}")
      
      // 需要额外一个周期来执行
      dut.io.memDataIn.poke(0xEA.U)  // NOP
      dut.clock.step(1)
      println("\n=== After INX execute ===")
      println(s"X: ${dut.io.debug.regX.peek()}")
      
      dut.io.debug.regX.expect(0x11.U)
    }
  }
}
