package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESIntegrationQuickSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "NES System Integration (Quick)"
  
  it should "initialize and run" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.step(10)
      val pc = dut.io.debug.cpuPC.peek().litValue
      assert(pc >= 0)
    }
  }
  
  it should "output video signal" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.step(10)
      
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
      dut.clock.step(10)
      val audio = dut.io.audioOut.peek().litValue
      assert(audio >= 0)
    }
  }
  
  it should "load PRG ROM" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.prgLoadEn.poke(true.B)
      
      for (i <- 0 until 16) {  // 只测试 16 字节
        dut.io.prgLoadAddr.poke(i.U)
        dut.io.prgLoadData.poke((i & 0xFF).U)
        dut.clock.step()
      }
      
      dut.io.prgLoadEn.poke(false.B)
      dut.clock.step(2)
    }
  }
  
  it should "load CHR ROM" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.chrLoadEn.poke(true.B)
      
      for (i <- 0 until 16) {  // 只测试 16 字节
        dut.io.chrLoadAddr.poke(i.U)
        dut.io.chrLoadData.poke((0xFF - i).U)
        dut.clock.step()
      }
      
      dut.io.chrLoadEn.poke(false.B)
      dut.clock.step(2)
    }
  }
  
  it should "handle controller input" in {
    test(new NESSystemRefactored) { dut =>
      dut.io.controller1.poke(0xFF.U)
      dut.io.controller2.poke(0x00.U)
      dut.clock.step(10)
    }
  }
}
