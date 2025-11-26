package nes

import chisel3._
import chisel3.util._

// 背景渲染器
class BackgroundRenderer extends Module {
  val io = IO(new Bundle {
    // 当前像素位置
    val pixelX = Input(UInt(9.W))
    val pixelY = Input(UInt(9.W))
    
    // 滚动位置
    val scrollX = Input(UInt(8.W))
    val scrollY = Input(UInt(8.W))
    
    // VRAM 访问
    val vramAddr = Output(UInt(14.W))
    val vramData = Input(UInt(8.W))
    
    // Pattern table 访问
    val patternAddr = Output(UInt(13.W))
    val patternData = Input(UInt(8.W))
    
    // 调色板索引输出
    val paletteIndex = Output(UInt(2.W))
    val valid = Output(Bool())
  })
  
  // 计算 tile 坐标
  val scrolledX = io.pixelX + io.scrollX
  val scrolledY = io.pixelY + io.scrollY
  
  val tileX = scrolledX(7, 3)  // 除以 8
  val tileY = scrolledY(7, 3)
  val fineX = scrolledX(2, 0)  // 模 8
  val fineY = scrolledY(2, 0)
  
  // Nametable 地址计算
  // $2000 + (tileY * 32) + tileX
  val nametableAddr = 0x2000.U + (tileY << 5) + tileX
  io.vramAddr := nametableAddr
  
  // 获取 tile 索引
  val tileIndex = io.vramData
  
  // Pattern table 地址计算
  // patternTableBase + (tileIndex * 16) + fineY
  val patternTableBase = 0x0000.U  // 背景使用 pattern table 0
  io.patternAddr := patternTableBase + (tileIndex << 4) + fineY
  
  // 从 pattern data 中提取像素
  val patternLow = io.patternData
  val patternHigh = io.patternData  // 需要读取下一个字节
  
  // 根据 fineX 选择像素位
  val pixelBit = 7.U - fineX
  val pixel = Cat(
    (patternHigh >> pixelBit)(0),
    (patternLow >> pixelBit)(0)
  )
  
  io.paletteIndex := pixel
  io.valid := io.pixelX < 256.U && io.pixelY < 240.U
}

// 精灵渲染器
class SpriteRenderer extends Module {
  val io = IO(new Bundle {
    // 当前像素位置
    val pixelX = Input(UInt(9.W))
    val pixelY = Input(UInt(9.W))
    
    // OAM 访问
    val oamAddr = Output(UInt(8.W))
    val oamData = Input(UInt(8.W))
    
    // Pattern table 访问
    val patternAddr = Output(UInt(13.W))
    val patternData = Input(UInt(8.W))
    
    // 输出
    val paletteIndex = Output(UInt(2.W))
    val priority = Output(Bool())  // 0 = 前景, 1 = 背景
    val valid = Output(Bool())
  })
  
  // 精灵评估
  // 在每条扫描线开始时，评估哪些精灵在这条线上
  val spriteCount = RegInit(0.U(4.W))
  val spriteBuffer = Reg(Vec(8, new Bundle {
    val y = UInt(8.W)
    val tileIndex = UInt(8.W)
    val attributes = UInt(8.W)
    val x = UInt(8.W)
  }))
  
  // 扫描 OAM 查找当前扫描线上的精灵
  val scanState = RegInit(0.U(2.W))
  val scanIndex = RegInit(0.U(6.W))  // 0-63 个精灵
  
  when(io.pixelX === 0.U) {
    // 扫描线开始，重置精灵计数
    spriteCount := 0.U
    scanIndex := 0.U
    scanState := 0.U
  }
  
  // 简化的精灵扫描逻辑
  io.oamAddr := scanIndex << 2  // 每个精灵 4 字节
  
  // 渲染当前像素的精灵
  io.paletteIndex := 0.U
  io.priority := false.B
  io.valid := false.B
  
  // 遍历精灵缓冲区
  for (i <- 0 until 8) {
    val sprite = spriteBuffer(i)
    val inRangeX = io.pixelX >= sprite.x && io.pixelX < (sprite.x + 8.U)
    val inRangeY = io.pixelY >= sprite.y && io.pixelY < (sprite.y + 8.U)
    
    when(inRangeX && inRangeY && i.U < spriteCount) {
      // 计算精灵内的像素位置
      val spriteX = io.pixelX - sprite.x
      val spriteY = io.pixelY - sprite.y
      
      // Pattern table 地址
      val patternTableBase = 0x1000.U  // 精灵使用 pattern table 1
      io.patternAddr := patternTableBase + (sprite.tileIndex << 4) + spriteY
      
      // 提取像素 (简化)
      val pixelBit = 7.U - spriteX
      val pixel = (io.patternData >> pixelBit)(1, 0)
      
      when(pixel =/= 0.U) {
        io.paletteIndex := pixel
        io.priority := sprite.attributes(5)  // Bit 5 = priority
        io.valid := true.B
      }
    }
  }
}

// 调色板查找
class PaletteLookup extends Module {
  val io = IO(new Bundle {
    // 输入
    val bgPaletteIndex = Input(UInt(2.W))
    val bgValid = Input(Bool())
    val spritePaletteIndex = Input(UInt(2.W))
    val spritePriority = Input(Bool())
    val spriteValid = Input(Bool())
    
    // 调色板 RAM 访问
    val paletteAddr = Output(UInt(5.W))
    val paletteData = Input(UInt(6.W))
    
    // 输出颜色
    val colorOut = Output(UInt(6.W))
  })
  
  // 优先级逻辑
  val useSprite = io.spriteValid && (!io.spritePriority || !io.bgValid)
  
  // 选择调色板
  when(useSprite) {
    // 精灵调色板: $3F10-$3F1F
    io.paletteAddr := Cat(1.U(1.W), 0.U(2.W), io.spritePaletteIndex)
  }.elsewhen(io.bgValid) {
    // 背景调色板: $3F00-$3F0F
    io.paletteAddr := Cat(0.U(1.W), 0.U(2.W), io.bgPaletteIndex)
  }.otherwise {
    // 背景色: $3F00
    io.paletteAddr := 0.U
  }
  
  io.colorOut := io.paletteData
}

// 完整的 PPU 渲染管线
class PPURenderPipeline extends Module {
  val io = IO(new Bundle {
    // 像素位置
    val pixelX = Input(UInt(9.W))
    val pixelY = Input(UInt(9.W))
    
    // 滚动
    val scrollX = Input(UInt(8.W))
    val scrollY = Input(UInt(8.W))
    
    // 内存接口
    val vramAddr = Output(UInt(14.W))
    val vramData = Input(UInt(8.W))
    val oamAddr = Output(UInt(8.W))
    val oamData = Input(UInt(8.W))
    val paletteAddr = Output(UInt(5.W))
    val paletteData = Input(UInt(6.W))
    val patternAddr = Output(UInt(13.W))
    val patternData = Input(UInt(8.W))
    
    // 输出
    val colorOut = Output(UInt(6.W))
  })
  
  // 实例化渲染器
  val bgRenderer = Module(new BackgroundRenderer)
  val spriteRenderer = Module(new SpriteRenderer)
  val paletteLookup = Module(new PaletteLookup)
  
  // 连接背景渲染器
  bgRenderer.io.pixelX := io.pixelX
  bgRenderer.io.pixelY := io.pixelY
  bgRenderer.io.scrollX := io.scrollX
  bgRenderer.io.scrollY := io.scrollY
  bgRenderer.io.vramData := io.vramData
  bgRenderer.io.patternData := io.patternData
  
  // 连接精灵渲染器
  spriteRenderer.io.pixelX := io.pixelX
  spriteRenderer.io.pixelY := io.pixelY
  spriteRenderer.io.oamData := io.oamData
  spriteRenderer.io.patternData := io.patternData
  
  // 连接调色板查找
  paletteLookup.io.bgPaletteIndex := bgRenderer.io.paletteIndex
  paletteLookup.io.bgValid := bgRenderer.io.valid
  paletteLookup.io.spritePaletteIndex := spriteRenderer.io.paletteIndex
  paletteLookup.io.spritePriority := spriteRenderer.io.priority
  paletteLookup.io.spriteValid := spriteRenderer.io.valid
  paletteLookup.io.paletteData := io.paletteData
  
  // 输出
  io.colorOut := paletteLookup.io.colorOut
  
  // 多路复用内存访问
  // 简化：按优先级选择
  io.vramAddr := bgRenderer.io.vramAddr
  io.oamAddr := spriteRenderer.io.oamAddr
  io.paletteAddr := paletteLookup.io.paletteAddr
  io.patternAddr := bgRenderer.io.patternAddr
}
