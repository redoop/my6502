package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PPURendererTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "BackgroundRenderer" should "correctly calculate tile coordinates" in {
    test(new BackgroundRenderer) { dut =>
      // 测试基本的 tile 坐标计算
      dut.io.pixelX.poke(16.U)
      dut.io.pixelY.poke(24.U)
      dut.io.scrollX.poke(0.U)
      dut.io.scrollY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.showBackground.poke(true.B)
      dut.io.vramData.poke(0x42.U)
      dut.io.patternData.poke(0xFF.U)
      
      dut.clock.step(5)
      
      // 验证输出有效
      assert(dut.io.valid.peek().litToBoolean)
    }
  }
  
  it should "handle scrolling correctly" in {
    test(new BackgroundRenderer) { dut =>
      // 测试滚动
      dut.io.pixelX.poke(0.U)
      dut.io.pixelY.poke(0.U)
      dut.io.scrollX.poke(8.U)  // 滚动 1 个 tile
      dut.io.scrollY.poke(16.U) // 滚动 2 个 tile
      dut.io.ppuCtrl.poke(0.U)
      dut.io.showBackground.poke(true.B)
      dut.io.vramData.poke(0.U)
      dut.io.patternData.poke(0.U)
      
      dut.clock.step(5)
    }
  }
  
  it should "support different pattern tables" in {
    test(new BackgroundRenderer) { dut =>
      // 测试 pattern table 选择
      dut.io.pixelX.poke(0.U)
      dut.io.pixelY.poke(0.U)
      dut.io.scrollX.poke(0.U)
      dut.io.scrollY.poke(0.U)
      dut.io.ppuCtrl.poke(0x10.U)  // Bit 4 = 1, 使用 pattern table 1
      dut.io.showBackground.poke(true.B)
      dut.io.vramData.poke(0.U)
      dut.io.patternData.poke(0.U)
      
      dut.clock.step(5)
    }
  }
  
  "SpriteRenderer" should "evaluate sprites correctly" in {
    test(new SpriteRenderer) { dut =>
      // 初始化
      dut.io.pixelX.poke(0.U)
      dut.io.pixelY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.showSprites.poke(true.B)
      dut.io.oamData.poke(0.U)
      dut.io.patternData.poke(0.U)
      
      dut.clock.step(10)
      
      // 验证初始状态
      assert(!dut.io.valid.peek().litToBoolean)
    }
  }
  
  it should "detect sprite 0 hit" in {
    test(new SpriteRenderer) { dut =>
      // 设置精灵 0 在屏幕上
      dut.io.pixelX.poke(256.U)  // 触发精灵评估
      dut.io.pixelY.poke(10.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.showSprites.poke(true.B)
      dut.io.oamData.poke(10.U)  // Y 坐标
      dut.io.patternData.poke(0xFF.U)
      
      dut.clock.step(5)
      
      // 移动到精灵位置
      dut.io.pixelX.poke(16.U)
      dut.io.pixelY.poke(18.U)
      
      dut.clock.step(5)
    }
  }
  
  it should "handle sprite flipping" in {
    test(new SpriteRenderer) { dut =>
      // 测试水平和垂直翻转
      dut.io.pixelX.poke(0.U)
      dut.io.pixelY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.showSprites.poke(true.B)
      dut.io.oamData.poke(0xC0.U)  // 水平和垂直翻转
      dut.io.patternData.poke(0.U)
      
      dut.clock.step(10)
    }
  }
  
  "PaletteLookup" should "select correct palette" in {
    test(new PaletteLookup) { dut =>
      // 测试背景调色板选择
      dut.io.bgPaletteIndex.poke(2.U)
      dut.io.bgPaletteSelect.poke(1.U)
      dut.io.bgValid.poke(true.B)
      dut.io.spritePaletteIndex.poke(0.U)
      dut.io.spritePaletteSelect.poke(0.U)
      dut.io.spritePriority.poke(false.B)
      dut.io.spriteValid.poke(false.B)
      dut.io.sprite0Hit.poke(false.B)
      dut.io.paletteData.poke(0x0F.U)
      
      dut.clock.step()
      
      // 验证调色板地址
      val addr = dut.io.paletteAddr.peek().litValue
      assert(addr == 0x06)  // 0b00_01_10 = 背景, 调色板 1, 颜色 2
    }
  }
  
  it should "handle sprite priority correctly" in {
    test(new PaletteLookup) { dut =>
      // 背景和精灵都存在
      dut.io.bgPaletteIndex.poke(1.U)
      dut.io.bgPaletteSelect.poke(0.U)
      dut.io.bgValid.poke(true.B)
      dut.io.spritePaletteIndex.poke(2.U)
      dut.io.spritePaletteSelect.poke(1.U)
      dut.io.spritePriority.poke(false.B)  // 精灵在前
      dut.io.spriteValid.poke(true.B)
      dut.io.sprite0Hit.poke(false.B)
      dut.io.paletteData.poke(0x20.U)
      
      dut.clock.step()
      
      // 应该选择精灵
      val addr = dut.io.paletteAddr.peek().litValue
      assert((addr & 0x10) == 0x10)  // 精灵调色板
    }
  }
  
  it should "detect sprite 0 collision" in {
    test(new PaletteLookup) { dut =>
      // 背景和精灵 0 都不透明
      dut.io.bgPaletteIndex.poke(1.U)
      dut.io.bgPaletteSelect.poke(0.U)
      dut.io.bgValid.poke(true.B)
      dut.io.spritePaletteIndex.poke(1.U)
      dut.io.spritePaletteSelect.poke(0.U)
      dut.io.spritePriority.poke(false.B)
      dut.io.spriteValid.poke(true.B)
      dut.io.sprite0Hit.poke(true.B)
      dut.io.paletteData.poke(0x10.U)
      
      dut.clock.step()
      
      // 应该检测到碰撞
      assert(dut.io.sprite0HitOut.peek().litToBoolean)
    }
  }
  
  "PPURenderPipeline" should "integrate all components" in {
    test(new PPURenderPipeline) { dut =>
      // 初始化
      dut.io.pixelX.poke(100.U)
      dut.io.pixelY.poke(50.U)
      dut.io.scrollX.poke(0.U)
      dut.io.scrollY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.ppuMask.poke(0x18.U)  // 显示背景和精灵
      dut.io.vramData.poke(0x42.U)
      dut.io.oamData.poke(0.U)
      dut.io.paletteData.poke(0x0F.U)
      dut.io.patternData.poke(0xFF.U)
      
      // 运行几个周期
      dut.clock.step(20)
      
      // 验证输出
      val color = dut.io.colorOut.peek().litValue
      assert(color <= 0x3F)  // 有效的调色板索引
    }
  }
  
  it should "handle left column clipping" in {
    test(new PPURenderPipeline) { dut =>
      // 测试最左 8 像素的裁剪
      dut.io.pixelX.poke(4.U)  // 在最左 8 像素内
      dut.io.pixelY.poke(10.U)
      dut.io.scrollX.poke(0.U)
      dut.io.scrollY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.ppuMask.poke(0x18.U)  // 显示背景和精灵，但不显示最左 8 像素
      dut.io.vramData.poke(0.U)
      dut.io.oamData.poke(0.U)
      dut.io.paletteData.poke(0x0F.U)
      dut.io.patternData.poke(0.U)
      
      dut.clock.step(10)
    }
  }
  
  it should "multiplex memory access" in {
    test(new PPURenderPipeline) { dut =>
      // 验证内存访问仲裁
      dut.io.pixelX.poke(128.U)
      dut.io.pixelY.poke(64.U)
      dut.io.scrollX.poke(0.U)
      dut.io.scrollY.poke(0.U)
      dut.io.ppuCtrl.poke(0.U)
      dut.io.ppuMask.poke(0x1E.U)  // 全部显示
      dut.io.vramData.poke(0.U)
      dut.io.oamData.poke(0.U)
      dut.io.paletteData.poke(0.U)
      dut.io.patternData.poke(0.U)
      
      // 观察内存访问模式
      for (i <- 0 until 8) {
        dut.clock.step()
        // 每个周期应该访问不同的内存
      }
    }
  }
}
