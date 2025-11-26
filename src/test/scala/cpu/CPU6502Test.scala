package cpu6502

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CPU6502Test extends AnyFlatSpec with ChiselScalatestTester {
  
  "CPU6502Refactored" should "execute LDA immediate" in {
    test(new CPU6502Refactored) { dut =>
      // 模拟内存：LDA #$42
      dut.io.memDataIn.poke(0xA9.U)  // LDA Immediate
      dut.clock.step(1)
      
      dut.io.memDataIn.poke(0x42.U)  // 操作数
      dut.clock.step(1)
      
      dut.io.debug.regA.expect(0x42.U)
      dut.io.debug.flagZ.expect(false.B)
      dut.io.debug.flagN.expect(false.B)
    }
  }

  it should "execute ADC and set carry flag" in {
    test(new CPU6502Refactored) { dut =>
      // LDA #$FF
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step(1)
      
      // ADC #$02 (应该产生进位)
      dut.io.memDataIn.poke(0x69.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0x02.U)
      dut.clock.step(1)
      
      dut.io.debug.regA.expect(0x01.U)
      dut.io.debug.flagC.expect(true.B)
    }
  }

  it should "execute INX" in {
    test(new CPU6502Refactored) { dut =>
      // LDX #$10
      dut.io.memDataIn.poke(0xA2.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step(1)
      
      // INX
      dut.io.memDataIn.poke(0xE8.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0xEA.U)  // NOP (让 INX 执行)
      dut.clock.step(1)
      
      dut.io.debug.regX.expect(0x11.U)
    }
  }

  it should "execute transfer instructions" in {
    test(new CPU6502Refactored) { dut =>
      // LDA #$55
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step(1)
      
      // TAX
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0xEA.U)  // NOP
      dut.clock.step(1)
      
      dut.io.debug.regX.expect(0x55.U)
      
      // TAY
      dut.io.memDataIn.poke(0xA8.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0xEA.U)  // NOP
      dut.clock.step(1)
      
      dut.io.debug.regY.expect(0x55.U)
    }
  }

  it should "execute branch instructions" in {
    test(new CPU6502Refactored) { dut =>
      // LDA #$00 (设置 Z 标志)
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step(1)
      
      val pcBefore = dut.io.debug.regPC.peek().litValue
      
      // BEQ +5 (应该跳转)
      dut.io.memDataIn.poke(0xF0.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0x05.U)
      dut.clock.step(1)
      dut.io.memDataIn.poke(0xEA.U)  // NOP
      dut.clock.step(1)
      
      val pcAfter = dut.io.debug.regPC.peek().litValue
      assert(pcAfter == pcBefore + 7) // PC + 2 (指令) + 5 (偏移)
    }
  }
}
