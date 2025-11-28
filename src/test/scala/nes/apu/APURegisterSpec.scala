package nes.apu

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import nes.APURefactored

/**
 * APU 寄存器测试 - 完整覆盖
 */
class APURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "APU Registers - Pulse 1 ($4000-$4003)"
  
  it should "write to Pulse 1 register 0" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0xBF.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Pulse 1 duty cycle" in {
    test(new APURefactored) { dut =>
      val duties = Seq(0x00, 0x40, 0x80, 0xC0)
      for (duty <- duties) {
        dut.io.cpuAddr.poke(0x00.U)
        dut.io.cpuDataIn.poke(duty.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  it should "set Pulse 1 volume" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Pulse 1 sweep" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x01.U)
      dut.io.cpuDataIn.poke(0x88.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Pulse 1 timer low" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x02.U)
      dut.io.cpuDataIn.poke(0x54.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Pulse 1 timer high and length" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x03.U)
      dut.io.cpuDataIn.poke(0xF8.U)
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
  
  it should "set Pulse 2 duty cycle" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x04.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Triangle ($4008-$400B)"
  
  it should "write to Triangle linear counter" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x08.U)
      dut.io.cpuDataIn.poke(0x7F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Triangle control flag" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x08.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Triangle timer low" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0A.U)
      dut.io.cpuDataIn.poke(0xFE.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to Triangle timer high and length" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0B.U)
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
  
  it should "set Noise mode" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0E.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set Noise period" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x0E.U)
      for (i <- 0 until 16) {
        dut.io.cpuDataIn.poke(i.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  behavior of "APU Registers - DMC ($4010-$4013)"
  
  it should "write to DMC frequency" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x10.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set DMC IRQ enable" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x10.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set DMC loop flag" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x10.U)
      dut.io.cpuDataIn.poke(0x40.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to DMC direct load" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x11.U)
      dut.io.cpuDataIn.poke(0x7F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to DMC sample address" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x12.U)
      dut.io.cpuDataIn.poke(0xC0.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "write to DMC sample length" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x13.U)
      dut.io.cpuDataIn.poke(0xFF.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  behavior of "APU Registers - Control ($4015)"
  
  it should "enable channels" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuDataIn.poke(0x0F.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "enable individual channels" in {
    test(new APURefactored) { dut =>
      val enables = Seq(0x01, 0x02, 0x04, 0x08, 0x10)
      for (en <- enables) {
        dut.io.cpuAddr.poke(0x15.U)
        dut.io.cpuDataIn.poke(en.U)
        dut.io.cpuWrite.poke(true.B)
        dut.clock.step()
      }
    }
  }
  
  it should "read channel status" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x15.U)
      dut.io.cpuRead.poke(true.B)
      dut.clock.step()
      dut.io.cpuDataOut.expect(0.U)
    }
  }
  
  behavior of "APU Registers - Frame Counter ($4017)"
  
  it should "set 4-step mode" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x17.U)
      dut.io.cpuDataIn.poke(0x00.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set 5-step mode" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x17.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
  
  it should "set IRQ inhibit flag" in {
    test(new APURefactored) { dut =>
      dut.io.cpuAddr.poke(0x17.U)
      dut.io.cpuDataIn.poke(0x40.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
    }
  }
}
