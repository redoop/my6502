package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class NESMapper4Test extends AnyFlatSpec with ChiselScalatestTester {
  
  "NES System" should "read from ROM through Mapper 4" in {
    test(new NESSystemRefactored(enableDebug = false)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Set mapper to 4
      dut.io.mapperNum.poke(4.U)
      
      // Load some test data into ROM
      dut.io.prgLoadEn.poke(true.B)
      
      // Load reset vector at $FFFC-$FFFD -> points to $8000
      dut.io.prgLoadAddr.poke(0x7FFFC.U)  // Last 32KB bank, offset $FFFC
      dut.io.prgLoadData.poke(0x00.U)     // Low byte
      dut.clock.step(1)
      
      dut.io.prgLoadAddr.poke(0x7FFFD.U)
      dut.io.prgLoadData.poke(0x80.U)     // High byte -> $8000
      dut.clock.step(1)
      
      // Load NOP instructions at $8000-$8010
      for (i <- 0 until 16) {
        dut.io.prgLoadAddr.poke((0x00000 + i).U)  // Bank 0
        dut.io.prgLoadData.poke(0xEA.U)           // NOP
        dut.clock.step(1)
      }
      
      dut.io.prgLoadEn.poke(false.B)
      
      // Release reset
      dut.reset.poke(false.B)
      
      // Run for several cycles
      for (i <- 0 until 20) {
        dut.clock.step(1)
        val pc = dut.io.debug.cpuPC.peek().litValue
        val opcode = dut.io.debug.cpuOpcode.peek().litValue
        val memAddr = dut.io.debug.cpuMemAddr.peek().litValue
        val memData = dut.io.debug.cpuMemDataIn.peek().litValue
        val memRead = dut.io.debug.cpuMemRead.peek().litValue
        println(f"Cycle $i: PC=0x${pc}%04x Opcode=0x${opcode}%02x MemAddr=0x${memAddr}%04x MemData=0x${memData}%02x MemRead=$memRead")
      }
      
      // CPU should have read the reset vector and started executing
      val finalPC = dut.io.debug.cpuPC.peek().litValue
      println(f"Final PC: 0x${finalPC}%04x")
      
      // PC should be around $8000 area
      assert(finalPC >= 0x8000L && finalPC < 0x8010L)
    }
  }
}
