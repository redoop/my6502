package nes

import java.nio.file.{Files, Paths}

/**
 * 文本显示 NES 模拟器
 * 
 * 使用 ASCII 字符显示游戏画面
 * 适合无 GUI 环境
 */
object TextDisplay {
  
  // ASCII 字符集 (从暗到亮)
  val ASCII_CHARS = " .'`^\",:;Il!i><~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$"
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: TextDisplay <rom文件>")
      System.exit(1)
    }
    
    val romPath = args(0)
    
    println("=" * 80)
    println("🎮 NES 文本显示模拟器")
    println("=" * 80)
    println()
    
    // 加载并分析 ROM
    val romData = Files.readAllBytes(Paths.get(romPath))
    val header = romData.take(16)
    
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      println("❌ 不是有效的 NES ROM 文件")
      System.exit(1)
    }
    
    val prgBanks = header(4) & 0xFF
    val chrBanks = header(5) & 0xFF
    val mapper = ((header(6) >> 4) & 0x0F) | (header(7) & 0xF0)
    
    println(s"📁 ROM: $romPath")
    println(s"📊 Mapper: $mapper")
    println(s"📦 PRG: ${prgBanks * 16}KB, CHR: ${chrBanks * 8}KB")
    println()
    
    // 显示测试画面
    println("🎨 测试画面 (64x32):")
    println("-" * 80)
    displayTestPattern()
    println("-" * 80)
    println()
    
    // 显示 CHR ROM 图案
    if (chrBanks > 0) {
      println("🎨 CHR ROM 图案预览:")
      println("-" * 80)
      displayCHRPattern(romData, prgBanks)
      println("-" * 80)
      println()
    }
    
    // 显示控制说明
    println("🎮 模拟器功能:")
    println("  ✅ ROM 加载和解析")
    println("  ✅ 文本模式显示")
    println("  ✅ CHR ROM 可视化")
    println("  🚧 完整模拟 (需要 Verilator)")
    println()
    
    println("💡 提示:")
    println("  要运行完整的模拟器，请使用:")
    println("  - Verilator 方案 (见 docs/EMULATOR_GUIDE.md)")
    println("  - FPGA 部署 (见 docs/FPGA_GUIDE.md)")
    println()
    
    println("=" * 80)
  }
  
  /**
   * 显示测试图案
   */
  def displayTestPattern(): Unit = {
    val width = 64
    val height = 32
    
    for (y <- 0 until height) {
      for (x <- 0 until width) {
        // 生成渐变图案
        val value = ((x * 64 / width) + (y * 64 / height)) / 2
        val charIndex = (value * ASCII_CHARS.length / 64).min(ASCII_CHARS.length - 1)
        print(ASCII_CHARS.charAt(charIndex))
      }
      println()
    }
  }
  
  /**
   * 显示 CHR ROM 图案
   */
  def displayCHRPattern(romData: Array[Byte], prgBanks: Int): Unit = {
    val prgSize = prgBanks * 16384
    val chrStart = 16 + prgSize
    
    if (chrStart + 128 > romData.length) {
      println("  (CHR ROM 数据不足)")
      return
    }
    
    // 显示前 8 个 tile (8x8 像素)
    for (tileRow <- 0 until 2) {
      for (pixelRow <- 0 until 8) {
        for (tileCol <- 0 until 4) {
          val tileIndex = tileRow * 4 + tileCol
          val tileOffset = chrStart + tileIndex * 16
          
          if (tileOffset + 16 <= romData.length) {
            // 读取 tile 数据 (2 个 bitplane)
            val plane0 = romData(tileOffset + pixelRow) & 0xFF
            val plane1 = romData(tileOffset + pixelRow + 8) & 0xFF
            
            // 渲染 8 个像素
            for (pixelCol <- 0 until 8) {
              val bit = 7 - pixelCol
              val pixel0 = (plane0 >> bit) & 1
              val pixel1 = (plane1 >> bit) & 1
              val pixelValue = (pixel1 << 1) | pixel0
              
              // 转换为 ASCII
              val char = pixelValue match {
                case 0 => ' '
                case 1 => '░'
                case 2 => '▒'
                case 3 => '█'
                case _ => '?'
              }
              print(char)
            }
            print("  ")
          }
        }
        println()
      }
      println()
    }
  }
}

/**
 * 动画文本显示
 */
object AnimatedTextDisplay {
  
  import TextDisplay._
  
  def main(args: Array[String]): Unit = {
    println("🎮 NES 动画文本显示")
    println()
    println("显示 10 帧动画...")
    println()
    
    for (frame <- 0 until 10) {
      // 清屏 (简单版本)
      println("\n" * 3)
      println(s"帧 $frame:")
      println("-" * 64)
      
      // 显示动画帧
      displayAnimatedFrame(frame)
      
      println("-" * 64)
      Thread.sleep(200)
    }
    
    println()
    println("✅ 动画完成")
  }
  
  def displayAnimatedFrame(frame: Int): Unit = {
    val width = 64
    val height = 24
    
    for (y <- 0 until height) {
      for (x <- 0 until width) {
        // 动画效果
        val value = ((x + frame * 2) * 64 / width + (y + frame) * 64 / height) / 2
        val charIndex = (value * ASCII_CHARS.length / 64) % ASCII_CHARS.length
        print(ASCII_CHARS.charAt(charIndex))
      }
      println()
    }
  }
}
