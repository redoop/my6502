package cpu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.CPU6502Refactored

class CPUResetTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "CPU" should "progress through Reset state" in {
    test(new CPU6502Refactored).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Initialize
      dut.io.memDataIn.poke(0.U)
      dut.io.memReady.poke(true.B)
      dut.io.nmi.poke(false.B)
      
      // Hold reset for a few cycles
      dut.io.reset.poke(true.B)
      dut.clock.step(5)
      
      // Release reset
      dut.io.reset.poke(false.B)
      
      println("=== After reset release ===")
      for (i <- 0 until 20) {
        val state = dut.io.debug.state.peek().litValue
        val cycle = dut.io.debug.cycle.peek().litValue
        val pc = dut.io.debug.regPC.peek().litValue
        val memAddr = dut.io.memAddr.peek().litValue
        val memRead = dut.io.memRead.peek().litValue
        
        println(f"Cycle $i: State=$state Cycle=$cycle PC=0x${pc}%04x MemAddr=0x${memAddr}%04x MemRead=$memRead")
        
        // Provide data based on address
        if (memAddr == 0xFFFC) {
          dut.io.memDataIn.poke(0x00.U)  // Reset vector low byte
        } else if (memAddr == 0xFFFD) {
          dut.io.memDataIn.poke(0x80.U)  // Reset vector high byte -> $8000
        } else if (memAddr >= 0x8000.U.litValue) {
          dut.io.memDataIn.poke(0xEA.U)  // NOP instruction
        } else {
          dut.io.memDataIn.poke(0x00.U)  // Default
        }
        
        dut.clock.step(1)
      }
      
      val finalPC = dut.io.debug.regPC.peek().litValue
      val finalState = dut.io.debug.state.peek().litValue
      println(f"\nFinal: State=$finalState PC=0x${finalPC}%04x")
      
      // Should have completed reset and moved to Fetch state
      assert(finalState != 0, "CPU should have left Reset state")
      assert(finalPC == 0x8000L, f"PC should be 0x8000, got 0x${finalPC}%04x")
    }
  }
}
