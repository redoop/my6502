package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.io.{File, RandomAccessFile}

class GameCompatibilitySpec extends AnyFlatSpec with ChiselScalatestTester {
  
  val gamesDir = "games"
  
  def loadROM(path: String): Option[(Array[Byte], Array[Byte], Int, Boolean)] = {
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
    Some((prgROM, chrROM, mapper, verticalMirror))
  }
  
  def testGame(romPath: String, gameName: String, expectedMapper: Int, testCycles: Int = 1000): Unit = {
    it should s"load and run $gameName" in {
      loadROM(romPath) match {
        case Some((prgROM, chrROM, mapper, vertical)) =>
          println(s"Testing $gameName:")
          println(s"  PRG ROM: ${prgROM.length} bytes")
          println(s"  CHR ROM: ${chrROM.length} bytes")
          println(s"  Mapper: $mapper")
          println(s"  Mirroring: ${if (vertical) "Vertical" else "Horizontal"}")
          
          assert(mapper == expectedMapper, s"Expected mapper $expectedMapper, got $mapper")
          
          test(new NESSystemRefactored).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.setTimeout(testCycles + 1000)
            
            // Load PRG ROM (limit to 64KB for 16-bit address)
            val prgLoadSize = Math.min(prgROM.length, 65536)
            dut.io.prgLoadEn.poke(true.B)
            for (i <- 0 until prgLoadSize) {
              dut.io.prgLoadAddr.poke(i.U)
              dut.io.prgLoadData.poke((prgROM(i) & 0xFF).U)
              dut.clock.step()
            }
            dut.io.prgLoadEn.poke(false.B)
            
            // Load CHR ROM (limit to 64KB for 16-bit address)
            val chrLoadSize = Math.min(chrROM.length, 65536)
            dut.io.chrLoadEn.poke(true.B)
            for (i <- 0 until chrLoadSize) {
              dut.io.chrLoadAddr.poke(i.U)
              dut.io.chrLoadData.poke((chrROM(i) & 0xFF).U)
              dut.clock.step()
            }
            dut.io.chrLoadEn.poke(false.B)
            
            // Run game
            var vblankCount = 0
            var lastVBlank = false
            var cycles = 0
            
            while (cycles < testCycles && vblankCount < 3) {
              dut.clock.step()
              val vblank = dut.io.vblank.peek().litToBoolean
              
              if (vblank && !lastVBlank) {
                vblankCount += 1
                val pc = dut.io.debug.cpuPC.peek().litValue
                println(f"  Frame $vblankCount: PC=0x$pc%04X")
              }
              
              lastVBlank = vblank
              cycles += 1
            }
            
            println(s"  Completed $vblankCount frames in $cycles cycles")
            assert(vblankCount >= 1, "Should complete at least 1 frame")
          }
          
        case None =>
          cancel(s"ROM not found: $romPath")
      }
    }
  }
  
  behavior of "Donkey Kong (Mapper 0)"
  testGame(s"$gamesDir/Donkey-Kong.nes", "Donkey Kong", 0, 100000)
  
  behavior of "Super Mario Bros (Mapper 4)"
  testGame(s"$gamesDir/Super-Mario-Bros.nes", "Super Mario Bros", 4, 100000)
  
  behavior of "Super Contra X (Mapper 4)"
  testGame(s"$gamesDir/Super-Contra-X-(China)-(Pirate).nes", "Super Contra X", 4, 100000)
}
