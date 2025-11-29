package nes

import chisel3._
import chisel3.util._
import nes.core._

/**
// * PPU Refactored Version
// *  CPU6502Refactored Module
// * and PPU, PPUv2, PPUv3, PPUSimplified
// *
 */
class PPURefactored(enableDebug: Boolean = false) extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(3.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // OAM DMA Interface
    val oamDmaAddr = Input(UInt(8.W))
    val oamDmaData = Input(UInt(8.W))
    val oamDmaWrite = Input(Bool())
    
    // Output
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    val nmiOut = Output(Bool())
    
    // CHR ROM Interface
    val chrLoadEn = Input(Bool())
    val chrLoadAddr = Input(UInt(13.W))
    val chrLoadData = Input(UInt(8.W))
    
    // Debug Interface
    val debug = Output(new Bundle {
      val ppuCtrl = UInt(8.W)
      val ppuMask = UInt(8.W)
      val ppuStatus = UInt(8.W)
      val ppuAddrReg = UInt(16.W)
      val paletteInitDone = Bool()
    })
  })
  
  // RegistersControlModule
  val regControl = Module(new PPURegisterControl(enableDebug))
  regControl.io.cpuAddr := io.cpuAddr
  regControl.io.cpuDataIn := io.cpuDataIn
  regControl.io.cpuWrite := io.cpuWrite
  regControl.io.cpuRead := io.cpuRead
  io.cpuDataOut := regControl.io.cpuDataOut
  
  val regs = regControl.io.regs
  

  val scanline = RegInit(0.U(9.W))
  val pixel = RegInit(0.U(9.W))
  
  // Debug: 1000Cycle
  val debugCounter = RegInit(0.U(32.W))
  debugCounter := debugCounter + 1.U
  when(debugCounter === 10000.U) {
    printf("[PPU Debug] scanline=%d pixel=%d\n", scanline, pixel)
    debugCounter := 0.U
  }
  

  when(pixel === 340.U) {
    pixel := 0.U
    when(scanline === 261.U) {
      scanline := 0.U
      printf("[PPU] Frame complete, reset to scanline 0\n")
    }.otherwise {
      scanline := scanline + 1.U
      when(scanline === 240.U) {
        printf("[PPU] Entering VBlank region, next scanline=241\n")
      }
    }
  }.otherwise {
    pixel := pixel + 1.U
  }
  
  // VBlank Control - in pixel 0 Set， pixel 1 when
  regControl.io.setVBlank := false.B
  regControl.io.clearVBlank := false.B
  regControl.io.setSprite0Hit := false.B
  regControl.io.setSpriteOverflow := false.B
  
  when(scanline === 241.U && pixel === 0.U) {
    regControl.io.setVBlank := true.B
    printf("[PPU] VBlank START at scanline=241 pixel=0\n")
  }.elsewhen(scanline === 261.U && pixel === 0.U) {
    regControl.io.clearVBlank := true.B
    printf("[PPU] VBlank END at scanline=261 pixel=0\n")
  }
  
  // NMI  - in pixel 1 Trigger（when vblankFlag Set）
  val nmiEnable = regs.ppuCtrl(7)
  val nmiTrigger = RegInit(false.B)
  
  // VBlank StartwhenSet NMI Trigger（to）
  when(scanline === 241.U && pixel === 1.U && nmiEnable) {
    nmiTrigger := true.B
    printf("[PPU] NMI Triggered at scanline=241 pixel=1\n")
  }
  // VBlank whenClear NMI（pre-render scanline）
  .elsewhen(scanline === 261.U && pixel === 1.U) {
    nmiTrigger := false.B
    printf("[PPU] NMI Cleared at scanline=261 pixel=1\n")
  }
  
  io.nmiOut := nmiTrigger
  
  // CHR ROM (8KB)
  val chrRom = SyncReadMem(8192, UInt(8.W))
  when(io.chrLoadEn) {
    chrRom.write(io.chrLoadAddr, io.chrLoadData)
  }
  
  // RAM (32 bytes) - Initializefor NES
  val paletteRam = RegInit(VecInit(Seq(
    0x09.U, 0x01.U, 0x00.U, 0x01.U, 0x00.U, 0x02.U, 0x02.U, 0x0D.U,
    0x08.U, 0x10.U, 0x08.U, 0x24.U, 0x00.U, 0x00.U, 0x04.U, 0x2C.U,
    0x09.U, 0x01.U, 0x34.U, 0x03.U, 0x00.U, 0x04.U, 0x00.U, 0x14.U,
    0x08.U, 0x3A.U, 0x00.U, 0x02.U, 0x00.U, 0x20.U, 0x2C.U, 0x08.U
  )))
  
  // RAM (2KB)
  val nametableRam = SyncReadMem(2048, UInt(8.W))
  
  // Nametable Write ( PPUDATA $2007)
  when(io.cpuWrite && io.cpuAddr === 7.U) {  // PPUDATA
    val ppuAddr = regs.ppuAddr
    when(ppuAddr >= 0x3F00.U && ppuAddr <= 0x3FFF.U) {

      val paletteAddr = ppuAddr(4, 0)
      paletteRam(paletteAddr) := io.cpuDataIn
    }.elsewhen(ppuAddr >= 0x2000.U && ppuAddr < 0x3F00.U) {
      // Nametable
      val ntAddr = ppuAddr(10, 0)
      nametableRam.write(ntAddr, io.cpuDataIn)
    }
  }
  
  // OAM (256 bytes)
  val oam = RegInit(VecInit(Seq.fill(256)(0.U(8.W))))
  when(io.oamDmaWrite) {
    oam(io.oamDmaAddr) := io.oamDmaData
  }
  
  // Control
  val isRendering = scanline < 240.U && pixel < 256.U
  val bgEnable = regs.ppuMask(3)
  val spriteEnable = regs.ppuMask(4)
  val showLeftBg = regs.ppuMask(1)
  val showLeftSprite = regs.ppuMask(2)
  
  // Registers
  val scrollX = RegInit(0.U(8.W))
  val scrollY = RegInit(0.U(8.W))
  

  val nametableBase = Cat(regs.ppuCtrl(1, 0), 0.U(10.W))
  val tileX = (pixel + scrollX) >> 3
  val tileY = (scanline + scrollY) >> 3
  val tileAddr = nametableBase + (tileY << 5) + tileX
  val tileIndex = nametableRam.read(tileAddr(10, 0))
  
  val patternBase = Mux(regs.ppuCtrl(4), 0x1000.U, 0x0000.U)
  val fineY = (scanline + scrollY)(2, 0)
  val patternAddr = patternBase + (tileIndex << 4) + fineY
  val patternLow = chrRom.read(patternAddr)
  val patternHigh = chrRom.read(patternAddr + 8.U)
  
  val fineX = (pixel + scrollX)(2, 0)
  val bitPos = 7.U - fineX
  val pixelBit = ((patternHigh >> bitPos)(0) << 1) | ((patternLow >> bitPos)(0))
  
  val attrAddr = nametableBase + 0x3C0.U + ((tileY >> 2) << 3) + (tileX >> 2)
  val attrByte = nametableRam.read(attrAddr(10, 0))
  val attrShift = ((tileY(1) << 2) | (tileX(1) << 1))
  val paletteIdx = (attrByte >> attrShift)(1, 0)
  
  val bgPaletteAddr = (paletteIdx << 2) | pixelBit
  val bgColor = Mux(pixelBit === 0.U, paletteRam(0), paletteRam(bgPaletteAddr))
  

  val spriteY = oam(0)
  val spriteTile = oam(1)
  val spriteAttr = oam(2)
  val spriteX = oam(3)
  val spriteSize = Mux(regs.ppuCtrl(5), 16.U, 8.U)
  
  val inSpriteX = pixel >= spriteX && pixel < (spriteX + 8.U)
  val inSpriteY = scanline >= spriteY && scanline < (spriteY + spriteSize)
  val spriteActive = inSpriteX && inSpriteY
  
  val spriteFineX = pixel - spriteX
  val spriteFineY = scanline - spriteY
  val spritePatternBase = Mux(regs.ppuCtrl(3), 0x1000.U, 0x0000.U)
  val spritePatternAddr = spritePatternBase + (spriteTile << 4) + spriteFineY
  val spritePatternLow = chrRom.read(spritePatternAddr)
  val spritePatternHigh = chrRom.read(spritePatternAddr + 8.U)
  
  val spriteBitPos = 7.U - spriteFineX
  val spritePixelBit = ((spritePatternHigh >> spriteBitPos)(0) << 1) | ((spritePatternLow >> spriteBitPos)(0))
  val spritePaletteIdx = spriteAttr(1, 0)
  val spritePaletteAddr = 0x10.U + (spritePaletteIdx << 2) | spritePixelBit
  val spriteColor = paletteRam(spritePaletteAddr)
  val spritePriority = spriteAttr(5)
  
  // Sprite 0 Hit
  when(spriteActive && spritePixelBit =/= 0.U && pixelBit =/= 0.U && pixel =/= 255.U) {
    regControl.io.setSprite0Hit := true.B
  }
  

  val hideLeft = pixel < 8.U
  val showBg = bgEnable && (!hideLeft || showLeftBg)
  val showSprite = spriteEnable && (!hideLeft || showLeftSprite)
  
  val finalColor = RegInit(0.U(8.W))
  
  // - ReadData
  val tileIndexReg = RegNext(tileIndex)
  val patternLowReg = RegNext(patternLow)
  val patternHighReg = RegNext(patternHigh)
  val attrByteReg = RegNext(attrByte)
  
  // Data
  val fineXReg = RegNext(fineX)
  val bitPosReg = 7.U - fineXReg
  val pixelBitReg = ((patternHighReg >> bitPosReg)(0) << 1) | ((patternLowReg >> bitPosReg)(0))
  
  val tileXReg = RegNext(tileX)
  val tileYReg = RegNext(tileY)
  val attrShiftReg = ((tileYReg(1) << 2) | (tileXReg(1) << 1))
  val paletteIdxReg = (attrByteReg >> attrShiftReg)(1, 0)
  
  val bgPaletteAddrReg = (paletteIdxReg << 2) | pixelBitReg
  val bgColorReg = Mux(pixelBitReg === 0.U, paletteRam(0), paletteRam(bgPaletteAddrReg))
  
  when(isRendering) {
    finalColor := paletteRam(0)
    when(pixelBitReg =/= 0.U) {
      // Address： +
      finalColor := bgColorReg
    }
  }.otherwise {
    finalColor := paletteRam(0)
  }
  
  // Output
  io.pixelX := pixel
  io.pixelY := scanline
  io.pixelColor := finalColor(5, 0)
  io.vblank := regs.vblank  // Registers，ReadClear
  

  dontTouch(finalColor)
  
  // Output
  io.debug.ppuCtrl := regs.ppuCtrl
  io.debug.ppuMask := regs.ppuMask
  io.debug.ppuStatus := Cat(regs.vblank, regs.sprite0Hit, regs.spriteOverflow, 0.U(5.W))
  io.debug.ppuAddrReg := regs.ppuAddr
  io.debug.paletteInitDone := true.B
}
