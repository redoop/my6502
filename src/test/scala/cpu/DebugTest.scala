package cpu6502

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DebugTest extends AnyFlatSpec with ChiselScalatestTester {
  
  def waitForReset(dut: CPU6502Refactored): Unit = {
    dut.io.memDataIn.poke(0.U)
    dut.clock.step(6)
  }
  
  "CPU6502Refactored" should "provide debug interface" in {
    test(new CPU6502Refactored) { dut =>
      waitForReset(dut)
      
      println("=== Debug Interface Test ===")
      println(s"PC: ${dut.io.debug.regPC.peek()}")
      println(s"A: ${dut.io.debug.regA.peek()}")
      println(s"X: ${dut.io.debug.regX.peek()}")
      println(s"Y: ${dut.io.debug.regY.peek()}")
      println(s"SP: ${dut.io.debug.regSP.peek()}")
      
      // Just verify debug interface is accessible
      assert(dut.io.debug.regPC.peek().litValue >= 0)
      assert(dut.io.debug.regSP.peek().litValue == 0xFD)
    }
  }
}
