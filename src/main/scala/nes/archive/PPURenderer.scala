package nes

import chisel3._
import chisel3.util._

// 背景渲染器 - 完整实现
class BackgroundRenderer extends Module {
  val io = IO(new Bundle {
    // 当前像素位置
    val pixelX = Input(UInt(9.W))
    val pixelY = Input(UInt(9.W))
    
    // 滚动位置
    val scrollX = Input(UInt(8.W))
    val scrollY = Input(UInt(8.W))
    
    // PPU 控制
    val ppuCtrl = Input(UInt(8.W))
    val showBackground = Input(Bool())
    
    // VRAM 访问
    val vramAddr = Output(UInt(14.W))
    val vramData = Input(UInt(8.W))
    
    // Pattern table 访问
    val patternAddr = Output(UInt(13.W))
    val patternData = Input(UInt(8.W))
    
    // 输出
    val paletteIndex = Output(UInt(2.W))
    val paletteSelect = Output(UInt(2.W))  // 属性表选择的调色板
    val valid = Output(Bool())
  })
  
  // 渲染流水线状态
  val sFetchNametable :: sFetchAttribute :: sFetchPatternLow :: sFetchPatternHigh :: sRender :: Nil = Enum(5)
  val state = RegInit(sFetchNametable)
  
  // 计算 tile 坐标
  val scrolledX = io.pixelX + io.scrollX
  val scrolledY = io.pixelY + io.scrollY
  
  val tileX = scrolledX >> 3  // 除以 8
  val tileY = scrolledY >> 3
  val fineX = scrolledX(2, 0)  // 模 8
  val fineY = scrolledY(2, 0)
  
  // Nametable 选择 (支持水平/垂直镜像)
  val nametableSelect = Cat(scrolledY(8), scrolledX(8))
  val nametableBase = MuxLookup(nametableSelect, 0x2000.U, Seq(
    0.U -> 0x2000.U,
    1.U -> 0x2400.U,
    2.U -> 0x2800.U,
    3.U -> 0x2C00.U
  ))
  
  // Tile 数据缓存
  val tileIndex = RegInit(0.U(8.W))
  val attributeByte = RegInit(0.U(8.W))
  val patternLow = RegInit(0.U(8.W))
  val patternHigh = RegInit(0.U(8.W))
  
  // Nametable 地址: base + (tileY * 32) + tileX
  val nametableAddr = nametableBase + ((tileY & 0x1F.U) << 5) + (tileX & 0x1F.U)
  
  // 属性表地址: base + $3C0 + (tileY / 4) * 8 + (tileX / 4)
  val attrX = tileX >> 2
  val attrY = tileY >> 2
  val attributeAddr = nametableBase + 0x3C0.U + (attrY << 3) + attrX
  
  // Pattern table 基地址 (PPUCTRL bit 4)
  val patternTableBase = Mux(io.ppuCtrl(4), 0x1000.U, 0x0000.U)
  
  // 简化的流水线 - 预取下一个 tile
  val nextTileX = RegInit(0.U(5.W))
  val nextTileY = RegInit(0.U(5.W))
  
  // 当前渲染的像素数据
  val shiftRegLow = RegInit(0.U(8.W))
  val shiftRegHigh = RegInit(0.U(8.W))
  val attrLatch = RegInit(0.U(2.W))
  
  // 默认输出
  io.vramAddr := nametableAddr
  io.patternAddr := patternTableBase + (tileIndex << 4) + fineY
  
  // 状态机
  switch(state) {
    is(sFetchNametable) {
      io.vramAddr := nametableAddr
      tileIndex := io.vramData
      state := sFetchAttribute
    }
    is(sFetchAttribute) {
      io.vramAddr := attributeAddr
      attributeByte := io.vramData
      state := sFetchPatternLow
    }
    is(sFetchPatternLow) {
      io.patternAddr := patternTableBase + (tileIndex << 4) + fineY
      patternLow := io.patternData
      state := sFetchPatternHigh
    }
    is(sFetchPatternHigh) {
      io.patternAddr := patternTableBase + (tileIndex << 4) + fineY + 8.U
      patternHigh := io.patternData
      shiftRegLow := io.patternData  // 加载到移位寄存器
      shiftRegHigh := patternHigh
      state := sRender
    }
    is(sRender) {
      // 每个周期渲染一个像素
      state := sFetchNametable
    }
  }
  
  // 从属性字节中提取调色板选择
  // 属性字节格式: [右下][左下][右上][左上]，每个 2 位
  val quadrantX = tileX(1)
  val quadrantY = tileY(1)
  val attrShift = Cat(quadrantY, quadrantX) << 1
  val paletteSelectBits = (attributeByte >> attrShift)(1, 0)
  
  // 从移位寄存器中提取像素
  val pixelBit = 7.U - fineX
  val pixelLow = (patternLow >> pixelBit)(0)
  val pixelHigh = (patternHigh >> pixelBit)(0)
  val pixel = Cat(pixelHigh, pixelLow)
  
  // 输出
  io.paletteIndex := pixel
  io.paletteSelect := paletteSelectBits
  io.valid := io.showBackground && io.pixelX < 256.U && io.pixelY < 240.U && pixel =/= 0.U
}

// 精灵渲染器 - 完整实现
class SpriteRenderer extends Module {
  val io = IO(new Bundle {
    // 当前像素位置
    val pixelX = Input(UInt(9.W))
    val pixelY = Input(UInt(9.W))
    
    // PPU 控制
    val ppuCtrl = Input(UInt(8.W))
    val showSprites = Input(Bool())
    
    // OAM 访问
    val oamAddr = Output(UInt(8.W))
    val oamData = Input(UInt(8.W))
    
    // Pattern table 访问
    val patternAddr = Output(UInt(13.W))
    val patternData = Input(UInt(8.W))
    
    // 输出
    val paletteIndex = Output(UInt(2.W))
    val paletteSelect = Output(UInt(2.W))
    val priority = Output(Bool())  // 0 = 前景, 1 = 背景后面
    val sprite0Hit = Output(Bool())
    val spriteOverflow = Output(Bool())  // 精灵溢出标志
    val valid = Output(Bool())
  })
  
  // 精灵数据结构
  class SpriteData extends Bundle {
    val y = UInt(8.W)
    val tileIndex = UInt(8.W)
    val attributes = UInt(8.W)
    val x = UInt(8.W)
    val patternLow = UInt(8.W)
    val patternHigh = UInt(8.W)
    val isSprite0 = Bool()
  }
  
  // 次级 OAM (Secondary OAM) - 最多 8 个精灵
  val spriteCount = RegInit(0.U(4.W))
  val spriteBuffer = Reg(Vec(8, new SpriteData))
  
  // 精灵评估状态机
  val sIdle :: sEvaluate :: sFetch :: sRender :: Nil = Enum(4)
  val evalState = RegInit(sIdle)
  val evalIndex = RegInit(0.U(6.W))  // 0-63 个精灵
  val fetchIndex = RegInit(0.U(3.W))  // 0-7 个精灵
  
  // 精灵大小 (PPUCTRL bit 5: 0=8x8, 1=8x16)
  val spriteHeight = Mux(io.ppuCtrl(5), 16.U, 8.U)
  val sprite8x16Mode = io.ppuCtrl(5)
  
  // Pattern table 基地址 (PPUCTRL bit 3 for sprites, 仅用于 8x8 模式)
  val patternTableBase = Mux(io.ppuCtrl(3), 0x1000.U, 0x0000.U)
  
  // 精灵溢出标志
  val spriteOverflow = RegInit(false.B)
  
  // 精灵评估 - 在扫描线 256-320 期间进行
  when(io.pixelX === 256.U) {
    // 开始评估下一条扫描线的精灵
    evalState := sEvaluate
    evalIndex := 0.U
    spriteCount := 0.U
    spriteOverflow := false.B  // 重置溢出标志
  }
  
  // OAM 评估状态机
  switch(evalState) {
    is(sIdle) {
      // 等待扫描线结束
    }
    is(sEvaluate) {
      // 读取精灵 Y 坐标
      io.oamAddr := evalIndex << 2
      val spriteY = io.oamData
      val nextY = io.pixelY + 1.U
      
      // 检查精灵是否在下一条扫描线上
      val inRange = (nextY >= spriteY) && (nextY < (spriteY + spriteHeight))
      
      when(inRange) {
        when(spriteCount < 8.U) {
          // 添加到次级 OAM
          val sprite = spriteBuffer(spriteCount)
          sprite.y := spriteY
          sprite.isSprite0 := evalIndex === 0.U
          
          // 读取其他字节
          io.oamAddr := (evalIndex << 2) + 1.U
          sprite.tileIndex := io.oamData
          io.oamAddr := (evalIndex << 2) + 2.U
          sprite.attributes := io.oamData
          io.oamAddr := (evalIndex << 2) + 3.U
          sprite.x := io.oamData
          
          spriteCount := spriteCount + 1.U
        }.otherwise {
          // 超过 8 个精灵，设置溢出标志
          spriteOverflow := true.B
        }
      }
      
      evalIndex := evalIndex + 1.U
      when(evalIndex === 63.U) {
        evalState := sFetch
        fetchIndex := 0.U
      }
    }
    is(sFetch) {
      // 预取精灵 pattern 数据
      when(fetchIndex < spriteCount) {
        val sprite = spriteBuffer(fetchIndex)
        val spriteY = io.pixelY - sprite.y
        
        // 垂直翻转 (attributes bit 7)
        val actualY = Mux(sprite.attributes(7), 
          spriteHeight - 1.U - spriteY,
          spriteY
        )
        
        // Pattern 地址计算
        val patternAddr = Wire(UInt(13.W))
        when(sprite8x16Mode) {
          // 8x16 模式: tile index bit 0 选择 pattern table
          // bit 7-1 选择 tile pair
          val patternTable = Mux(sprite.tileIndex(0), 0x1000.U, 0x0000.U)
          val tileNum = sprite.tileIndex & 0xFE.U  // 清除 bit 0
          val isBottomHalf = actualY >= 8.U
          val tileOffset = Mux(isBottomHalf, 1.U, 0.U)
          val yOffset = Mux(isBottomHalf, actualY - 8.U, actualY)
          patternAddr := patternTable + ((tileNum + tileOffset) << 4) + yOffset
        }.otherwise {
          // 8x8 模式: 使用 PPUCTRL bit 3
          patternAddr := patternTableBase + (sprite.tileIndex << 4) + actualY
        }
        
        io.patternAddr := patternAddr
        sprite.patternLow := io.patternData
        
        io.patternAddr := patternAddr + 8.U
        sprite.patternHigh := io.patternData
        
        fetchIndex := fetchIndex + 1.U
      }.otherwise {
        evalState := sRender
      }
    }
    is(sRender) {
      // 渲染阶段
      when(io.pixelX === 0.U) {
        evalState := sIdle
      }
    }
  }
  
  // 渲染当前像素 - 使用寄存器避免组合环路
  val outPaletteIndex = WireDefault(0.U(2.W))
  val outPaletteSelect = WireDefault(0.U(2.W))
  val outPriority = WireDefault(false.B)
  val outSprite0Hit = WireDefault(false.B)
  val outValid = WireDefault(false.B)
  
  io.oamAddr := 0.U
  io.patternAddr := 0.U
  
  // 遍历精灵缓冲区 (优先级从高到低)
  var foundSprite = false.B
  for (i <- 0 until 8) {
    val sprite = spriteBuffer(i)
    val inRangeX = io.pixelX >= sprite.x && io.pixelX < (sprite.x + 8.U)
    
    when(inRangeX && i.U < spriteCount && !foundSprite) {
      // 计算精灵内的像素位置
      val spriteX = io.pixelX - sprite.x
      
      // 水平翻转 (attributes bit 6)
      val actualX = Mux(sprite.attributes(6), 
        7.U - spriteX,
        spriteX
      )
      
      // 提取像素
      val pixelBit = 7.U - actualX
      val pixelLow = (sprite.patternLow >> pixelBit)(0)
      val pixelHigh = (sprite.patternHigh >> pixelBit)(0)
      val pixel = Cat(pixelHigh, pixelLow)
      
      when(pixel =/= 0.U) {
        outPaletteIndex := pixel
        outPaletteSelect := sprite.attributes(1, 0)  // 调色板选择
        outPriority := sprite.attributes(5)  // Bit 5 = priority
        outSprite0Hit := sprite.isSprite0
        outValid := io.showSprites
        foundSprite = true.B
      }
    }
  }
  
  io.paletteIndex := outPaletteIndex
  io.paletteSelect := outPaletteSelect
  io.priority := outPriority
  io.sprite0Hit := outSprite0Hit
  io.spriteOverflow := spriteOverflow
  io.valid := outValid
}

// 调色板查找 - 完整实现
class PaletteLookup extends Module {
  val io = IO(new Bundle {
    // 背景输入
    val bgPaletteIndex = Input(UInt(2.W))
    val bgPaletteSelect = Input(UInt(2.W))
    val bgValid = Input(Bool())
    
    // 精灵输入
    val spritePaletteIndex = Input(UInt(2.W))
    val spritePaletteSelect = Input(UInt(2.W))
    val spritePriority = Input(Bool())
    val spriteValid = Input(Bool())
    val sprite0Hit = Input(Bool())
    
    // 调色板 RAM 访问
    val paletteAddr = Output(UInt(5.W))
    val paletteData = Input(UInt(6.W))
    
    // 输出
    val colorOut = Output(UInt(6.W))
    val sprite0HitOut = Output(Bool())
  })
  
  // 优先级逻辑
  // 1. 如果背景和精灵都透明，使用背景色
  // 2. 如果只有背景不透明，使用背景
  // 3. 如果只有精灵不透明，使用精灵
  // 4. 如果都不透明，根据精灵优先级决定
  val useSprite = io.spriteValid && (!io.spritePriority || !io.bgValid)
  val useBg = io.bgValid && (!io.spriteValid || io.spritePriority)
  
  // Sprite 0 碰撞检测
  // 当背景和精灵 0 都不透明时发生
  io.sprite0HitOut := io.sprite0Hit && io.bgValid && io.spriteValid
  
  // 选择调色板地址
  when(useSprite) {
    // 精灵调色板: $3F10 + paletteSelect * 4 + paletteIndex
    // paletteSelect (0-3) 选择 4 个精灵调色板之一
    // paletteIndex (0-3) 选择调色板内的颜色
    io.paletteAddr := Cat(1.U(1.W), io.spritePaletteSelect, io.spritePaletteIndex)
  }.elsewhen(useBg) {
    // 背景调色板: $3F00 + paletteSelect * 4 + paletteIndex
    io.paletteAddr := Cat(0.U(1.W), io.bgPaletteSelect, io.bgPaletteIndex)
  }.otherwise {
    // 背景色 (universal background): $3F00
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
    
    // PPU 控制
    val ppuCtrl = Input(UInt(8.W))
    val ppuMask = Input(UInt(8.W))
    
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
    val sprite0Hit = Output(Bool())
    val spriteOverflow = Output(Bool())
  })
  
  // 从 PPUMASK 提取渲染使能标志
  val showBackground = io.ppuMask(3)
  val showSprites = io.ppuMask(4)
  val showBgLeft = io.ppuMask(1)  // 显示最左 8 像素的背景
  val showSpritesLeft = io.ppuMask(2)  // 显示最左 8 像素的精灵
  
  // 实例化渲染器
  val bgRenderer = Module(new BackgroundRenderer)
  val spriteRenderer = Module(new SpriteRenderer)
  val paletteLookup = Module(new PaletteLookup)
  
  // 连接背景渲染器
  bgRenderer.io.pixelX := io.pixelX
  bgRenderer.io.pixelY := io.pixelY
  bgRenderer.io.scrollX := io.scrollX
  bgRenderer.io.scrollY := io.scrollY
  bgRenderer.io.ppuCtrl := io.ppuCtrl
  bgRenderer.io.showBackground := showBackground && (showBgLeft || io.pixelX >= 8.U)
  bgRenderer.io.vramData := io.vramData
  bgRenderer.io.patternData := io.patternData
  
  // 连接精灵渲染器
  spriteRenderer.io.pixelX := io.pixelX
  spriteRenderer.io.pixelY := io.pixelY
  spriteRenderer.io.ppuCtrl := io.ppuCtrl
  spriteRenderer.io.showSprites := showSprites && (showSpritesLeft || io.pixelX >= 8.U)
  spriteRenderer.io.oamData := io.oamData
  spriteRenderer.io.patternData := io.patternData
  
  // 连接调色板查找
  paletteLookup.io.bgPaletteIndex := bgRenderer.io.paletteIndex
  paletteLookup.io.bgPaletteSelect := bgRenderer.io.paletteSelect
  paletteLookup.io.bgValid := bgRenderer.io.valid
  paletteLookup.io.spritePaletteIndex := spriteRenderer.io.paletteIndex
  paletteLookup.io.spritePaletteSelect := spriteRenderer.io.paletteSelect
  paletteLookup.io.spritePriority := spriteRenderer.io.priority
  paletteLookup.io.spriteValid := spriteRenderer.io.valid
  paletteLookup.io.sprite0Hit := spriteRenderer.io.sprite0Hit
  paletteLookup.io.paletteData := io.paletteData
  
  // 输出
  io.colorOut := paletteLookup.io.colorOut
  io.sprite0Hit := paletteLookup.io.sprite0HitOut
  io.spriteOverflow := spriteRenderer.io.spriteOverflow
  
  // 内存访问仲裁
  // 使用时分复用策略：不同的周期访问不同的内存
  val memCycle = RegInit(0.U(2.W))
  memCycle := memCycle + 1.U
  
  // 默认值
  io.vramAddr := 0.U
  io.oamAddr := 0.U
  io.paletteAddr := paletteLookup.io.paletteAddr
  io.patternAddr := 0.U
  
  // 根据周期选择内存访问
  switch(memCycle) {
    is(0.U) {
      // 背景 VRAM 访问
      io.vramAddr := bgRenderer.io.vramAddr
    }
    is(1.U) {
      // 背景 Pattern 访问
      io.patternAddr := bgRenderer.io.patternAddr
    }
    is(2.U) {
      // 精灵 OAM 访问
      io.oamAddr := spriteRenderer.io.oamAddr
    }
    is(3.U) {
      // 精灵 Pattern 访问
      io.patternAddr := spriteRenderer.io.patternAddr
    }
  }
}
