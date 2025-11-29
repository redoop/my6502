package cpu6502

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CPU6502Test extends AnyFlatSpec with ChiselScalatestTester {
  
  def waitForReset(dut: CPU6502Refactored): Unit = {
    dut.io.memDataIn.poke(0.U)
    dut.clock.step(6)
  }
  
  "CPU6502Refactored" should "complete reset sequence" in {
    test(new CPU6502Refactored) { dut =>
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step(3)
      dut.io.memDataIn.poke(0xC0.U)
      dut.clock.step(3)
      
      // PC should be set to reset vector
      dut.io.debug.regPC.expect(0xC000.U)
    }
  }

  it should "execute LDA immediate" in {
    test(new CPU6502Refactored) { dut =>
      waitForReset(dut)
      // Run enough cycles for LDA #$42
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step(5)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step(5)
      
      dut.io.debug.regA.expect(0x42.U)
    }
  }

  it should "read from memory" in {
    test(new CPU6502Refactored) { dut =>
      waitForReset(dut)
      dut.clock.step(1)
      
      // Should be reading from memory
      dut.io.memRead.expect(true.B)
    }
  }

  it should "have correct initial state" in {
    test(new CPU6502Refactored) { dut =>
      waitForReset(dut)
      
      // Check initial register values
      dut.io.debug.regA.expect(0.U)
      dut.io.debug.regX.expect(0.U)
      dut.io.debug.regY.expect(0.U)
      dut.io.debug.regSP.expect(0xFD.U)
    }
  }

  it should "increment PC during fetch" in {
    test(new CPU6502Refactored) { dut =>
      waitForReset(dut)
      val pc0 = dut.io.debug.regPC.peek().litValue
      
      dut.io.memDataIn.poke(0xEA.U)  // NOP
      dut.clock.step(5)
      
      val pc1 = dut.io.debug.regPC.peek().litValue
      assert(pc1 > pc0)
    }
  }
}
