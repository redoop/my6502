package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESMapper4CHRTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "NES System" should "load CHR ROM without crash" in {
    test(new NESSystemRefactored(enableDebug = false)) { dut =>
      // Set mapper to 4
      dut.io.mapperNum.poke(4.U)
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      
      // Hold reset
      dut.reset.poke(true.B)
      dut.clock.step(5)
      
      println("=== Loading PRG ROM ===")
      // Load small PRG ROM
      dut.io.prgLoadEn.poke(true.B)
      for (i <- 0 until 100) {
        dut.io.prgLoadAddr.poke(i.U)
        dut.io.prgLoadData.poke((i & 0xFF).U)
        dut.clock.step(1)
        
        if (i % 20 == 0) {
          println(s"PRG: $i bytes loaded")
        }
      }
      dut.io.prgLoadEn.poke(false.B)
      println("PRG ROM loaded successfully")
      
      println("\n=== Loading CHR ROM ===")
      // Load small CHR ROM
      dut.io.chrLoadEn.poke(true.B)
      for (i <- 0 until 100) {
        dut.io.chrLoadAddr.poke(i.U)
        dut.io.chrLoadData.poke((i & 0xFF).U)
        dut.clock.step(1)
        
        if (i % 20 == 0) {
          println(s"CHR: $i bytes loaded")
        }
      }
      dut.io.chrLoadEn.poke(false.B)
      println("CHR ROM loaded successfully")
      
      // Release reset
      dut.reset.poke(false.B)
      dut.clock.step(10)
      
      println("\n✅ Test passed - No combinational loop crash")
    }
  }
}
