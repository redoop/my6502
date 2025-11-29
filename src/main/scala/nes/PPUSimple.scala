package nes

import chisel3._
import chisel3.util._
import nes.core._

// Simplified PPU - Registers only, no rendering
// For testing Mapper 4 PRG bank switching
class PPUSimple extends Module {
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
  
  // Registers only
  val regControl = Module(new PPURegisterControl(false))
  regControl.io.cpuAddr := io.cpuAddr
  regControl.io.cpuDataIn := io.cpuDataIn
  regControl.io.cpuWrite := io.cpuWrite
  regControl.io.cpuRead := io.cpuRead
  regControl.io.setVBlank := false.B
  regControl.io.clearVBlank := false.B
  regControl.io.setSprite0Hit := false.B
  
  io.cpuDataOut := regControl.io.cpuDataOut
  
  val regs = regControl.io.regs
  
  // Simple counters
  val scanline = RegInit(0.U(9.W))
  val pixel = RegInit(0.U(9.W))
  
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
  
  // VBlank at scanline 241
  when(scanline === 241.U && pixel === 1.U) {
    regControl.io.setVBlank := true.B
  }
  when(scanline === 261.U && pixel === 1.U) {
    regControl.io.clearVBlank := true.B
  }
  
  // Output
  io.pixelX := pixel
  io.pixelY := scanline
  io.pixelColor := 0.U
  io.vblank := regs.vblank
  io.nmiOut := regs.vblank && regs.ppuCtrl(7)
  
  // Debug
  io.debug.ppuCtrl := regs.ppuCtrl
  io.debug.ppuMask := regs.ppuMask
  io.debug.ppuStatus := Cat(regs.vblank, regs.sprite0Hit, regs.spriteOverflow, 0.U(5.W))
  io.debug.ppuAddrReg := regs.ppuAddr
  io.debug.paletteInitDone := true.B
}
