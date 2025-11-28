package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

/**
 * PPU 寄存器测试 - 使用重构版本
 * 参考 CPU 指令测试方式，测试 PPU 的 8 个寄存器
 */
class PPURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "PPU Registers - PPUCTRL ($2000)"
  
  it should "write to PPUCTRL" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)  // $2000
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
  
  it should "set NMI enable bit" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x80.U)  // bit 7 = 1
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
  
  behavior of "PPU Registers - PPUMASK ($2001)"
  
  it should "write to PPUMASK" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)  // $2001
      dut.io.cpuDataIn.poke(0x1E.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuMask.expect(0x1E.U)
    }
  }
  
  behavior of "PPU Registers - PPUSTATUS ($2002)"
  
  it should "read PPUSTATUS" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(2.U)  // $2002
      dut.io.cpuRead.poke(true.B)
      dut.clock.step()
      
      // 初始状态应该是 0
      dut.io.cpuDataOut.expect(0.U)
    }
  }
  
  behavior of "PPU Registers - PPUSCROLL ($2005)"
  
  it should "write X scroll on first write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)  // $2005
      dut.io.cpuDataIn.poke(0x12.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 验证写入成功（通过第二次写入验证锁存器切换）
      dut.io.cpuDataIn.poke(0x34.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write Y scroll on second write" in {
    test(new PPURefactored) { dut =>
      // 第一次写入 X
      dut.io.cpuAddr.poke(5.U)
      dut.io.cpuDataIn.poke(0x12.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 第二次写入 Y
      dut.io.cpuDataIn.poke(0x34.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "PPU Registers - PPUADDR ($2006)"
  
  it should "write high byte on first write" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(6.U)  // $2006
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write low byte on second write" in {
    test(new PPURefactored) { dut =>
      // 第一次写入高字节
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x20.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 第二次写入低字节
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuAddrReg.expect(0x2000.U)
    }
  }
  
  behavior of "PPU Registers - PPUDATA ($2007)"
  
  it should "write to VRAM" in {
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
      dut.io.cpuAddr.poke(7.U)  // $2007
      dut.io.cpuDataIn.poke(0x42.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
}
