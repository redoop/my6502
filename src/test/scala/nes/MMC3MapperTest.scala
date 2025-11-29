package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MMC3MapperTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "MMC3Mapper" should "output correct PRG address for bank 0" in {
    test(new MMC3Mapper) { dut =>
      // Reset
      dut.clock.step(1)
      
      // Test default bank mapping (Mode 0)
      // Bank 0 should map to r6 (default 0)
      dut.io.cpuAddr.poke(0x8000.U)  // $8000-$9FFF
      dut.clock.step(1)
      
      val prgAddr = dut.io.prgAddr.peek().litValue
      println(f"CPU Addr: 0x8000, PRG Addr: 0x${prgAddr}%05x")
      
      // Should be bank 0 (0x00) + offset 0x0000 = 0x00000
      assert(prgAddr == 0x00000L)
    }
  }
  
  "MMC3Mapper" should "switch banks correctly" in {
    test(new MMC3Mapper) { dut =>
      dut.clock.step(1)
      
      // Write to bank select register ($8000)
      dut.io.cpuAddr.poke(0x8000.U)
      dut.io.cpuDataIn.poke(0x06.U)  // Select R6 (PRG bank 0)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      // Write bank number to $8001
      dut.io.cpuAddr.poke(0x8001.U)
      dut.io.cpuDataIn.poke(0x05.U)  // Set R6 = 5
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step(1)
      dut.io.cpuWrite.poke(false.B)
      
      // Read from $8000 should now use bank 5
      dut.io.cpuAddr.poke(0x8000.U)
      dut.clock.step(1)
      
      val prgAddr = dut.io.prgAddr.peek().litValue
      println(f"After bank switch: CPU Addr: 0x8000, PRG Addr: 0x${prgAddr}%05x")
      
      // Should be bank 5 (0x05) + offset 0x0000 = 0x0A000 (5 * 8KB)
      assert(prgAddr == 0x0A000L)
    }
  }
  
  "MMC3Mapper" should "read data through ROM" in {
    test(new MMC3Mapper) { dut =>
      dut.clock.step(1)
      
      // Simulate ROM data
      dut.io.prgData.poke(0x42.U)
      dut.io.cpuAddr.poke(0x8000.U)
      dut.clock.step(1)
      
      val dataOut = dut.io.cpuDataOut.peek().litValue
      println(f"CPU Data Out: 0x${dataOut}%02x")
      
      // Should output the ROM data
      assert(dataOut == 0x42L)
    }
  }
}
