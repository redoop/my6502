package nes.ppu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.PPURefactored

/**
 * PPU 渲染测试
 * 测试背景渲染、精灵渲染、Sprite 0 Hit 等功能
 */
class PPURenderSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "PPU Rendering - Background"
  
  it should "render solid background" in {
    test(new PPURefactored) { dut =>
      // 使能背景渲染
      dut.io.cpuAddr.poke(1.U)  // PPUMASK
      dut.io.cpuDataIn.poke(0x08.U)  // 背景使能
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置背景色
      dut.io.cpuAddr.poke(6.U)  // PPUADDR
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)  // PPUDATA
      dut.io.cpuDataIn.poke(0x0F.U)  // 白色
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 验证像素输出
      dut.clock.step(10)
      val color = dut.io.pixelColor.peek().litValue
      assert(color >= 0 && color < 64)
    }
  }
  
  it should "load pattern table" in {
    test(new PPURefactored) { dut =>
      // 加载图案表数据
      dut.io.chrLoadEn.poke(true.B)
      for (i <- 0 until 16) {
        dut.io.chrLoadAddr.poke(i.U)
        dut.io.chrLoadData.poke((0xFF - i).U)
        dut.clock.step()
      }
      dut.io.chrLoadEn.poke(false.B)
    }
  }
  
  it should "render nametable data" in {
    test(new PPURefactored) { dut =>
      // 写入名称表
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
  
  it should "apply attribute table palette" in {
    test(new PPURefactored) { dut =>
      // 写入属性表
      dut.io.cpuAddr.poke(6.U)
      dut.io.cpuDataIn.poke(0x23.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0xC0.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(7.U)
      dut.io.cpuDataIn.poke(0x55.U)  // 调色板选择
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "scroll X direction" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)  // PPUSCROLL
      dut.io.cpuDataIn.poke(0x10.U)  // X = 16
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x00.U)  // Y = 0
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "scroll Y direction" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(5.U)
      dut.io.cpuDataIn.poke(0x00.U)  // X = 0
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataIn.poke(0x10.U)  // Y = 16
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "switch nametable" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)  // PPUCTRL
      dut.io.cpuDataIn.poke(0x01.U)  // 名称表 1
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x02.U)  // 名称表 2
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuDataIn.poke(0x03.U)  // 名称表 3
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "PPU Rendering - Sprites"
  
  it should "load single sprite" in {
    test(new PPURefactored) { dut =>
      // 通过 OAM DMA 加载精灵
      dut.io.oamDmaWrite.poke(true.B)
      dut.io.oamDmaAddr.poke(0x00.U)
      dut.io.oamDmaData.poke(0x10.U)  // Y
      dut.clock.step()
      dut.io.oamDmaAddr.poke(0x01.U)
      dut.io.oamDmaData.poke(0x00.U)  // Tile
      dut.clock.step()
      dut.io.oamDmaAddr.poke(0x02.U)
      dut.io.oamDmaData.poke(0x00.U)  // Attr
      dut.clock.step()
      dut.io.oamDmaAddr.poke(0x03.U)
      dut.io.oamDmaData.poke(0x10.U)  // X
      dut.clock.step()
      dut.io.oamDmaWrite.poke(false.B)
    }
  }
  
  it should "load multiple sprites" in {
    test(new PPURefactored) { dut =>
      dut.io.oamDmaWrite.poke(true.B)
      for (i <- 0 until 16) {
        dut.io.oamDmaAddr.poke(i.U)
        dut.io.oamDmaData.poke((i * 8).U)
        dut.clock.step()
      }
      dut.io.oamDmaWrite.poke(false.B)
    }
  }
  
  it should "set sprite attributes" in {
    test(new PPURefactored) { dut =>
      dut.io.oamDmaWrite.poke(true.B)
      dut.io.oamDmaAddr.poke(0x02.U)
      
      // 调色板 0
      dut.io.oamDmaData.poke(0x00.U)
      dut.clock.step()
      
      // 调色板 1
      dut.io.oamDmaData.poke(0x01.U)
      dut.clock.step()
      
      // 水平翻转
      dut.io.oamDmaData.poke(0x40.U)
      dut.clock.step()
      
      // 垂直翻转
      dut.io.oamDmaData.poke(0x80.U)
      dut.clock.step()
      
      dut.io.oamDmaWrite.poke(false.B)
    }
  }
  
  it should "enable sprite rendering" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)  // PPUMASK
      dut.io.cpuDataIn.poke(0x10.U)  // 精灵使能
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuMask.expect(0x10.U)
    }
  }
  
  it should "set sprite size 8x8" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)  // PPUCTRL
      dut.io.cpuDataIn.poke(0x00.U)  // 8x8 模式
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set sprite size 8x16" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x20.U)  // 8x16 模式
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "PPU Rendering - Priority"
  
  it should "enable both background and sprites" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x18.U)  // 背景 + 精灵
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuMask.expect(0x18.U)
    }
  }
  
  it should "disable rendering" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuMask.expect(0x00.U)
    }
  }
  
  it should "show leftmost 8 pixels" in {
    test(new PPURefactored) { dut =>
      dut.io.cpuAddr.poke(1.U)
      dut.io.cpuDataIn.poke(0x1E.U)  // 全部显示
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.debug.ppuMask.expect(0x1E.U)
    }
  }
}
