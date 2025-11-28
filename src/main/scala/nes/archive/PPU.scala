package nes

import chisel3._
import chisel3.util._

// PPU 寄存器地址
object PPURegs {
  val PPUCTRL   = 0x2000.U  // PPU 控制寄存器
  val PPUMASK   = 0x2001.U  // PPU 掩码寄存器
  val PPUSTATUS = 0x2002.U  // PPU 状态寄存器
  val OAMADDR   = 0x2003.U  // OAM 地址
  val OAMDATA   = 0x2004.U  // OAM 数据
  val PPUSCROLL = 0x2005.U  // PPU 滚动
  val PPUADDR   = 0x2006.U  // PPU 地址
  val PPUDATA   = 0x2007.U  // PPU 数据
}

// 简化的 PPU 实现
class PPU extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(3.W))      // 寄存器地址 (0-7)
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // OAM DMA 接口
    val oamDmaAddr = Input(UInt(8.W))
    val oamDmaData = Input(UInt(8.W))
    val oamDmaWrite = Input(Bool())
    
    // 视频输出 (简化)
    val pixelX = Output(UInt(9.W))      // 0-255 (可见) + blanking
    val pixelY = Output(UInt(9.W))      // 0-239 (可见) + vblank
    val pixelColor = Output(UInt(6.W))  // 调色板索引
    val vblank = Output(Bool())         // VBlank 标志
    val nmiOut = Output(Bool())         // NMI 中断输出
    
    // CHR ROM 加载接口 (用于 Verilator)
    val chrLoadEn = Input(Bool())
    val chrLoadAddr = Input(UInt(13.W))  // 8KB CHR ROM
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
  val ppuStatus = RegInit(0.U(8.W))
  val oamAddr = RegInit(0.U(8.W))
  val ppuScrollX = RegInit(0.U(8.W))
  val ppuScrollY = RegInit(0.U(8.W))
  val ppuAddrLatch = RegInit(false.B)
  val ppuAddrReg = RegInit(0.U(16.W))
  
  // 内部 RAM (使用 Mem 以支持异步读取)
  val vram = Mem(2048, UInt(8.W))  // 2KB VRAM (nametables)
  val oam = Mem(256, UInt(8.W))    // 256B OAM (sprites)
  val palette = Mem(32, UInt(8.W)) // 32B palette RAM
  val chrROM = Mem(8192, UInt(8.W)) // 8KB CHR ROM (pattern tables)
  
  // 初始化调色板为默认的 NES 调色板
  val paletteInitDone = RegInit(false.B)
  val paletteInitAddr = RegInit(0.U(5.W))
  
  when(!paletteInitDone) {
    // 初始化默认调色板
    val defaultPalette = VecInit(Seq(
      0x0F.U, 0x00.U, 0x10.U, 0x30.U,  // 背景调色板 0: 黑、深灰、蓝、白
      0x0F.U, 0x16.U, 0x27.U, 0x18.U,  // 背景调色板 1: 黑、红、橙、黄
      0x0F.U, 0x2A.U, 0x1A.U, 0x0A.U,  // 背景调色板 2: 黑、绿、浅绿、深绿
      0x0F.U, 0x12.U, 0x22.U, 0x32.U,  // 背景调色板 3: 黑、蓝、紫、浅紫
      0x0F.U, 0x00.U, 0x10.U, 0x30.U,  // 精灵调色板 0
      0x0F.U, 0x16.U, 0x27.U, 0x18.U,  // 精灵调色板 1
      0x0F.U, 0x2A.U, 0x1A.U, 0x0A.U,  // 精灵调色板 2
      0x0F.U, 0x12.U, 0x22.U, 0x32.U   // 精灵调色板 3
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
  
  // VBlank 和状态标志
  val vblankFlag = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  val sprite0Hit = RegInit(false.B)
  val spriteOverflow = RegInit(false.B)
  
  // 扫描线计数 (简化的时序)
  scanlineX := scanlineX + 1.U
  when(scanlineX === 340.U) {
    scanlineX := 0.U
    scanlineY := scanlineY + 1.U
    
    when(scanlineY === 261.U) {
      scanlineY := 0.U
    }
  }
  
  // VBlank 检测
  when(scanlineY === 241.U && scanlineX === 1.U) {
    vblankFlag := true.B
    when(ppuCtrl(7)) {  // NMI enable
      nmiOccurred := true.B
    }
  }
  
  when(scanlineY === 261.U && scanlineX === 1.U) {
    vblankFlag := false.B
    nmiOccurred := false.B
    sprite0Hit := false.B
    spriteOverflow := false.B
  }
  
  // Sprite 0 碰撞检测（简化版本）
  when(scanlineY < 240.U && scanlineX < 256.U && ppuMask(3) && ppuMask(4)) {
    val sprite0Y = oam.read(0.U)
    val sprite0X = oam.read(3.U)
    val spriteHeight = Mux(ppuCtrl(5), 16.U, 8.U)
    
    // 检查 Sprite 0 是否在当前像素位置
    val sprite0InRange = (scanlineY >= sprite0Y) && 
                         (scanlineY < (sprite0Y + spriteHeight)) &&
                         (scanlineX >= sprite0X) && 
                         (scanlineX < (sprite0X + 8.U))
    
    // 简化：如果 Sprite 0 在范围内且背景和精灵都启用，就设置碰撞
    when(sprite0InRange && !bgTransparent && spriteFound) {
      sprite0Hit := true.B
    }
  }
  
  // CPU 读写寄存器
  io.cpuDataOut := 0.U
  
  // 延迟清除 VBlank 标志（在读取的下一个周期清除）
  val vblankClearNext = RegInit(false.B)
  when(vblankClearNext) {
    vblankFlag := false.B
    nmiOccurred := false.B
    vblankClearNext := false.B
  }
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x2.U) {  // PPUSTATUS
        // Bit 7: VBlank, Bit 6: Sprite 0 Hit, Bit 5: Sprite Overflow
        io.cpuDataOut := Cat(vblankFlag, sprite0Hit, spriteOverflow, 0.U(5.W))
        vblankClearNext := true.B  // 下一个周期清除
        ppuAddrLatch := false.B
      }
      is(0x4.U) {  // OAMDATA
        io.cpuDataOut := oam.read(oamAddr)
      }
      is(0x7.U) {  // PPUDATA
        // 根据地址范围读取不同的内存
        when(ppuAddrReg < 0x2000.U) {
          // CHR ROM
          io.cpuDataOut := chrROM.read(ppuAddrReg(12, 0))
        }.elsewhen(ppuAddrReg < 0x3F00.U) {
          // VRAM (nametables)
          io.cpuDataOut := vram.read(ppuAddrReg(10, 0))
        }.otherwise {
          // Palette RAM
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
      is(0x0.U) {  // PPUCTRL
        ppuCtrl := io.cpuDataIn
      }
      is(0x1.U) {  // PPUMASK
        ppuMask := io.cpuDataIn
      }
      is(0x3.U) {  // OAMADDR
        oamAddr := io.cpuDataIn
      }
      is(0x4.U) {  // OAMDATA
        oam.write(oamAddr, io.cpuDataIn)
        oamAddr := oamAddr + 1.U
      }
      is(0x5.U) {  // PPUSCROLL
        when(!ppuAddrLatch) {
          ppuScrollX := io.cpuDataIn
        }.otherwise {
          ppuScrollY := io.cpuDataIn
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x6.U) {  // PPUADDR
        when(!ppuAddrLatch) {
          ppuAddrReg := Cat(io.cpuDataIn(5, 0), 0.U(8.W))
        }.otherwise {
          ppuAddrReg := Cat(ppuAddrReg(15, 8), io.cpuDataIn)
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x7.U) {  // PPUDATA
        // 根据地址范围写入不同的内存
        when(ppuAddrReg < 0x2000.U) {
          // CHR ROM (通常只读，但测试时可写)
          chrROM.write(ppuAddrReg(12, 0), io.cpuDataIn)
        }.elsewhen(ppuAddrReg < 0x3F00.U) {
          // VRAM (nametables)
          vram.write(ppuAddrReg(10, 0), io.cpuDataIn)
        }.otherwise {
          // Palette RAM
          palette.write(ppuAddrReg(4, 0), io.cpuDataIn)
        }
        ppuAddrReg := ppuAddrReg + 1.U
      }
    }
  }
  
  // CHR ROM 加载逻辑 (用于 Verilator 仿真)
  when(io.chrLoadEn) {
    chrROM.write(io.chrLoadAddr, io.chrLoadData)
  }
  
  // ========== 渲染逻辑 ==========
  
  // 主渲染逻辑
  val renderX = scanlineX
  val renderY = scanlineY
  val pixelColor = WireDefault(0x0F.U(6.W))  // 默认黑色
  
  // 背景渲染（带滚动支持）
  val bgColor = WireDefault(0.U(6.W))
  val bgTransparent = WireDefault(true.B)
  
  when(renderX < 256.U && renderY < 240.U) {
    // 应用滚动偏移
    val scrolledX = renderX + ppuScrollX
    val scrolledY = renderY + ppuScrollY
    
    // 计算 tile 坐标
    val tileX = scrolledX >> 3
    val tileY = scrolledY >> 3
    val pixelInTileX = scrolledX(2, 0)
    val pixelInTileY = scrolledY(2, 0)
    
    // 选择 nametable（支持 4 个 nametable 的镜像）
    val nametableSelect = (ppuCtrl(1, 0))
    val nametableBase = nametableSelect << 10  // 每个 nametable 1KB
    
    // 从 nametable 读取 tile 索引
    val nametableAddr = nametableBase + (tileY(4, 0) << 5) + tileX(4, 0)
    val tileIndex = vram.read(nametableAddr(10, 0))
    
    // 计算 attribute table 地址和调色板
    val attrX = tileX(4, 0) >> 2
    val attrY = tileY(4, 0) >> 2
    val attrAddr = nametableBase + 0x3C0.U + (attrY << 3) + attrX
    val attrByte = vram.read(attrAddr(10, 0))
    val attrShift = ((tileY(1) << 2) | (tileX(1) << 1))
    val paletteHigh = (attrByte >> attrShift) & 0x3.U
    
    // 计算 pattern table 地址
    val patternTableBase = Mux(ppuCtrl(4), 0x1000.U, 0x0000.U)
    val patternAddr = patternTableBase + (tileIndex << 4) + pixelInTileY
    
    // 读取 pattern 数据
    val patternLow = chrROM.read(patternAddr)
    val patternHigh = chrROM.read(patternAddr + 8.U)
    
    // 提取像素颜色
    val bitPos = 7.U - pixelInTileX
    val colorLow = (patternLow >> bitPos) & 1.U
    val colorHigh = (patternHigh >> bitPos) & 1.U
    val paletteLow = (colorHigh << 1) | colorLow
    
    // 组合完整的调色板索引
    val fullPaletteIndex = (paletteHigh << 2) | paletteLow
    
    // 从调色板读取颜色（背景调色板在 0x00-0x0F）
    val bgPaletteAddr = Mux(paletteLow === 0.U, 0.U, fullPaletteIndex)
    val bgPaletteColor = palette.read(bgPaletteAddr)
    
    bgColor := bgPaletteColor(5, 0)
    bgTransparent := paletteLow === 0.U
  }
  
  // 精灵渲染
  val spriteColor = WireDefault(0.U(6.W))
  val spriteFound = WireDefault(false.B)
  val spritePriority = WireDefault(false.B)  // false=前景, true=背景后
  
  when(renderX < 256.U && renderY < 240.U) {
    // 精灵数据结构：
    // Byte 0: Y 坐标
    // Byte 1: Tile 索引
    // Byte 2: 属性 (76543210)
    //         ||||||++- 调色板 (4-7)
    //         |||||+--- 优先级 (0=前景, 1=背景后)
    //         ||||+---- 水平翻转
    //         |||+----- 垂直翻转
    // Byte 3: X 坐标
    
    // 扫描所有 64 个精灵（从后往前，优先级高的在前）
    for (i <- 63 to 0 by -1) {
      val spriteBase = (i * 4).U
      val sprY = oam.read(spriteBase)
      val sprTile = oam.read(spriteBase + 1.U)
      val sprAttr = oam.read(spriteBase + 2.U)
      val sprX = oam.read(spriteBase + 3.U)
      
      // 检查精灵是否在当前扫描线
      val spriteHeight = Mux(ppuCtrl(5), 16.U, 8.U)  // 8x8 或 8x16
      val inYRange = (renderY >= sprY) && (renderY < (sprY + spriteHeight))
      val inXRange = (renderX >= sprX) && (renderX < (sprX + 8.U))
      
      when(inYRange && inXRange && !spriteFound) {
        // 计算精灵内的像素坐标
        val pixY = renderY - sprY
        val pixX = renderX - sprX
        
        // 处理翻转
        val flipH = sprAttr(6)
        val flipV = sprAttr(7)
        val actualPixelX = Mux(flipH, 7.U - pixX, pixX)
        val actualPixelY = Mux(flipV, (spriteHeight - 1.U) - pixY, pixY)
        
        // 计算 pattern table 地址
        val patternTableBase = Mux(ppuCtrl(3), 0x1000.U, 0x0000.U)
        val patternAddr = patternTableBase + (sprTile << 4) + actualPixelY
        
        // 读取 pattern 数据
        val patternLow = chrROM.read(patternAddr)
        val patternHigh = chrROM.read(patternAddr + 8.U)
        
        // 提取像素颜色
        val bitPos = 7.U - actualPixelX
        val colorLow = (patternLow >> bitPos) & 1.U
        val colorHigh = (patternHigh >> bitPos) & 1.U
        val sprPaletteLow = (colorHigh << 1) | colorLow
        
        // 如果不是透明像素
        when(sprPaletteLow =/= 0.U) {
          // 精灵调色板在 0x10-0x1F
          val spritePaletteIdx = sprAttr(1, 0)
          val fullPaletteIndex = 0x10.U + (spritePaletteIdx << 2) + sprPaletteLow
          val sprPaletteColor = palette.read(fullPaletteIndex(4, 0))
          
          spriteColor := sprPaletteColor(5, 0)
          spriteFound := true.B
          spritePriority := sprAttr(5)  // 优先级位
        }
      }
    }
  }
  
  // 合成最终颜色
  when(renderX < 256.U && renderY < 240.U) {
    // 检查渲染使能
    val bgEnabled = ppuMask(3)
    val spriteEnabled = ppuMask(4)
    
    // 合成最终颜色
    when(!paletteInitDone) {
      // 调色板初始化期间，使用简单的颜色映射
      pixelColor := 0x0F.U
    }.elsewhen(spriteEnabled && spriteFound && (!spritePriority || bgTransparent)) {
      // 精灵在前景，或背景透明
      pixelColor := spriteColor
    }.elsewhen(bgEnabled && !bgTransparent) {
      // 显示背景
      pixelColor := bgColor
    }.otherwise {
      // 显示背景色（调色板索引 0）
      pixelColor := palette.read(0.U)(5, 0)
    }
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
  io.debug.ppuStatus := Cat(vblankFlag, sprite0Hit, spriteOverflow, 0.U(5.W))
  io.debug.ppuAddrReg := ppuAddrReg
  io.debug.paletteInitDone := paletteInitDone
}
