package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESSystemTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "NESSystem" should "initialize correctly" in {
    test(new NESSystem) { dut =>
      // 初始化
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      dut.io.romLoadEn.poke(false.B)
      dut.io.romLoadAddr.poke(0.U)
      dut.io.romLoadData.poke(0.U)
      
      dut.clock.step(1)
      
      // 检查初始状态
      println(f"Initial PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
      println(f"Initial A: 0x${dut.io.debug.regA.peek().litValue}%02x")
    }
  }
  
  "NESSystem" should "run simple program" in {
    test(new NESSystem) { dut =>
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      dut.io.romLoadEn.poke(false.B)
      dut.io.romLoadAddr.poke(0.U)
      dut.io.romLoadData.poke(0.U)
      
      // 运行几个周期
      for (i <- 0 until 100) {
        dut.clock.step(1)
        
        if (i % 10 == 0) {
          println(s"Cycle $i:")
          println(f"  PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
          println(f"  A: 0x${dut.io.debug.regA.peek().litValue}%02x")
          println(f"  X: 0x${dut.io.debug.regX.peek().litValue}%02x")
          println(f"  Y: 0x${dut.io.debug.regY.peek().litValue}%02x")
          println(s"  Scanline: ${dut.io.pixelY.peek().litValue}")
        }
      }
    }
  }
  
  "PPU" should "generate vblank" in {
    test(new PPU).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(0)  // 禁用超时
      
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      
      var vblankSeen = false
      
      // 运行足够的周期以看到 vblank (一帧约 89342 周期)
      for (i <- 0 until 100000) {
        dut.clock.step(1)
        
        if (dut.io.vblank.peek().litToBoolean && !vblankSeen) {
          vblankSeen = true
          println(s"VBlank detected at cycle $i")
          println(s"  Scanline Y: ${dut.io.pixelY.peek().litValue}")
          println(s"  Scanline X: ${dut.io.pixelX.peek().litValue}")
        }
      }
      
      assert(vblankSeen, "VBlank should occur")
    }
  }
}
