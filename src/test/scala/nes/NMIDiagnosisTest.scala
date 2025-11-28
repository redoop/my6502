package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

/**
 * NMI 诊断测试 - 详细分析 NMI 未触发的原因
 */
class NMIDiagnosisTest extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "NMI Diagnosis"
  
  it should "diagnose NMI trigger issues" in {
    test(new NESSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      println("\n" + "=" * 70)
      println("🔍 NMI 诊断测试")
      println("=" * 70)
      
      // 加载测试程序
      println("\n📝 加载测试程序...")
      
      // 测试程序：
      // 1. 设置 PPUCTRL = 0x90 (启用 NMI)
      // 2. 进入死循环
      // 3. NMI 处理程序写入标记
      
      val testProgram = Seq(
        // RESET handler at 0xC000
        (0xC000, 0x78),  // SEI
        (0xC001, 0xA9),  // LDA #$90
        (0xC002, 0x90),
        (0xC003, 0x8D),  // STA $2000 (PPUCTRL)
        (0xC004, 0x00),
        (0xC005, 0x20),
        (0xC006, 0xA9),  // LDA #$01
        (0xC007, 0x01),
        (0xC008, 0x8D),  // STA $0300 (标记程序已运行)
        (0xC009, 0x00),
        (0xC00A, 0x03),
        (0xC00B, 0x4C),  // JMP $C00B (死循环)
        (0xC00C, 0x0B),
        (0xC00D, 0xC0),
        
        // NMI handler at 0xC800
        (0xC800, 0xA9),  // LDA #$42
        (0xC801, 0x42),
        (0xC802, 0x8D),  // STA $0400 (NMI 标记)
        (0xC803, 0x00),
        (0xC804, 0x04),
        (0xC805, 0x40),  // RTI
        
        // Vectors
        (0xFFFA, 0x00),  // NMI vector low
        (0xFFFB, 0xC8),  // NMI vector high
        (0xFFFC, 0x00),  // RESET vector low
        (0xFFFD, 0xC0),  // RESET vector high
        (0xFFFE, 0x00),  // IRQ vector low
        (0xFFFF, 0x00)   // IRQ vector high
      )
      
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      for ((addr, data) <- testProgram) {
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke(data.U)
        dut.clock.step(1)
      }
      
      dut.io.romLoadEn.poke(false.B)
      println("   ✅ 程序加载完成")
      
      // 设置超时
      dut.clock.setTimeout(0)
      
      // Reset
      println("\n🔄 Reset CPU...")
      dut.reset.poke(true.B)
      dut.clock.step(10)
      dut.reset.poke(false.B)
      dut.clock.step(20)  // 给更多时间完成 Reset 序列
      
      val resetPC = dut.io.debug.regPC.peek().litValue
      println(f"   PC = 0x$resetPC%04X")
      
      if (resetPC != 0xC000L) {
        println(f"   ⚠️  PC 不是预期的 0xC000")
        println("   检查 Reset 向量是否正确加载...")
      }
      
      // 阶段 1: 等待 PPUCTRL 设置
      println("\n" + "=" * 70)
      println("📊 阶段 1: 监控 PPUCTRL 设置")
      println("=" * 70)
      
      var ppuCtrlSet = false
      var cycles = 0
      val maxCycles = 1000
      
      while (cycles < maxCycles && !ppuCtrlSet) {
        dut.clock.step(1)
        cycles += 1
        
        val pc = dut.io.debug.regPC.peek().litValue
        val ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        
        if (ppuCtrl != 0) {
          println(f"\n✅ PPUCTRL 已设置")
          println(f"   周期: $cycles")
          println(f"   PC: 0x$pc%04X")
          println(f"   PPUCTRL: 0x$ppuCtrl%02X")
          println(f"   Bit 7 (NMI Enable): ${(ppuCtrl & 0x80) != 0}")
          ppuCtrlSet = true
        }
      }
      
      if (!ppuCtrlSet) {
        println("\n❌ PPUCTRL 未设置")
        println(f"   运行了 $cycles 个周期")
        val finalPC = dut.io.debug.regPC.peek().litValue
        println(f"   最终 PC: 0x$finalPC%04X")
        fail("PPUCTRL 未设置")
      }
      
      // 阶段 2: 监控 PPU 扫描线和 VBlank
      println("\n" + "=" * 70)
      println("📊 阶段 2: 监控 PPU 扫描线和 VBlank")
      println("=" * 70)
      
      var vblankSeen = false
      var scanlineReached241 = false
      cycles = 0
      val vblankMaxCycles = 100000
      
      var lastScanlineY = 0
      var scanlineChanges = 0
      
      while (cycles < vblankMaxCycles && !vblankSeen) {
        dut.clock.step(1)
        cycles += 1
        
        val scanlineY = dut.io.pixelY.peek().litValue.toInt
        val scanlineX = dut.io.pixelX.peek().litValue.toInt
        val vblank = dut.io.vblank.peek().litToBoolean
        
        // 监控扫描线变化
        if (scanlineY != lastScanlineY) {
          scanlineChanges += 1
          lastScanlineY = scanlineY
          
          if (scanlineY == 241) {
            println(f"\n✅ 扫描线到达 241")
            println(f"   周期: $cycles")
            println(f"   扫描线 X: $scanlineX")
            scanlineReached241 = true
          }
        }
        
        if (vblank) {
          println(f"\n✅ VBlank 触发")
          println(f"   周期: $cycles")
          println(f"   扫描线 Y: $scanlineY")
          println(f"   扫描线 X: $scanlineX")
          vblankSeen = true
        }
        
        // 每 10000 周期报告一次
        if (cycles % 10000 == 0) {
          println(f"   [周期 $cycles%6d] 扫描线: $scanlineY, VBlank: $vblank")
        }
      }
      
      println(f"\n📈 扫描线统计:")
      println(f"   总周期: $cycles")
      println(f"   扫描线变化次数: $scanlineChanges")
      println(f"   到达扫描线 241: $scanlineReached241")
      println(f"   VBlank 触发: $vblankSeen")
      
      if (!vblankSeen) {
        println("\n❌ VBlank 未触发")
        println("   可能原因: PPU 扫描线计数器未正常工作")
        fail("VBlank 未触发")
      }
      
      // 阶段 3: 监控 NMI 信号
      println("\n" + "=" * 70)
      println("📊 阶段 3: 监控 NMI 信号")
      println("=" * 70)
      
      // 继续运行，监控 NMI
      var nmiTriggered = false
      cycles = 0
      val nmiMaxCycles = 10000
      
      while (cycles < nmiMaxCycles && !nmiTriggered) {
        dut.clock.step(1)
        cycles += 1
        
        val pc = dut.io.debug.regPC.peek().litValue
        val ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        val vblank = dut.io.vblank.peek().litToBoolean
        
        // 检查 PC 是否跳转到 NMI 向量
        if (pc == 0xC800L) {
          println(f"\n✅ NMI 触发！")
          println(f"   周期: $cycles")
          println(f"   PC: 0x$pc%04X")
          println(f"   PPUCTRL: 0x$ppuCtrl%02X")
          println(f"   VBlank: $vblank")
          nmiTriggered = true
        }
        
        if (cycles % 1000 == 0) {
          println(f"   [周期 $cycles%6d] PC: 0x$pc%04X, VBlank: $vblank")
        }
      }
      
      if (!nmiTriggered) {
        println(f"\n❌ NMI 未触发")
        println(f"   运行了 $cycles 个周期")
        
        val finalPC = dut.io.debug.regPC.peek().litValue
        val finalPPUCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        val finalVBlank = dut.io.vblank.peek().litToBoolean
        
        println(f"\n📊 最终状态:")
        println(f"   PC: 0x$finalPC%04X")
        println(f"   PPUCTRL: 0x$finalPPUCtrl%02X")
        println(f"   VBlank: $finalVBlank")
        
        println(f"\n🔍 可能的原因:")
        if ((finalPPUCtrl & 0x80) == 0) {
          println("   ❌ PPUCTRL bit 7 = 0 (NMI 未启用)")
        } else {
          println("   ✅ PPUCTRL bit 7 = 1 (NMI 已启用)")
        }
        
        if (!finalVBlank) {
          println("   ⚠️  VBlank 已结束")
        } else {
          println("   ✅ VBlank 仍然有效")
        }
        
        println("\n   可能的问题:")
        println("   1. PPU nmiOccurred 信号未正确设置")
        println("   2. CPU NMI 边沿检测未工作")
        println("   3. 读取 PPUSTATUS 清除了 NMI 信号")
        println("   4. NMI 信号在 CPU 处理前被清除")
      }
      
      println("\n" + "=" * 70)
      println("诊断完成")
      println("=" * 70)
      
      // 断言
      assert(ppuCtrlSet, "PPUCTRL 应该被设置")
      assert(vblankSeen, "VBlank 应该触发")
      // 注意: 暂时不断言 NMI，因为我们正在诊断问题
    }
  }
}
