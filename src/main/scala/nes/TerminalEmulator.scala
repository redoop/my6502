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
  
  // NES 调色板到 ANSI 256 色的映射
  val NES_TO_ANSI = Array(
    // 0x00-0x0F
    16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 16, 16, 16,
    // 0x10-0x1F
    250, 33, 39, 45, 201, 196, 202, 208, 214, 220, 226, 190, 154, 16, 16, 16,
    // 0x20-0x2F
    255, 51, 87, 123, 159, 195, 231, 229, 228, 227, 226, 190, 159, 240, 16, 16,
    // 0x30-0x3F
    255, 159, 195, 231, 225, 219, 213, 207, 201, 195, 189, 183, 159, 255, 16, 16
  )
  
  // 像素字符 (使用 Unicode 方块字符)
  val PIXEL_FULL = "█"
  val PIXEL_HALF = "▄"
  val PIXEL_EMPTY = " "
  
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
  private val SCALE_X = 2  // 水平缩放
  private val SCALE_Y = 1  // 垂直缩放
  
  private val displayWidth = WIDTH / SCALE_X
  private val displayHeight = HEIGHT / SCALE_Y
  
  // 帧缓冲
  private val framebuffer = Array.ofDim[Int](WIDTH, HEIGHT)
  
  // 控制器状态
  private var controller1 = 0
  private var running = true
  private var paused = false
  
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
   * 模拟器主循环 (演示模式)
   */
  private def runEmulatorLoop(): Unit = {
    println("🎮 模拟器运行中 (演示模式)...")
    println("   注意: 完整模拟需要 ChiselTest")
    println("   当前显示测试图案")
    println()
    
    var frameCount = 0
    val startTime = System.currentTimeMillis()
    
    // 生成测试图案
    for (y <- 0 until HEIGHT) {
      for (x <- 0 until WIDTH) {
        val colorIndex = ((x / 16) + (y / 16)) % 64
        framebuffer(x)(y) = colorIndex
      }
    }
    
    // 主循环
    while (running) {
      if (!paused) {
        // 动画效果
        for (y <- 0 until HEIGHT by 4) {
          for (x <- 0 until WIDTH by 4) {
            val colorIndex = ((x + frameCount) / 16 + (y + frameCount / 2) / 16) % 64
            framebuffer(x)(y) = colorIndex
          }
        }
        
        // 渲染到终端
        renderFrame()
        
        frameCount += 1
        
        // 显示状态
        if (frameCount % 60 == 0) {
          val elapsed = (System.currentTimeMillis() - startTime) / 1000.0
          val fps = frameCount / elapsed
          displayStatus(frameCount, fps)
        }
        
        // 限制帧率
        Thread.sleep(33)  // ~30 FPS
      } else {
        Thread.sleep(100)
      }
    }
  }
  
  /**
   * 渲染帧到终端
   */
  private def renderFrame(): Unit = {
    val sb = new StringBuilder()
    
    // 清屏并回到开头
    sb.append(ANSI_CLEAR)
    sb.append(ANSI_HOME)
    
    // 渲染每一行
    for (y <- 0 until displayHeight) {
      for (x <- 0 until displayWidth) {
        // 采样原始像素
        val srcX = x * SCALE_X
        val srcY = y * SCALE_Y
        val colorIndex = framebuffer(srcX)(srcY)
        
        // 转换为 ANSI 颜色
        val ansiColor = NES_TO_ANSI(colorIndex)
        
        // 输出彩色方块
        sb.append(s"\u001b[48;5;${ansiColor}m$PIXEL_FULL")
      }
      sb.append(ANSI_RESET)
      sb.append("\n")
    }
    
    print(sb.toString())
  }
  
  /**
   * 显示状态信息
   */
  private def displayStatus(frame: Int, fps: Double): Unit = {
    print(ANSI_RESET)
    println()
    println(f"帧数: $frame%6d | FPS: $fps%5.1f | 控制器: 0x$controller1%02X | ${if (paused) "暂停" else "运行"}")
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
   * 运行演示
   */
  private def runDemo(): Unit = {
    val WIDTH = 128
    val HEIGHT = 60
    
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
      
      // 绘制测试图案
      for (y <- 0 until HEIGHT) {
        for (x <- 0 until WIDTH) {
          // 动画效果
          val colorIndex = ((x + frame) / 8 + (y + frame / 2) / 8) % 64
          val ansiColor = NES_TO_ANSI(colorIndex)
          
          sb.append(s"\u001b[48;5;${ansiColor}m$PIXEL_FULL")
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
