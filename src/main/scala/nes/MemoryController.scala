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
    
    // OAM DMA 接口
    val oamDmaAddr = Output(UInt(8.W))
    val oamDmaData = Output(UInt(8.W))
    val oamDmaWrite = Output(Bool())
    val oamDmaActive = Output(Bool())  // DMA 正在进行，CPU 暂停
    
    // 控制器接口 (简化)
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // ROM 加载接口 (用于 Verilator)
    val romLoadEn = Input(Bool())
    val romLoadAddr = Input(UInt(16.W))
    val romLoadData = Input(UInt(8.W))
    val romLoadPRG = Input(Bool())
  })

  // 内部 RAM (2KB) - 同步读取
  val internalRAM = SyncReadMem(2048, UInt(8.W))
  
  // 程序 ROM (32KB) - 使用 Vec 实现组合逻辑读取
  // 这样可以在同一个周期内读取数据，避免时序问题
  val prgROM = Mem(32768, UInt(8.W))
  
  // ROM 读取缓存（用于组合逻辑读取）
  val romReadData = Wire(UInt(8.W))
  romReadData := 0.U
  
  // OAM DMA 状态机
  val dmaActive = RegInit(false.B)
  val dmaPage = RegInit(0.U(8.W))
  val dmaOffset = RegInit(0.U(8.W))
  
  // 默认输出
  io.cpuDataOut := 0.U
  io.ppuAddr := 0.U
  io.ppuDataIn := 0.U
  io.ppuWrite := false.B
  io.ppuRead := false.B
  io.oamDmaAddr := 0.U
  io.oamDmaData := 0.U
  io.oamDmaWrite := false.B
  io.oamDmaActive := dmaActive
  
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
      // PRG ROM (支持 16KB 和 32KB)
      // 对于 16KB ROM: 0x8000-0xBFFF 和 0xC000-0xFFFF 都映射到 ROM 0x0000-0x3FFF (使用低 14 位)
      // 对于 32KB ROM: 0x8000-0xFFFF 直接映射到 ROM 0x0000-0x7FFF (使用低 15 位)
      // 使用低 14 位 (0-13) 来支持 16KB ROM 的镜像
      val romAddr = (io.cpuAddr - 0x8000.U)(13, 0)
      io.cpuDataOut := prgROM(romAddr)  // 使用括号语法进行组合逻辑读取

    }
  }
  
  // OAM DMA 处理
  when(dmaActive) {
    // DMA 正在进行，从内存读取并写入 OAM
    val dmaAddr = Cat(dmaPage, dmaOffset)
    val dmaData = WireDefault(0.U(8.W))
    
    // 从内存读取数据
    when(dmaAddr < 0x2000.U) {
      dmaData := internalRAM.read(dmaAddr(10, 0))
    }.elsewhen(dmaAddr >= 0x8000.U) {
      val romAddr = (dmaAddr - 0x8000.U)(13, 0)
      dmaData := prgROM.read(romAddr)
    }
    
    // 写入 OAM
    io.oamDmaAddr := dmaOffset
    io.oamDmaData := dmaData
    io.oamDmaWrite := true.B
    
    // 更新偏移
    dmaOffset := dmaOffset + 1.U
    
    // 完成 256 字节传输后结束
    when(dmaOffset === 255.U) {
      dmaActive := false.B
    }
  }
  
  when(io.cpuWrite && !dmaActive) {
    when(io.cpuAddr < 0x2000.U) {
      // 内部 RAM (带镜像)
      val ramAddr = io.cpuAddr(10, 0)
      internalRAM.write(ramAddr, io.cpuDataIn)
    }.elsewhen(io.cpuAddr >= 0x2000.U && io.cpuAddr < 0x4000.U) {
      // PPU 寄存器 (带镜像)
      io.ppuAddr := io.cpuAddr(2, 0)
      io.ppuDataIn := io.cpuDataIn
      io.ppuWrite := true.B
    }.elsewhen(io.cpuAddr === 0x4014.U) {
      // OAM DMA 寄存器
      dmaActive := true.B
      dmaPage := io.cpuDataIn
      dmaOffset := 0.U
    }.elsewhen(io.cpuAddr >= 0x8000.U) {
      // PRG ROM (测试时可写)
      val romAddr = io.cpuAddr - 0x8000.U
      prgROM.write(romAddr, io.cpuDataIn)
    }
  }
  
  // ROM 加载逻辑 (用于 Verilator 仿真)
  when(io.romLoadEn && io.romLoadPRG) {
    // 加载 PRG ROM
    // testbench 传入的是 ROM 内部地址 (0-32767)，直接使用
    val romAddr = io.romLoadAddr(14, 0)  // 取低 15 位
    when(romAddr < 32768.U) {
      prgROM.write(romAddr, io.romLoadData)
    }
  }
}
