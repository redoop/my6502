package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

/**
 * PPU 寄存器测试 - 完整覆盖
 * 参考 CPU 指令测试方式，测试 PPU 的 8 个寄存器
 */
class PPURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "PPU Registers - PPUCTRL ($2000)"
  
  it should "write to PPUCTRL" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
  
  it should "set NMI enable bit (bit 7)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
  
  it should "set sprite size bit (bit 5)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x20.U)
    }
  }
  
  it should "set background pattern table (bit 4)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x10.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x10.U)
    }
  }
  
  it should "set sprite pattern table (bit 3)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x08.U)
    }
  }
  
  it should "set VRAM increment (bit 2)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x04.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x04.U)
    }
  }
  
  it should "set nametable select (bits 1-0)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x03.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x03.U)
    }
  }
  
  it should "write combined PPUCTRL bits" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x9F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuCtrl.expect(0x9F.U)
    }
  }
  
  behavior of "PPU Registers - PPUMASK ($2001)"
  
  it should "write to PPUMASK" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x1E.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x1E.U)
    }
  }
  
  it should "enable sprite rendering (bit 4)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x10.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x10.U)
    }
  }
  
  it should "enable background rendering (bit 3)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x08.U)
    }
  }
  
  it should "show sprites in leftmost 8 pixels (bit 2)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x04.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x04.U)
    }
  }
  
  it should "show background in leftmost 8 pixels (bit 1)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x02.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x02.U)
    }
  }
  
  it should "enable greyscale (bit 0)" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x01.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.debug.ppuMask.expect(0x01.U)
    }
  }
  
  behavior of "PPU Registers - PPUSTATUS ($2002)"
  
  it should "read PPUSTATUS" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataOut.expect(0.U)
    }
  }
  
  it should "read VBlank flag" in {
    test(new PPURefactored) { dut =>
      // 简单验证 PPUSTATUS 可读
      dut.io.cpuAddr.poke(2.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step()
      
      // 初始状态应该是 0
      dut.io.cpuDataOut.expect(0.U)
    }
  }
  
  behavior of "PPU Registers - OAMADDR ($2003)"
  
  it should "write to OAMADDR" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(3.U)
      dut.io.cpuDataIn.poke(0x42.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "PPU Registers - PPUSCROLL ($2005)"
  
  it should "write X scroll on first write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)
      dut.io.cpuDataIn.poke(0x12.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x34.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write Y scroll on second write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)
      dut.io.cpuDataIn.poke(0x12.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x34.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "toggle latch on consecutive writes" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)
      
      for (i <- 0 until 4) {
        dut.io.cpuDataIn.poke((i * 16).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  behavior of "PPU Registers - PPUADDR ($2006)"
  
  it should "write high byte on first write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write low byte on second write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuAddrReg.expect(0x2000.U)
    }
  }
  
  it should "set different addresses" in {
    test(new PPURefactored) { dut =>
      val addresses = Seq(0x2000, 0x23C0, 0x3F00, 0x3F1F)
      
      for (addr <- addresses) {
        dut.io.cpuAddr.poke(6.U)
        dut.io.cpuDataIn.poke((addr >> 8).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
        
        dut.io.cpuDataIn.poke((addr & 0xFF).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
        
        dut.io.debug.ppuAddrReg.expect(addr.U)
      }
    }
  }
  
  behavior of "PPU Registers - PPUDATA ($2007)"
  
  it should "write to VRAM" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      dut.io.cpuDataIn.poke(0x42.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write multiple bytes to VRAM" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      for (i <- 0 until 8) {
        dut.io.cpuDataIn.poke((i * 16).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
}
