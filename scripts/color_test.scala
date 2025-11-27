/**
 * 终端颜色测试程序
 * 展示改进的 NES 调色板映射效果
 */

object ColorTest {
  
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
  
  def main(args: Array[String]): Unit = {
    println("\n🎨 NES 调色板测试")
    println("=" * 80)
    println()
    
    println("完整 NES 调色板 (64 色):")
    println()
    
    // 显示所有颜色
    for (row <- 0 until 4) {
      for (col <- 0 until 16) {
        val idx = row * 16 + col
        val (r, g, b) = NES_PALETTE_RGB(idx)
        val ansi = rgbToAnsi256(r, g, b)
        
        print(s"\u001b[48;5;${ansi}m  ")
      }
      print("\u001b[0m")
      println()
    }
    
    println()
    println("颜色信息:")
    println()
    
    // 显示详细信息
    for (row <- 0 until 4) {
      for (col <- 0 until 16) {
        val idx = row * 16 + col
        val (r, g, b) = NES_PALETTE_RGB(idx)
        val ansi = rgbToAnsi256(r, g, b)
        
        print(f"$idx%02X:$ansi%3d ")
      }
      println()
    }
    
    println()
    println("半字符测试 (▄):")
    println()
    
    // 测试半字符效果
    for (i <- 0 until 32) {
      val upper = i
      val lower = i + 32
      val (r1, g1, b1) = NES_PALETTE_RGB(upper)
      val (r2, g2, b2) = NES_PALETTE_RGB(lower)
      val ansi1 = rgbToAnsi256(r1, g1, b1)
      val ansi2 = rgbToAnsi256(r2, g2, b2)
      
      print(s"\u001b[38;5;${ansi2}m\u001b[48;5;${ansi1}m▄")
    }
    print("\u001b[0m")
    println()
    
    println()
    println("渐变测试:")
    println()
    
    // 灰度渐变
    print("灰度: ")
    for (i <- 232 to 255) {
      print(s"\u001b[48;5;${i}m ")
    }
    print("\u001b[0m")
    println()
    
    // 红色渐变
    print("红色: ")
    for (i <- 0 to 5) {
      val ansi = 16 + 36 * i
      print(s"\u001b[48;5;${ansi}m  ")
    }
    print("\u001b[0m")
    println()
    
    // 绿色渐变
    print("绿色: ")
    for (i <- 0 to 5) {
      val ansi = 16 + 6 * i
      print(s"\u001b[48;5;${ansi}m  ")
    }
    print("\u001b[0m")
    println()
    
    // 蓝色渐变
    print("蓝色: ")
    for (i <- 0 to 5) {
      val ansi = 16 + i
      print(s"\u001b[48;5;${ansi}m  ")
    }
    print("\u001b[0m")
    println()
    
    println()
    println("✅ 测试完成")
    println()
  }
}
