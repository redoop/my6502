package nes.apu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.APURefactored

/**
 * APU 寄存器测试 - 使用重构版本
 * 参考 CPU 指令测试方式，测试 APU 的 20 个寄存器
 */
class APURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "APU Registers - Pulse 1 ($4000-$4003)"
  
  it should "write to Pulse 1 register 0" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x00.U)  // $4000
      dut.io.cpuDataIn.poke(0xBF.U)  // 占空比=3, 循环, 音量=15
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 验证写入成功（通过后续操作验证）
    }
  }
  
  it should "write to Pulse 1 register 1 (sweep)" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x01.U)  // $4001
      dut.io.cpuDataIn.poke(0x88.U)  // 使能, 周期=0, 负向, 移位=0
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Pulse 1 timer low" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x02.U)  // $4002
      dut.io.cpuDataIn.poke(0x54.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Pulse 1 timer high and length" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x03.U)  // $4003
      dut.io.cpuDataIn.poke(0xF8.U)  // 长度=31, 定时器高3位=0
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Pulse 2 ($4004-$4007)"
  
  it should "write to Pulse 2 registers" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x04.U)
      dut.io.cpuDataIn.poke(0xBF.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x05.U)
      dut.io.cpuDataIn.poke(0x88.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x06.U)
      dut.io.cpuDataIn.poke(0x54.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x07.U)
      dut.io.cpuDataIn.poke(0xF8.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Triangle ($4008-$400B)"
  
  it should "write to Triangle linear counter" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x08.U)  // $4008
      dut.io.cpuDataIn.poke(0x7F.U)  // 控制=0, 重载值=127
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Triangle timer low" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0A.U)  // $400A
      dut.io.cpuDataIn.poke(0xFE.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Triangle timer high and length" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0B.U)  // $400B
      dut.io.cpuDataIn.poke(0xF8.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Noise ($400C-$400F)"
  
  it should "write to Noise registers" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0C.U)
      dut.io.cpuDataIn.poke(0x3F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x0E.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      dut.io.cpuAddr.poke(0x0F.U)
      dut.io.cpuDataIn.poke(0xF8.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Control ($4015)"
  
  it should "enable channels" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x15.U)  // $4015
      dut.io.cpuDataIn.poke(0x0F.U)  // 使能所有通道
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "read channel status" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x15.U)  // $4015
      dut.io.cpuRead.poke(true.B)
      dut.clock.step()
      
      // 初始状态应该是 0
      dut.io.cpuDataOut.expect(0.U)
    }
  }
  
  behavior of "APU Registers - Frame Counter ($4017)"
  
  it should "set 4-step mode" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x17.U)  // $4017
      dut.io.cpuDataIn.poke(0x00.U)  // 4步模式
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set 5-step mode" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x17.U)  // $4017
      dut.io.cpuDataIn.poke(0x80.U)  // 5步模式
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
}
