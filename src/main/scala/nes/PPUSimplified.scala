package nes

import chisel3._
import chisel3.util._

// 简化的 PPU 实现（带精灵和滚动支持）
class PPUSimplified extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(3.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // OAM DMA 接口
    val oamDmaAddr = Input(UInt(8.W))
    val oamDmaData = Input(UInt(8.W))
    val oamDmaWrite = Input(Bool())
    
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    val nmiOut = Output(Bool())
    
    // CHR ROM 加载接口
    val chrLoadEn = Input(Bool())
    val chrLoadAddr = Input(UInt(13.W))
    val chrLoadData = Input(UInt(8.W))
    
    // 调试接口
    val debug = Output(new Bundle {
      val ppuCtrl = UInt(8.W)
      val ppuMask = UInt(8.W)
      val ppuStatus = UInt(8.W)
      val ppuAddrReg = UInt(16.W)
      val paletteInitDone = Bool()
    })
  })

  // PPU 寄存器
  val ppuCtrl = RegInit(0.U(8.W))
  val ppuMask = RegInit(0.U(8.W))
  val oamAddr = RegInit(0.U(8.W))
  val ppuScrollX = RegInit(0.U(8.W))
  val ppuScrollY = RegInit(0.U(8.W))
  val ppuAddrLatch = RegInit(false.B)
  val ppuAddrReg = RegInit(0.U(16.W))
  
  // 内部 RAM
  val vram = Mem(2048, UInt(8.W))
  val oam = Mem(256, UInt(8.W))
  val palette = Mem(32, UInt(8.W))
  val chrROM = Mem(8192, UInt(8.W))
  
  // 初始化调色板
  val paletteInitDone = RegInit(false.B)
  val paletteInitAddr = RegInit(0.U(5.W))
  
  when(!paletteInitDone) {
    val defaultPalette = VecInit(Seq(
      0x0F.U, 0x00.U, 0x10.U, 0x30.U,
      0x0F.U, 0x16.U, 0x27.U, 0x18.U,
      0x0F.U, 0x2A.U, 0x1A.U, 0x0A.U,
      0x0F.U, 0x12.U, 0x22.U, 0x32.U,
      0x0F.U, 0x00.U, 0x10.U, 0x30.U,
      0x0F.U, 0x16.U, 0x27.U, 0x18.U,
      0x0F.U, 0x2A.U, 0x1A.U, 0x0A.U,
      0x0F.U, 0x12.U, 0x22.U, 0x32.U
    ))
    
    palette.write(paletteInitAddr, defaultPalette(paletteInitAddr))
    paletteInitAddr := paletteInitAddr + 1.U
    
    when(paletteInitAddr === 31.U) {
      paletteInitDone := true.B
    }
  }
  
  // 扫描计数器
  val scanlineX = RegInit(0.U(9.W))
  val scanlineY = RegInit(0.U(9.W))
  
  scanlineX := scanlineX + 1.U
  when(scanlineX === 340.U) {
    scanlineX := 0.U
    scanlineY := scanlineY + 1.U
    when(scanlineY === 261.U) {
      scanlineY := 0.U
    }
  }
  
  // VBlank 和状态标志
  val vblankFlag = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  val sprite0Hit = RegInit(false.B)
  
  when(scanlineY === 241.U && scanlineX === 1.U) {
    vblankFlag := true.B
    when(ppuCtrl(7)) {
      nmiOccurred := true.B
    }
  }
  
  when(scanlineY === 261.U && scanlineX === 1.U) {
    vblankFlag := false.B
    nmiOccurred := false.B
    sprite0Hit := false.B
  }
  
  // CPU 读写寄存器
  io.cpuDataOut := 0.U
  
  val vblankClearNext = RegInit(false.B)
  when(vblankClearNext) {
    vblankFlag := false.B
    nmiOccurred := false.B
    vblankClearNext := false.B
  }
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x2.U) {
        io.cpuDataOut := Cat(vblankFlag, sprite0Hit, 0.U(6.W))
        vblankClearNext := true.B
        ppuAddrLatch := false.B
      }
      is(0x4.U) {
        io.cpuDataOut := oam.read(oamAddr)
      }
      is(0x7.U) {
        when(ppuAddrReg < 0x2000.U) {
          io.cpuDataOut := chrROM.read(ppuAddrReg(12, 0))
        }.elsewhen(ppuAddrReg < 0x3F00.U) {
          io.cpuDataOut := vram.read(ppuAddrReg(10, 0))
        }.otherwise {
          io.cpuDataOut := palette.read(ppuAddrReg(4, 0))
        }
        ppuAddrReg := ppuAddrReg + 1.U
      }
    }
  }
  
  // OAM DMA 写入
  when(io.oamDmaWrite) {
    oam.write(io.oamDmaAddr, io.oamDmaData)
  }
  
  when(io.cpuWrite) {
    switch(io.cpuAddr) {
      is(0x0.U) { ppuCtrl := io.cpuDataIn }
      is(0x1.U) { ppuMask := io.cpuDataIn }
      is(0x3.U) { oamAddr := io.cpuDataIn }
      is(0x4.U) {
        oam.write(oamAddr, io.cpuDataIn)
        oamAddr := oamAddr + 1.U
      }
      is(0x5.U) {
        when(!ppuAddrLatch) {
          ppuScrollX := io.cpuDataIn
        }.otherwise {
          ppuScrollY := io.cpuDataIn
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x6.U) {
        when(!ppuAddrLatch) {
          ppuAddrReg := Cat(io.cpuDataIn(5, 0), 0.U(8.W))
        }.otherwise {
          ppuAddrReg := Cat(ppuAddrReg(15, 8), io.cpuDataIn)
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x7.U) {
        when(ppuAddrReg < 0x2000.U) {
          chrROM.write(ppuAddrReg(12, 0), io.cpuDataIn)
        }.elsewhen(ppuAddrReg < 0x3F00.U) {
          vram.write(ppuAddrReg(10, 0), io.cpuDataIn)
        }.otherwise {
          palette.write(ppuAddrReg(4, 0), io.cpuDataIn)
        }
        ppuAddrReg := ppuAddrReg + 1.U
      }
    }
  }
  
  // CHR ROM 加载
  when(io.chrLoadEn) {
    chrROM.write(io.chrLoadAddr, io.chrLoadData)
  }
  
  // 渲染逻辑（带精灵支持 - 使用优先级编码器避免组合循环）
  val pixelColor = WireDefault(0x0F.U(6.W))
  
  // 背景颜色和透明标志
  val bgColor = WireDefault(0x0F.U(6.W))
  val bgTransparent = WireDefault(true.B)
  
  // 只在可见区域渲染
  val inVisibleArea = scanlineX < 256.U && scanlineY < 240.U
  val renderingEnabled = ppuMask(3) || ppuMask(4)  // 背景或精灵渲染启用
  
  when(inVisibleArea && renderingEnabled) {
    // ========== 背景渲染 ==========
    when(ppuMask(3)) {  // 背景渲染启用
      val tileX = scanlineX >> 3
      val tileY = scanlineY >> 3
      val pixelInTileX = scanlineX(2, 0)
      val pixelInTileY = scanlineY(2, 0)
      
      // 从 VRAM 读取 nametable
      val nametableAddr = (tileY << 5) + tileX
      val tileIndex = vram.read(nametableAddr)
      
      // 从 VRAM 读取属性表
      val attrX = tileX >> 2
      val attrY = tileY >> 2
      val attrAddr = 0x3C0.U + (attrY << 3) + attrX
      val attrByte = vram.read(attrAddr)
      val attrShift = ((tileY(1) << 2) | (tileX(1) << 1))
      val paletteHigh = (attrByte >> attrShift) & 0x3.U
      
      // 从 CHR ROM 读取图案数据
      val patternTableBase = Mux(ppuCtrl(4), 0x1000.U, 0x0000.U)
      val patternAddr = patternTableBase + (tileIndex << 4) + pixelInTileY
      
      val patternLow = chrROM.read(patternAddr)
      val patternHigh = chrROM.read(patternAddr + 8.U)
      
      val bitPos = 7.U - pixelInTileX
      val colorLow = (patternLow >> bitPos) & 1.U
      val colorHigh = (patternHigh >> bitPos) & 1.U
      val paletteLow = (colorHigh << 1) | colorLow
      
      val fullPaletteIndex = (paletteHigh << 2) | paletteLow
      val paletteAddr = Mux(paletteLow === 0.U, 0.U, fullPaletteIndex)
      val paletteColor = palette.read(paletteAddr)
      
      bgColor := paletteColor(5, 0)
      bgTransparent := paletteLow === 0.U
    }
    
    // ========== 精灵渲染（前 8 个精灵）==========
    // 使用优先级编码器避免组合循环
    val spriteColors = VecInit(Seq.fill(8)(0.U(6.W)))
    val spriteHits = VecInit(Seq.fill(8)(false.B))
    val spritePriorities = VecInit(Seq.fill(8)(false.B))
    
    // 只在精灵渲染启用时扫描
    when(ppuMask(4)) {
      // 扫描前 8 个精灵
      for (i <- 0 until 8) {
        val spriteBase = (i * 4).U
        val sprY = oam.read(spriteBase)
        val sprTile = oam.read(spriteBase + 1.U)
        val sprAttr = oam.read(spriteBase + 2.U)
        val sprX = oam.read(spriteBase + 3.U)
        
        val sprHeight = 8.U
        val sprInYRange = (scanlineY >= sprY) && (scanlineY < (sprY + sprHeight))
        val sprInXRange = (scanlineX >= sprX) && (scanlineX < (sprX + 8.U))
        
        when(sprInYRange && sprInXRange) {
          val pixY = scanlineY - sprY
          val pixX = scanlineX - sprX
          
          val flipH = sprAttr(6)
          val flipV = sprAttr(7)
          val actualPixelX = Mux(flipH, 7.U - pixX, pixX)
          val actualPixelY = Mux(flipV, 7.U - pixY, pixY)
          
          val sprPatternTableBase = Mux(ppuCtrl(3), 0x1000.U, 0x0000.U)
          val sprPatternAddr = sprPatternTableBase + (sprTile << 4) + actualPixelY
          
          val sprPatternLow = chrROM.read(sprPatternAddr)
          val sprPatternHigh = chrROM.read(sprPatternAddr + 8.U)
          
          val sprBitPos = 7.U - actualPixelX
          val sprColorLow = (sprPatternLow >> sprBitPos) & 1.U
          val sprColorHigh = (sprPatternHigh >> sprBitPos) & 1.U
          val sprPaletteLow = (sprColorHigh << 1) | sprColorLow
          
          when(sprPaletteLow =/= 0.U) {
            val spritePaletteIdx = sprAttr(1, 0)
            val sprFullPaletteIndex = 0x10.U + (spritePaletteIdx << 2) + sprPaletteLow
            val sprPaletteColor = palette.read(sprFullPaletteIndex(4, 0))
            
            spriteColors(i) := sprPaletteColor(5, 0)
            spriteHits(i) := true.B
            spritePriorities(i) := sprAttr(5)
          }
        }
      }
    }
    
    // 优先级编码：选择第一个命中的精灵
    val spriteColor = WireDefault(0.U(6.W))
    val spriteFound = WireDefault(false.B)
    val spriteBehindBg = WireDefault(false.B)
    
    when(spriteHits(0)) {
      spriteColor := spriteColors(0)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(0)
    }.elsewhen(spriteHits(1)) {
      spriteColor := spriteColors(1)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(1)
    }.elsewhen(spriteHits(2)) {
      spriteColor := spriteColors(2)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(2)
    }.elsewhen(spriteHits(3)) {
      spriteColor := spriteColors(3)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(3)
    }.elsewhen(spriteHits(4)) {
      spriteColor := spriteColors(4)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(4)
    }.elsewhen(spriteHits(5)) {
      spriteColor := spriteColors(5)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(5)
    }.elsewhen(spriteHits(6)) {
      spriteColor := spriteColors(6)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(6)
    }.elsewhen(spriteHits(7)) {
      spriteColor := spriteColors(7)
      spriteFound := true.B
      spriteBehindBg := spritePriorities(7)
    }
    
    // ========== 合成最终颜色 ==========
    when(spriteFound && (!spriteBehindBg || bgTransparent)) {
      // 精灵在前景，或背景透明
      pixelColor := spriteColor
    }.elsewhen(!bgTransparent) {
      // 背景不透明
      pixelColor := bgColor
    }.otherwise {
      // 显示背景色（调色板地址 0）
      pixelColor := palette.read(0.U)(5, 0)
    }
  }.otherwise {
    // 不在可见区域或渲染未启用，输出背景色
    pixelColor := palette.read(0.U)(5, 0)
  }
  
  // 输出
  io.pixelX := scanlineX
  io.pixelY := scanlineY
  io.pixelColor := pixelColor
  io.vblank := vblankFlag
  io.nmiOut := nmiOccurred
  
  // 调试输出
  io.debug.ppuCtrl := ppuCtrl
  io.debug.ppuMask := ppuMask
  io.debug.ppuStatus := Cat(vblankFlag, sprite0Hit, 0.U(6.W))
  io.debug.ppuAddrReg := ppuAddrReg
  io.debug.paletteInitDone := paletteInitDone
}
