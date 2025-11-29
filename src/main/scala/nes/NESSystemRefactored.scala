package nes

import chisel3._
import chisel3.util._
import cpu6502.CPU6502Refactored

/**
 * NES 系统重构版本
 * 参考 CPU6502Refactored 的模块化设计
 * 整合 CPU + PPU + APU + Memory
 */
class NESSystemRefactored(enableDebug: Boolean = false) extends Module {
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
      val cpuState = UInt(3.W)  // CPU 状态机状态
      val cpuCycle = UInt(3.W)  // CPU 周期计数
      val cpuOpcode = UInt(8.W) // 当前指令
      val cpuMemAddr = UInt(16.W) // CPU 内存地址
      val cpuMemDataIn = UInt(8.W) // CPU 读取的数据
      val cpuMemRead = Bool() // CPU 读取信号
    })
  })
  
  // CPU
  val cpu = Module(new CPU6502Refactored)
  
  // PPU
  val ppu = Module(new PPURefactored(enableDebug))
  
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
  when(cpuAddr >= 0x2000.U && cpuAddr <= 0x2010.U) {
    printf("[NES] cpuAddr=$%x memRead=%d\n", cpuAddr, cpu.io.memRead)
  }
  val isRam = cpuAddr < 0x2000.U
  val isPpuReg = cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U
  val isApuReg = cpuAddr >= 0x4000.U && cpuAddr < 0x4018.U
  val isController = cpuAddr === 0x4016.U || cpuAddr === 0x4017.U
  val isPrgRom = cpuAddr >= 0x8000.U
  
  // 控制器 strobe 逻辑
  val controller1Shift = RegInit(0.U(8.W))
  val controller2Shift = RegInit(0.U(8.W))
  val controllerStrobe = RegInit(false.B)
  
  when(cpu.io.memWrite && cpuAddr === 0x4016.U) {
    controllerStrobe := cpu.io.memDataOut(0)
    when(cpu.io.memDataOut(0)) {
      // Strobe = 1: 加载控制器状态
      controller1Shift := io.controller1
      controller2Shift := io.controller2
    }
  }
  
  // 控制器读取：每次读取返回最低位，然后右移
  val controller1Data = controller1Shift(0)
  val controller2Data = controller2Shift(0)
  
  when(cpu.io.memRead && isController && !controllerStrobe) {
    when(cpuAddr === 0x4016.U) {
      controller1Shift := controller1Shift >> 1
    }.otherwise {
      controller2Shift := controller2Shift >> 1
    }
  }
  
  val controllerData = Mux(cpuAddr(0), controller2Data, controller1Data)
  
  // CPU 读取
  val ramData = ram.read(cpuAddr(10, 0))
  val ppuData = ppu.io.cpuDataOut
  // val apuData = apu.io.cpuDataOut
  
  // PRG ROM 读取 - 支持 16KB 镜像
  // 对于 16KB ROM: $8000-$BFFF 和 $C000-$FFFF 都映射到 $0000-$3FFF
  // 对于 32KB ROM: $8000-$FFFF 映射到 $0000-$7FFF
  val prgAddr = Mux(cpuAddr(14), cpuAddr(13, 0), cpuAddr(13, 0))  // 使用 bit 13-0 (14 位 = 16KB)
  val prgData = prgRom.read(prgAddr)
  
  cpu.io.memDataIn := MuxCase(0.U, Seq(
    isRam -> ramData,
    isPpuReg -> ppuData,
    // isApuReg -> apuData,
    isController -> controllerData,
    isPrgRom -> prgData
  ))
  
  // Debug: CPU 读取 PPU
  when(isPpuReg) {
    printf("[NES] isPpuReg=true: addr=$%x data=0x%x\n", cpuAddr, ppuData)
  }
  when(cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U) {
    printf("[NES] PPU addr range: addr=$%x isPpuReg=%d\n", cpuAddr, isPpuReg)
  }
  
  // CPU 写入
  when(cpu.io.memWrite) {
    printf("[CPU Write] Addr=$%x Data=0x%x isRam=%d isPpuReg=%d\n", 
           cpuAddr, cpu.io.memDataOut, isRam, isPpuReg)
    when(isRam) {
      // 监控 $0200-$020F 写入
      when(cpuAddr >= 0x0200.U && cpuAddr < 0x0210.U) {
        printf("[RAM Write] Addr=$%x Data=0x%x PC=0x%x\n", cpuAddr, cpu.io.memDataOut, cpu.io.debug.regPC)
      }
      ram.write(cpuAddr(10, 0), cpu.io.memDataOut)
    }
  }
  
  // PPU 连接
  ppu.io.cpuAddr := cpuAddr(2, 0)
  ppu.io.cpuDataIn := cpu.io.memDataOut
  ppu.io.cpuWrite := cpu.io.memWrite && isPpuReg
  ppu.io.cpuRead := cpu.io.memRead && isPpuReg
  
  // Debug: PPU 写入监控
  when(cpu.io.memWrite && isPpuReg) {
    printf("[PPU Write] Addr=$%x RegAddr=%d Data=0x%x cpuWrite=%d isPpuReg=%d\n", 
           cpuAddr, cpuAddr(2, 0), cpu.io.memDataOut, cpu.io.memWrite, isPpuReg)
  }
  when(cpu.io.memRead && isPpuReg) {
    printf("[PPU Read] Addr=$%x RegAddr=%d cpuRead=%d ppuData=0x%x\n", 
           cpuAddr, cpuAddr(2, 0), cpu.io.memRead, ppuData)
  }
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
  cpu.io.reset := reset.asBool  // 连接到系统 reset
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
  io.debug.cpuState := cpu.io.debug.state
  io.debug.cpuCycle := cpu.io.debug.cycle
  io.debug.cpuOpcode := cpu.io.debug.opcode
  io.debug.cpuMemAddr := cpu.io.memAddr
  io.debug.cpuMemDataIn := cpu.io.memDataIn
  io.debug.cpuMemRead := cpu.io.memRead
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
