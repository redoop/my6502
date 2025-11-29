package nes

import chisel3._
import chisel3.util._
import cpu6502.CPU6502Refactored

/**
 * NES 系统重构版本
 * 参考 CPU6502Refactored 的模块化设计
 * 整合 CPU + PPU + APU + Memory
 */
class NESSystemRefactored extends Module {
  val io = IO(new Bundle {
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    
    // 音频输出
    val audioOut = Output(UInt(16.W))
    
    // ROM 加载接口
    val prgLoadEn = Input(Bool())
    val prgLoadAddr = Input(UInt(16.W))
    val prgLoadData = Input(UInt(8.W))
    val chrLoadEn = Input(Bool())
    val chrLoadAddr = Input(UInt(13.W))
    val chrLoadData = Input(UInt(8.W))
    
    // 控制器接口
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // 调试接口
    val debug = Output(new Bundle {
      val cpuPC = UInt(16.W)
      val cpuA = UInt(8.W)
      val cpuX = UInt(8.W)
      val cpuY = UInt(8.W)
      val ppuCtrl = UInt(8.W)
      val ppuMask = UInt(8.W)
      val vblank = Bool()
      val nmi = Bool()
      val apuPulse1Active = Bool()
      val apuPulse2Active = Bool()
    })
  })
  
  // CPU
  val cpu = Module(new CPU6502Refactored)
  
  // PPU
  val ppu = Module(new PPURefactored)
  
  // APU - 暂时禁用，等待完整实现
  // val apu = Module(new APURefactored)
  
  // PRG ROM (32KB)
  val prgRom = SyncReadMem(32768, UInt(8.W))
  when(io.prgLoadEn) {
    prgRom.write(io.prgLoadAddr, io.prgLoadData)
  }
  
  // RAM (2KB)
  val ram = SyncReadMem(2048, UInt(8.W))
  
  // 内存映射
  val cpuAddr = cpu.io.memAddr
  val isRam = cpuAddr < 0x2000.U
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  val isApuReg = cpuAddr >= 0x4000.U && cpuAddr < 0x4018.U
  val isController = cpuAddr === 0x4016.U || cpuAddr === 0x4017.U
  val isPrgRom = cpuAddr >= 0x8000.U
  
  // CPU 读取
  val ramData = ram.read(cpuAddr(10, 0))
  val ppuData = ppu.io.cpuDataOut
  // val apuData = apu.io.cpuDataOut
  val prgData = prgRom.read(cpuAddr(14, 0))
  val controllerData = Mux(cpuAddr(0), io.controller2, io.controller1)
  
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isRam -> ramData,
    isPpuReg -> ppuData,
    // isApuReg -> apuData,
    isController -> controllerData,
    isPrgRom -> prgData
  ))
  
  // CPU 写入
  when(cpu.io.memWrite) {
    when(isRam) {
      ram.write(cpuAddr(10, 0), cpu.io.memDataOut)
    }
  }
  
  // PPU 连接
  ppu.io.cpuAddr := cpuAddr(2, 0)
  ppu.io.cpuDataIn := cpu.io.memDataOut
  ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg
  ppu.io.cpuRead := cpu.io.memRead && isPpuReg
  ppu.io.oamDmaAddr := 0.U
  ppu.io.oamDmaData := 0.U
  ppu.io.oamDmaWrite := false.B
  ppu.io.chrLoadEn := io.chrLoadEn
  ppu.io.chrLoadAddr := io.chrLoadAddr
  ppu.io.chrLoadData := io.chrLoadData
  
  // APU 连接 - 暂时禁用
  // apu.io.cpuAddr := cpuAddr(7, 0)
  // apu.io.cpuDataIn := cpu.io.memDataOut
  // apu.io.cpuWrite := cpu.io.memWrite && isApuReg
  // apu.io.cpuRead := cpu.io.memRead && isApuReg
  
  // CPU 中断
  cpu.io.reset := false.B
  cpu.io.nmi := ppu.io.nmiOut
  
  // 输出
  io.pixelX := ppu.io.pixelX
  io.pixelY := ppu.io.pixelY
  io.pixelColor := ppu.io.pixelColor
  io.vblank := ppu.io.vblank
  io.audioOut := 0.U // apu.io.audioOut
  
  // 调试输出
  io.debug.cpuPC := cpu.io.debug.regPC
  io.debug.cpuA := cpu.io.debug.regA
  io.debug.cpuX := cpu.io.debug.regX
  io.debug.cpuY := cpu.io.debug.regY
  io.debug.ppuCtrl := ppu.io.debug.ppuCtrl
  io.debug.ppuMask := ppu.io.debug.ppuMask
  io.debug.vblank := ppu.io.vblank
  io.debug.nmi := ppu.io.nmiOut
  io.debug.apuPulse1Active := false.B // apu.io.debug.pulse1Active
  io.debug.apuPulse2Active := false.B // apu.io.debug.pulse2Active
}

object NESSystemRefactored extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new NESSystemRefactored)
}
