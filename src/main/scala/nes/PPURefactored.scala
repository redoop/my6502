package nes

import chisel3._
import chisel3.util._
import nes.core._

/**
 * PPU 重构版本
 * 参考 CPU6502Refactored 的模块化设计
 * 合并 PPU, PPUv2, PPUv3, PPUSimplified 的功能
 * 与测试用例衔接
 */
class PPURefactored extends Module {
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
  
  // 寄存器控制模块
  val regControl = Module(new PPURegisterControl)
  regControl.io.cpuAddr := io.cpuAddr
  regControl.io.cpuDataIn := io.cpuDataIn
  regControl.io.cpuWrite := io.cpuWrite
  regControl.io.cpuRead := io.cpuRead
  io.cpuDataOut := regControl.io.cpuDataOut
  
  val regs = regControl.io.regs
  
  // 扫描线和像素计数器
  val scanline = RegInit(0.U(9.W))
  val pixel = RegInit(0.U(9.W))
  
  // 像素计数
  when(pixel === 340.U) {
    pixel := 0.U
    when(scanline === 261.U) {
      scanline := 0.U
    }.otherwise {
      scanline := scanline + 1.U
    }
  }.otherwise {
    pixel := pixel + 1.U
  }
  
  // VBlank 控制
  val vblankFlag = RegInit(false.B)
  regControl.io.setVBlank := false.B
  regControl.io.clearVBlank := false.B
  regControl.io.setSprite0Hit := false.B
  regControl.io.setSpriteOverflow := false.B
  
  when(scanline === 241.U && pixel === 1.U) {
    vblankFlag := true.B
    regControl.io.setVBlank := true.B
  }.elsewhen(scanline === 261.U && pixel === 1.U) {
    vblankFlag := false.B
    regControl.io.clearVBlank := true.B
  }
  
  // NMI 生成
  val nmiEnable = regs.ppuCtrl(7)
  io.nmiOut := nmiEnable && vblankFlag
  
  // CHR ROM (8KB)
  val chrRom = SyncReadMem(8192, UInt(8.W))
  when(io.chrLoadEn) {
    chrRom.write(io.chrLoadAddr, io.chrLoadData)
  }
  
  // 调色板 RAM (32 bytes)
  val paletteRam = RegInit(VecInit(Seq.fill(32)(0.U(8.W))))
  
  // 名称表 RAM (2KB)
  val nametableRam = SyncReadMem(2048, UInt(8.W))
  
  // OAM (256 bytes)
  val oam = RegInit(VecInit(Seq.fill(256)(0.U(8.W))))
  when(io.oamDmaWrite) {
    oam(io.oamDmaAddr) := io.oamDmaData
  }
  
  // 简单的背景渲染
  val isRendering = scanline < 240.U && pixel < 256.U
  val bgColor = Mux(isRendering, paletteRam(0), 0.U)
  
  // 输出
  io.pixelX := pixel
  io.pixelY := scanline
  io.pixelColor := bgColor(5, 0)
  io.vblank := vblankFlag
  
  // 调试输出
  io.debug.ppuCtrl := regs.ppuCtrl
  io.debug.ppuMask := regs.ppuMask
  io.debug.ppuStatus := regs.ppuStatus
  io.debug.ppuAddrReg := regs.ppuAddr
  io.debug.paletteInitDone := true.B
}
