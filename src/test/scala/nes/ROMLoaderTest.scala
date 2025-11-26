package nes

import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class ROMLoaderTest extends AnyFlatSpec with Matchers {
  
  "ROMLoader" should "load Contra ROM correctly" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    
    // 检查文件是否存在
    val file = new java.io.File(romPath)
    if (!file.exists()) {
      println(s"Warning: ROM file not found at $romPath")
      println("Skipping ROM loading test")
      succeed
    } else {
      val rom = ROMLoader.loadNESROM(romPath)
      
      // 打印 ROM 信息
      println("\n" + "=" * 60)
      println("Contra ROM Information:")
      println("=" * 60)
      println(rom.toString)
      println("=" * 60)
      
      // 验证基本信息
      rom.prgROM.length should be > 0
      rom.mapper should be >= 0
      
      // 魂斗罗通常使用 MMC3 (Mapper 4)
      println(s"\nMapper Type: ${rom.mapper}")
      if (rom.mapper == 4) {
        println("✅ This ROM uses MMC3 mapper (compatible with our implementation)")
      } else {
        println(s"⚠️  This ROM uses Mapper ${rom.mapper} (may need additional support)")
      }
      
      // 验证 ROM 大小合理
      rom.prgROM.length should be <= (512 * 1024)  // 最大 512KB
      if (rom.chrROM.length > 0) {
        rom.chrROM.length should be <= (256 * 1024)  // 最大 256KB
      }
      
      println(s"\n✅ ROM loaded successfully!")
      println(s"   PRG ROM: ${rom.prgROM.length / 1024}KB")
      println(s"   CHR ROM: ${rom.chrROM.length / 1024}KB")
      println(s"   Mapper: ${rom.mapper}")
    }
  }
  
  "ROMLoader" should "convert ROM to test data" in {
    val romPath = "games/Super-Contra-X-(China)-(Pirate).nes"
    val file = new java.io.File(romPath)
    
    if (!file.exists()) {
      println("Skipping test data conversion test")
      succeed
    } else {
      val rom = ROMLoader.loadNESROM(romPath)
      val (prgData, chrData) = ROMLoader.romToTestData(rom)
      
      prgData.length shouldBe rom.prgROM.length
      if (rom.chrROM.length > 0) {
        chrData.length shouldBe rom.chrROM.length
      }
      
      // 验证数据范围
      prgData.foreach { byte =>
        byte should be >= 0
        byte should be <= 255
      }
      
      println(s"\n✅ Test data conversion successful!")
      println(s"   PRG data: ${prgData.length} bytes")
      println(s"   CHR data: ${chrData.length} bytes")
    }
  }
  
  "ROMLoader" should "handle invalid files gracefully" in {
    assertThrows[RuntimeException] {
      ROMLoader.loadNESROM("nonexistent.nes")
    }
  }
  
  "ROMLoader" should "reject invalid iNES headers" in {
    // 创建一个无效的 ROM 数据
    val invalidData = Array.fill[Byte](16)(0)
    
    assertThrows[RuntimeException] {
      ROMLoader.parseINES(invalidData)
    }
  }
}
