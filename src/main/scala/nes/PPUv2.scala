package nes

import chisel3._
import chisel3.util._

// PPU v2 - 带渲染功能
class PPUv2 extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(3.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    val rendering = Output(Bool())
    
    // NMI 输出
    val nmiOut = Output(Bool())
    
    // CHR ROM 接口 (用于 pattern tables)
    val chrAddr = Output(UInt(13.W))
    val chrData = Input(UInt(8.W))
  })

  // 默认输出
  io.chrAddr := 0.U

  // PPU 寄存器
  val ppuCtrl = RegInit(0.U(8.W))
  val ppuMask = RegInit(0.U(8.W))
  val ppuStatus = RegInit(0.U(8.W))
  val oamAddr = RegInit(0.U(8.W))
  
  // 滚动寄存器
  val scrollX = RegInit(0.U(8.W))
  val scrollY = RegInit(0.U(8.W))
  val scrollLatch = RegInit(false.B)
  
  // 地址寄存器
  val ppuAddrHi = RegInit(0.U(8.W))
  val ppuAddrLo = RegInit(0.U(8.W))
  val ppuAddrLatch = RegInit(false.B)
  val ppuAddr = Cat(ppuAddrHi, ppuAddrLo)  // 16 位地址
  
  // 内部 RAM
  val vram = SyncReadMem(2048, UInt(8.W))      // 2KB VRAM
  val oam = SyncReadMem(256, UInt(8.W))        // 256B OAM
  val palette = SyncReadMem(32, UInt(8.W))     // 32B palette
  
  // 读缓冲区 (PPU 读取延迟)
  val readBuffer = RegInit(0.U(8.W))
  
  // 扫描计数器
  val scanlineX = RegInit(0.U(9.W))
  val scanlineY = RegInit(0.U(9.W))
  
  // 标志
  val vblankFlag = RegInit(false.B)
  val sprite0Hit = RegInit(false.B)
  val spriteOverflow = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  
  // 渲染使能
  val renderingEnabled = ppuMask(3) || ppuMask(4)  // 显示背景或精灵
  
  // 扫描线计数
  scanlineX := scanlineX + 1.U
  when(scanlineX === 340.U) {
    scanlineX := 0.U
    scanlineY := scanlineY + 1.U
    
    when(scanlineY === 261.U) {
      scanlineY := 0.U
    }
  }
  
  // VBlank 控制
  when(scanlineY === 241.U && scanlineX === 1.U) {
    vblankFlag := true.B
    when(ppuCtrl(7)) {  // NMI enable
      nmiOccurred := true.B
    }
  }
  
  when(scanlineY === 261.U && scanlineX === 1.U) {
    vblankFlag := false.B
    sprite0Hit := false.B
    spriteOverflow := false.B
    nmiOccurred := false.B
  }
  
  // 渲染逻辑
  val inVisibleArea = scanlineX < 256.U && scanlineY < 240.U
  val pixelColor = WireDefault(0.U(6.W))
  
  when(inVisibleArea && renderingEnabled) {
    // 简化的渲染：从 VRAM 读取
    // 实际应该使用 PPURenderPipeline
    
    // 计算 tile 坐标
    val tileX = (scanlineX + scrollX) >> 3
    val tileY = (scanlineY + scrollY) >> 3
    val fineX = (scanlineX + scrollX)(2, 0)
    val fineY = (scanlineY + scrollY)(2, 0)
    
    // Nametable 地址
    val nametableBase = Mux(ppuCtrl(0), 0x2400.U, 0x2000.U)
    val nametableAddr = nametableBase + (tileY << 5) + tileX
    
    // 读取 tile 索引 (简化)
    val tileIndex = vram.read(nametableAddr(10, 0))
    
    // Pattern table 地址
    val patternBase = Mux(ppuCtrl(4), 0x1000.U, 0x0000.U)
    io.chrAddr := patternBase + (tileIndex << 4) + fineY
    
    // 从 CHR ROM 读取 pattern data
    val patternData = io.chrData
    val pixelBit = 7.U - fineX
    val pixel = (patternData >> pixelBit)(0)
    
    // 查找调色板 (简化)
    pixelColor := Mux(pixel, 0x30.U, 0x0F.U)  // 白色或黑色
  }
  
  // CPU 寄存器访问
  io.cpuDataOut := 0.U
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x2.U) {  // PPUSTATUS
        io.cpuDataOut := Cat(
          vblankFlag,
          sprite0Hit,
          spriteOverflow,
          0.U(5.W)
        )
        vblankFlag := false.B
        nmiOccurred := false.B
        ppuAddrLatch := false.B
        scrollLatch := false.B
      }
      is(0x4.U) {  // OAMDATA
        io.cpuDataOut := oam.read(oamAddr)
      }
      is(0x7.U) {  // PPUDATA
        when(ppuAddr < 0x3F00.U) {
          // VRAM 读取有延迟
          io.cpuDataOut := readBuffer
          readBuffer := vram.read(ppuAddr(10, 0))
        }.otherwise {
          // 调色板读取无延迟
          io.cpuDataOut := palette.read(ppuAddr(4, 0))
        }
        // 地址自增
        val increment = Mux(ppuCtrl(2), 32.U, 1.U)
        ppuAddrHi := ((ppuAddr + increment) >> 8)(7, 0)
        ppuAddrLo := (ppuAddr + increment)(7, 0)
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
        when(!scrollLatch) {
          scrollX := io.cpuDataIn
        }.otherwise {
          scrollY := io.cpuDataIn
        }
        scrollLatch := !scrollLatch
      }
      is(0x6.U) {  // PPUADDR
        when(!ppuAddrLatch) {
          ppuAddrHi := io.cpuDataIn
        }.otherwise {
          ppuAddrLo := io.cpuDataIn
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x7.U) {  // PPUDATA
        when(ppuAddr < 0x2000.U) {
          // CHR RAM 写入 (如果有)
        }.elsewhen(ppuAddr < 0x3F00.U) {
          // VRAM 写入
          vram.write(ppuAddr(10, 0), io.cpuDataIn)
        }.otherwise {
          // 调色板写入
          palette.write(ppuAddr(4, 0), io.cpuDataIn)
        }
        // 地址自增
        val increment = Mux(ppuCtrl(2), 32.U, 1.U)
        ppuAddrHi := ((ppuAddr + increment) >> 8)(7, 0)
        ppuAddrLo := (ppuAddr + increment)(7, 0)
      }
    }
  }
  
  // 输出
  io.pixelX := scanlineX
  io.pixelY := scanlineY
  io.pixelColor := pixelColor
  io.vblank := vblankFlag
  io.rendering := inVisibleArea && renderingEnabled
  io.nmiOut := nmiOccurred
}
