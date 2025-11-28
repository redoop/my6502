package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

/**
 * ROM 加载测试 - 验证 ROM 地址映射是否正确
 */
class ROMLoadTest extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "ROM Loading"
  
  it should "correctly load and read ROM data" in {
    test(new NESSystem) { dut =>
      
      println("\n" + "=" * 60)
      println("🧪 ROM 加载测试")
      println("=" * 60)
      
      dut.clock.setTimeout(0)
      
      // 测试数据：在不同地址写入不同的值
      val testData = Seq(
        (0x8000, 0x12),  // ROM 起始
        (0x8001, 0x34),
        (0xC000, 0x56),  // ROM 中间
        (0xC001, 0x78),
        (0xFFFC, 0xAB),  // Reset 向量低字节
        (0xFFFD, 0xCD),  // Reset 向量高字节
        (0xFFFE, 0xEF),  // IRQ 向量低字节
        (0xFFFF, 0x01)   // IRQ 向量高字节
      )
      
      println("\n1. 加载测试数据到 ROM...")
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      for ((addr, data) <- testData) {
        println(f"   写入: 地址 0x$addr%04X = 0x$data%02X")
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke(data.U)
        dut.clock.step(1)
      }
      
      dut.io.romLoadEn.poke(false.B)
      println("   ✅ 数据加载完成")
      
      // 不进行 Reset，直接测试内存读取
      println("\n2. 测试内存读取...")
      
      // 需要通过 CPU 接口读取，因为我们没有直接的内存读取接口
      // 我们可以通过观察 CPU Reset 序列来验证
      
      println("\n3. 执行 Reset 并观察...")
      dut.reset.poke(true.B)
      dut.clock.step(5)
      dut.reset.poke(false.B)
      
      // Reset 状态会读取 0xFFFC 和 0xFFFD
      println("\n4. 观察 Reset 序列...")
      var resetPC = BigInt(0)
      for (i <- 0 until 10) {
        dut.clock.step(1)
        
        val pc = dut.io.debug.regPC.peek().litValue
        val state = dut.io.debug.state.peek().litValue
        val cycle = dut.io.debug.cycle.peek().litValue
        
        println(f"   周期 $i: State=$state, Cycle=$cycle, PC=0x$pc%04X")
        
        // 在 Reset 完成后（State=1, Cycle=0）记录 PC
        if (state == 1 && cycle == 0 && resetPC == 0) {
          resetPC = pc
        }
      }
      
      val expectedPC = 0xCDABL  // 高字节 0xCD, 低字节 0xAB
      
      println(f"\n5. 结果:")
      println(f"   Reset 后 PC: 0x$resetPC%04X")
      println(f"   预期 PC: 0x$expectedPC%04X")
      
      if (resetPC == expectedPC) {
        println("   ✅ ROM 加载和读取正确！")
      } else {
        println("   ❌ ROM 加载或读取有问题")
        println(f"   差异: 预期 0x$expectedPC%04X, 实际 0x$resetPC%04X")
      }
      
      println("\n" + "=" * 60)
      
      assert(resetPC == expectedPC, f"PC 应该是 0x$expectedPC%04X，实际是 0x$resetPC%04X")
    }
  }
}
