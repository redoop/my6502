package nes

import java.nio.file.{Files, Paths}
import scala.collection.mutable.ArrayBuffer

// iNES ROM Data
case class NESROMData(
  prgROM: Array[Byte],      // PRG ROM Data
  chrROM: Array[Byte],      // CHR ROM Data
  mapper: Int,              // Mapper
  mirroring: Int,           // 0 = horizontal, 1 = vertical
  hasBattery: Boolean,
  hasTrainer: Boolean,      // trainer
  prgRAMSize: Int,          // PRG RAM
  chrRAMSize: Int           // CHR RAM
) {
  def prgBankCount: Int = prgROM.length / 16384  // 16KB banks
  def chrBankCount: Int = if (chrROM.length > 0) chrROM.length / 8192 else 0  // 8KB banks
  
  override def toString: String = {
    s"""NES ROM Information:
       |  Mapper: $mapper
       |  PRG ROM: ${prgROM.length / 1024}KB (${prgBankCount} x 16KB banks)
       |  CHR ROM: ${chrROM.length / 1024}KB (${chrBankCount} x 8KB banks)
       |  Mirroring: ${if (mirroring == 0) "Horizontal" else "Vertical"}
       |  Battery: $hasBattery
       |  Trainer: $hasTrainer
       |  PRG RAM: ${prgRAMSize}KB
       |  CHR RAM: ${chrRAMSize}KB
       |""".stripMargin
  }
}

// ROM
object ROMLoader {
  
  // iNES
  val INES_MAGIC = Array[Byte](0x4E, 0x45, 0x53, 0x1A)  // "NES" + 0x1A
  val HEADER_SIZE = 16
  val TRAINER_SIZE = 512
  
  /**
// *  iNES  ROM
   * 
// * @param filename ROM
// * @return NESROMData
   */
  def loadNESROM(filename: String): NESROMData = {
    val path = Paths.get(filename)
    if (!Files.exists(path)) {
      throw new RuntimeException(s"ROM file not found: $filename")
    }
    
    val bytes = Files.readAllBytes(path)
    parseINES(bytes)
  }
  
  /**
// *  iNES Data
   * 
// * iNES :
   * 0-3:   "NES" + 0x1A
   * 4:     PRG ROM size (in 16KB units)
   * 5:     CHR ROM size (in 8KB units)
   * 6:     Flags 6
   * 7:     Flags 7
   * 8:     PRG RAM size (in 8KB units)
   * 9:     Flags 9
   * 10:    Flags 10
   * 11-15: Unused (should be zero)
   */
  def parseINES(bytes: Array[Byte]): NESROMData = {
    // magic number
    if (bytes.length < HEADER_SIZE) {
      throw new RuntimeException("File too small to be a valid NES ROM")
    }
    
    for (i <- 0 until 4) {
      if (bytes(i) != INES_MAGIC(i)) {
        throw new RuntimeException("Invalid iNES header (magic number mismatch)")
      }
    }
    
    // header
    val prgROMSize = (bytes(4) & 0xFF) * 16384  // 16KB units
    val chrROMSize = (bytes(5) & 0xFF) * 8192   // 8KB units
    
    val flags6 = bytes(6) & 0xFF
    val flags7 = bytes(7) & 0xFF
    val flags8 = bytes(8) & 0xFF
    val flags9 = bytes(9) & 0xFF
    
    // flags
    val mirroring = flags6 & 0x01
    val hasBattery = (flags6 & 0x02) != 0
    val hasTrainer = (flags6 & 0x04) != 0
    val ignoreMirroring = (flags6 & 0x08) != 0
    
    // Mapper
    val mapperLow = (flags6 >> 4) & 0x0F
    val mapperHigh = (flags7 >> 4) & 0x0F
    val mapper = (mapperHigh << 4) | mapperLow
    
    // PRG RAM size
    val prgRAMSize = if (flags8 == 0) 8 else flags8 * 8  // 8KB units
    
    // CHR RAM size ( CHR ROM size = 0)
    val chrRAMSize = if (chrROMSize == 0) 8 else 0
    
    // Data
    var offset = HEADER_SIZE
    
    // trainer ()
    if (hasTrainer) {
      offset += TRAINER_SIZE
    }
    
    // PRG ROM
    val prgROM = new Array[Byte](prgROMSize)
    Array.copy(bytes, offset, prgROM, 0, prgROMSize)
    offset += prgROMSize
    
    // CHR ROM
    val chrROM = new Array[Byte](chrROMSize)
    if (chrROMSize > 0) {
      Array.copy(bytes, offset, chrROM, 0, chrROMSize)
    }
    
    NESROMData(
      prgROM = prgROM,
      chrROM = chrROM,
      mapper = mapper,
      mirroring = mirroring,
      hasBattery = hasBattery,
      hasTrainer = hasTrainer,
      prgRAMSize = prgRAMSize,
      chrRAMSize = chrRAMSize
    )
  }
  
  /**
// *  ROM Datafor Chisel
   */
  def romToTestData(rom: NESROMData): (Seq[Int], Seq[Int]) = {
    val prgData = rom.prgROM.map(b => b & 0xFF).toSeq
    val chrData = rom.chrROM.map(b => b & 0xFF).toSeq
    (prgData, chrData)
  }
  
  /**
// *  ROM
   */
  def printROMInfo(filename: String): Unit = {
    try {
      val rom = loadNESROM(filename)
      println("=" * 60)
      println(s"ROM File: $filename")
      println("=" * 60)
      println(rom.toString)
      println("=" * 60)
    } catch {
      case e: Exception =>
        println(s"Error loading ROM: ${e.getMessage}")
    }
  }
}


object ROMLoaderApp extends App {
  if (args.length == 0) {
    println("Usage: ROMLoaderApp <rom_file>")
    println("Example: ROMLoaderApp games/Super-Contra-X-(China)-(Pirate).nes")
  } else {
    ROMLoader.printROMInfo(args(0))
  }
}
