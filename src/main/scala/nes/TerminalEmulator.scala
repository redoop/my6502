package nes

import java.nio.file.{Files, Paths}
import scala.io.StdIn
import java.io.{BufferedReader, InputStreamReader}

/**
 * 终端 NES 模拟器
 * 
 * 使用 ANSI 转义序列在终端中显示游戏画面
 * 支持 256 色终端
 */
object TerminalEmulator {
  
  // ANSI 转义序列
  val ANSI_CLEAR = "\u001b[2J"
  val ANSI_HOME = "\u001b[H"
  val ANSI_HIDE_CURSOR = "\u001b[?25l"
  val ANSI_SHOW_CURSOR = "\u001b[?25h"
  val ANSI_RESET = "\u001b[0m"
  
  // 改进的 NES 调色板到 ANSI 256 色的映射
  // 基于实际 NES 调色板的 RGB 值进行更精确的映射
  val NES_TO_ANSI = Array(
    // 0x00-0x0F (灰度和深色)
    16, 17, 18, 19, 20, 21, 57, 93, 129, 165, 201, 207, 208, 16, 16, 16,
    // 0x10-0x1F (蓝紫色系)
    235, 27, 33, 39, 45, 51, 87, 123, 159, 195, 231, 229, 228, 16, 16, 16,
    // 0x20-0x2F (绿色系)
    255, 46, 82, 118, 154, 190, 226, 220, 214, 208, 202, 196, 160, 240, 16, 16,
    // 0x30-0x3F (红色系)
    255, 226, 220, 214, 208, 202, 196, 160, 124, 88, 52, 22, 28, 255, 16, 16
  )
  
  // 像素字符 (使用 Unicode 方块字符)
  val PIXEL_FULL = "█"
  val PIXEL_HALF_UPPER = "▀"  // 上半部分
  val PIXEL_HALF_LOWER = "▄"  // 下半部分
  val PIXEL_EMPTY = " "
  
  // 更精确的 NES 调色板 RGB 值 (用于更好的颜色匹配)
  val NES_PALETTE_RGB = Array(
    (84, 84, 84), (0, 30, 116), (8, 16, 144), (48, 0, 136),
    (68, 0, 100), (92, 0, 48), (84, 4, 0), (60, 24, 0),
    (32, 42, 0), (8, 58, 0), (0, 64, 0), (0, 60, 0),
    (0, 50, 60), (0, 0, 0), (0, 0, 0), (0, 0, 0),
    
    (152, 150, 152), (8, 76, 196), (48, 50, 236), (92, 30, 228),
    (136, 20, 176), (160, 20, 100), (152, 34, 32), (120, 60, 0),
    (84, 90, 0), (40, 114, 0), (8, 124, 0), (0, 118, 40),
    (0, 102, 120), (0, 0, 0), (0, 0, 0), (0, 0, 0),
    
    (236, 238, 236), (76, 154, 236), (120, 124, 236), (176, 98, 236),
    (228, 84, 236), (236, 88, 180), (236, 106, 100), (212, 136, 32),
    (160, 170, 0), (116, 196, 0), (76, 208, 32), (56, 204, 108),
    (56, 180, 204), (60, 60, 60), (0, 0, 0), (0, 0, 0),
    
    (236, 238, 236), (168, 204, 236), (188, 188, 236), (212, 178, 236),
    (236, 174, 236), (236, 174, 212), (236, 180, 176), (228, 196, 144),
    (204, 210, 120), (180, 222, 120), (168, 226, 144), (152, 226, 180),
    (160, 214, 228), (160, 162, 160), (0, 0, 0), (0, 0, 0)
  )
  
  /**
   * 将 RGB 颜色转换为最接近的 ANSI 256 色
   */
  def rgbToAnsi256(r: Int, g: Int, b: Int): Int = {
    // 灰度检测
    if (Math.abs(r - g) < 10 && Math.abs(g - b) < 10 && Math.abs(r - b) < 10) {
      val gray = (r + g + b) / 3
      if (gray < 8) return 16
      if (gray > 247) return 231
      return 232 + ((gray - 8) * 24 / 240)
    }
    
    // 6x6x6 颜色立方体
    val r6 = if (r < 48) 0 else if (r < 115) 1 else ((r - 35) / 40).min(5)
    val g6 = if (g < 48) 0 else if (g < 115) 1 else ((g - 35) / 40).min(5)
    val b6 = if (b < 48) 0 else if (b < 115) 1 else ((b - 35) / 40).min(5)
    
    16 + 36 * r6 + 6 * g6 + b6
  }
  
  // 预计算 NES 调色板到 ANSI 的映射
  val NES_TO_ANSI_IMPROVED = NES_PALETTE_RGB.map { case (r, g, b) => 
    rgbToAnsi256(r, g, b)
  }
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: TerminalEmulator <rom文件>")
      println("示例: TerminalEmulator games/contra.nes")
      System.exit(1)
    }
    
    val romPath = args(0)
    println(s"🎮 加载 ROM: $romPath")
    
    // 加载 ROM
    val romData = Files.readAllBytes(Paths.get(romPath))
    println(s"   ROM 大小: ${romData.length} bytes")
    
    // 解析 ROM 头
    if (romData.length < 16) {
      println("❌ ROM 文件太小")
      System.exit(1)
    }
    
    val header = romData.take(16)
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      println("❌ 不是有效的 NES ROM 文件")
      System.exit(1)
    }
    
    val mapper = ((header(6) >> 4) & 0x0F) | (header(7) & 0xF0)
    println(s"   Mapper: $mapper")
    println()
    
    // 启动模拟器
    val emulator = new TerminalNESEmulator(romData)
    emulator.run()
  }
}

/**
 * 终端 NES 模拟器类
 */
class TerminalNESEmulator(romData: Array[Byte]) {
  
  import TerminalEmulator._
  
  private val WIDTH = 256
  private val HEIGHT = 240
  // 使用半字符提高垂直分辨率 (每个字符显示2个像素)
  private val SCALE_X = 1  // 水平缩放
  private val SCALE_Y = 2  // 垂直缩放 (使用半字符)
  
  private val displayWidth = WIDTH / SCALE_X
  private val displayHeight = HEIGHT / SCALE_Y
  
  // 帧缓冲
  private val framebuffer = Array.ofDim[Int](WIDTH, HEIGHT)
  
  // 控制器状态
  private var controller1 = 0
  private var running = true
  private var paused = false
  
  // ROM 数据
  private val header = romData.take(16)
  private val prgSize = header(4) * 16384
  private val chrSize = header(5) * 8192
  private val hasCHR = chrSize > 0
  
  // CHR ROM 数据 (图形数据)
  private val chrROM = if (hasCHR) {
    romData.slice(16 + prgSize, 16 + prgSize + chrSize)
  } else {
    Array.ofDim[Byte](8192) // 使用 CHR RAM
  }
  
  /**
   * 运行模拟器
   */
  def run(): Unit = {
    println("🚀 启动终端模拟器...")
    println()
    println("控制说明:")
    println("  W/A/S/D - 方向键")
    println("  J - A 按钮")
    println("  K - B 按钮")
    println("  U - SELECT")
    println("  I - START")
    println("  P - 暂停/继续")
    println("  Q - 退出")
    println()
    println("按 Enter 开始...")
    StdIn.readLine()
    
    // 隐藏光标
    print(ANSI_HIDE_CURSOR)
    
    // 启动输入线程
    val inputThread = new Thread(() => handleInput())
    inputThread.setDaemon(true)
    inputThread.start()
    
    try {
      runEmulatorLoop()
    } finally {
      // 恢复光标
      print(ANSI_SHOW_CURSOR)
      print(ANSI_RESET)
      println()
    }
  }
  
  /**
   * 模拟器主循环 (演示模式 - 显示 CHR 图形数据)
   */
  private def runEmulatorLoop(): Unit = {
    println("🎮 模拟器运行中 (演示模式)...")
    println("   显示 ROM 中的图形数据 (CHR ROM)")
    println(s"   CHR 大小: $chrSize bytes")
    println()
    
    var frameCount = 0
    var tileOffset = 0
    val startTime = System.currentTimeMillis()
    
    // 初始化显示
    drawCHRTiles(tileOffset)
    
    // 主循环
    while (running) {
      if (!paused) {
        // 每 60 帧切换显示的图块
        if (frameCount % 60 == 0 && hasCHR) {
          tileOffset = (tileOffset + 32) % (chrSize / 16)
          drawCHRTiles(tileOffset)
        }
        
        // 渲染到终端
        renderFrame()
        
        frameCount += 1
        
        // 显示状态
        if (frameCount % 60 == 0) {
          val elapsed = (System.currentTimeMillis() - startTime) / 1000.0
          val fps = frameCount / elapsed
          displayStatus(frameCount, fps, tileOffset)
        }
        
        // 限制帧率
        Thread.sleep(33)  // ~30 FPS
      } else {
        Thread.sleep(100)
      }
    }
  }
  
  /**
   * 绘制 CHR ROM 图块到帧缓冲
   * NES 图块格式: 8x8 像素，每个图块 16 字节
   */
  private def drawCHRTiles(startTile: Int): Unit = {
    if (!hasCHR) {
      // 没有 CHR ROM，显示提示信息
      drawNoChRMessage()
      return
    }
    
    val tilesPerRow = 32  // 每行显示 32 个图块
    val tilesPerCol = 30  // 每列显示 30 个图块
    
    for (tileY <- 0 until tilesPerCol) {
      for (tileX <- 0 until tilesPerRow) {
        val tileIndex = startTile + tileY * tilesPerRow + tileX
        if (tileIndex * 16 < chrSize) {
          drawTile(tileX * 8, tileY * 8, tileIndex)
        }
      }
    }
  }
  
  /**
   * 绘制单个 8x8 图块（使用边缘检测）
   * NES 图块格式:
   * - 16 字节/图块
   * - 前 8 字节: 低位平面
   * - 后 8 字节: 高位平面
   * - 每个像素 2 位颜色索引 (0-3)
   */
  private def drawTile(x: Int, y: Int, tileIndex: Int): Unit = {
    val tileAddr = tileIndex * 16
    if (tileAddr + 16 > chrSize) return
    
    // 先提取图块数据到临时数组
    val tileData = Array.ofDim[Int](8, 8)
    for (row <- 0 until 8) {
      val lowByte = chrROM(tileAddr + row) & 0xFF
      val highByte = chrROM(tileAddr + row + 8) & 0xFF
      
      for (col <- 0 until 8) {
        val bit = 7 - col
        val lowBit = (lowByte >> bit) & 1
        val highBit = (highByte >> bit) & 1
        tileData(row)(col) = (highBit << 1) | lowBit
      }
    }
    
    // 绘制边缘轮廓
    for (row <- 0 until 8) {
      for (col <- 0 until 8) {
        val px = x + col
        val py = y + row
        
        if (px >= WIDTH || py >= HEIGHT) {
          // 跳过越界
        } else {
          val current = tileData(row)(col)
          
          if (current > 0) {
            // 检测边缘：如果相邻像素是背景色(0)，则绘制边缘
            val hasTop = row == 0 || tileData(row - 1)(col) == 0
            val hasBottom = row == 7 || tileData(row + 1)(col) == 0
            val hasLeft = col == 0 || tileData(row)(col - 1) == 0
            val hasRight = col == 7 || tileData(row)(col + 1) == 0
            
            // 根据边缘情况选择颜色索引
            if (hasTop || hasBottom || hasLeft || hasRight) {
              // 边缘像素 - 使用亮色
              framebuffer(px)(py) = 0x30  // 白色
            } else {
              // 内部像素 - 使用暗色
              framebuffer(px)(py) = 0x10  // 灰色
            }
          } else {
            // 背景
            framebuffer(px)(py) = 0x0F  // 黑色
          }
        }
      }
    }
  }
  
  /**
   * 显示无 CHR ROM 的提示信息
   */
  private def drawNoChRMessage(): Unit = {
    // 清空为黑色
    for (y <- 0 until HEIGHT) {
      for (x <- 0 until WIDTH) {
        framebuffer(x)(y) = 0x0F
      }
    }
    
    // 绘制一些彩色条纹作为背景
    for (y <- 0 until HEIGHT) {
      for (x <- 0 until WIDTH) {
        if ((y / 20) % 2 == 0) {
          framebuffer(x)(y) = ((x / 32) % 4) * 16
        }
      }
    }
  }
  
  /**
   * 渲染帧到终端 (使用半字符提高分辨率)
   */
  private def renderFrame(): Unit = {
    val sb = new StringBuilder()
    
    // 清屏并回到开头
    sb.append(ANSI_CLEAR)
    sb.append(ANSI_HOME)
    
    // 渲染每一行 (每个字符显示2个垂直像素)
    for (y <- 0 until displayHeight) {
      for (x <- 0 until displayWidth) {
        // 采样上下两个像素
        val srcX = x * SCALE_X
        val srcY = y * SCALE_Y
        
        val upperColorIndex = framebuffer(srcX)(srcY).min(63)
        val lowerColorIndex = if (srcY + 1 < HEIGHT) 
          framebuffer(srcX)(srcY + 1).min(63) 
        else upperColorIndex
        
        // 转换为 ANSI 颜色
        val upperAnsi = NES_TO_ANSI_IMPROVED(upperColorIndex)
        val lowerAnsi = NES_TO_ANSI_IMPROVED(lowerColorIndex)
        
        // 如果上下颜色相同，使用全字符
        if (upperAnsi == lowerAnsi) {
          sb.append(s"\u001b[48;5;${upperAnsi}m$PIXEL_FULL")
        } else {
          // 使用半字符：前景色为下半部分，背景色为上半部分
          sb.append(s"\u001b[38;5;${lowerAnsi}m\u001b[48;5;${upperAnsi}m$PIXEL_HALF_LOWER")
        }
      }
      sb.append(ANSI_RESET)
      sb.append("\n")
    }
    
    print(sb.toString())
  }
  
  /**
   * 显示状态信息
   */
  private def displayStatus(frame: Int, fps: Double, tileOffset: Int): Unit = {
    print(ANSI_RESET)
    println()
    println(f"帧数: $frame%6d | FPS: $fps%5.1f | 图块偏移: $tileOffset%4d | ${if (paused) "暂停" else "运行"} | 按 Q 退出")
  }
  
  /**
   * 处理键盘输入
   */
  private def handleInput(): Unit = {
    val reader = new BufferedReader(new InputStreamReader(System.in))
    
    // 设置终端为原始模式 (非阻塞输入)
    val commands = Array(
      "/bin/sh",
      "-c",
      "stty raw -echo < /dev/tty"
    )
    Runtime.getRuntime().exec(commands).waitFor()
    
    try {
      while (running) {
        if (System.in.available() > 0) {
          val ch = System.in.read().toChar.toLower
          
          ch match {
            // 方向键
            case 'w' => controller1 |= 0x10  // UP
            case 's' => controller1 |= 0x20  // DOWN
            case 'a' => controller1 |= 0x40  // LEFT
            case 'd' => controller1 |= 0x80  // RIGHT
            
            // 按钮
            case 'j' => controller1 |= 0x01  // A
            case 'k' => controller1 |= 0x02  // B
            case 'u' => controller1 |= 0x04  // SELECT
            case 'i' => controller1 |= 0x08  // START
            
            // 控制
            case 'p' => paused = !paused
            case 'q' => running = false
            
            case _ =>
          }
          
          // 按键释放 (简化处理)
          Thread.sleep(50)
          controller1 = 0
        }
        Thread.sleep(10)
      }
    } finally {
      // 恢复终端设置
      val restoreCommands = Array(
        "/bin/sh",
        "-c",
        "stty sane < /dev/tty"
      )
      Runtime.getRuntime().exec(restoreCommands).waitFor()
    }
  }
}

/**
 * 简化版终端模拟器 (不需要 ChiselTest)
 */
object SimpleTerminalEmulator {
  
  import TerminalEmulator._
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: SimpleTerminalEmulator <rom文件>")
      System.exit(1)
    }
    
    val romPath = args(0)
    println(s"🎮 加载 ROM: $romPath")
    
    // 加载 ROM
    val romData = Files.readAllBytes(Paths.get(romPath))
    val header = romData.take(16)
    
    if (header(0) != 'N' || header(1) != 'E' || header(2) != 'S' || header(3) != 0x1A) {
      println("❌ 不是有效的 NES ROM 文件")
      System.exit(1)
    }
    
    val mapper = ((header(6) >> 4) & 0x0F) | (header(7) & 0xF0)
    println(s"   Mapper: $mapper")
    println()
    
    println("🚀 启动演示模式...")
    println("   (显示测试图案)")
    println()
    println("按 Enter 开始...")
    StdIn.readLine()
    
    // 隐藏光标
    print(ANSI_HIDE_CURSOR)
    
    try {
      runDemo()
    } finally {
      // 恢复光标
      print(ANSI_SHOW_CURSOR)
      print(ANSI_RESET)
      println()
    }
  }
  
  /**
   * 运行演示 (改进版，使用半字符和更好的颜色)
   */
  private def runDemo(): Unit = {
    val WIDTH = 256
    val HEIGHT = 240
    
    var frame = 0
    var running = true
    
    // 启动输入监听
    val inputThread = new Thread(() => {
      StdIn.readLine()
      running = false
    })
    inputThread.setDaemon(true)
    inputThread.start()
    
    println("按 Enter 退出...")
    println()
    
    while (running && frame < 300) {
      val sb = new StringBuilder()
      
      // 清屏
      sb.append(ANSI_CLEAR)
      sb.append(ANSI_HOME)
      
      // 绘制改进的测试图案 (使用半字符)
      for (y <- 0 until HEIGHT / 2) {
        for (x <- 0 until WIDTH) {
          // 上下两个像素
          val y1 = y * 2
          val y2 = y * 2 + 1
          
          // 创建更有趣的图案
          val colorIndex1 = ((x + frame) / 4 + (y1 + frame / 2) / 4) % 64
          val colorIndex2 = ((x + frame) / 4 + (y2 + frame / 2) / 4) % 64
          
          val ansiColor1 = NES_TO_ANSI_IMPROVED(colorIndex1)
          val ansiColor2 = NES_TO_ANSI_IMPROVED(colorIndex2)
          
          // 使用半字符
          if (ansiColor1 == ansiColor2) {
            sb.append(s"\u001b[48;5;${ansiColor1}m$PIXEL_FULL")
          } else {
            sb.append(s"\u001b[38;5;${ansiColor2}m\u001b[48;5;${ansiColor1}m$PIXEL_HALF_LOWER")
          }
        }
        sb.append(ANSI_RESET)
        sb.append("\n")
      }
      
      // 显示信息
      sb.append(ANSI_RESET)
      sb.append(f"\n帧数: $frame%4d | 按 Enter 退出\n")
      
      print(sb.toString())
      
      frame += 1
      Thread.sleep(33)  // ~30 FPS
    }
  }
}
