package nes

import java.io.{File, RandomAccessFile}

object ROMAnalyzer {
  
  case class ROMInfo(
    name: String,
    prgSize: Int,
    chrSize: Int,
    mapper: Int,
    mirroring: String,
    hasBattery: Boolean,
    hasTrainer: Boolean,
    prgBanks: Int,
    chrBanks: Int
  )
  
  def analyzeROM(path: String): Option[ROMInfo] = {
    val file = new File(path)
    if (!file.exists()) return None
    
    val raf = new RandomAccessFile(file, "r")
    val header = new Array[Byte](16)
    raf.read(header)
    
    // Check iNES header
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      raf.close()
      return None
    }
    
    val prgBanks = header(4) & 0xFF
    val chrBanks = header(5) & 0xFF
    val prgSize = prgBanks * 16384
    val chrSize = chrBanks * 8192
    
    val flags6 = header(6) & 0xFF
    val flags7 = header(7) & 0xFF
    
    val mapper = ((flags6 >> 4) & 0x0F) | (flags7 & 0xF0)
    val verticalMirror = (flags6 & 0x01) != 0
    val hasBattery = (flags6 & 0x02) != 0
    val hasTrainer = (flags6 & 0x04) != 0
    val fourScreen = (flags6 & 0x08) != 0
    
    val mirroring = if (fourScreen) "Four-Screen" 
                    else if (verticalMirror) "Vertical" 
                    else "Horizontal"
    
    raf.close()
    
    Some(ROMInfo(
      file.getName,
      prgSize,
      chrSize,
      mapper,
      mirroring,
      hasBattery,
      hasTrainer,
      prgBanks,
      chrBanks
    ))
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
    case _ => s"Unknown ($mapper)"
  }
  
  def printROMInfo(info: ROMInfo): Unit = {
    println(s"\n=== ${info.name} ===")
    println(f"Mapper:      ${info.mapper}%-3d (${getMapperName(info.mapper)})")
    println(f"PRG ROM:     ${info.prgSize}%-8d bytes (${info.prgBanks} x 16KB)")
    println(f"CHR ROM:     ${info.chrSize}%-8d bytes (${info.chrBanks} x 8KB)")
    println(f"Mirroring:   ${info.mirroring}")
    println(f"Battery:     ${if (info.hasBattery) "Yes" else "No"}")
    println(f"Trainer:     ${if (info.hasTrainer) "Yes" else "No"}")
  }
  
  def main(args: Array[String]): Unit = {
    val gamesDir = "games"
    val games = Seq(
      "Donkey-Kong.nes",
      "Super-Mario-Bros.nes",
      "Super-Contra-X-(China)-(Pirate).nes"
    )
    
    println("=" * 70)
    println("NES ROM Analyzer")
    println("=" * 70)
    
    games.foreach { game =>
      val path = s"$gamesDir/$game"
      analyzeROM(path) match {
        case Some(info) => printROMInfo(info)
        case None => println(s"\n✗ Failed to load: $game")
      }
    }
    
    println("\n" + "=" * 70)
    println("Mapper Support Status:")
    println("=" * 70)
    println("✓ Mapper 0 (NROM)  - 100% Complete")
    println("✓ Mapper 4 (MMC3)  - 95% Complete")
    println("⏳ Mapper 1 (MMC1)  - Planned")
    println("⏳ Mapper 2 (UxROM) - Planned")
    println("⏳ Mapper 3 (CNROM) - Planned")
    println()
  }
}
