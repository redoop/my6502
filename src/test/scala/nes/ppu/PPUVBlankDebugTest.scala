package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUVBlankDebugTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU VBlank Debug" should "show scanline progression" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== Scanline Progression Test ===")
      
      // scanline
      for (sl <- 0 until 5) {
        val targetCycles = sl * 341
        if (sl > 0) dut.clock.step(341)
        
        val y = dut.io.pixelY.peek().litValue
        val x = dut.io.pixelX.peek().litValue
        val vb = dut.io.vblank.peek().litValue
        println(f"Scanline $sl: y=$y x=$x vblank=$vb")
      }
      
      // to scanline 240
      dut.clock.step((240 - 4) * 341)
      val y240 = dut.io.pixelY.peek().litValue
      val vb240 = dut.io.vblank.peek().litValue
      println(f"Scanline 240: y=$y240 vblank=$vb240")
      
      // scanline 241
      dut.clock.step(341)
      val y241_0 = dut.io.pixelY.peek().litValue
      val x241_0 = dut.io.pixelX.peek().litValue
      val vb241_0 = dut.io.vblank.peek().litValue
      println(f"Scanline 241 pixel 0: y=$y241_0 x=$x241_0 vblank=$vb241_0")
      
      // pixel 1
      dut.clock.step(1)
      val y241_1 = dut.io.pixelY.peek().litValue
      val x241_1 = dut.io.pixelX.peek().litValue
      val vb241_1 = dut.io.vblank.peek().litValue
      println(f"Scanline 241 pixel 1: y=$y241_1 x=$x241_1 vblank=$vb241_1")
      
      // pixel 2
      dut.clock.step(1)
      val y241_2 = dut.io.pixelY.peek().litValue
      val x241_2 = dut.io.pixelX.peek().litValue
      val vb241_2 = dut.io.vblank.peek().litValue
      println(f"Scanline 241 pixel 2: y=$y241_2 x=$x241_2 vblank=$vb241_2")
      
      println(s"\n✓ VBlank should be set at scanline 241 pixel 1")
      println(s"  Actual: vblank=$vb241_1 at y=$y241_1 x=$x241_1")
    }
  }
}
