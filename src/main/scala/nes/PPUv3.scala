package nes

import chisel3._
import chisel3.util._

// PPU v3 - 集成完整渲染管线
class PPUv3 extends Module {
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
  val ppuStatus = RegInit(0x80.U(8.W))  // VBlank 初始为 1
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
  
  // 初始化调色板为默认值
  val paletteInit = RegInit(false.B)
  val paletteInitAddr = RegInit(0.U(5.W))
  when(!paletteInit) {
    palette.write(paletteInitAddr, 0x0F.U)  // 默认黑色
    paletteInitAddr := paletteInitAddr + 1.U
    when(paletteInitAddr === 31.U) {
      paletteInit := true.B
    }
  }
  
  // 扫描计数器
  val scanlineX = RegInit(0.U(9.W))
  val scanlineY = RegInit(0.U(9.W))
  
  // VBlank 和 NMI
  val vblankFlag = RegInit(false.B)
  val nmiOccurred = RegInit(false.B)
  val suppressNMI = RegInit(false.B)
  val sprite0Hit = RegInit(false.B)
  val spriteOverflow = RegInit(false.B)
  
  // 扫描线时序
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
    sprite0Hit := false.B
    spriteOverflow := false.B
    ppuStatus := ppuStatus & 0x1F.U  // 清除 VBlank, Sprite 0 hit, Sprite overflow
    nmiOccurred := false.B
  }
  
  // 渲染使能
  val renderingEnabled = ppuMask(3) || ppuMask(4)  // Show background or sprites
  val inVisibleArea = scanlineX < 256.U && scanlineY < 240.U
  
  // 实例化渲染管线
  val renderPipeline = Module(new PPURenderPipeline)
  
  // 连接渲染管线
  renderPipeline.io.pixelX := scanlineX
  renderPipeline.io.pixelY := scanlineY
  renderPipeline.io.scrollX := ppuScrollX
  renderPipeline.io.scrollY := ppuScrollY
  renderPipeline.io.ppuCtrl := ppuCtrl
  renderPipeline.io.ppuMask := ppuMask
  
  // 内存连接 - 使用渲染管线的地址
  renderPipeline.io.vramData := vram.read(renderPipeline.io.vramAddr(10, 0))
  renderPipeline.io.oamData := oam.read(renderPipeline.io.oamAddr)
  renderPipeline.io.paletteData := palette.read(renderPipeline.io.paletteAddr)
  renderPipeline.io.patternData := io.chrData
  
  // CHR ROM 地址从渲染管线获取
  io.chrAddr := renderPipeline.io.patternAddr
  
  // Sprite 0 碰撞检测
  when(renderPipeline.io.sprite0Hit && inVisibleArea) {
    sprite0Hit := true.B
    ppuStatus := ppuStatus | 0x40.U  // Set bit 6
  }
  
  // 精灵溢出检测
  when(renderPipeline.io.spriteOverflow && inVisibleArea) {
    spriteOverflow := true.B
    ppuStatus := ppuStatus | 0x20.U  // Set bit 5
  }
  
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
  
  // 输出
  io.pixelX := scanlineX
  io.pixelY := scanlineY
  io.pixelColor := Mux(inVisibleArea && renderingEnabled, 
    renderPipeline.io.colorOut, 
    0x0F.U  // 黑色
  )
  io.vblank := vblankFlag
  io.rendering := renderingEnabled && inVisibleArea
  io.nmiOut := nmiOccurred
}
