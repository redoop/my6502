package cpu6502.core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PCDebugTest extends AnyFlatSpec with ChiselScalatestTester {
  "PC" should "show update pattern" in {
    test(new CPU6502Core) { dut =>
      println(s"Initial PC: ${dut.io.debug.regPC.peek().litValue}")
      
      // Fetch NOP
      dut.io.memDataIn.poke(0xEA.U)
      dut.clock.step()
      println(s"After step 1 (Fetch): PC=${dut.io.debug.regPC.peek().litValue}")
      
      // Execute NOP
      dut.clock.step()
      println(s"After step 2 (Execute): PC=${dut.io.debug.regPC.peek().litValue}")
      
      // Next Fetch
      dut.io.memDataIn.poke(0xEA.U)
      dut.clock.step()
      println(s"After step 3 (Fetch): PC=${dut.io.debug.regPC.peek().litValue}")
    }
  }
}
