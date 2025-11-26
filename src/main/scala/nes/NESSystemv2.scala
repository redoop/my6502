package nes

import chisel3._
import chisel3.util._
import cpu6502._

// NES 系统 v2 - 带 MMC3 和改进的 PPU
class NESSystemv2 extends Module {
  val io = IO(new Bundle {
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    val rendering = Output(Bool())
    
    // 控制器输入
    val controller1 = Input(UInt(8.W))
    val controller2 = Input(UInt(8.W))
    
    // 调试接口
    val debug = Output(new DebugBundle)
    
    // Mapper 选择
    val mapperType = Input(UInt(8.W))  // 0 = NROM, 4 = MMC3
    
    // ROM 加载接口
    val romLoadEn = Input(Bool())
    val romLoadAddr = Input(UInt(19.W))
    val romLoadData = Input(UInt(8.W))
    val romLoadPRG = Input(Bool())  // true = PRG, false = CHR
  })

  // 实例化组件
  val cpu = Module(new CPU6502)
  val ppu = Module(new PPUv2)
  val mapper = Module(new MMC3Mapper)
  
  // PRG ROM (512KB 最大)
  val prgROM = SyncReadMem(524288, UInt(8.W))
  
  // CHR ROM (256KB 最大)
  val chrROM = SyncReadMem(262144, UInt(8.W))
  
  // 内部 RAM (2KB)
  val internalRAM = SyncReadMem(2048, UInt(8.W))
  
  // ROM 加载逻辑
  when(io.romLoadEn) {
    when(io.romLoadPRG) {
      prgROM.write(io.romLoadAddr, io.romLoadData)
    }.otherwise {
      chrROM.write(io.romLoadAddr(17, 0), io.romLoadData)
    }
  }
  
  // 默认值
  ppu.io.cpuAddr := 0.U
  ppu.io.cpuDataIn := 0.U
  ppu.io.cpuWrite := false.B
  ppu.io.cpuRead := false.B
  ppu.io.chrData := 0.U
  
  mapper.io.cpuAddr := 0.U
  mapper.io.cpuDataIn := 0.U
  mapper.io.cpuWrite := false.B
  mapper.io.cpuRead := false.B
  mapper.io.prgData := 0.U
  mapper.io.chrData := 0.U
  mapper.io.ppuAddr := 0.U
  
  // CPU 内存映射
  val cpuAddr = cpu.io.memAddr
  val cpuDataOut = WireDefault(0.U(8.W))
  
  when(cpuAddr < 0x2000.U) {
    // 内部 RAM (带镜像)
    val ramAddr = cpuAddr(10, 0)
    when(cpu.io.memRead) {
      cpuDataOut := internalRAM.read(ramAddr)
    }
    when(cpu.io.memWrite) {
      internalRAM.write(ramAddr, cpu.io.memDataOut)
    }
  }.elsewhen(cpuAddr >= 0x2000.U && cpuAddr < 0x4000.U) {
    // PPU 寄存器 (带镜像)
    ppu.io.cpuAddr := cpuAddr(2, 0)
    ppu.io.cpuDataIn := cpu.io.memDataOut
    ppu.io.cpuWrite := cpu.io.memWrite
    ppu.io.cpuRead := cpu.io.memRead
    cpuDataOut := ppu.io.cpuDataOut
  }.elsewhen(cpuAddr === 0x4016.U) {
    // 控制器 1
    cpuDataOut := io.controller1
  }.elsewhen(cpuAddr === 0x4017.U) {
    // 控制器 2
    cpuDataOut := io.controller2
  }.elsewhen(cpuAddr >= 0x8000.U) {
    // PRG ROM (通过 mapper)
    when(io.mapperType === 4.U) {
      // MMC3
      mapper.io.cpuAddr := cpuAddr
      mapper.io.cpuDataIn := cpu.io.memDataOut
      mapper.io.cpuWrite := cpu.io.memWrite
      mapper.io.cpuRead := cpu.io.memRead
      mapper.io.prgData := prgROM.read(mapper.io.prgAddr)
      cpuDataOut := mapper.io.cpuDataOut
    }.otherwise {
      // NROM (简单映射)
      val romAddr = cpuAddr - 0x8000.U
      cpuDataOut := prgROM.read(romAddr)
    }
  }
  
  cpu.io.memDataIn := cpuDataOut
  
  // PPU CHR ROM 访问
  when(io.mapperType === 4.U) {
    // MMC3 CHR bank switching
    mapper.io.ppuAddr := ppu.io.chrAddr
    mapper.io.chrData := chrROM.read(mapper.io.chrAddr)
    ppu.io.chrData := mapper.io.chrData
  }.otherwise {
    // NROM 直接访问
    ppu.io.chrData := chrROM.read(ppu.io.chrAddr)
  }
  
  // 视频输出
  io.pixelX := ppu.io.pixelX
  io.pixelY := ppu.io.pixelY
  io.pixelColor := ppu.io.pixelColor
  io.vblank := ppu.io.vblank
  io.rendering := ppu.io.rendering
  
  // 调试输出
  io.debug := cpu.io.debug
}

// 魂斗罗专用系统
class ContraSystem extends Module {
  val io = IO(new Bundle {
    // 视频输出
    val videoOut = Output(new Bundle {
      val x = UInt(9.W)
      val y = UInt(9.W)
      val color = UInt(6.W)
      val vblank = Bool()
    })
    
    // 控制器输入
    val controller = Input(new Bundle {
      val a = Bool()
      val b = Bool()
      val select = Bool()
      val start = Bool()
      val up = Bool()
      val down = Bool()
      val left = Bool()
      val right = Bool()
    })
    
    // 调试
    val debug = Output(new DebugBundle)
  })
  
  val nes = Module(new NESSystemv2)
  
  // 固定为 MMC3 mapper
  nes.io.mapperType := 4.U
  
  // 控制器映射
  val controllerByte = Cat(
    io.controller.right,
    io.controller.left,
    io.controller.down,
    io.controller.up,
    io.controller.start,
    io.controller.select,
    io.controller.b,
    io.controller.a
  )
  nes.io.controller1 := controllerByte
  nes.io.controller2 := 0.U
  
  // ROM 加载 (需要外部提供)
  nes.io.romLoadEn := false.B
  nes.io.romLoadAddr := 0.U
  nes.io.romLoadData := 0.U
  nes.io.romLoadPRG := false.B
  
  // 视频输出
  io.videoOut.x := nes.io.pixelX
  io.videoOut.y := nes.io.pixelY
  io.videoOut.color := nes.io.pixelColor
  io.videoOut.vblank := nes.io.vblank
  
  // 调试
  io.debug := nes.io.debug
}
