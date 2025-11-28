package nes

import chisel3._
import chisel3.util._

// PPU v2 - 完整的渲染管线
class PPUv2 extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(3.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // CHR ROM 接口
    val chrAddr = Output(UInt(14.W))
    val chrData = Input(UInt(8.W))
    
    // 视频输出
    val pixelX = Output(UInt(9.W))
    val pixelY = Output(UInt(9.W))
    val pixelColor = Output(UInt(6.W))
    val vblank = Output(Bool())
    val rendering = Output(Bool())
    
    // NMI 输出
    val nmiOut = Output(Bool())
  })

  // PPU 寄存器
  val ppuCtrl = RegInit(0.U(8.W))
  val ppuMask = RegInit(0.U(8.W))
  val ppuStatus = RegInit(0xA0.U(8.W))  // VBlank=1, Sprite0Hit=1 初始状态
  val oamAddr = RegInit(0.U(8.W))
  val ppuScrollX = RegInit(0.U(8.W))
  val ppuScrollY = RegInit(0.U(8.W))
  val ppuAddrLatch = RegInit(false.B)
  val ppuAddrReg = RegInit(0.U(14.W))
  val ppuDataBuffer = RegInit(0.U(8.W))
  
  // 内部存储
  val vram = SyncReadMem(2048, UInt(8.W))  // Nametables
  val oam = SyncReadMem(256, UInt(8.W))    // Sprite OAM
  val palette = SyncReadMem(32, UInt(8.W)) // Palette RAM
  
  // 初始化调色板为默认值（不阻塞 PPU 运行）
  val paletteInitAddr = RegInit(0.U(5.W))
  val paletteInitDone = RegInit(false.B)
  when(!paletteInitDone && paletteInitAddr < 32.U) {
    palette.write(paletteInitAddr, 0x0F.U)  // 默认黑色
    paletteInitAddr := paletteInitAddr + 1.U
    when(paletteInitAddr === 31.U) {
      paletteInitDone := true.B
    }
  }
  
  // 扫描计数器 - 始终运行
  val scanlineX = RegInit(0.U(9.W))
  val scanlineY = RegInit(0.U(9.W))
  
  // VBlank 和 NMI
  val vblankFlag = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  val suppressNMI = RegInit(false.B)
  
  // 扫描线时序 - 始终运行
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
    ppuStatus := ppuStatus | 0x80.U
    when(ppuCtrl(7) && !suppressNMI) {
      nmiOccurred := true.B
    }
    suppressNMI := false.B
  }
  
  when(scanlineY === 261.U && scanlineX === 1.U) {
    vblankFlag := false.B
    ppuStatus := ppuStatus & 0x7F.U
    nmiOccurred := false.B
  }
  
  // 渲染使能
  val renderingEnabled = ppuMask(3) || ppuMask(4)  // Show background or sprites
  val inVisibleArea = scanlineX < 256.U && scanlineY < 240.U
  
  // CPU 寄存器访问
  io.cpuDataOut := 0.U
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x2.U) {  // PPUSTATUS
        io.cpuDataOut := ppuStatus
        // 读取后清除 VBlank 标志
        ppuStatus := ppuStatus & 0x7F.U
        vblankFlag := false.B
        ppuAddrLatch := false.B
        // 如果在 VBlank 开始时读取，抑制 NMI
        when(scanlineY === 241.U && scanlineX <= 1.U) {
          suppressNMI := true.B
          nmiOccurred := false.B
        }
      }
      is(0x4.U) {  // OAMDATA
        io.cpuDataOut := oam.read(oamAddr)
      }
      is(0x7.U) {  // PPUDATA
        val addr = ppuAddrReg
        when(addr < 0x3F00.U) {
          // VRAM 读取有延迟
          io.cpuDataOut := ppuDataBuffer
          when(addr < 0x2000.U) {
            // CHR ROM
            ppuDataBuffer := io.chrData
          }.otherwise {
            // Nametable
            ppuDataBuffer := vram.read(addr(10, 0))
          }
        }.otherwise {
          // Palette 读取无延迟
          val paletteAddr = addr(4, 0)
          io.cpuDataOut := palette.read(paletteAddr)
          // 但仍然更新缓冲区
          ppuDataBuffer := vram.read(addr(10, 0))
        }
        // 自动递增地址
        val increment = Mux(ppuCtrl(2), 32.U, 1.U)
        ppuAddrReg := (ppuAddrReg + increment) & 0x3FFF.U
      }
    }
  }
  
  when(io.cpuWrite) {
    switch(io.cpuAddr) {
      is(0x0.U) {  // PPUCTRL
        ppuCtrl := io.cpuDataIn
        // 如果在 VBlank 期间启用 NMI
        when(io.cpuDataIn(7) && vblankFlag) {
          nmiOccurred := true.B
        }
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
          ppuAddrReg := Cat(ppuAddrReg(13, 8), io.cpuDataIn)
        }
        ppuAddrLatch := !ppuAddrLatch
      }
      is(0x7.U) {  // PPUDATA
        val addr = ppuAddrReg
        when(addr < 0x2000.U) {
          // CHR ROM (通常只读，但某些游戏使用 CHR RAM)
          // 这里不处理
        }.elsewhen(addr < 0x3F00.U) {
          // Nametable
          vram.write(addr(10, 0), io.cpuDataIn)
        }.otherwise {
          // Palette
          val paletteAddr = addr(4, 0)
          // 处理镜像: $3F10/$3F14/$3F18/$3F1C 镜像到 $3F00/$3F04/$3F08/$3F0C
          val actualAddr = Mux(paletteAddr(1, 0) === 0.U && paletteAddr(4),
            paletteAddr & 0x0F.U,
            paletteAddr
          )
          palette.write(actualAddr, io.cpuDataIn & 0x3F.U)
        }
        // 自动递增地址
        val increment = Mux(ppuCtrl(2), 32.U, 1.U)
        ppuAddrReg := (ppuAddrReg + increment) & 0x3FFF.U
      }
    }
  }
  
  // 简化的背景渲染
  val tileX = (scanlineX + ppuScrollX) >> 3
  val tileY = (scanlineY + ppuScrollY) >> 3
  val fineX = (scanlineX + ppuScrollX)(2, 0)
  val fineY = (scanlineY + ppuScrollY)(2, 0)
  
  // Nametable 地址
  val nametableBase = Mux(ppuCtrl(0), 0x0400.U, 0x0000.U)
  val nametableAddr = nametableBase + (tileY(4, 0) << 5) + tileX(4, 0)
  
  // 读取 tile 索引
  val tileIndex = vram.read(nametableAddr)
  
  // Pattern table 地址
  val patternTableBase = Mux(ppuCtrl(4), 0x1000.U, 0x0000.U)
  val patternAddr = patternTableBase + (tileIndex << 4) + fineY
  io.chrAddr := patternAddr
  
  // 简化的像素输出
  val pixelData = io.chrData
  val pixelBit = 7.U - fineX
  val pixelValue = (pixelData >> pixelBit)(0)
  
  // 调色板查找
  val paletteIndex = Mux(pixelValue === 0.U, 0.U, 1.U)
  val paletteColor = palette.read(paletteIndex)
  
  // 输出
  io.pixelX := scanlineX
  io.pixelY := scanlineY
  io.pixelColor := Mux(inVisibleArea && renderingEnabled, paletteColor, 0x0F.U)
  io.vblank := vblankFlag
  io.rendering := renderingEnabled && inVisibleArea
  io.nmiOut := nmiOccurred
}
