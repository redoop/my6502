package nes

import chisel3._
import chisel3.util._

// NES 内存控制器
class MemoryController extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(16.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // PPU 接口
    val ppuAddr = Output(UInt(3.W))
    val ppuDataIn = Output(UInt(8.W))
    val ppuDataOut = Input(UInt(8.W))
    val ppuWrite = Output(Bool())
    val ppuRead = Output(Bool())
    
    // 控制器接口 (简化)
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // ROM 加载接口 (用于 Verilator)
    val romLoadEn = Input(Bool())
    val romLoadAddr = Input(UInt(16.W))
    val romLoadData = Input(UInt(8.W))
    val romLoadPRG = Input(Bool())
  })

  // 内部 RAM (2KB)
  val internalRAM = SyncReadMem(2048, UInt(8.W))
  
  // 程序 ROM (32KB) - 简化为 RAM 用于测试
  val prgROM = SyncReadMem(32768, UInt(8.W))
  
  // 默认输出
  io.cpuDataOut := 0.U
  io.ppuAddr := 0.U
  io.ppuDataIn := 0.U
  io.ppuWrite := false.B
  io.ppuRead := false.B
  
  // NES 内存映射
  // $0000-$07FF: 2KB 内部 RAM
  // $0800-$1FFF: RAM 镜像
  // $2000-$2007: PPU 寄存器
  // $2008-$3FFF: PPU 寄存器镜像
  // $4000-$4017: APU 和 I/O 寄存器
  // $4018-$401F: APU 和 I/O 测试功能
  // $4020-$FFFF: 卡带空间
  
  when(io.cpuRead) {
    when(io.cpuAddr < 0x2000.U) {
      // 内部 RAM (带镜像)
      val ramAddr = io.cpuAddr(10, 0)
      io.cpuDataOut := internalRAM.read(ramAddr)
    }.elsewhen(io.cpuAddr >= 0x2000.U && io.cpuAddr < 0x4000.U) {
      // PPU 寄存器 (带镜像)
      io.ppuAddr := io.cpuAddr(2, 0)
      io.ppuRead := true.B
      io.cpuDataOut := io.ppuDataOut
    }.elsewhen(io.cpuAddr === 0x4016.U) {
      // 控制器 1
      io.cpuDataOut := io.controller1
    }.elsewhen(io.cpuAddr === 0x4017.U) {
      // 控制器 2
      io.cpuDataOut := io.controller2
    }.elsewhen(io.cpuAddr >= 0x8000.U) {
      // PRG ROM
      val romAddr = io.cpuAddr - 0x8000.U
      io.cpuDataOut := prgROM.read(romAddr)
    }
  }
  
  when(io.cpuWrite) {
    when(io.cpuAddr < 0x2000.U) {
      // 内部 RAM (带镜像)
      val ramAddr = io.cpuAddr(10, 0)
      internalRAM.write(ramAddr, io.cpuDataIn)
    }.elsewhen(io.cpuAddr >= 0x2000.U && io.cpuAddr < 0x4000.U) {
      // PPU 寄存器 (带镜像)
      io.ppuAddr := io.cpuAddr(2, 0)
      io.ppuDataIn := io.cpuDataIn
      io.ppuWrite := true.B
    }.elsewhen(io.cpuAddr >= 0x8000.U) {
      // PRG ROM (测试时可写)
      val romAddr = io.cpuAddr - 0x8000.U
      prgROM.write(romAddr, io.cpuDataIn)
    }
  }
  
  // ROM 加载逻辑 (用于 Verilator 仿真)
  when(io.romLoadEn && io.romLoadPRG) {
    // 加载 PRG ROM
    when(io.romLoadAddr < 32768.U) {
      prgROM.write(io.romLoadAddr, io.romLoadData)
    }
  }
}
