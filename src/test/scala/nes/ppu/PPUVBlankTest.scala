package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class PPUVBlankTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU" should "generate VBlank at scanline 241" in {
    test(new PPURefactored).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // 增加 timeout
      dut.clock.setTimeout(100000)
      
      // 初始化
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      // VBlank 应该初始为 false
      dut.io.vblank.expect(false.B)
      println("✓ Initial VBlank = false")
      
      // 运行到 scanline 241, pixel 1
      // 每个 scanline 有 341 个像素
      val cyclesTo241 = 241 * 341 + 1
      
      println(s"运行 $cyclesTo241 个周期到 scanline 241...")
      dut.clock.step(cyclesTo241)
      
      // 检查位置
      val scanline = dut.io.pixelY.peek().litValue
      val pixel = dut.io.pixelX.peek().litValue
      val vblank = dut.io.vblank.peek().litValue
      
      println(f"✓ scanline=$scanline pixel=$pixel vblank=$vblank")
      
      // VBlank 应该被设置
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
      
      // 运行到 VBlank
      val cyclesTo241 = 241 * 341 + 1
      dut.clock.step(cyclesTo241)
      
      // 读取 PPUSTATUS ($2002)
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"✓ PPUSTATUS = 0x$status%02x")
      
      // Bit 7 应该为 1 (VBlank)
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
      
      // 启用 NMI (PPUCTRL bit 7)
      dut.io.cpuAddr.poke(0.U)  // $2000
      dut.io.cpuDataIn.poke(0x80.U)  // NMI enable
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      println("✓ NMI enabled (PPUCTRL = 0x80)")
      
      // NMI 应该初始为 false
      dut.io.nmiOut.expect(false.B)
      
      // 运行到 VBlank 开始
      val cyclesTo241 = 241 * 341 + 1
      dut.clock.step(cyclesTo241)
      
      // NMI 应该被触发
      val nmi = dut.io.nmiOut.peek().litValue
      println(s"✓ NMI = $nmi at VBlank start")
      
      assert(nmi == 1, "NMI should be triggered when VBlank starts with NMI enabled")
    }
  }
}
