package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUStatusReadTimingTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU" should "return VBlank=1 when reading PPUSTATUS during VBlank" in {
    test(new PPURefactored(enableDebug = true)) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== PPUSTATUS Read Timing Test ===")
      
      // 运行到 VBlank
      val cyclesTo241 = 241 * 341 + 10
      dut.clock.step(cyclesTo241)
      
      // VBlank 应该被设置
      val vb1 = dut.io.vblank.peek().litValue
      println(f"✓ VBlank before read = $vb1")
      assert(vb1 == 1)
      
      // 开始读取 PPUSTATUS
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      
      // 在同一个周期内，PPUSTATUS 应该返回 VBlank=1
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"✓ PPUSTATUS during read = 0x$status%02x")
      assert((status & 0x80) != 0, "PPUSTATUS should show VBlank=1 during read")
      
      // 清除读取信号
      dut.io.cpuRead.poke(false.B)
      println(s"✓ cpuRead cleared")
      
      // 下一个周期，VBlank 被清除
      dut.clock.step(1)
      val vb2 = dut.io.vblank.peek().litValue
      val status2 = dut.io.cpuDataOut.peek().litValue
      println(f"✓ VBlank after read = $vb2, PPUSTATUS = 0x$status2%02x")
      assert(vb2 == 0, "VBlank should be cleared after read")
      
      println("\n✓ CPU can see VBlank=1 when reading PPUSTATUS")
    }
  }
}
