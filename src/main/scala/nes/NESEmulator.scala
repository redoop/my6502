package nes

import java.io.File
import java.nio.file.{Files, Paths}
import javax.swing._
import java.awt._
import java.awt.event._
import java.awt.image.BufferedImage

/**
 * NES 模拟器 - 基于 ChiselTest 的软件模拟器
 * 
 * 功能:
 * - 加载 NES ROM
 * - 显示游戏画面
 * - 键盘输入
 * - 实时运行
 */
object NESEmulator {
  
  // NES 调色板 (64 色)
  val NES_PALETTE = Array(
    0x7C7C7C, 0x0000FC, 0x0000BC, 0x4428BC, 0x940084, 0xA80020, 0xA81000, 0x881400,
    0x503000, 0x007800, 0x006800, 0x005800, 0x004058, 0x000000, 0x000000, 0x000000,
    0xBCBCBC, 0x0078F8, 0x0058F8, 0x6844FC, 0xD800CC, 0xE40058, 0xF83800, 0xE45C10,
    0xAC7C00, 0x00B800, 0x00A800, 0x00A844, 0x008888, 0x000000, 0x000000, 0x000000,
    0xF8F8F8, 0x3CBCFC, 0x6888FC, 0x9878F8, 0xF878F8, 0xF85898, 0xF87858, 0xFCA044,
    0xF8B800, 0xB8F818, 0x58D854, 0x58F898, 0x00E8D8, 0x787878, 0x000000, 0x000000,
    0xFCFCFC, 0xA4E4FC, 0xB8B8F8, 0xD8B8F8, 0xF8B8F8, 0xF8A4C0, 0xF0D0B0, 0xFCE0A8,
    0xF8D878, 0xD8F878, 0xB8F8B8, 0xB8F8D8, 0x00FCFC, 0xF8D8F8, 0x000000, 0x000000
  )
  
  // 控制器按键映射
  val KEY_A      = KeyEvent.VK_Z
  val KEY_B      = KeyEvent.VK_X
  val KEY_SELECT = KeyEvent.VK_A
  val KEY_START  = KeyEvent.VK_S
  val KEY_UP     = KeyEvent.VK_UP
  val KEY_DOWN   = KeyEvent.VK_DOWN
  val KEY_LEFT   = KeyEvent.VK_LEFT
  val KEY_RIGHT  = KeyEvent.VK_RIGHT
  
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      println("用法: NESEmulator <rom文件>")
      println("示例: NESEmulator games/contra.nes")
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
    
    val prgSize = header(4) * 16384
    val chrSize = header(5) * 8192
    val mapper = ((header(6) >> 4) & 0x0F) | (header(7) & 0xF0)
    
    println(s"   Mapper: $mapper")
    println(s"   PRG ROM: $prgSize bytes")
    println(s"   CHR ROM: $chrSize bytes")
    
    // 创建模拟器窗口
    SwingUtilities.invokeLater(() => {
      val emulator = new EmulatorWindow(romData)
      emulator.setVisible(true)
    })
  }
}

/**
 * 模拟器窗口
 */
class EmulatorWindow(romData: Array[Byte]) extends JFrame("NES Emulator - Chisel") {
  
  private val SCALE = 2
  private val WIDTH = 256
  private val HEIGHT = 240
  
  private val canvas = new EmulatorCanvas()
  private var controller1: Int = 0
  private var running = true
  private var paused = false
  
  // 设置窗口
  setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE)
  setResizable(false)
  add(canvas)
  pack()
  setLocationRelativeTo(null)
  
  // 键盘监听
  addKeyListener(new KeyAdapter {
    override def keyPressed(e: KeyEvent): Unit = {
      e.getKeyCode match {
        case NESEmulator.KEY_A      => controller1 |= 0x01
        case NESEmulator.KEY_B      => controller1 |= 0x02
        case NESEmulator.KEY_SELECT => controller1 |= 0x04
        case NESEmulator.KEY_START  => controller1 |= 0x08
        case NESEmulator.KEY_UP     => controller1 |= 0x10
        case NESEmulator.KEY_DOWN   => controller1 |= 0x20
        case NESEmulator.KEY_LEFT   => controller1 |= 0x40
        case NESEmulator.KEY_RIGHT  => controller1 |= 0x80
        case KeyEvent.VK_SPACE      => paused = !paused
        case KeyEvent.VK_ESCAPE     => running = false; dispose()
        case _ =>
      }
    }
    
    override def keyReleased(e: KeyEvent): Unit = {
      e.getKeyCode match {
        case NESEmulator.KEY_A      => controller1 &= ~0x01
        case NESEmulator.KEY_B      => controller1 &= ~0x02
        case NESEmulator.KEY_SELECT => controller1 &= ~0x04
        case NESEmulator.KEY_START  => controller1 &= ~0x08
        case NESEmulator.KEY_UP     => controller1 &= ~0x10
        case NESEmulator.KEY_DOWN   => controller1 &= ~0x20
        case NESEmulator.KEY_LEFT   => controller1 &= ~0x40
        case NESEmulator.KEY_RIGHT  => controller1 &= ~0x80
        case _ =>
      }
    }
  })
  
  // 启动模拟器线程
  new Thread(() => {
    runEmulator()
  }).start()
  
  /**
   * 运行模拟器
   * 
   * 注意: 这是一个演示版本，显示 ROM 信息和测试画面
   * 完整的模拟器需要使用 Verilator 或 FPGA
   */
  private def runEmulator(): Unit = {
    println("🚀 启动模拟器...")
    println("   按键: Z=A, X=B, A=SELECT, S=START, 方向键=移动")
    println("   空格=暂停, ESC=退出")
    println("")
    println("⚠️  注意: 这是演示版本")
    println("   完整的模拟器需要使用 Verilator 或 FPGA")
    println("   当前显示测试画面")
    println("")
    
    var frameCount = 0
    val startTime = System.currentTimeMillis()
    
    // 显示测试画面
    drawTestPattern()
    
    // 主循环
    while (running) {
      if (!paused) {
        // 更新测试画面
        animateTestPattern(frameCount)
        
        // 更新显示
        canvas.repaint()
        frameCount += 1
        
        // 显示 FPS
        if (frameCount % 60 == 0) {
          val elapsed = (System.currentTimeMillis() - startTime) / 1000.0
          val fps = frameCount / elapsed
          setTitle(f"NES Emulator - Demo - FPS: $fps%.1f - Controller: 0x$controller1%02X")
        }
        
        // 限制帧率到 60 FPS
        Thread.sleep(16)
      } else {
        Thread.sleep(100)
      }
    }
  }
  
  /**
   * 绘制测试图案
   */
  private def drawTestPattern(): Unit = {
    // 绘制彩色条纹
    for (y <- 0 until HEIGHT) {
      for (x <- 0 until WIDTH) {
        val colorIndex = ((x / 32) + (y / 30)) % 64
        val color = NESEmulator.NES_PALETTE(colorIndex)
        canvas.setPixel(x, y, color)
      }
    }
    
    // 绘制文字区域背景
    for (y <- 80 until 160) {
      for (x <- 20 until 236) {
        canvas.setPixel(x, y, 0x000000)
      }
    }
  }
  
  /**
   * 动画测试图案
   */
  private def animateTestPattern(frame: Int): Unit = {
    // 简单的动画效果
    val offset = (frame / 2) % 256
    for (y <- 0 until 40) {
      for (x <- 0 until WIDTH) {
        val colorIndex = ((x + offset) / 16) % 64
        val color = NESEmulator.NES_PALETTE(colorIndex)
        canvas.setPixel(x, y, color)
      }
    }
  }
  
  /**
   * 画布组件
   */
  class EmulatorCanvas extends JPanel {
    private val image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB)
    
    setPreferredSize(new Dimension(WIDTH * SCALE, HEIGHT * SCALE))
    setBackground(Color.BLACK)
    
    def setPixel(x: Int, y: Int, color: Int): Unit = {
      if (x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT) {
        image.setRGB(x, y, color)
      }
    }
    
    override def paintComponent(g: Graphics): Unit = {
      super.paintComponent(g)
      val g2d = g.asInstanceOf[Graphics2D]
      g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, 
                          RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR)
      g2d.drawImage(image, 0, 0, WIDTH * SCALE, HEIGHT * SCALE, null)
    }
  }
}
