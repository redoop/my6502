package nes

import java.nio.file.{Files, Paths}

/**
 * NES ROM 分析器
 * 
 * 分析 ROM 文件并显示详细信息
 */
object ROMAnalyzer {
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: ROMAnalyzer <rom文件>")
      System.exit(1)
    }
    
    val romPath = args(0)
    analyzeROM(romPath)
  }
  
  def analyzeROM(romPath: String): Unit = {
    println("=" * 60)
    println("🎮 NES ROM 分析器")
    println("=" * 60)
    println()
    
    // 加载 ROM
    val romData = Files.readAllBytes(Paths.get(romPath))
    println(s"📁 文件: $romPath")
    println(s"📊 大小: ${romData.length} bytes (${romData.length / 1024} KB)")
    println()
    
    // 检查文件头
    if (romData.length < 16) {
      println("❌ ROM 文件太小")
      return
    }
    
    val header = romData.take(16)
    
    // 验证 NES 标识
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      println("❌ 不是有效的 NES ROM 文件")
      println(s"   文件头: ${header.take(4).map(b => f"0x$b%02X").mkString(" ")}")
      return
    }
    
    println("✅ 有效的 NES ROM 文件")
    println()
    
    // 解析头部信息
    val prgBanks = header(4) & 0xFF
    val chrBanks = header(5) & 0xFF
    val flags6 = header(6) & 0xFF
    val flags7 = header(7) & 0xFF
    val prgRamSize = header(8) & 0xFF
    val flags9 = header(9) & 0xFF
    val flags10 = header(10) & 0xFF
    
    val prgSize = prgBanks * 16384
    val chrSize = chrBanks * 8192
    val mapper = ((flags7 & 0xF0) | ((flags6 & 0xF0) >> 4))
    val mirroring = if ((flags6 & 0x01) != 0) "Vertical" else "Horizontal"
    val battery = (flags6 & 0x02) != 0
    val trainer = (flags6 & 0x04) != 0
    val fourScreen = (flags6 & 0x08) != 0
    
    println("📋 ROM 信息:")
    println("-" * 60)
    println(f"  Mapper:        $mapper%3d (${getMapperName(mapper)})")
    println(f"  PRG ROM:       $prgSize%7d bytes ($prgBanks%2d x 16KB banks)")
    println(f"  CHR ROM:       $chrSize%7d bytes ($chrBanks%2d x 8KB banks)")
    println(f"  PRG RAM:       ${if (prgRamSize == 0) 8 else prgRamSize * 8192}%7d bytes")
    println(f"  Mirroring:     $mirroring")
    println(f"  Battery:       ${if (battery) "Yes" else "No"}")
    println(f"  Trainer:       ${if (trainer) "Yes (512 bytes)" else "No"}")
    println(f"  Four Screen:   ${if (fourScreen) "Yes" else "No"}")
    println()
    
    // 兼容性检查
    println("🎯 兼容性:")
    println("-" * 60)
    val compatibility = checkCompatibility(mapper, prgSize, chrSize)
    println(s"  状态: ${compatibility._1}")
    println(s"  说明: ${compatibility._2}")
    println()
    
    // Reset Vector
    if (romData.length >= 16 + prgSize) {
      val prgStart = 16 + (if (trainer) 512 else 0)
      val prgEnd = prgStart + prgSize
      
      if (prgEnd >= prgStart + 2) {
        // 读取最后 6 个字节 (vectors)
        val vectorStart = prgEnd - 6
        val nmiVector = ((romData(vectorStart + 1) & 0xFF) << 8) | (romData(vectorStart) & 0xFF)
        val resetVector = ((romData(vectorStart + 3) & 0xFF) << 8) | (romData(vectorStart + 2) & 0xFF)
        val irqVector = ((romData(vectorStart + 5) & 0xFF) << 8) | (romData(vectorStart + 4) & 0xFF)
        
        println("🔧 中断向量:")
        println("-" * 60)
        println(f"  NMI Vector:    0x$nmiVector%04X")
        println(f"  Reset Vector:  0x$resetVector%04X")
        println(f"  IRQ Vector:    0x$irqVector%04X")
        println()
      }
    }
    
    // PRG ROM 数据预览
    println("📝 PRG ROM 预览 (前 64 字节):")
    println("-" * 60)
    val prgStart = 16 + (if (trainer) 512 else 0)
    val previewSize = Math.min(64, romData.length - prgStart)
    for (i <- 0 until previewSize by 16) {
      val line = romData.slice(prgStart + i, prgStart + i + 16)
      print(f"  $i%04X: ")
      line.foreach(b => print(f"${b & 0xFF}%02X "))
      print("  ")
      line.foreach(b => {
        val c = b & 0xFF
        if (c >= 32 && c < 127) print(c.toChar) else print('.')
      })
      println()
    }
    println()
    
    // CHR ROM 数据预览
    if (chrSize > 0) {
      println("🎨 CHR ROM 预览 (前 64 字节):")
      println("-" * 60)
      val chrStart = prgStart + prgSize
      val chrPreviewSize = Math.min(64, romData.length - chrStart)
      for (i <- 0 until chrPreviewSize by 16) {
        val line = romData.slice(chrStart + i, chrStart + i + 16)
        print(f"  $i%04X: ")
        line.foreach(b => print(f"${b & 0xFF}%02X "))
        println()
      }
      println()
    }
    
    // 推荐的游戏
    println("🎮 推荐游戏 (相同 Mapper):")
    println("-" * 60)
    getRecommendedGames(mapper).foreach(game => println(s"  • $game"))
    println()
    
    println("=" * 60)
    println("✅ 分析完成")
    println("=" * 60)
  }
  
  def getMapperName(mapper: Int): String = mapper match {
    case 0 => "NROM"
    case 1 => "MMC1"
    case 2 => "UxROM"
    case 3 => "CNROM"
    case 4 => "MMC3"
    case 7 => "AxROM"
    case 9 => "MMC2"
    case 10 => "MMC4"
    case 11 => "Color Dreams"
    case _ => "Unknown"
  }
  
  def checkCompatibility(mapper: Int, prgSize: Int, chrSize: Int): (String, String) = {
    mapper match {
      case 4 => 
        ("✅ 完全支持", "MMC3 Mapper 已完整实现，包括 IRQ 支持")
      case 0 => 
        ("🚧 部分支持", "NROM Mapper 基础功能支持，需要更多测试")
      case 1 | 2 | 3 => 
        ("⏳ 待实现", s"${getMapperName(mapper)} Mapper 尚未实现")
      case _ => 
        ("❌ 不支持", s"Mapper $mapper 尚未实现")
    }
  }
  
  def getRecommendedGames(mapper: Int): List[String] = mapper match {
    case 0 => List(
      "Super Mario Bros",
      "Donkey Kong",
      "Balloon Fight",
      "Ice Climber"
    )
    case 1 => List(
      "The Legend of Zelda",
      "Metroid",
      "Mega Man 2",
      "Castlevania II"
    )
    case 2 => List(
      "Mega Man",
      "Castlevania",
      "Contra",
      "Duck Tales"
    )
    case 4 => List(
      "Super Mario Bros 3",
      "Contra (魂斗罗)",
      "Kirby's Adventure",
      "Mega Man 3-6"
    )
    case _ => List("(无推荐)")
  }
}
