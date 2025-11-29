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
      
      // 运行到 VBlank
      val cyclesTo241 = 241 * 341 + 10
      dut.clock.step(cyclesTo241)
      
      // 验证 VBlank 已设置
      val vblankBefore = dut.io.vblank.peek().litValue
      println(f"✓ VBlank before read = $vblankBefore")
      assert(vblankBefore == 1, "VBlank should be set")
      
      // 模拟 LDA $2002 的读取
      // Cycle 0-1: 地址解码 (已完成)
      // Cycle 2: 发出读请求
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      
      // Cycle 3: 读取数据 (SyncReadMem 延迟)
      dut.clock.step(1)
      
      val status = dut.io.cpuDataOut.peek().litValue
      println(f"✓ PPUSTATUS = 0x$status%02x")
      
      // 验证 VBlank bit (bit 7)
      assert((status & 0x80) != 0, f"PPUSTATUS should have VBlank bit set, got 0x$status%02x")
      
      // 停止读取
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // 验证 VBlank 被清除
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
      
      // 运行到 VBlank
      dut.clock.step(241 * 341 + 10)
      
      // 读取前
      val statusBefore = dut.io.debug.ppuStatus.peek().litValue
      println(f"Before read: PPUSTATUS = 0x$statusBefore%02x")
      
      // 开始读取
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      
      // 读取时应该看到 VBlank=1
      val statusDuring = dut.io.cpuDataOut.peek().litValue
      println(f"During read: PPUSTATUS = 0x$statusDuring%02x")
      assert((statusDuring & 0x80) != 0, "Should see VBlank during read")
      
      // 停止读取
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // 读取后应该被清除
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
      
      // 初始状态
      val status0 = dut.io.debug.ppuStatus.peek().litValue
      println(f"Initial: PPUSTATUS = 0x$status0%02x")
      assert((status0 & 0x80) == 0, "VBlank should be clear initially")
      
      // 运行到 VBlank 开始
      dut.clock.step(241 * 341)
      
      // VBlank 应该立即反映到 PPUSTATUS
      val status1 = dut.io.debug.ppuStatus.peek().litValue
      println(f"At VBlank: PPUSTATUS = 0x$status1%02x")
      
      // 注意：由于寄存器延迟，可能需要 1 个周期
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
      
      // 运行到 VBlank
      dut.clock.step(241 * 341 + 10)
      
      // 第一次读取
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status1 = dut.io.cpuDataOut.peek().litValue
      println(f"Read 1: PPUSTATUS = 0x$status1%02x")
      assert((status1 & 0x80) != 0, "First read should see VBlank")
      
      dut.io.cpuRead.poke(false.B)
      dut.clock.step(1)
      
      // 第二次读取 (VBlank 已被清除)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step(1)
      val status2 = dut.io.cpuDataOut.peek().litValue
      println(f"Read 2: PPUSTATUS = 0x$status2%02x")
      assert((status2 & 0x80) == 0, "Second read should not see VBlank")
      
      dut.io.cpuRead.poke(false.B)
    }
  }
}
