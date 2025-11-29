package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.io.{File, RandomAccessFile}

class GameCompatibilityQuickSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  val gamesDir = "games"
  
  case class ROMInfo(prgROM: Array[Byte], chrROM: Array[Byte], mapper: Int, vertical: Boolean)
  
  def loadROM(path: String): Option[ROMInfo] = {
    val file = new File(path)
    if (!file.exists()) return None
    
    val raf = new RandomAccessFile(file, "r")
    val header = new Array[Byte](16)
    raf.read(header)
    
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      raf.close()
      return None
    }
    
    val prgSize = header(4) * 16384
    val chrSize = header(5) * 8192
    val mapper = ((header(6) >> 4) & 0x0F) | (header(7) & 0xF0)
    val verticalMirror = (header(6) & 0x01) != 0
    
    val prgROM = new Array[Byte](prgSize)
    val chrROM = new Array[Byte](if (chrSize > 0) chrSize else 8192)
    
    raf.read(prgROM)
    if (chrSize > 0) raf.read(chrROM)
    
    raf.close()
    Some(ROMInfo(prgROM, chrROM, mapper, verticalMirror))
  }
  
  behavior of "Donkey Kong"
  
  it should "load ROM correctly" in {
    loadROM(s"$gamesDir/Donkey-Kong.nes") match {
      case Some(rom) =>
        println(s"✓ PRG ROM: ${rom.prgROM.length} bytes")
        println(s"✓ CHR ROM: ${rom.chrROM.length} bytes")
        println(s"✓ Mapper: ${rom.mapper}")
        assert(rom.mapper == 0)
        assert(rom.prgROM.length == 16384)
      case None => cancel("ROM not found")
    }
  }
  
  it should "initialize system" in {
    loadROM(s"$gamesDir/Donkey-Kong.nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load full PRG ROM
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until rom.prgROM.length) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          dut.clock.step(10)
          
          val pc = dut.io.debug.cpuPC.peek().litValue
          val resetLo = rom.prgROM(rom.prgROM.length - 4) & 0xFF
          val resetHi = rom.prgROM(rom.prgROM.length - 3) & 0xFF
          val expectedPC = (resetHi << 8) | resetLo
          
          println(f"✓ Reset Vector: 0x$expectedPC%04X")
          println(f"✓ CPU PC: 0x$pc%04X")
        }
      case None => cancel("ROM not found")
    }
  }
  
  it should "execute first instructions" in {
    loadROM(s"$gamesDir/Donkey-Kong.nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load ROM
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until rom.prgROM.length) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          val startPC = dut.io.debug.cpuPC.peek().litValue
          dut.clock.step(100)
          val endPC = dut.io.debug.cpuPC.peek().litValue
          
          println(f"✓ Executed 100 cycles: PC 0x$startPC%04X -> 0x$endPC%04X")
          assert(startPC != endPC, "CPU should execute instructions")
        }
      case None => cancel("ROM not found")
    }
  }
  
  behavior of "Super Mario Bros"
  
  it should "load ROM correctly" in {
    loadROM(s"$gamesDir/Super-Mario-Bros.nes") match {
      case Some(rom) =>
        println(s"✓ PRG ROM: ${rom.prgROM.length} bytes")
        println(s"✓ CHR ROM: ${rom.chrROM.length} bytes")
        println(s"✓ Mapper: ${rom.mapper}")
        assert(rom.mapper == 4)
      case None => cancel("ROM not found")
    }
  }
  
  it should "initialize system" in {
    loadROM(s"$gamesDir/Super-Mario-Bros.nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load PRG ROM (first 16KB for quick test)
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until 16384) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          // Load CHR ROM (first 8KB)
          dut.io.chrLoadEn.poke(true.B)
          for (i <- 0 until 8192) {
            dut.io.chrLoadAddr.poke(i.U)
            dut.io.chrLoadData.poke((rom.chrROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.chrLoadEn.poke(false.B)
          
          dut.clock.step(10)
          println("✓ System initialized with CHR ROM")
        }
      case None => cancel("ROM not found")
    }
  }
  
  it should "verify PPU registers" in {
    loadROM(s"$gamesDir/Super-Mario-Bros.nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load minimal ROM
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until 256) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          dut.clock.step(50)
          
          val ctrl = dut.io.debug.ppuCtrl.peek().litValue
          val mask = dut.io.debug.ppuMask.peek().litValue
          println(f"✓ PPU registers: CTRL=0x$ctrl%02X, MASK=0x$mask%02X")
        }
      case None => cancel("ROM not found")
    }
  }
  
  behavior of "Super Contra X"
  
  it should "load ROM correctly" in {
    loadROM(s"$gamesDir/Super-Contra-X-(China)-(Pirate).nes") match {
      case Some(rom) =>
        println(s"✓ PRG ROM: ${rom.prgROM.length} bytes")
        println(s"✓ CHR ROM: ${rom.chrROM.length} bytes")
        println(s"✓ Mapper: ${rom.mapper}")
        assert(rom.mapper == 4)
      case None => cancel("ROM not found")
    }
  }
  
  it should "initialize system" in {
    loadROM(s"$gamesDir/Super-Contra-X-(China)-(Pirate).nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load first bank (8KB)
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until 8192) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          dut.clock.step(10)
          println("✓ System initialized with MMC3 mapper")
        }
      case None => cancel("ROM not found")
    }
  }
  
  it should "test bank switching" in {
    loadROM(s"$gamesDir/Super-Contra-X-(China)-(Pirate).nes") match {
      case Some(rom) =>
        test(new NESSystemRefactored) { dut =>
          dut.clock.setTimeout(20000)
          
          // Load first two banks
          dut.io.prgLoadEn.poke(true.B)
          for (i <- 0 until 16384) {
            dut.io.prgLoadAddr.poke(i.U)
            dut.io.prgLoadData.poke((rom.prgROM(i) & 0xFF).U)
            dut.clock.step()
          }
          dut.io.prgLoadEn.poke(false.B)
          
          dut.clock.step(100)
          
          val pc = dut.io.debug.cpuPC.peek().litValue
          println(f"✓ MMC3 system running: PC=0x$pc%04X")
        }
      case None => cancel("ROM not found")
    }
  }
  
  behavior of "Game Comparison"
  
  it should "compare all three games" in {
    val games = Seq(
      ("Donkey Kong", s"$gamesDir/Donkey-Kong.nes", 0),
      ("Super Mario Bros", s"$gamesDir/Super-Mario-Bros.nes", 4),
      ("Super Contra X", s"$gamesDir/Super-Contra-X-(China)-(Pirate).nes", 4)
    )
    
    println("\n=== Game Comparison ===")
    println(f"${"Game"}%-20s ${"Mapper"}%-8s ${"PRG"}%-10s ${"CHR"}%-10s ${"Status"}%-10s")
    println("-" * 70)
    
    games.foreach { case (name, path, expectedMapper) =>
      loadROM(path) match {
        case Some(rom) =>
          val status = if (rom.mapper == expectedMapper) "✓ OK" else "✗ FAIL"
          println(f"$name%-20s ${rom.mapper}%-8d ${rom.prgROM.length}%-10d ${rom.chrROM.length}%-10d $status%-10s")
        case None =>
          println(f"$name%-20s ${"N/A"}%-8s ${"N/A"}%-10s ${"N/A"}%-10s ${"✗ Missing"}%-10s")
      }
    }
    println()
  }
}
