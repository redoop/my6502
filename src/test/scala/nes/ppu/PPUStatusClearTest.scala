package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUStatusClearTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU" should "keep VBlank set until PPUSTATUS is read" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== VBlank Persistence Test ===")
      
      // to VBlank
      val cyclesTo241 = 241 * 341 + 1
      dut.clock.step(cyclesTo241)
      
      // VBlank Set
      dut.io.vblank.expect(true.B)
      println("✓ VBlank set at scanline 241")
      
      // cycles, VBlank
      for (i <- 1 to 10) {
        dut.clock.step(100)
        val vb = dut.io.vblank.peek().litValue
        val y = dut.io.pixelY.peek().litValue
        val x = dut.io.pixelX.peek().litValue
        println(f"  +${i*100}: scanline=$y pixel=$x vblank=$vb")
        assert(vb == 1, f"VBlank should stay set, but vblank=$vb at scanline=$y")
      }
      
      println("\n✓ VBlank persists without PPUSTATUS read")
      
      // now read PPUSTATUS
      println("\nread PPUSTATUS...")
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"  PPUSTATUS = 0x$status%02x")
      assert((status & 0x80) != 0, "PPUSTATUS bit 7 should be set")
      
      // Read
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // VBlank Clear
      val vbAfter = dut.io.vblank.peek().litValue
      println(f"  VBlank after read = $vbAfter")
      assert(vbAfter == 0, "VBlank should be cleared after PPUSTATUS read")
      
      println("\n✓ VBlank cleared after PPUSTATUS read")
    }
  }
}
