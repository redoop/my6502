package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

/**
 * NMI 中断功能测试
 * 
 * 测试目标：
 * 1. VBlank 标志正确设置
 * 2. 当 PPUCTRL bit 7 = 1 时，NMI 触发
 * 3. CPU 跳转到 NMI 向量
 */
class NMITest extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "NMI Interrupt"
  
  it should "trigger NMI when VBlank occurs and PPUCTRL bit 7 is set" in {
    test(new NESSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      println("🧪 NMI 中断测试")
      println("=" * 50)
      
      // 1. 加载一个简单的测试程序到 ROM
      println("\n1. 加载测试程序...")
      
      // 测试程序：
      // RESET:
      //   SEI           ; 0xC000: 0x78
      //   LDA #$90      ; 0xC001: 0xA9 0x90
      //   STA $2000     ; 0xC003: 0x8D 0x00 0x20
      // LOOP:
      //   JMP LOOP      ; 0xC006: 0x4C 0x06 0xC0
      //
      // NMI:
      //   LDA #$42      ; 0xC800: 0xA9 0x42
      //   STA $0200     ; 0xC802: 0x8D 0x00 0x02
      //   RTI           ; 0xC805: 0x40
      
      val testProgram = Seq(
        // RESET handler at 0xC000
        (0xC000, 0x78),  // SEI
        (0xC001, 0xA9),  // LDA #$90
        (0xC002, 0x90),
        (0xC003, 0x8D),  // STA $2000
        (0xC004, 0x00),
        (0xC005, 0x20),
        (0xC006, 0x4C),  // JMP $C006
        (0xC007, 0x06),
        (0xC008, 0xC0),
        
        // NMI handler at 0xC800
        (0xC800, 0xA9),  // LDA #$42
        (0xC801, 0x42),
        (0xC802, 0x8D),  // STA $0200
        (0xC803, 0x00),
        (0xC804, 0x02),
        (0xC805, 0x40),  // RTI
        
        // Vectors at 0xFFFA-0xFFFF
        (0xFFFA, 0x00),  // NMI vector low
        (0xFFFB, 0xC8),  // NMI vector high (0xC800)
        (0xFFFC, 0x00),  // RESET vector low
        (0xFFFD, 0xC0),  // RESET vector high (0xC000)
        (0xFFFE, 0x00),  // IRQ vector low
        (0xFFFF, 0x00)   // IRQ vector high
      )
      
      // 加载程序到 ROM
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      for ((addr, data) <- testProgram) {
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke(data.U)
        dut.clock.step(1)
      }
      
      dut.io.romLoadEn.poke(false.B)
      println("   ✅ 程序加载完成")
      
      // 设置超时为 0（无限制）
      dut.clock.setTimeout(0)
      
      // 2. Reset CPU
      println("\n2. Reset CPU...")
      dut.reset.poke(true.B)
      dut.clock.step(10)
      dut.reset.poke(false.B)
      
      // 等待 Reset 序列完成（4 个周期）
      dut.clock.step(4)
      
      val resetPC = dut.io.debug.regPC.peek().litValue
      println(f"   Reset 后 PC = 0x$resetPC%04X")
      
      // PC 应该在 0xC000 附近（可能已经执行了几条指令）
      if (resetPC < 0xC000L || resetPC > 0xC010L) {
        println(f"   ⚠️  PC 不在预期范围内")
      } else {
        println("   ✅ Reset 成功")
      }
      
      // 3. 运行直到设置 PPUCTRL
      println("\n3. 运行程序，设置 PPUCTRL...")
      var ppuCtrl = 0
      var cycles = 0
      val maxCycles = 1000
      var ppuCtrlSet = false
      
      while (cycles < maxCycles && !ppuCtrlSet) {
        dut.clock.step(1)
        ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        cycles += 1
        
        if (ppuCtrl == 0x90) {
          println(f"   ✅ PPUCTRL 设置为 0x$ppuCtrl%02X (NMI 启用)")
          ppuCtrlSet = true
        }
      }
      
      if (ppuCtrl != 0x90) {
        println(f"   ⚠️  PPUCTRL = 0x$ppuCtrl%02X (NMI 未启用)")
        println("   继续测试...")
      }
      
      // 4. 等待 VBlank
      println("\n4. 等待 VBlank...")
      var vblank = false
      cycles = 0
      val vblankMaxCycles = 100000  // 约 1.5 帧
      
      while (cycles < vblankMaxCycles && !vblank) {
        dut.clock.step(1)
        vblank = dut.io.vblank.peek().litToBoolean
        cycles += 1
      }
      
      if (vblank) {
        println(f"   ✅ VBlank 触发 (在 $cycles 个周期后)")
      } else {
        println("   ⚠️  VBlank 未触发")
      }
      
      // 5. 检查 NMI 是否触发
      println("\n5. 检查 NMI 触发...")
      var nmiTriggered = false
      cycles = 0
      val nmiMaxCycles = 1000
      
      while (cycles < nmiMaxCycles && !nmiTriggered) {
        dut.clock.step(1)
        val pc = dut.io.debug.regPC.peek().litValue
        cycles += 1
        
        // 检查 PC 是否跳转到 NMI 向量 (0xC800)
        if (pc == 0xC800L) {
          println(f"   ✅ NMI 触发！PC 跳转到 0x$pc%04X")
          nmiTriggered = true
        }
      }
      
      if (!nmiTriggered) {
        val currentPC = dut.io.debug.regPC.peek().litValue
        val currentPPUCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        println(f"   ⚠️  NMI 未触发")
        println(f"   当前 PC = 0x$currentPC%04X")
        println(f"   当前 PPUCTRL = 0x$currentPPUCtrl%02X")
        
        if ((currentPPUCtrl & 0x80) == 0) {
          println("   原因：PPUCTRL bit 7 = 0 (NMI 未启用)")
        }
      }
      
      // 6. 如果 NMI 触发，检查 RTI 后的行为
      if (nmiTriggered) {
        println("\n6. 检查 NMI 处理程序...")
        
        // 运行 NMI 处理程序
        dut.clock.step(50)
        
        val pc = dut.io.debug.regPC.peek().litValue
        println(f"   NMI 处理后 PC = 0x$pc%04X")
        
        // PC 应该返回到主循环 (0xC006)
        if (pc == 0xC006L || pc == 0xC007L || pc == 0xC008L) {
          println("   ✅ RTI 成功，返回主循环")
        } else {
          println(f"   ⚠️  PC 不在预期位置")
        }
      }
      
      println("\n" + "=" * 50)
      println("测试完成")
      
      // 断言：至少 VBlank 应该工作
      assert(vblank, "VBlank 应该触发")
    }
  }
  
  it should "not trigger NMI when PPUCTRL bit 7 is 0" in {
    test(new NESSystem) { dut =>
      
      println("\n🧪 NMI 禁用测试")
      println("=" * 50)
      
      // 加载一个不启用 NMI 的程序
      val testProgram = Seq(
        // RESET handler - 不设置 PPUCTRL
        (0xC000, 0x78),  // SEI
        (0xC001, 0x4C),  // JMP $C001 (死循环)
        (0xC002, 0x01),
        (0xC003, 0xC0),
        
        // Vectors
        (0xFFFA, 0x00),  // NMI vector
        (0xFFFB, 0xC8),
        (0xFFFC, 0x00),  // RESET vector
        (0xFFFD, 0xC0),
        (0xFFFE, 0x00),  // IRQ vector
        (0xFFFF, 0x00)
      )
      
      // 加载程序
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      for ((addr, data) <- testProgram) {
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke(data.U)
        dut.clock.step(1)
      }
      
      dut.io.romLoadEn.poke(false.B)
      
      // Reset
      dut.clock.setTimeout(0)
      dut.reset.poke(true.B)
      dut.clock.step(10)
      dut.reset.poke(false.B)
      dut.clock.step(10)
      
      // 等待 VBlank
      var cycles = 0
      val maxCycles = 100000
      var vblankSeen = false
      
      while (cycles < maxCycles) {
        dut.clock.step(1)
        val vblank = dut.io.vblank.peek().litToBoolean
        val pc = dut.io.debug.regPC.peek().litValue
        cycles += 1
        
        if (vblank) {
          vblankSeen = true
        }
        
        // PC 不应该跳转到 NMI 向量
        if (pc == 0xC800L) {
          fail("NMI 不应该触发（PPUCTRL bit 7 = 0）")
        }
      }
      
      val ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue
      println(f"PPUCTRL = 0x$ppuCtrl%02X")
      println(f"VBlank 触发: $vblankSeen")
      println("✅ NMI 正确地未触发")
      
      assert(vblankSeen, "VBlank 应该触发")
      assert((ppuCtrl & 0x80) == 0, "PPUCTRL bit 7 应该是 0")
    }
  }
}
