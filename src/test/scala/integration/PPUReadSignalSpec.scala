package integration

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUReadSignalSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU cpuRead" should "trigger when cpuRead=1 and cpuAddr=2" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== PPU cpuRead Signal Test ===")
      
      // to VBlank
      dut.clock.step(241 * 341 + 10)
      
      // VBlank Set
      val vblank = dut.io.vblank.peek().litValue
      println(f"VBlank = $vblank")
      assert(vblank == 1)
      
      // 1: cpuRead=0 whenTrigger
      println("\nTest 1: cpuRead=0")
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      val vb1 = dut.io.vblank.peek().litValue
      println(f"  VBlank after = $vb1 (should stay 1)")
      assert(vb1 == 1, "VBlank should not be cleared when cpuRead=0")
      
      // 2: cpuRead=1, cpuAddr=2 Trigger
      println("\nTest 2: cpuRead=1, cpuAddr=2")
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"  PPUSTATUS = 0x$status%02x")
      
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      val vb2 = dut.io.vblank.peek().litValue
      println(f"  VBlank after = $vb2 (should be 0)")
      

      assert((status & 0x80) != 0, "Should read VBlank=1")
      assert(vb2 == 0, "VBlank should be cleared after read")
    }
  }
  
  "PPU cpuRead" should "work in Cycle 2 (not Cycle 3)" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("\n=== PPU cpuRead Cycle Test ===")
      
      // to VBlank
      dut.clock.step(241 * 341 + 10)
      
      println("Simulating LDA $2002:")
      
      // Cycle 0-1: Address
      println("  Cycle 0-1: Address decode")
      dut.clock.step(2)
      
      // Cycle 2: memRead=1,
      println("  Cycle 2: memRead=1, cpuAddr=2")
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      val status2 = dut.io.cpuDataOut.peek().litValue
      println(f"    PPUSTATUS = 0x$status2%02x")
      
      // Cycle 3: memRead=0, CPU ReadData
      println("  Cycle 3: memRead=0, CPU reads data")
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      val vblank3 = dut.io.vblank.peek().litValue
      println(f"    VBlank = $vblank3")
      
      // ：CPU in Cycle 2 Trigger PPU Read
      assert((status2 & 0x80) != 0, "Cycle 2 should see VBlank")
      println("\n✓ PPU cpuRead works in Cycle 2")
    }
  }
}
