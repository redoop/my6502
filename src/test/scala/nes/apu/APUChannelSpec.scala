package nes.apu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.APURefactored

/**
 * APU 通道测试
 * 测试 Pulse, Triangle, Noise 通道的功能
 */
class APUChannelSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "APU Channel - Pulse 1"
  
  it should "enable Pulse 1 channel" in {
    test(new APURefactored) { dut =>
      // 使能 Pulse 1
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x01.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置音量
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0x3F.U)  // 音量=15
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置频率
      dut.io.cpuAddr.poke(0x02.U)
      dut.io.cpuDataIn.poke(0x54.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x03.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Pulse 1 duty cycle" in {
    test(new APURefactored) { dut =>
      // 占空比 12.5%
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 占空比 25%
      dut.io.cpuDataIn.poke(0x40.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 占空比 50%
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 占空比 75%
      dut.io.cpuDataIn.poke(0xC0.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "configure Pulse 1 sweep" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x01.U)
      dut.io.cpuDataIn.poke(0x88.U)  // 使能, 周期=0, 负向, 移位=0
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Channel - Pulse 2"
  
  it should "enable Pulse 2 channel" in {
    test(new APURefactored) { dut =>
      // 使能 Pulse 2
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x02.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置参数
      dut.io.cpuAddr.poke(0x04.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Channel - Triangle"
  
  it should "enable Triangle channel" in {
    test(new APURefactored) { dut =>
      // 使能 Triangle
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x04.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置线性计数器
      dut.io.cpuAddr.poke(0x08.U)
      dut.io.cpuDataIn.poke(0x7F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置频率
      dut.io.cpuAddr.poke(0x0A.U)
      dut.io.cpuDataIn.poke(0xFE.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x0B.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "control Triangle linear counter" in {
    test(new APURefactored) { dut =>
      // 控制标志=0, 重载值=64
      dut.io.cpuAddr.poke(0x08.U)
      dut.io.cpuDataIn.poke(0x40.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 控制标志=1, 重载值=127
      dut.io.cpuDataIn.poke(0xFF.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Channel - Noise"
  
  it should "enable Noise channel" in {
    test(new APURefactored) { dut =>
      // 使能 Noise
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置音量
      dut.io.cpuAddr.poke(0x0C.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置周期
      dut.io.cpuAddr.poke(0x0E.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 设置长度
      dut.io.cpuAddr.poke(0x0F.U)
      dut.io.cpuDataIn.poke(0x08.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Noise mode" in {
    test(new APURefactored) { dut =>
      // 短周期模式
      dut.io.cpuAddr.poke(0x0E.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 长周期模式
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Channel - Multiple Channels"
  
  it should "enable all channels" in {
    test(new APURefactored) { dut =>
      // 使能所有通道
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "disable all channels" in {
    test(new APURefactored) { dut =>
      // 禁用所有通道
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "enable selective channels" in {
    test(new APURefactored) { dut =>
      // 只使能 Pulse 1 和 Triangle
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x05.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Channel - Frequency Control"
  
  it should "set Pulse 1 frequency" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x02.U)
      dut.io.cpuDataIn.poke(0xFE.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x03.U)
      dut.io.cpuDataIn.poke(0x07.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Triangle frequency" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0A.U)
      dut.io.cpuDataIn.poke(0xFE.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x0B.U)
      dut.io.cpuDataIn.poke(0x07.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set different Noise periods" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0E.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke(i.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  behavior of "APU Channel - Volume Control"
  
  it should "set Pulse 1 volume levels" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x00.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke(i.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  it should "set Noise volume levels" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0C.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke(i.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
}
