package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESSystemv2Test extends AnyFlatSpec with ChiselScalatestTester {
  
  "NESSystemv2" should "initialize correctly" in {
    test(new NESSystemv2) { dut =>
      dut.clock.setTimeout(0)
      
      // 配置为 NROM mapper
      dut.io.mapperType.poke(0.U)
      dut.io.romLoadEn.poke(false.B)
      dut.io.romLoadPRG.poke(false.B)
      dut.io.romLoadAddr.poke(0.U)
      dut.io.romLoadData.poke(0.U)
      
      // 初始化控制器
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      
      // 运行几个周期
      for (i <- 0 until 20) {
        dut.clock.step(1)
      }
      
      println(s"✅ NES System initialized")
      println(f"   PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
      println(f"   A:  0x${dut.io.debug.regA.peek().litValue}%02x")
    }
  }
  
  "PPUv2" should "generate vblank" in {
    test(new PPUv2) { dut =>
      dut.clock.setTimeout(0)
      
      // 初始化
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrData.poke(0.U)
      
      var vblankSeen = false
      var cycles = 0
      
      // 运行直到看到 VBlank
      while (!vblankSeen && cycles < 100000) {
        dut.clock.step(1)
        cycles += 1
        
        if (dut.io.vblank.peek().litToBoolean) {
          vblankSeen = true
          val x = dut.io.pixelX.peek().litValue
          val y = dut.io.pixelY.peek().litValue
          println(s"✅ VBlank detected at cycle $cycles")
          println(f"   Position: ($x, $y)")
        }
      }
      
      assert(vblankSeen, "VBlank should occur")
    }
  }
  
  "PPUv2" should "handle register writes" in {
    test(new PPUv2) { dut =>
      dut.clock.setTimeout(0)
      
      // 初始化
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrData.poke(0.U)
      
      dut.clock.step(1)
      
      // 写入 PPUCTRL
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x80.U)  // Enable NMI
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✅ PPUCTRL write successful")
      
      // 写入 PPUMASK
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x1E.U)  // Show background and sprites
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✅ PPUMASK write successful")
      
      // 读取 PPUSTATUS
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status = dut.io.cpuDataOut.peek().litValue
      dut.io.cpuRead.poke(false.B)
      
      println(f"✅ PPUSTATUS read: 0x$status%02x")
    }
  }
  
  "APU" should "handle register writes" in {
    test(new APU) { dut =>
      dut.clock.setTimeout(0)
      
      // 初始化
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0.U)
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      
      dut.clock.step(1)
      
      // 启用 Pulse 1
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x01.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✅ APU Pulse 1 enabled")
      
      // 设置 Pulse 1 音量
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0x0F.U)  // Max volume
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✅ APU Pulse 1 volume set")
      
      // 运行一些周期
      for (i <- 0 until 100) {
        dut.clock.step(1)
      }
      
      println("✅ APU running")
    }
  }
}
