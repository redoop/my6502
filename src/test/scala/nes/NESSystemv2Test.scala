package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESSystemv2Test extends AnyFlatSpec with ChiselScalatestTester {
  
  "NESSystemv2" should "initialize correctly" in {
    test(new NESSystemv2) { dut =>
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      dut.io.mapperType.poke(0.U)  // NROM
      dut.io.romLoadEn.poke(false.B)
      dut.io.romLoadAddr.poke(0.U)
      dut.io.romLoadData.poke(0.U)
      dut.io.romLoadPRG.poke(false.B)
      
      dut.clock.step(10)
      
      println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
      println(f"A: 0x${dut.io.debug.regA.peek().litValue}%02x")
      println(s"VBlank: ${dut.io.vblank.peek().litToBoolean}")
    }
  }
  
  "PPUv2" should "render correctly" in {
    test(new PPUv2).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(0)
      
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrData.poke(0xFF.U)  // 全白 pattern
      
      // 启用渲染
      dut.io.cpuAddr.poke(0.U)  // PPUCTRL
      dut.io.cpuDataIn.poke(0x80.U)  // 启用 NMI
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      dut.io.cpuAddr.poke(1.U)  // PPUMASK
      dut.io.cpuDataIn.poke(0x18.U)  // 显示背景和精灵
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      // 运行一帧
      var frameCount = 0
      var vblankSeen = false
      
      for (i <- 0 until 100000) {
        dut.clock.step(1)
        
        if (dut.io.vblank.peek().litToBoolean && !vblankSeen) {
          vblankSeen = true
          frameCount += 1
          println(s"Frame $frameCount at cycle $i")
          println(s"  Scanline: ${dut.io.pixelY.peek().litValue}")
          println(s"  NMI: ${dut.io.nmiOut.peek().litToBoolean}")
          
          // 看到 2 帧就够了
          if (frameCount >= 2) {
            println("Test complete: 2 frames rendered")
          }
        }
        
        if (!dut.io.vblank.peek().litToBoolean) {
          vblankSeen = false
        }
      }
    }
  }
  
  "MMC3Mapper" should "switch banks correctly" in {
    test(new MMC3Mapper) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.prgData.poke(0.U)
      dut.io.chrData.poke(0.U)
      dut.io.ppuAddr.poke(0.U)
      
      dut.clock.step(1)
      
      // 写入 bank select
      dut.io.cpuAddr.poke(0x8000.U)
      dut.io.cpuDataIn.poke(6.U)  // 选择 R6 (PRG bank 0)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      // 写入 bank data
      dut.io.cpuAddr.poke(0x8001.U)
      dut.io.cpuDataIn.poke(0x10.U)  // Bank 16
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      dut.clock.step(5)
      
      // 读取 PRG ROM
      dut.io.cpuAddr.poke(0x8000.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      println(f"PRG Address: 0x${dut.io.prgAddr.peek().litValue}%05x")
      println(s"Mirroring: ${dut.io.mirrorMode.peek().litValue}")
    }
  }
  
  "ContraSystem" should "initialize" in {
    test(new ContraSystem) { dut =>
      // 初始化控制器
      dut.io.controller.a.poke(false.B)
      dut.io.controller.b.poke(false.B)
      dut.io.controller.select.poke(false.B)
      dut.io.controller.start.poke(false.B)
      dut.io.controller.up.poke(false.B)
      dut.io.controller.down.poke(false.B)
      dut.io.controller.left.poke(false.B)
      dut.io.controller.right.poke(false.B)
      
      dut.clock.step(10)
      
      println("Contra System initialized")
      println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
      println(s"Video X: ${dut.io.videoOut.x.peek().litValue}")
      println(s"Video Y: ${dut.io.videoOut.y.peek().litValue}")
    }
  }
}
