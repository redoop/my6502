package nes

import java.nio.file.{Files, Paths}
import scala.io.StdIn
import java.io.{BufferedReader, InputStreamReader}

/**
 * 终端 NES 模拟器 - 轮廓线条版本
 * 
 * 只显示图形的边缘轮廓，不填充内部
 */
object TerminalEmulatorOutline {
  
  // ANSI 转义序列
  val ANSI_CLEAR = "\u001b[2J"
  val ANSI_HOME = "\u001b[H"
  val ANSI_HIDE_CURSOR = "\u001b[?25l"
  val ANSI_SHOW_CURSOR = "\u001b[?25h"
  val ANSI_RESET = "\u001b[0m"
  
  // NES 调色板 RGB 值
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
  
  def rgbToAnsi256(r: Int, g: Int, b: Int): Int = {
    if (Math.abs(r - g) < 10 && Math.abs(g - b) < 10 && Math.abs(r - b) < 10) {
      val gray = (r + g + b) / 3
      if (gray < 8) return 16
      if (gray > 247) return 231
      return 232 + ((gray - 8) * 24 / 240)
    }
    
    val r6 = if (r < 48) 0 else if (r < 115) 1 else ((r - 35) / 40).min(5)
    val g6 = if (g < 48) 0 else if (g < 115) 1 else ((g - 35) / 40).min(5)
    val b6 = if (b < 48) 0 else if (b < 115) 1 else ((b - 35) / 40).min(5)
    
    16 + 36 * r6 + 6 * g6 + b6
  }
  
  val NES_TO_ANSI_IMPROVED = NES_PALETTE_RGB.map { case (r, g, b) => 
    rgbToAnsi256(r, g, b)
  }
  
  val PIXEL_HALF_LOWER = "▄"
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: TerminalEmulatorOutline <rom文件>")
      System.exit(1)
    }
    
    val romPath = args(0)
    val romData = Files.readAllBytes(Paths.get(romPath))
    val emulator = new TerminalNESEmulatorOutline(romData)
    emulator.run()
  }
}

class TerminalNESEmulatorOutline(romData: Array[Byte]) {
  
  import TerminalEmulatorOutline._
  
  private val WIDTH = 256
  private val HEIGHT = 240
  private val SCALE_Y = 2
  
  private val displayWidth = WIDTH
  private val displayHeight = HEIGHT / SCALE_Y
  
  private val framebuffer = Array.ofDim[Int](WIDTH, HEIGHT)
  
  private var running = true
  private var paused = false
  
  private val header = romData.take(16)
  private val prgSize = header(4) * 16384
  private val chrSize = header(5) * 8192
  private val hasCHR = chrSize > 0
  
  private val chrROM = if (hasCHR) {
    romData.slice(16 + prgSize, 16 + prgSize + chrSize)
  } else {
    Array.ofDim[Byte](8192)
  }
  
  def run(): Unit = {
    println("🚀 启动轮廓线条模式...")
    println("   只显示图形边缘，不填充内部")
    println()
    println("按 Enter 开始...")
    StdIn.readLine()
    
    print(ANSI_HIDE_CURSOR)
    
    val inputThread = new Thread(() => handleInput())
    inputThread.setDaemon(true)
    inputThread.start()
    
    try {
      runEmulatorLoop()
    } finally {
      print(ANSI_SHOW_CURSOR)
      print(ANSI_RESET)
      println()
    }
  }
  
  private def runEmulatorLoop(): Unit = {
    var frameCount = 0
    var tileOffset = 0
    val startTime = System.currentTimeMillis()
    
    drawCHRTiles(tileOffset)
    
    while (running) {
      if (!paused) {
        if (frameCount % 60 == 0 && hasCHR) {
          tileOffset = (tileOffset + 32) % (chrSize / 16)
          drawCHRTiles(tileOffset)
        }
        
        renderFrame()
        frameCount += 1
        
        if (frameCount % 60 == 0) {
          val elapsed = (System.currentTimeMillis() - startTime) / 1000.0
          val fps = frameCount / elapsed
          displayStatus(frameCount, fps, tileOffset)
        }
        
        Thread.sleep(33)
      } else {
        Thread.sleep(100)
      }
    }
  }
  
  private def drawCHRTiles(startTile: Int): Unit = {
    if (!hasCHR) {
      drawNoChRMessage()
      return
    }
    
    val tilesPerRow = 32
    val tilesPerCol = 30
    
    for (tileY <- 0 until tilesPerCol) {
      for (tileX <- 0 until tilesPerRow) {
        val tileIndex = startTile + tileY * tilesPerRow + tileX
        if (tileIndex * 16 < chrSize) {
          drawTileOutline(tileX * 8, tileY * 8, tileIndex)
        }
      }
    }
  }
  
  /**
   * 绘制图块轮廓（只显示外边缘，使用更严格的检测）
   */
  private def drawTileOutline(x: Int, y: Int, tileIndex: Int): Unit = {
    val tileAddr = tileIndex * 16
    if (tileAddr + 16 > chrSize) return
    
    // 提取图块数据
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
    
    // 只绘制最外层边缘（更严格的检测）
    for (row <- 0 until 8) {
      for (col <- 0 until 8) {
        val px = x + col
        val py = y + row
        
        if (px < WIDTH && py < HEIGHT) {
          val current = tileData(row)(col)
          
          if (current > 0) {
            // 检测是否为外边缘像素（至少有一个方向是背景）
            val top = if (row > 0) tileData(row - 1)(col) else 0
            val bottom = if (row < 7) tileData(row + 1)(col) else 0
            val left = if (col > 0) tileData(row)(col - 1) else 0
            val right = if (col < 7) tileData(row)(col + 1) else 0
            
            // 只有当至少有一个相邻像素是背景时才绘制
            val isEdge = (top == 0) || (bottom == 0) || (left == 0) || (right == 0)
            
            // 更严格：只绘制真正的外轮廓（相邻至少2个方向是背景）
            val emptyCount = (if (top == 0) 1 else 0) + 
                            (if (bottom == 0) 1 else 0) + 
                            (if (left == 0) 1 else 0) + 
                            (if (right == 0) 1 else 0)
            
            if (emptyCount >= 2) {
              // 只绘制角落和突出的边缘
              framebuffer(px)(py) = 0x30  // 亮白
            } else if (isEdge) {
              // 普通边缘用较暗的颜色
              framebuffer(px)(py) = 0x10  // 深灰
            } else {
              // 内部像素 - 透明
              framebuffer(px)(py) = 0x0F
            }
          } else {
            framebuffer(px)(py) = 0x0F
          }
        }
      }
    }
  }
  
  private def drawNoChRMessage(): Unit = {
    for (y <- 0 until HEIGHT) {
      for (x <- 0 until WIDTH) {
        framebuffer(x)(y) = 0x0F
      }
    }
  }
  
  private def renderFrame(): Unit = {
    val sb = new StringBuilder()
    sb.append(ANSI_CLEAR)
    sb.append(ANSI_HOME)
    
    for (y <- 0 until displayHeight) {
      for (x <- 0 until displayWidth) {
        val srcX = x
        val srcY = y * SCALE_Y
        
        val upperColorIndex = framebuffer(srcX)(srcY).min(63)
        val lowerColorIndex = if (srcY + 1 < HEIGHT) 
          framebuffer(srcX)(srcY + 1).min(63) 
        else upperColorIndex
        
        val upperAnsi = NES_TO_ANSI_IMPROVED(upperColorIndex)
        val lowerAnsi = NES_TO_ANSI_IMPROVED(lowerColorIndex)
        
        if (upperAnsi == lowerAnsi) {
          sb.append(s"\u001b[48;5;${upperAnsi}m ")
        } else {
          sb.append(s"\u001b[38;5;${lowerAnsi}m\u001b[48;5;${upperAnsi}m$PIXEL_HALF_LOWER")
        }
      }
      sb.append(ANSI_RESET)
      sb.append("\n")
    }
    
    print(sb.toString())
  }
  
  private def displayStatus(frame: Int, fps: Double, tileOffset: Int): Unit = {
    print(ANSI_RESET)
    println()
    println(f"轮廓模式 | 帧数: $frame%6d | FPS: $fps%5.1f | 图块: $tileOffset%4d | 按 Q 退出")
  }
  
  private def handleInput(): Unit = {
    val reader = new BufferedReader(new InputStreamReader(System.in))
    
    val commands = Array("/bin/sh", "-c", "stty raw -echo < /dev/tty")
    Runtime.getRuntime().exec(commands).waitFor()
    
    try {
      while (running) {
        if (System.in.available() > 0) {
          val ch = System.in.read().toChar.toLower
          
          ch match {
            case 'p' => paused = !paused
            case 'q' => running = false
            case _ =>
          }
        }
        Thread.sleep(10)
      }
    } finally {
      val restoreCommands = Array("/bin/sh", "-c", "stty sane < /dev/tty")
      Runtime.getRuntime().exec(restoreCommands).waitFor()
    }
  }
}
