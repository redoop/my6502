package cpu6502.core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CPU6502CoreSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "CPU6502Core Integration"

  // Helper: Wait for Reset sequence (6 cycles)
  def waitForReset(dut: CPU6502Core, resetVector: Int = 0x0000): Unit = {
    dut.io.memDataIn.poke((resetVector & 0xFF).U)
    dut.clock.step(3)
    dut.io.memDataIn.poke(((resetVector >> 8) & 0xFF).U)
    dut.clock.step(3)
  }

  it should "execute NOP instruction" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // Fetch NOP (0xEA)
      dut.io.memDataIn.poke(0xEA.U)
      dut.clock.step()
      
      // Execute NOP
      dut.clock.step()
      
      // Should be back in fetch state
      dut.io.memRead.expect(true.B)
    }
  }

  it should "execute LDA immediate" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // Fetch LDA #$42
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step()
      
      // Execute - read operand
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      
      // Check accumulator
      dut.io.debug.regA.expect(0x42.U)
      dut.io.debug.flagZ.expect(false.B)
      dut.io.debug.flagN.expect(false.B)
    }
  }

  it should "execute INX instruction" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // Fetch INX (0xE8)
      dut.io.memDataIn.poke(0xE8.U)
      dut.clock.step()
      
      // Execute INX
      dut.clock.step()
      
      // X should be 1
      dut.io.debug.regX.expect(0x01.U)
    }
  }

  it should "execute TAX instruction" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // First load A with LDA #$55
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step()
      dut.io.memDataIn.poke(0x55.U)
      dut.clock.step()
      
      // Then TAX (0xAA)
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.clock.step()
      
      // X should equal A
      dut.io.debug.regX.expect(0x55.U)
      dut.io.debug.regA.expect(0x55.U)
    }
  }

  it should "execute CLC instruction" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // Fetch CLC (0x18)
      dut.io.memDataIn.poke(0x18.U)
      dut.clock.step()
      
      // Execute CLC
      dut.clock.step()
      
      // Carry should be clear
      dut.io.debug.flagC.expect(false.B)
    }
  }

  it should "update PC correctly" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // PC should be 0 after reset
      dut.io.debug.regPC.expect(0.U)
      
      // Fetch NOP
      dut.io.memDataIn.poke(0xEA.U)
      dut.clock.step()
      
      // PC should increment to 1
      dut.io.debug.regPC.expect(1.U)
      
      // Execute NOP
      dut.clock.step()
      
      // PC should still be 1 (ready for next fetch)
      dut.io.debug.regPC.expect(1.U)
    }
  }

  it should "execute simple program: LDA #$10, INX, TAX" in {
    test(new CPU6502Core) { dut =>
      waitForReset(dut)
      // LDA #$10
      dut.io.memDataIn.poke(0xA9.U)
      dut.clock.step()
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      dut.io.debug.regA.expect(0x10.U)
      
      // INX
      dut.io.memDataIn.poke(0xE8.U)
      dut.clock.step()
      dut.clock.step()
      dut.io.debug.regX.expect(0x01.U)
      
      // TAX
      dut.io.memDataIn.poke(0xAA.U)
      dut.clock.step()
      dut.clock.step()
      dut.io.debug.regX.expect(0x10.U)
    }
  }
}
