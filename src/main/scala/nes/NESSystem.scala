package nes

import chisel3._
import chisel3.util._
import cpu6502.CPU6502Refactored
import cpu6502.core.DebugBundle

// NES 系统顶层模块
class NESSystem extends Module {
  val io = IO(new Bundle {
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    
    // 控制器输入
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // 调试接口
    val debug = Output(new DebugBundle)
    
    // ROM 加载接口 (用于 Verilator 仿真)
    val romLoadEn = Input(Bool())
    val romLoadAddr = Input(UInt(16.W))
    val romLoadData = Input(UInt(8.W))
    val romLoadPRG = Input(Bool())  // true = PRG ROM, false = CHR ROM
  })

  // 实例化组件
  val cpu = Module(new CPU6502Refactored)
  val ppu = Module(new PPU)
  val memory = Module(new MemoryController)
  
  // Reset 连接
  cpu.io.reset := reset.asBool
  
  // CPU <-> Memory 连接
  memory.io.cpuAddr := cpu.io.memAddr
  memory.io.cpuDataIn := cpu.io.memDataOut
  cpu.io.memDataIn := memory.io.cpuDataOut
  memory.io.cpuWrite := cpu.io.memWrite
  memory.io.cpuRead := cpu.io.memRead
  
  // Memory <-> PPU 连接
  ppu.io.cpuAddr := memory.io.ppuAddr
  ppu.io.cpuDataIn := memory.io.ppuDataIn
  memory.io.ppuDataOut := ppu.io.cpuDataOut
  ppu.io.cpuWrite := memory.io.ppuWrite
  ppu.io.cpuRead := memory.io.ppuRead
  
  // 控制器连接
  memory.io.controller1 := io.controller1
  memory.io.controller2 := io.controller2
  
  // 视频输出
  io.pixelX := ppu.io.pixelX
  io.pixelY := ppu.io.pixelY
  io.pixelColor := ppu.io.pixelColor
  io.vblank := ppu.io.vblank
  
  // 调试输出
  io.debug := cpu.io.debug
  
  // ROM 加载逻辑 (用于 Verilator 仿真)
  memory.io.romLoadEn := io.romLoadEn
  memory.io.romLoadAddr := io.romLoadAddr
  memory.io.romLoadData := io.romLoadData
  memory.io.romLoadPRG := io.romLoadPRG
  
  // CHR ROM 加载到 PPU
  ppu.io.chrLoadEn := io.romLoadEn && !io.romLoadPRG
  ppu.io.chrLoadAddr := io.romLoadAddr(12, 0)  // CHR 地址 13 位
  ppu.io.chrLoadData := io.romLoadData
}
