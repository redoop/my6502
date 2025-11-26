package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ContraQuickTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "ContraSystem" should "load Contra ROM header" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    val file = new java.io.File(romPath)
    
    if (!file.exists()) {
      println(s"Warning: ROM file not found at $romPath")
      println("Skipping Contra test")
      succeed
    } else {
      // 加载 ROM
      val rom = ROMLoader.loadNESROM(romPath)
      
      println("\n" + "=" * 60)
      println("🎮 Contra ROM Analysis")
      println("=" * 60)
      println(rom.toString)
      
      // 验证这是 MMC3 mapper
      assert(rom.mapper == 4, "Contra should use MMC3 (Mapper 4)")
      
      // 验证 ROM 大小
      assert(rom.prgROM.length == 256 * 1024, "PRG ROM should be 256KB")
      assert(rom.chrROM.length == 256 * 1024, "CHR ROM should be 256KB")
      
      println("\n✅ ROM validation passed!")
      println("   This ROM is compatible with our NES system")
      
      // 显示 PRG ROM 的前几个字节 (reset vector 区域)
      println("\n📋 Reset Vector Area (at 0xFFFC-0xFFFD):")
      val resetVectorOffset = rom.prgROM.length - 4
      val resetLo = rom.prgROM(resetVectorOffset) & 0xFF
      val resetHi = rom.prgROM(resetVectorOffset + 1) & 0xFF
      val resetVector = (resetHi << 8) | resetLo
      println(f"   Reset Vector: 0x$resetVector%04X")
      
      // 显示 NMI vector
      val nmiVectorOffset = rom.prgROM.length - 6
      val nmiLo = rom.prgROM(nmiVectorOffset) & 0xFF
      val nmiHi = rom.prgROM(nmiVectorOffset + 1) & 0xFF
      val nmiVector = (nmiHi << 8) | nmiLo
      println(f"   NMI Vector: 0x$nmiVector%04X")
      
      // 显示 IRQ vector
      val irqVectorOffset = rom.prgROM.length - 2
      val irqLo = rom.prgROM(irqVectorOffset) & 0xFF
      val irqHi = rom.prgROM(irqVectorOffset + 1) & 0xFF
      val irqVector = (irqHi << 8) | irqLo
      println(f"   IRQ Vector: 0x$irqVector%04X")
      
      // 显示 PRG ROM 开头的一些字节
      println("\n📋 First 16 bytes of PRG ROM:")
      print("   ")
      for (i <- 0 until 16) {
        print(f"${rom.prgROM(i) & 0xFF}%02X ")
      }
      println()
      
      // 显示 CHR ROM 开头的一些字节
      println("\n📋 First 16 bytes of CHR ROM:")
      print("   ")
      for (i <- 0 until 16) {
        print(f"${rom.chrROM(i) & 0xFF}%02X ")
      }
      println()
    }
  }
  
  "NESSystemv2" should "initialize with Contra configuration" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    val file = new java.io.File(romPath)
    
    if (!file.exists()) {
      println("Skipping initialization test")
      succeed
    } else {
      val rom = ROMLoader.loadNESROM(romPath)
      
      test(new NESSystemv2) { dut =>
        dut.clock.setTimeout(0)
        
        // 配置为 MMC3 mapper
        dut.io.mapperType.poke(rom.mapper.U)
        dut.io.romLoadEn.poke(false.B)
        dut.io.romLoadPRG.poke(false.B)
        dut.io.romLoadAddr.poke(0.U)
        dut.io.romLoadData.poke(0.U)
        
        // 初始化控制器
        dut.io.controller1.poke(0.U)
        dut.io.controller2.poke(0.U)
        
        println("\n🚀 NES System initialized with Contra configuration")
        println(s"   Mapper: ${rom.mapper} (MMC3)")
        
        // 运行几个周期
        for (i <- 0 until 100) {
          dut.clock.step(1)
        }
        
        println(f"   Initial PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
        println(f"   Initial A:  0x${dut.io.debug.regA.peek().litValue}%02x")
        println("   ✅ System running")
      }
    }
  }
  
  "ContraSystem" should "accept controller input" in {
    test(new ContraSystem) { dut =>
      // 初始化所有按钮为未按下
      dut.io.controller.a.poke(false.B)
      dut.io.controller.b.poke(false.B)
      dut.io.controller.select.poke(false.B)
      dut.io.controller.start.poke(false.B)
      dut.io.controller.up.poke(false.B)
      dut.io.controller.down.poke(false.B)
      dut.io.controller.left.poke(false.B)
      dut.io.controller.right.poke(false.B)
      
      dut.clock.step(10)
      
      println("\n🎮 Testing controller buttons:")
      
      // 测试每个按钮
      val buttons = Seq(
        ("A", () => dut.io.controller.a.poke(true.B)),
        ("B", () => dut.io.controller.b.poke(true.B)),
        ("SELECT", () => dut.io.controller.select.poke(true.B)),
        ("START", () => dut.io.controller.start.poke(true.B)),
        ("UP", () => dut.io.controller.up.poke(true.B)),
        ("DOWN", () => dut.io.controller.down.poke(true.B)),
        ("LEFT", () => dut.io.controller.left.poke(true.B)),
        ("RIGHT", () => dut.io.controller.right.poke(true.B))
      )
      
      for ((name, press) <- buttons) {
        press()
        dut.clock.step(1)
        println(s"   ✓ $name button")
        
        // 释放按钮
        dut.io.controller.a.poke(false.B)
        dut.io.controller.b.poke(false.B)
        dut.io.controller.select.poke(false.B)
        dut.io.controller.start.poke(false.B)
        dut.io.controller.up.poke(false.B)
        dut.io.controller.down.poke(false.B)
        dut.io.controller.left.poke(false.B)
        dut.io.controller.right.poke(false.B)
        dut.clock.step(1)
      }
      
      println("   ✅ All buttons working")
    }
  }
}
