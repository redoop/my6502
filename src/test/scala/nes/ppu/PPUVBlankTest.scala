package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUVBlankTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU" should "generate VBlank at scanline 241" in {
    test(new PPURefactored).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Increase timeout
      dut.clock.setTimeout(100000)
      
      // Initialize
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      // VBlank for false
      dut.io.vblank.expect(false.B)
      println("✓ Initial VBlank = false")
      
      // to scanline 241, pixel 1
      // scanline  341
      val cyclesTo241 = 241 * 341 + 1
      
      println(s"Running $cyclesTo241 cycles to scanline 241...")
      dut.clock.step(cyclesTo241)
      

      val scanline = dut.io.pixelY.peek().litValue
      val pixel = dut.io.pixelX.peek().litValue
      val vblank = dut.io.vblank.peek().litValue
      
      println(f"✓ scanline=$scanline pixel=$pixel vblank=$vblank")
      
      // VBlank Set
      assert(vblank == 1, f"VBlank should be set at scanline 241, but vblank=$vblank")
    }
  }
  
  "PPU" should "set PPUSTATUS bit 7 during VBlank" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      // to VBlank
      val cyclesTo241 = 241 * 341 + 1
      dut.clock.step(cyclesTo241)
      
      // Read PPUSTATUS ($2002)
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"✓ PPUSTATUS = 0x$status%02x")
      
      // Bit 7 for 1 (VBlank)
      assert((status & 0x80) != 0, f"PPUSTATUS bit 7 should be set, but status=0x$status%02x")
    }
  }
  
  "PPU" should "generate NMI when VBlank starts and NMI is enabled" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      // Enable NMI (PPUCTRL bit 7)
      dut.io.cpuAddr.poke(0.U)  // $2000
      dut.io.cpuDataIn.poke(0x80.U)  // NMI enable
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✓ NMI enabled (PPUCTRL = 0x80)")
      
      // NMI for false
      dut.io.nmiOut.expect(false.B)
      
      // to VBlank Start
      val cyclesTo241 = 241 * 341 + 1
      dut.clock.step(cyclesTo241)
      
      // NMI Trigger
      val nmi = dut.io.nmiOut.peek().litValue
      println(s"✓ NMI = $nmi at VBlank start")
      
      assert(nmi == 1, "NMI should be triggered when VBlank starts with NMI enabled")
    }
  }
}
