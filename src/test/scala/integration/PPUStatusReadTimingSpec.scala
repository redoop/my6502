package integration

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUStatusReadTimingSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPUSTATUS Read Timing" should "return VBlank bit correctly" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== PPUSTATUS Read Timing Test ===")
      
      // to VBlank
      val cyclesTo241 = 241 * 341 + 10
      dut.clock.step(cyclesTo241)
      
      // VBlank Set
      val vblankBefore = dut.io.vblank.peek().litValue
      println(f"✓ VBlank before read = $vblankBefore")
      assert(vblankBefore == 1, "VBlank should be set")
      
      // LDA $2002 Read
      // Cycle 0-1: Address (Complete)
      // Cycle 2:
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      
      // Cycle 3: ReadData (SyncReadMem )
      dut.clock.step(1)
      
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"✓ PPUSTATUS = 0x$status%02x")
      
      // VBlank bit (bit 7)
      assert((status & 0x80) != 0, f"PPUSTATUS should have VBlank bit set, got 0x$status%02x")
      
      // Read
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // VBlank Clear
      val vblankAfter = dut.io.vblank.peek().litValue
      println(f"✓ VBlank after read = $vblankAfter")
      assert(vblankAfter == 0, "VBlank should be cleared after read")
    }
  }
  
  "PPUSTATUS" should "clear VBlank immediately on read" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("\n=== VBlank Clear Timing Test ===")
      
      // to VBlank
      dut.clock.step(241 * 341 + 10)
      
      // Read
      val statusBefore = dut.io.debug.ppuStatus.peek().litValue
      println(f"Before read: PPUSTATUS = 0x$statusBefore%02x")
      
      // StartRead
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      // Readwhento VBlank=1
      val statusDuring = dut.io.cpuDataOut.peek().litValue
      println(f"During read: PPUSTATUS = 0x$statusDuring%02x")
      assert((statusDuring & 0x80) != 0, "Should see VBlank during read")
      
      // Read
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // ReadClear
      val statusAfter = dut.io.debug.ppuStatus.peek().litValue
      println(f"After read: PPUSTATUS = 0x$statusAfter%02x")
      assert((statusAfter & 0x80) == 0, "VBlank should be cleared after read")
    }
  }
  
  "PPUSTATUS" should "reflect VBlank in same cycle" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("\n=== VBlank Reflection Test ===")
      
      // State
      val status0 = dut.io.debug.ppuStatus.peek().litValue
      println(f"Initial: PPUSTATUS = 0x$status0%02x")
      assert((status0 & 0x80) == 0, "VBlank should be clear initially")
      
      // to VBlank Start
      dut.clock.step(241 * 341)
      
      // VBlank to PPUSTATUS
      val status1 = dut.io.debug.ppuStatus.peek().litValue
      println(f"At VBlank: PPUSTATUS = 0x$status1%02x")
      
      // ：Registers， 1 Cycle
      dut.clock.step(1)
      val status2 = dut.io.debug.ppuStatus.peek().litValue
      println(f"After 1 cycle: PPUSTATUS = 0x$status2%02x")
      
      assert((status2 & 0x80) != 0, "VBlank should be reflected in PPUSTATUS")
    }
  }
  
  "Multiple reads" should "only clear VBlank once" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("\n=== Multiple Read Test ===")
      
      // to VBlank
      dut.clock.step(241 * 341 + 10)
      
      // Read
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status1 = dut.io.cpuDataOut.peek().litValue
      println(f"Read 1: PPUSTATUS = 0x$status1%02x")
      assert((status1 & 0x80) != 0, "First read should see VBlank")
      
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // Read (VBlank Clear)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status2 = dut.io.cpuDataOut.peek().litValue
      println(f"Read 2: PPUSTATUS = 0x$status2%02x")
      assert((status2 & 0x80) == 0, "Second read should not see VBlank")
      
      dut.io.cpuRead.poke(false.B)
    }
  }
}
