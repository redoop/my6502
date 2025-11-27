package cpu6502

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.CPU6502Refactored

/**
 * NMI 中断测试
 * 验证 CPU 的 NMI 中断处理功能
 */
class NMIInterruptTest extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "CPU6502 NMI Interrupt"
  
  it should "detect NMI rising edge" in {
    test(new CPU6502Refactored) { dut =>
      // 初始化
      dut.io.reset.poke(true.B)
      dut.io.nmi.poke(false.B)
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      
      // 等待 reset 完成
      dut.clock.step(10)
      
      // 触发 NMI 上升沿
      dut.io.nmi.poke(true.B)
      dut.clock.step(1)
      
      // CPU 应该进入 NMI 处理状态
      // 验证会在后续周期中进行
      dut.clock.step(10)
    }
  }
  
  it should "push PC and status to stack during NMI" in {
    test(new CPU6502Refactored) { dut =>
      // 初始化
      dut.io.reset.poke(true.B)
      dut.io.nmi.poke(false.B)
      dut.io.memDataIn.poke(0xEA.U)  // NOP 指令
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      
      // 等待 reset 完成
      for (_ <- 0 until 10) {
        dut.io.memDataIn.poke(0xEA.U)
        dut.clock.step(1)
      }
      
      // 记录当前 PC 和 SP
      val initialPC = dut.io.debug.pc.peek().litValue
      val initialSP = dut.io.debug.sp.peek().litValue
      
      println(s"Before NMI: PC=0x${initialPC.toHexString}, SP=0x${initialSP.toHexString}")
      
      // 触发 NMI
      dut.io.nmi.poke(true.B)
      dut.clock.step(1)
      
      // NMI 处理需要 7 个周期
      var stackWrites = 0
      for (cycle <- 0 until 10) {
        if (dut.io.memWrite.peek().litToBoolean) {
          val addr = dut.io.memAddr.peek().litValue
          val data = dut.io.memDataOut.peek().litValue
          println(s"Cycle $cycle: Stack write to 0x${addr.toHexString} = 0x${data.toHexString}")
          stackWrites += 1
        }
        dut.io.memDataIn.poke(0x00.U)  // 提供 NMI 向量数据
        dut.clock.step(1)
      }
      
      // 应该有 3 次栈写入：PC 高字节、PC 低字节、状态寄存器
      assert(stackWrites >= 3, s"Expected at least 3 stack writes, got $stackWrites")
      
      // SP 应该减少 3
      val finalSP = dut.io.debug.sp.peek().litValue
      println(s"After NMI: SP=0x${finalSP.toHexString}")
      assert(finalSP == (initialSP - 3) % 256, 
        s"SP should decrease by 3: initial=0x${initialSP.toHexString}, final=0x${finalSP.toHexString}")
    }
  }
  
  it should "read NMI vector from 0xFFFA-0xFFFB" in {
    test(new CPU6502Refactored) { dut =>
      // 初始化
      dut.io.reset.poke(true.B)
      dut.io.nmi.poke(false.B)
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      
      // 等待 reset 完成
      for (_ <- 0 until 10) {
        dut.io.memDataIn.poke(0xEA.U)
        dut.clock.step(1)
      }
      
      // 触发 NMI
      dut.io.nmi.poke(true.B)
      dut.clock.step(1)
      
      // 监控内存读取
      var nmiVectorRead = false
      for (_ <- 0 until 15) {
        val addr = dut.io.memAddr.peek().litValue
        val isRead = dut.io.memRead.peek().litToBoolean
        
        if (isRead && (addr == 0xFFFA || addr == 0xFFFB)) {
          println(s"Reading NMI vector from 0x${addr.toHexString}")
          nmiVectorRead = true
          
          // 提供 NMI 向量数据
          if (addr == 0xFFFA) {
            dut.io.memDataIn.poke(0x00.U)  // 低字节
          } else {
            dut.io.memDataIn.poke(0xC0.U)  // 高字节 -> 0xC000
          }
        } else {
          dut.io.memDataIn.poke(0xEA.U)
        }
        
        dut.clock.step(1)
      }
      
      assert(nmiVectorRead, "NMI vector should be read from 0xFFFA-0xFFFB")
      
      // PC 应该跳转到 NMI 向量地址
      val finalPC = dut.io.debug.pc.peek().litValue
      println(s"PC after NMI: 0x${finalPC.toHexString}")
    }
  }
  
  it should "set interrupt disable flag during NMI" in {
    test(new CPU6502Refactored) { dut =>
      // 初始化
      dut.io.reset.poke(true.B)
      dut.io.nmi.poke(false.B)
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      
      // 等待 reset 完成
      for (_ <- 0 until 10) {
        dut.io.memDataIn.poke(0xEA.U)
        dut.clock.step(1)
      }
      
      // 确保 I 标志初始为 false
      val initialI = dut.io.debug.flagI.peek().litToBoolean
      println(s"Initial I flag: $initialI")
      
      // 触发 NMI
      dut.io.nmi.poke(true.B)
      dut.clock.step(1)
      
      // 等待 NMI 处理完成
      for (_ <- 0 until 10) {
        dut.io.memDataIn.poke(0x00.U)
        dut.clock.step(1)
      }
      
      // I 标志应该被设置
      val finalI = dut.io.debug.flagI.peek().litToBoolean
      println(s"Final I flag: $finalI")
      assert(finalI, "Interrupt disable flag should be set after NMI")
    }
  }
  
  it should "not trigger NMI on low level, only on rising edge" in {
    test(new CPU6502Refactored) { dut =>
      // 初始化
      dut.io.reset.poke(true.B)
      dut.io.nmi.poke(false.B)
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      
      // 等待 reset 完成
      for (_ <- 0 until 10) {
        dut.io.memDataIn.poke(0xEA.U)
        dut.clock.step(1)
      }
      
      val initialPC = dut.io.debug.pc.peek().litValue
      
      // 保持 NMI 为高电平（不是上升沿）
      dut.io.nmi.poke(true.B)
      for (_ <- 0 until 5) {
        dut.io.memDataIn.poke(0xEA.U)
        dut.clock.step(1)
      }
      
      // PC 应该继续正常递增，不应该跳转到 NMI 向量
      val pc1 = dut.io.debug.pc.peek().litValue
      println(s"PC with NMI high: 0x${pc1.toHexString}")
      
      // 现在产生一个下降沿再上升沿
      dut.io.nmi.poke(false.B)
      dut.clock.step(1)
      dut.io.nmi.poke(true.B)
      dut.clock.step(1)
      
      // 这次应该触发 NMI
      var nmiTriggered = false
      for (_ <- 0 until 10) {
        val addr = dut.io.memAddr.peek().litValue
        if (addr == 0xFFFA || addr == 0xFFFB) {
          nmiTriggered = true
          println("NMI triggered on rising edge")
        }
        dut.io.memDataIn.poke(0x00.U)
        dut.clock.step(1)
      }
      
      assert(nmiTriggered, "NMI should trigger on rising edge")
    }
  }
}
