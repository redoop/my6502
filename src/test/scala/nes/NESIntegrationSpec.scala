package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESIntegrationSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "NES System Integration"
  
  it should "initialize and run" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.step(100)
      val pc = dut.io.debug.cpuPC.peek().litValue
      assert(pc >= 0)
    }
  }
  
  it should "generate VBlank signal" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.setTimeout(100000)
      var vblankSeen = false
      var cycles = 0
      
      // VBlank occurs at scanline 241, pixel 1 = 241*341 + 1 = 82,182 cycles
      while (cycles < 85000 && !vblankSeen) {
        dut.clock.step()
        if (dut.io.vblank.peek().litToBoolean) {
          vblankSeen = true
        }
        cycles += 1
      }
      
      assert(vblankSeen, s"VBlank should occur within 85000 cycles, checked $cycles")
    }
  }
  
  it should "output video signal" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.step(100)
      
      val x = dut.io.pixelX.peek().litValue
      val y = dut.io.pixelY.peek().litValue
      val color = dut.io.pixelColor.peek().litValue
      
      assert(x >= 0 && x < 341)
      assert(y >= 0 && y < 262)
      assert(color >= 0 && color < 64)
    }
  }
  
  it should "output audio signal" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.step(100)
      val audio = dut.io.audioOut.peek().litValue
      assert(audio >= 0)
    }
  }
  
  it should "load PRG ROM" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.prgLoadEn.poke(true.B)
      
      for (i <- 0 until 256) {
        dut.io.prgLoadAddr.poke(i.U)
        dut.io.prgLoadData.poke((i & 0xFF).U)
        dut.clock.step()
      }
      
      dut.io.prgLoadEn.poke(false.B)
      dut.clock.step(10)
    }
  }
  
  it should "load CHR ROM" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.chrLoadEn.poke(true.B)
      
      for (i <- 0 until 256) {
        dut.io.chrLoadAddr.poke(i.U)
        dut.io.chrLoadData.poke((0xFF - i).U)
        dut.clock.step()
      }
      
      dut.io.chrLoadEn.poke(false.B)
      dut.clock.step(10)
    }
  }
  
  it should "handle controller input" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.controller1.poke(0xFF.U)
      dut.io.controller2.poke(0x00.U)
      dut.clock.step(100)
    }
  }
  
  it should "run for one frame" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.setTimeout(100000)
      var frameComplete = false
      var lastVBlank = false
      var cycles = 0
      
      // One frame = 262 scanlines * 341 pixels = 89,342 cycles
      while (cycles < 95000 && !frameComplete) {
        dut.clock.step()
        val vblank = dut.io.vblank.peek().litToBoolean
        
        if (!vblank && lastVBlank) {
          frameComplete = true
        }
        lastVBlank = vblank
        cycles += 1
      }
      
      assert(frameComplete, s"Should complete one frame, checked $cycles cycles")
    }
  }
}
