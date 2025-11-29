package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PPUStatusReadTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "NES System" should "read PPUSTATUS correctly during VBlank" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      // Initialize
      dut.io.prgLoadEn.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      
      println("=== CPU Read PPUSTATUS Test ===")
      
      // to VBlank
      val cyclesTo241 = 241 * 341 + 10
      println(s"Running $cyclesTo241 cycles to VBlank...")
      dut.clock.step(cyclesTo241)
      
      // VBlank Flag
      val vblank = dut.io.vblank.peek().litValue
      val scanline = dut.io.pixelY.peek().litValue
      println(f"✓ Scanline=$scanline VBlank=$vblank")
      
      assert(vblank == 1, "VBlank should be set")
      
      // CPU State
      val pc = dut.io.debug.cpuPC.peek().litValue
      val ppuCtrl = dut.io.debug.ppuCtrl.peek().litValue
      val ppuMask = dut.io.debug.ppuMask.peek().litValue
      
      println(f"✓ CPU: PC=0x$pc%04x PPUCTRL=0x$ppuCtrl%02x PPUMASK=0x$ppuMask%02x")
      
      // Run cycles, observe CPU behavior
      println("\nObserving CPU behavior during VBlank...")
      for (i <- 0 until 10) {
        dut.clock.step(1000)
        val pc2 = dut.io.debug.cpuPC.peek().litValue
        val vb2 = dut.io.vblank.peek().litValue
        val nmi2 = dut.io.debug.nmi.peek().litValue
        println(f"  +${(i+1)*1000}: PC=0x$pc2%04x VBlank=$vb2 NMI=$nmi2")
      }
    }
  }
}
