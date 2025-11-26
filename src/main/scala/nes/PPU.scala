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
    
    // 视频输出 (简化)
    val pixelX = Output(UInt(9.W))      // 0-255 (可见) + blanking
    val pixelY = Output(UInt(9.W))      // 0-239 (可见) + vblank
    val pixelColor = Output(UInt(6.W))  // 调色板索引
    val vblank = Output(Bool())         // VBlank 标志
    val nmiOut = Output(Bool())         // NMI 中断输出
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
  
  // 内部 RAM
  val vram = SyncReadMem(2048, UInt(8.W))  // 2KB VRAM (nametables)
  val oam = SyncReadMem(256, UInt(8.W))    // 256B OAM (sprites)
  val palette = SyncReadMem(32, UInt(8.W)) // 32B palette RAM
  
  // 扫描计数器
  val scanlineX = RegInit(0.U(9.W))
  val scanlineY = RegInit(0.U(9.W))
  
  // VBlank 标志
  val vblankFlag = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  
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
  }
  
  // CPU 读写寄存器
  io.cpuDataOut := 0.U
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x2.U) {  // PPUSTATUS
        io.cpuDataOut := Cat(vblankFlag, 0.U(7.W))
        vblankFlag := false.B  // 读取后清除
        ppuAddrLatch := false.B
      }
      is(0x4.U) {  // OAMDATA
        io.cpuDataOut := oam.read(oamAddr)
      }
      is(0x7.U) {  // PPUDATA
        // 简化：直接读取 VRAM
        io.cpuDataOut := vram.read(ppuAddrReg(10, 0))
        ppuAddrReg := ppuAddrReg + 1.U
      }
    }
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
        // 简化：直接写入 VRAM
        vram.write(ppuAddrReg(10, 0), io.cpuDataIn)
        ppuAddrReg := ppuAddrReg + 1.U
      }
    }
  }
  
  // 输出
  io.pixelX := scanlineX
  io.pixelY := scanlineY
  io.pixelColor := 0.U  // 简化：暂时输出黑色
  io.vblank := vblankFlag
  io.nmiOut := nmiOccurred
}
