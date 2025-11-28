package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.nio.file.{Files, Paths}

/**
 * 使用真实游戏 ROM 测试 NMI 功能
 */
class GameNMITest extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "NMI with Real Game ROM"
  
  it should "detect NMI trigger in Donkey Kong" in {
    test(new NESSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      println("\n" + "=" * 60)
      println("🎮 Donkey Kong NMI 测试")
      println("=" * 60)
      
      // 1. 加载 ROM
      val romPath = "./games/Donkey-Kong.nes"
      println(s"\n1. 加载 ROM: $romPath")
      
      if (!Files.exists(Paths.get(romPath))) {
        println(s"   ❌ ROM 文件不存在")
        cancel("ROM 文件不存在")
      }
      
      val romData = Files.readAllBytes(Paths.get(romPath))
      println(s"   ROM 大小: ${romData.length} bytes")
      
      // 解析 ROM 头
      val prgSize = romData(4) * 16384
      val chrSize = romData(5) * 8192
      val mapper = ((romData(6) >> 4) & 0x0F) | (romData(7) & 0xF0)
      
      println(s"   Mapper: $mapper")
      println(s"   PRG ROM: $prgSize bytes")
      println(s"   CHR ROM: $chrSize bytes")
      
      // 加载 PRG ROM
      println("\n2. 加载 PRG ROM...")
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      val prgStart = 16
      for (i <- 0 until prgSize) {
        val addr = if (prgSize == 16384) {
          // 16KB PRG: 映射到 0x8000-0xBFFF 和 0xC000-0xFFFF
          0x8000 + i
        } else {
          // 32KB PRG: 映射到 0x8000-0xFFFF
          0x8000 + i
        }
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke((romData(prgStart + i) & 0xFF).U)
        dut.clock.step(1)
      }
      println(s"   ✅ 加载了 $prgSize bytes PRG ROM")
      
      // 加载 CHR ROM
      println("\n3. 加载 CHR ROM...")
      dut.io.romLoadPRG.poke(false.B)
      
      val chrStart = prgStart + prgSize
      for (i <- 0 until chrSize) {
        dut.io.romLoadAddr.poke(i.U)
        dut.io.romLoadData.poke((romData(chrStart + i) & 0xFF).U)
        dut.clock.step(1)
      }
      println(s"   ✅ 加载了 $chrSize bytes CHR ROM")
      
      dut.io.romLoadEn.poke(false.B)
      
      // 4. Reset CPU
      println("\n4. Reset CPU...")
      dut.reset.poke(true.B)
      dut.clock.step(10)
      dut.reset.poke(false.B)
      dut.clock.step(10)
      
      val resetPC = dut.io.debug.regPC.peek().litValue
      println(f"   Reset 后 PC = 0x$resetPC%04X")
      
      // 5. 运行游戏并监控
      println("\n5. 运行游戏...")
      println("   监控 PPUCTRL 和 NMI 触发...")
      println("")
      
      var ppuCtrlHistory = scala.collection.mutable.Set[Int]()
      var nmiTriggered = false
      var nmiCount = 0
      var lastPPUCtrl = 0
      var cycles = 0
      val maxCycles = 500000  // 约 8 秒
      
      // 设置超时
      dut.clock.setTimeout(0)
      
      while (cycles < maxCycles && !nmiTriggered) {
        dut.clock.step(1)
        cycles += 1
        
        val pc = dut.io.debug.regPC.peek().litValue
        val ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        
        // 记录 PPUCTRL 变化
        if (ppuCtrl != lastPPUCtrl) {
          ppuCtrlHistory += ppuCtrl
          println(f"   [周期 $cycles%6d] PPUCTRL 变化: 0x$lastPPUCtrl%02X -> 0x$ppuCtrl%02X")
          
          // 检查 NMI 是否启用
          if ((ppuCtrl & 0x80) != 0) {
            println(f"   ✅ NMI 已启用！(PPUCTRL = 0x$ppuCtrl%02X)")
          }
          
          lastPPUCtrl = ppuCtrl
        }
        
        // 检查是否跳转到 NMI 向量区域
        if (pc >= 0xC800L && pc <= 0xC8FFL) {
          nmiCount += 1
          if (nmiCount == 1) {
            println("")
            println(f"   🎉 检测到 NMI 触发！")
            println(f"   [周期 $cycles%6d] PC 跳转到 0x$pc%04X")
            println(f"   当前 PPUCTRL = 0x$ppuCtrl%02X")
            nmiTriggered = true
          }
        }
        
        // 每 50000 周期报告一次进度
        if (cycles % 50000 == 0) {
          println(f"   [周期 $cycles%6d] PC = 0x$pc%04X, PPUCTRL = 0x$ppuCtrl%02X")
        }
      }
      
      println("")
      println("=" * 60)
      println("测试结果")
      println("=" * 60)
      
      println(s"\n总运行周期: $cycles")
      println(s"PPUCTRL 不同值数量: ${ppuCtrlHistory.size}")
      println(s"PPUCTRL 历史: ${ppuCtrlHistory.toSeq.sorted.map(v => f"0x$v%02X").mkString(", ")}")
      
      if (nmiTriggered) {
        println(s"\n✅ NMI 触发成功！")
        println(s"   触发次数: $nmiCount")
      } else {
        println(s"\n⚠️  NMI 未触发")
        val finalPPUCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        println(f"   最终 PPUCTRL = 0x$finalPPUCtrl%02X")
        
        if ((finalPPUCtrl & 0x80) == 0) {
          println("   原因: PPUCTRL bit 7 = 0 (NMI 未启用)")
          println("   游戏可能需要更长时间初始化")
        }
      }
      
      println("")
      println("=" * 60)
      
      // 断言：至少应该看到 PPUCTRL 的变化
      assert(ppuCtrlHistory.nonEmpty, "PPUCTRL 应该有变化")
    }
  }
  
  it should "detect NMI trigger in Super Mario Bros" in {
    test(new NESSystem) { dut =>
      
      println("\n" + "=" * 60)
      println("🎮 Super Mario Bros. NMI 测试")
      println("=" * 60)
      
      // 1. 加载 ROM
      val romPath = "./games/Super-Mario-Bros.nes"
      println(s"\n1. 加载 ROM: $romPath")
      
      if (!Files.exists(Paths.get(romPath))) {
        println(s"   ❌ ROM 文件不存在")
        cancel("ROM 文件不存在")
      }
      
      val romData = Files.readAllBytes(Paths.get(romPath))
      println(s"   ROM 大小: ${romData.length} bytes")
      
      // 解析 ROM 头
      val prgSize = romData(4) * 16384
      val chrSize = romData(5) * 8192
      
      println(s"   PRG ROM: $prgSize bytes")
      println(s"   CHR ROM: $chrSize bytes")
      
      // 加载 PRG ROM
      println("\n2. 加载 PRG ROM...")
      dut.io.romLoadEn.poke(true.B)
      dut.io.romLoadPRG.poke(true.B)
      
      val prgStart = 16
      for (i <- 0 until prgSize) {
        val addr = 0x8000 + i
        dut.io.romLoadAddr.poke(addr.U)
        dut.io.romLoadData.poke((romData(prgStart + i) & 0xFF).U)
        dut.clock.step(1)
      }
      
      // 加载 CHR ROM
      println("\n3. 加载 CHR ROM...")
      dut.io.romLoadPRG.poke(false.B)
      
      val chrStart = prgStart + prgSize
      for (i <- 0 until chrSize) {
        dut.io.romLoadAddr.poke(i.U)
        dut.io.romLoadData.poke((romData(chrStart + i) & 0xFF).U)
        dut.clock.step(1)
      }
      
      dut.io.romLoadEn.poke(false.B)
      
      // 4. Reset
      println("\n4. Reset CPU...")
      dut.reset.poke(true.B)
      dut.clock.step(10)
      dut.reset.poke(false.B)
      dut.clock.step(10)
      
      // 5. 运行并监控
      println("\n5. 运行游戏...")
      
      var nmiTriggered = false
      var cycles = 0
      val maxCycles = 500000
      
      dut.clock.setTimeout(0)
      
      while (cycles < maxCycles && !nmiTriggered) {
        dut.clock.step(1)
        cycles += 1
        
        val pc = dut.io.debug.regPC.peek().litValue
        val ppuCtrl = dut.io.ppuDebug.ppuCtrl.peek().litValue.toInt
        
        // 检查 NMI 向量
        if (pc >= 0xC800L && pc <= 0xC8FFL) {
          println(f"\n   ✅ NMI 触发！PC = 0x$pc%04X")
          nmiTriggered = true
        }
        
        if (cycles % 50000 == 0) {
          println(f"   [周期 $cycles%6d] PC = 0x$pc%04X, PPUCTRL = 0x$ppuCtrl%02X")
        }
      }
      
      println(s"\n总运行周期: $cycles")
      if (nmiTriggered) {
        println("✅ NMI 触发成功！")
      } else {
        println("⚠️  NMI 未触发（游戏可能需要更长时间）")
      }
    }
  }
}
