package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class VBlankDebugTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "PPU" should "set VBlank at scanline 241" in {
    test(new PPURefactored(enableDebug = false)).withAnnotations(Seq(WriteVcdAnnotation)) { ppu =>
      ppu.clock.setTimeout(0)  // 禁用超时
      
      // 模拟到 scanline 241 (241 * 341 cycles)
      for (i <- 0 until 241 * 341) {
        ppu.clock.step()
        
        // 每 1000 个周期打印一次
        if (i % 10000 == 0) {
          val y = ppu.io.pixelY.peek().litValue
          val x = ppu.io.pixelX.peek().litValue
          val vb = ppu.io.vblank.peek().litToBoolean
          println(f"  Cycle $i: scanline=$y, pixel=$x, vblank=$vb")
        }
      }
      
      // 再 step 一次让寄存器更新
      ppu.clock.step()
      
      val vblank = ppu.io.vblank.peek().litToBoolean
      val y = ppu.io.pixelY.peek().litValue
      val x = ppu.io.pixelX.peek().litValue
      println(f"✅ Test 1: After ${241*341+1} cycles: scanline=$y, pixel=$x, VBlank=$vblank")
      assert(vblank, "VBlank should be set at scanline 241")
    }
  }
  
  "PPUSTATUS" should "return VBlank bit when read" in {
    test(new PPURefactored(enableDebug = false)) { ppu =>
      ppu.clock.setTimeout(0)  // 禁用超时
      
      // 初始化
      ppu.io.cpuWrite.poke(false.B)
      ppu.io.cpuRead.poke(false.B)
      ppu.clock.step()
      
      // 模拟到 VBlank
      for (i <- 0 until 241 * 341 + 100) {
        ppu.clock.step()
      }
      
      // 读取 PPUSTATUS ($2002)
      ppu.io.cpuAddr.poke(2.U)
      ppu.io.cpuRead.poke(true.B)
      ppu.clock.step()
      
      val status = ppu.io.cpuDataOut.peek().litValue
      val vblankBit = (status & 0x80) != 0
      
      println(f"✅ Test 2: PPUSTATUS = 0x$status%02X, VBlank bit = $vblankBit")
      assert(vblankBit, f"VBlank bit should be 1, got PPUSTATUS=0x$status%02X")
    }
  }
  
  "PPUSTATUS read" should "clear VBlank flag" in {
    test(new PPURefactored(enableDebug = false)) { ppu =>
      ppu.clock.setTimeout(0)  // 禁用超时
      
      // 初始化
      ppu.io.cpuWrite.poke(false.B)
      ppu.io.cpuRead.poke(false.B)
      ppu.clock.step()
      
      // 模拟到 VBlank
      for (i <- 0 until 241 * 341 + 100) {
        ppu.clock.step()
      }
      
      val vblankBefore = ppu.io.vblank.peek().litToBoolean
      println(s"   VBlank before read: $vblankBefore")
      
      // 读取 PPUSTATUS
      ppu.io.cpuAddr.poke(2.U)
      ppu.io.cpuRead.poke(true.B)
      ppu.clock.step()
      
      // 停止读取
      ppu.io.cpuRead.poke(false.B)
      ppu.clock.step()
      
      val vblankAfter = ppu.io.vblank.peek().litToBoolean
      println(s"✅ Test 3: VBlank after read: $vblankAfter")
      assert(!vblankAfter, "VBlank should be cleared after reading PPUSTATUS")
    }
  }
  
  "NES System" should "allow CPU to read VBlank" in {
    test(new NESSystemRefactored(enableDebug = false)) { nes =>
      nes.clock.setTimeout(0)  // 禁用超时
      
      // 加载简单测试程序到 $C000
      val testProg = Seq(
        0xAD, 0x02, 0x20,  // LDA $2002
        0x29, 0x80,        // AND #$80
        0xF0, 0xF8,        // BEQ -8 (loop if VBlank=0)
        0xEA               // NOP (should reach here)
      )
      
      // 加载程序
      nes.io.prgLoadEn.poke(true.B)
      for (i <- testProg.indices) {
        nes.io.prgLoadAddr.poke((0xC000 + i).U)
        nes.io.prgLoadData.poke(testProg(i).U)
        nes.clock.step()
      }
      nes.io.prgLoadEn.poke(false.B)
      
      // Reset CPU
      nes.reset.poke(true.B)
      nes.clock.step(10)
      nes.reset.poke(false.B)
      
      // 运行 1 帧 + 一些周期
      val maxCycles = 30000
      var escaped = false
      
      for (i <- 0 until maxCycles if !escaped) {
        nes.clock.step()
        
        val pc = nes.io.debug.cpuPC.peek().litValue
        if (pc > 0xC006) {  // 跳出循环
          escaped = true
          println(f"✅ Test 4: CPU escaped loop at cycle $i, PC=0x$pc%04X")
        }
        
        if (i % 10000 == 0) {
          val vblank = nes.io.vblank.peek().litToBoolean
          println(f"   Cycle $i: PC=0x$pc%04X, VBlank=$vblank")
        }
      }
      
      assert(escaped, "CPU should escape VBlank wait loop")
    }
  }
}
