package nes.apu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes._

/**
 * APU 功能模块测试
 * 参考 CPU 指令测试方式，测试 APU 的各个功能模块
 * 
 * 测试覆盖:
 * - Envelope (包络生成器)
 * - LengthCounter (长度计数器)
 * - LinearCounter (线性计数器)
 * - Sweep (扫描单元)
 */
class APUModuleSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "APU Module - Envelope"
  
  it should "start envelope" in {
    test(new Envelope) { dut =>
      dut.io.start.poke(true.B)
      dut.io.loop.poke(false.B)
      dut.io.constantVolume.poke(false.B)
      dut.io.dividerPeriod.poke(3.U)
      dut.clock.step()
      
      // TODO: 验证包络启动
    }
  }
  
  it should "decay envelope" in {
    test(new Envelope) { dut =>
      // 启动包络
      dut.io.start.poke(true.B)
      dut.io.loop.poke(false.B)
      dut.io.constantVolume.poke(false.B)
      dut.io.dividerPeriod.poke(1.U)
      dut.clock.step()
      
      dut.io.start.poke(false.B)
      
      // 时钟多次，观察衰减
      for (i <- 0 until 20) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      // TODO: 验证包络衰减到0
    }
  }
  
  it should "loop envelope" in {
    test(new Envelope) { dut =>
      dut.io.start.poke(true.B)
      dut.io.loop.poke(true.B)
      dut.io.constantVolume.poke(false.B)
      dut.io.dividerPeriod.poke(1.U)
      dut.clock.step()
      
      dut.io.start.poke(false.B)
      
      // 时钟多次，观察循环
      for (i <- 0 until 30) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      // TODO: 验证包络循环
    }
  }
  
  it should "use constant volume" in {
    test(new Envelope) { dut =>
      dut.io.start.poke(true.B)
      dut.io.constantVolume.poke(true.B)
      dut.io.volume.poke(8.U)
      dut.clock.step()
      
      dut.io.output.expect(8.U)
    }
  }
  
  behavior of "APU Module - LengthCounter"
  
  it should "load length from table" in {
    test(new LengthCounter) { dut =>
      dut.io.enable.poke(true.B)
      dut.io.halt.poke(false.B)
      dut.io.load.poke(0.U)  // 查找表索引0 = 10
      dut.io.loadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.counter.expect(10.U)
      dut.io.active.expect(true.B)
    }
  }
  
  it should "decrement length counter" in {
    test(new LengthCounter) { dut =>
      // 加载长度
      dut.io.enable.poke(true.B)
      dut.io.halt.poke(false.B)
      dut.io.load.poke(0.U)
      dut.io.loadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.loadTrigger.poke(false.B)
      
      // 时钟递减
      for (i <- 0 until 5) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      dut.io.counter.expect(5.U)
    }
  }
  
  it should "halt length counter" in {
    test(new LengthCounter) { dut =>
      // 加载长度
      dut.io.enable.poke(true.B)
      dut.io.halt.poke(false.B)
      dut.io.load.poke(0.U)
      dut.io.loadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.loadTrigger.poke(false.B)
      dut.io.halt.poke(true.B)
      
      // 时钟不应递减
      for (i <- 0 until 5) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      dut.io.counter.expect(10.U)
    }
  }
  
  it should "disable channel when length reaches zero" in {
    test(new LengthCounter) { dut =>
      // 加载长度
      dut.io.enable.poke(true.B)
      dut.io.halt.poke(false.B)
      dut.io.load.poke(0.U)
      dut.io.loadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.loadTrigger.poke(false.B)
      
      // 时钟直到归零
      for (i <- 0 until 15) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      dut.io.counter.expect(0.U)
      dut.io.active.expect(false.B)
    }
  }
  
  behavior of "APU Module - LinearCounter"
  
  it should "reload linear counter" in {
    test(new LinearCounter) { dut =>
      dut.io.control.poke(false.B)
      dut.io.reload.poke(64.U)
      dut.io.reloadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.reloadTrigger.poke(false.B)
      dut.io.clock.poke(true.B)
      dut.clock.step()
      
      dut.io.counter.expect(64.U)
    }
  }
  
  it should "decrement linear counter" in {
    test(new LinearCounter) { dut =>
      // 重载
      dut.io.control.poke(false.B)
      dut.io.reload.poke(10.U)
      dut.io.reloadTrigger.poke(true.B)
      dut.clock.step()
      
      dut.io.reloadTrigger.poke(false.B)
      dut.io.clock.poke(true.B)
      dut.clock.step()
      dut.io.clock.poke(false.B)
      dut.clock.step()
      
      // 递减
      for (i <- 0 until 5) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      dut.io.counter.expect(5.U)
    }
  }
  
  it should "control reload flag" in {
    test(new LinearCounter) { dut =>
      dut.io.control.poke(true.B)
      dut.io.reload.poke(10.U)
      dut.io.reloadTrigger.poke(true.B)
      dut.clock.step()
      
      // 控制标志为true时，重载标志不清除
      for (i <- 0 until 5) {
        dut.io.clock.poke(true.B)
        dut.clock.step()
        dut.io.clock.poke(false.B)
        dut.clock.step()
      }
      
      // TODO: 验证重载标志状态
    }
  }
}
