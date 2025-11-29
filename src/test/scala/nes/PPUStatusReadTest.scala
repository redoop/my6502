package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PPUStatusReadTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "NES System" should "read PPUSTATUS correctly during VBlank" in {
    test(new NESSystemRefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      // 初始化
      dut.io.prgLoadEn.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      
      println("=== CPU Read PPUSTATUS Test ===")
      
      // 运行到 VBlank
      val cyclesTo241 = 241 * 341 + 10
      println(s"运行 $cyclesTo241 个周期到 VBlank...")
      dut.clock.step(cyclesTo241)
      
      // 检查 VBlank 标志
      val vblank = dut.io.vblank.peek().litValue
      val scanline = dut.io.pixelY.peek().litValue
      println(f"✓ Scanline=$scanline VBlank=$vblank")
      
      assert(vblank == 1, "VBlank should be set")
      
      // 检查 CPU 状态
      val pc = dut.io.debug.cpuPC.peek().litValue
      val ppuCtrl = dut.io.debug.ppuCtrl.peek().litValue
      val ppuMask = dut.io.debug.ppuMask.peek().litValue
      
      println(f"✓ CPU: PC=0x$pc%04x PPUCTRL=0x$ppuCtrl%02x PPUMASK=0x$ppuMask%02x")
      
      // 运行更多周期，观察 CPU 行为
      println("\n观察 CPU 在 VBlank 期间的行为...")
      for (i <- 0 until 10) {
        dut.clock.step(1000)
        val pc2 = dut.io.debug.cpuPC.peek().litValue
        val vb2 = dut.io.vblank.peek().litValue
        val nmi2 = dut.io.debug.nmi.peek().litValue
        println(f"  +${(i+1)*1000}: PC=0x$pc2%04x VBlank=$vb2 NMI=$nmi2")
      }
    }
  }
}
