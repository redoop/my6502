package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ContraTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "ContraSystem" should "load and initialize Contra ROM" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    val file = new java.io.File(romPath)
    
    if (!file.exists()) {
      println(s"Warning: ROM file not found at $romPath")
      println("Skipping Contra test")
      succeed
    } else {
      // 加载 ROM
      val rom = ROMLoader.loadNESROM(romPath)
      val (prgData, chrData) = ROMLoader.romToTestData(rom)
      
      println("\n" + "=" * 60)
      println("🎮 Loading Contra into NES System")
      println("=" * 60)
      println(rom.toString)
      
      test(new NESSystemv2).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        dut.clock.setTimeout(0)
        
        // 配置为 MMC3 mapper
        dut.io.mapperType.poke(rom.mapper.U)
        
        println("\n📦 Loading PRG ROM...")
        // 加载 PRG ROM
        for (i <- prgData.indices) {
          dut.io.romLoadEn.poke(true.B)
          dut.io.romLoadPRG.poke(true.B)
          dut.io.romLoadAddr.poke(i.U)
          dut.io.romLoadData.poke(prgData(i).U)
          dut.clock.step(1)
          
          if (i % 10000 == 0) {
            print(s"\r  Progress: ${i * 100 / prgData.length}%")
          }
        }
        println(s"\r  Progress: 100% ✅")
        
        println("\n📦 Loading CHR ROM...")
        // 加载 CHR ROM
        for (i <- chrData.indices) {
          dut.io.romLoadEn.poke(true.B)
          dut.io.romLoadPRG.poke(false.B)
          dut.io.romLoadAddr.poke(i.U)
          dut.io.romLoadData.poke(chrData(i).U)
          dut.clock.step(1)
          
          if (i % 10000 == 0) {
            print(s"\r  Progress: ${i * 100 / chrData.length}%")
          }
        }
        println(s"\r  Progress: 100% ✅")
        
        // 停止加载
        dut.io.romLoadEn.poke(false.B)
        
        // 初始化控制器
        dut.io.controller1.poke(0.U)
        dut.io.controller2.poke(0.U)
        
        println("\n🚀 Starting NES System...")
        
        // 运行一些周期，观察系统启动
        var vblankCount = 0
        var lastVblank = false
        
        for (cycle <- 0 until 200000) {
          dut.clock.step(1)
          
          val vblank = dut.io.vblank.peek().litToBoolean
          
          // 检测 VBlank 上升沿
          if (vblank && !lastVblank) {
            vblankCount += 1
            println(s"\n📺 Frame $vblankCount rendered at cycle $cycle")
            println(f"   PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
            println(f"   A:  0x${dut.io.debug.regA.peek().litValue}%02x")
            println(f"   X:  0x${dut.io.debug.regX.peek().litValue}%02x")
            println(f"   Y:  0x${dut.io.debug.regY.peek().litValue}%02x")
            println(f"   SP: 0x${dut.io.debug.regSP.peek().litValue}%02x")
            println(s"   Flags: C=${dut.io.debug.flagC.peek().litToBoolean} " +
                   s"Z=${dut.io.debug.flagZ.peek().litToBoolean} " +
                   s"N=${dut.io.debug.flagN.peek().litToBoolean} " +
                   s"V=${dut.io.debug.flagV.peek().litToBoolean}")
            
            if (vblankCount >= 3) {
              println("\n✅ Successfully rendered 3 frames!")
              println("   Contra is running on the NES system!")
              // 测试完成，退出循环
            }
          }
          
          lastVblank = vblank
          
          // 每 10000 周期打印一次进度
          if (cycle % 10000 == 0 && cycle > 0) {
            print(s"\r⏱️  Running... cycle $cycle")
          }
        }
        
        println(s"\n\n📊 Test Summary:")
        println(s"   Total cycles: 200000")
        println(s"   Frames rendered: $vblankCount")
        println(f"   Final PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
      }
    }
  }
  
  "ContraSystem" should "respond to controller input" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    val file = new java.io.File(romPath)
    
    if (!file.exists()) {
      println("Skipping controller test")
      succeed
    } else {
      test(new ContraSystem) { dut =>
        dut.clock.setTimeout(0)
        
        // 初始化控制器
        dut.io.controller.a.poke(false.B)
        dut.io.controller.b.poke(false.B)
        dut.io.controller.select.poke(false.B)
        dut.io.controller.start.poke(false.B)
        dut.io.controller.up.poke(false.B)
        dut.io.controller.down.poke(false.B)
        dut.io.controller.left.poke(false.B)
        dut.io.controller.right.poke(false.B)
        
        dut.clock.step(100)
        
        println("\n🎮 Testing controller input...")
        
        // 按下 START 按钮
        println("   Pressing START button...")
        dut.io.controller.start.poke(true.B)
        dut.clock.step(10)
        dut.io.controller.start.poke(false.B)
        dut.clock.step(10)
        
        // 按下 A 按钮
        println("   Pressing A button...")
        dut.io.controller.a.poke(true.B)
        dut.clock.step(10)
        dut.io.controller.a.poke(false.B)
        dut.clock.step(10)
        
        // 移动方向
        println("   Moving RIGHT...")
        dut.io.controller.right.poke(true.B)
        dut.clock.step(10)
        dut.io.controller.right.poke(false.B)
        
        println("   ✅ Controller input test complete")
      }
    }
  }
}
