package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

/**
 * PPU 内存测试
 * 测试 CHR ROM, Nametable, Palette, OAM 等内存区域
 */
class PPUMemorySpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "PPU Memory - CHR ROM"
  
  it should "load CHR ROM data" in {
    test(new PPURefactored) { dut =>
      // 加载 CHR ROM
      dut.io.chrLoadEn.poke(true.B)
      dut.io.chrLoadAddr.poke(0x0000.U)
      dut.io.chrLoadData.poke(0x42.U)
      dut.clock.step()
      
      dut.io.chrLoadAddr.poke(0x0001.U)
      dut.io.chrLoadData.poke(0x43.U)
      dut.clock.step()
      
      dut.io.chrLoadEn.poke(false.B)
      dut.clock.step()
    }
  }
  
  it should "load pattern table 0" in {
    test(new PPURefactored) { dut =>
      // 加载图案表 0 ($0000-$0FFF)
      dut.io.chrLoadEn.poke(true.B)
      for (i <- 0 until 16) {
        dut.io.chrLoadAddr.poke(i.U)
        dut.io.chrLoadData.poke((i & 0xFF).U)
        dut.clock.step()
      }
      dut.io.chrLoadEn.poke(false.B)
    }
  }
  
  it should "load pattern table 1" in {
    test(new PPURefactored) { dut =>
      // 加载图案表 1 ($1000-$1FFF)
      dut.io.chrLoadEn.poke(true.B)
      for (i <- 0 until 16) {
        dut.io.chrLoadAddr.poke((0x1000 + i).U)
        dut.io.chrLoadData.poke((i & 0xFF).U)
        dut.clock.step()
      }
      dut.io.chrLoadEn.poke(false.B)
    }
  }
  
  behavior of "PPU Memory - OAM"
  
  it should "write to OAM via DMA" in {
    test(new PPURefactored) { dut =>
      // OAM DMA 写入
      dut.io.oamDmaWrite.poke(true.B)
      dut.io.oamDmaAddr.poke(0x00.U)
      dut.io.oamDmaData.poke(0x10.U)
      dut.clock.step()
      
      dut.io.oamDmaAddr.poke(0x01.U)
      dut.io.oamDmaData.poke(0x20.U)
      dut.clock.step()
      
      dut.io.oamDmaWrite.poke(false.B)
    }
  }
  
  it should "write multiple OAM entries" in {
    test(new PPURefactored) { dut =>
      dut.io.oamDmaWrite.poke(true.B)
      
      // 写入4个精灵属性
      for (i <- 0 until 16) {
        dut.io.oamDmaAddr.poke(i.U)
        dut.io.oamDmaData.poke((i * 16).U)
        dut.clock.step()
      }
      
      dut.io.oamDmaWrite.poke(false.B)
    }
  }
  
  behavior of "PPU Memory - VRAM Access"
  
  it should "set VRAM address" in {
    test(new PPURefactored) { dut =>
      // 设置 VRAM 地址 $2000
      dut.io.cpuAddr.poke(6.U)  // PPUADDR
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuAddrReg.expect(0x2000.U)
    }
  }
  
  it should "write to VRAM via PPUDATA" in {
    test(new PPURefactored) { dut =>
      // 设置地址
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 写入数据
      dut.io.cpuAddr.poke(7.U)  // PPUDATA
      dut.io.cpuDataIn.poke(0x42.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x43.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "access different VRAM regions" in {
    test(new PPURefactored) { dut =>
      // Nametable 0 ($2000)
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // Attribute table ($23C0)
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x23.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0xC0.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // Palette ($3F00)
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "PPU Memory - Palette"
  
  it should "write to background palette" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke(i.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  it should "write to sprite palette" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x10.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke((i * 16).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  behavior of "PPU Memory - Nametable"
  
  it should "write to nametable 0" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      for (i <- 0 until 32) {
        dut.io.cpuDataIn.poke((i & 0xFF).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  it should "write to nametable 1" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x24.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to attribute table" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x23.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0xC0.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      for (i <- 0 until 8) {
        dut.io.cpuDataIn.poke((i * 0x11).U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
}
