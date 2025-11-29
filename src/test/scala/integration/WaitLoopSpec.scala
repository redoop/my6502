package integration

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

class WaitLoopSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  "Wait Loop Simulation" should "exit when VBlank is set" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("=== Simulating Game Wait Loop ===")
      println("Code: LDA $2002 / AND #$80 / BEQ loop")
      
      // 模拟循环：等待 VBlank
      var loopCount = 0
      var exitLoop = false
      
      while (!exitLoop && loopCount < 10) {
        // 1. LDA $2002 (Read PPUSTATUS)
        dut.io.cpuAddr.poke(2.U)
        dut.io.cpuRead.poke(true.B)
        dut.clock.step(1)
        
        val ppuStatus = dut.io.cpuDataOut.peek().litValue
        val vblank = (ppuStatus & 0x80) != 0
        
        println(f"  Loop $loopCount: PPUSTATUS=0x$ppuStatus%02x VBlank=$vblank")
        
        // 停止读取
        dut.io.cpuRead.poke(false.B)
        
        // 2. AND #$80 (Check VBlank bit)
        val andResult = ppuStatus & 0x80
        val zeroFlag = andResult == 0
        
        // 3. BEQ (Branch if zero)
        if (zeroFlag) {
          // 继续循环
          println(f"    -> Z=1, branch back (VBlank not set)")
          loopCount += 1
          
          // 运行一些周期模拟循环
          dut.clock.step(100)
        } else {
          // 退出循环
          println(f"    -> Z=0, exit loop (VBlank set!)")
          exitLoop = true
        }
      }
      
      assert(exitLoop, s"Loop should exit when VBlank is set, but ran $loopCount iterations")
      println(f"\n✓ Loop exited after $loopCount iterations")
    }
  }
  
  "Wait Loop" should "eventually see VBlank after enough cycles" in {
    test(new PPURefactored) { dut =>
      dut.clock.setTimeout(100000)
      
      dut.io.cpuWrite.poke(false.B)
      dut.io.cpuRead.poke(false.B)
      dut.io.chrLoadEn.poke(false.B)
      dut.io.oamDmaWrite.poke(false.B)
      
      println("\n=== Testing VBlank Timing ===")
      
      // 运行到接近 VBlank
      val cyclesTo240 = 240 * 341
      println(f"Running $cyclesTo240 cycles to scanline 240...")
      dut.clock.step(cyclesTo240)
      
      // 现在开始轮询
      var foundVBlank = false
      for (i <- 0 until 1000 if !foundVBlank) {
        dut.io.cpuAddr.poke(2.U)
        dut.io.cpuRead.poke(true.B)
        dut.clock.step(1)
        
        val status = dut.io.cpuDataOut.peek().litValue
        if ((status & 0x80) != 0) {
          val scanline = dut.io.pixelY.peek().litValue
          println(f"✓ Found VBlank at cycle $i, scanline=$scanline")
          foundVBlank = true
        }
        
        dut.io.cpuRead.poke(false.B)
        dut.clock.step(10)
      }
      
      assert(foundVBlank, "Should find VBlank within 1000 poll attempts")
    }
  }
}
