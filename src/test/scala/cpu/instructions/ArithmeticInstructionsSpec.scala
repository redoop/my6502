package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

class ArithmeticInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ArithmeticInstructions"

  it should "INX increments X register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xE8.U)
      dut.io.xIn.poke(0x41.U)
      dut.clock.step()
      dut.io.xOut.expect(0x42.U)
      dut.io.flagZOut.expect(false.B)
      dut.io.flagNOut.expect(false.B)
    }
  }

  it should "INX wraps from 0xFF to 0x00 and sets zero flag" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xE8.U)
      dut.io.xIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.xOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  it should "INY increments Y register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xC8.U)
      dut.io.yIn.poke(0x10.U)
      dut.clock.step()
      dut.io.yOut.expect(0x11.U)
    }
  }

  it should "DEX decrements X register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xCA.U)
      dut.io.xIn.poke(0x42.U)
      dut.clock.step()
      dut.io.xOut.expect(0x41.U)
    }
  }

  it should "DEX wraps from 0x00 to 0xFF and sets negative flag" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0xCA.U)
      dut.io.xIn.poke(0x00.U)
      dut.clock.step()
      dut.io.xOut.expect(0xFF.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "DEY decrements Y register" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x88.U)
      dut.io.yIn.poke(0x01.U)
      dut.clock.step()
      dut.io.yOut.expect(0x00.U)
      dut.io.flagZOut.expect(true.B)
    }
  }

  behavior of "ArithmeticInstructions - Zero Page"

  it should "ADC zero page adds with carry" in {
    test(new ArithmeticZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0x65.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.flagCIn.poke(false.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      
      // Cycle 0: ReadAddress
      dut.io.memDataIn.poke(0x10.U)
      dut.clock.step()
      
      // Cycle 1: ReadDataandExecute
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x10.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "SBC zero page subtracts with borrow" in {
    test(new ArithmeticZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xE5.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      
      // Cycle 0: ReadAddress
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      
      // Cycle 1: ReadDataandExecute
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x20.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.aOut.expect(0x20.U)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "INC zero page increments memory" in {
    test(new ArithmeticZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xE6.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      
      // Cycle 0: ReadAddress
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      
      // Cycle 1: ReadData
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x30.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      
      // Cycle 2: Result
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x43.U)
      dut.io.done.expect(true.B)
    }
  }

  it should "DEC zero page decrements memory" in {
    test(new ArithmeticZeroPageTestModule) { dut =>
      dut.io.opcode.poke(0xC6.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      
      // Cycle 0: ReadAddress
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      
      // Cycle 1: ReadData
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x40.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      
      // Cycle 2: Result
      dut.io.cycle.poke(2.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "INC A (65C02) increments accumulator" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x1A.U)
      dut.io.aIn.poke(0x7F.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagNOut.expect(true.B)
    }
  }

  it should "DEC A (65C02) decrements accumulator" in {
    test(new ArithmeticTestModule) { dut =>
      dut.io.opcode.poke(0x3A.U)
      dut.io.aIn.poke(0x80.U)
      dut.clock.step()
      dut.io.aOut.expect(0x7F.U)
      dut.io.flagNOut.expect(false.B)
    }
  }
}

class ArithmeticTestModule extends Module {
  val io = IO(new Bundle {
    val opcode   = Input(UInt(8.W))
    val aIn      = Input(UInt(8.W))
    val xIn      = Input(UInt(8.W))
    val yIn      = Input(UInt(8.W))
    val aOut     = Output(UInt(8.W))
    val xOut     = Output(UInt(8.W))
    val yOut     = Output(UInt(8.W))
    val flagNOut = Output(Bool())
    val flagZOut = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.x := io.xIn
  regs.y := io.yIn

  val result = ArithmeticInstructions.executeImplied(io.opcode, regs)

  io.aOut     := result.regs.a
  io.xOut     := result.regs.x
  io.yOut     := result.regs.y
  io.flagNOut := result.regs.flagN
  io.flagZOut := result.regs.flagZ
}

class ArithmeticZeroPageTestModule extends Module {
  val io = IO(new Bundle {
    val opcode     = Input(UInt(8.W))
    val cycle      = Input(UInt(8.W))
    val operand    = Input(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val aIn        = Input(UInt(8.W))
    val flagCIn    = Input(Bool())
    val memAddr    = Output(UInt(16.W))
    val memWrite   = Output(Bool())
    val memDataOut = Output(UInt(8.W))
    val aOut       = Output(UInt(8.W))
    val flagN      = Output(Bool())
    val flagZ      = Output(Bool())
    val flagC      = Output(Bool())
    val done       = Output(Bool())
  })

  val regs = Wire(new Registers)
  regs := Registers.default()
  regs.a := io.aIn
  regs.flagC := io.flagCIn

  val isADCSBC = (io.opcode === 0x65.U) || (io.opcode === 0xE5.U)
  val result = Mux(isADCSBC,
    ArithmeticInstructions.executeADCSBCZeroPage(io.opcode, io.cycle, regs, io.operand, io.memDataIn),
    ArithmeticInstructions.executeZeroPage(io.opcode, io.cycle, regs, io.operand, io.memDataIn)
  )

  io.memAddr    := result.memAddr
  io.memWrite   := result.memWrite
  io.memDataOut := result.memData
  io.aOut       := result.regs.a
  io.flagN      := result.regs.flagN
  io.flagZ      := result.regs.flagZ
  io.flagC      := result.regs.flagC
  io.done       := result.done
}

class ArithmeticAbsoluteSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ArithmeticInstructions - Absolute"

  it should "ADC absolute" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x6D.U)
      dut.io.aIn.poke(0x00.U)
      dut.io.flagCIn.poke(false.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x34.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x34.U)
      dut.io.memDataIn.poke(0x12.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x1234.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.aOut.expect(0x50.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagZ.expect(false.B)
      dut.io.flagV.expect(false.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ADC absolute with carry" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x6D.U)
      dut.io.aIn.poke(0xFF.U)
      dut.io.flagCIn.poke(false.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x2000.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.aOut.expect(0x00.U)
      dut.io.flagC.expect(true.B)
      dut.io.flagZ.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "ADC absolute with overflow" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0x6D.U)
      dut.io.aIn.poke(0x7F.U)
      dut.io.flagCIn.poke(false.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x3000.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.aOut.expect(0x80.U)
      dut.io.flagV.expect(true.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "SBC absolute" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xED.U)
      dut.io.aIn.poke(0x50.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x2000.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.aOut.expect(0x20.U)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "SBC absolute with borrow" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xED.U)
      dut.io.aIn.poke(0x30.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x4000.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.aOut.expect(0xE0.U)
      dut.io.flagC.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "SBC absolute with overflow" in {
    test(new ArithmeticAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xED.U)
      dut.io.aIn.poke(0x80.U)
      dut.io.flagCIn.poke(true.B)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x5000.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.aOut.expect(0x7F.U)
      dut.io.flagV.expect(true.B)
      dut.io.flagC.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }
}

class IncDecAbsoluteSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ArithmeticInstructions - INC/DEC Absolute"

  it should "INC absolute" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xEE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x34.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x34.U)
      dut.io.memDataIn.poke(0x12.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x1234.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x43.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "INC absolute wrap to zero" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xEE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x20.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x2000.U)
      dut.io.memDataIn.poke(0xFF.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "INC absolute negative result" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xEE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x30.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x3000.U)
      dut.io.memDataIn.poke(0x7F.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x80.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "DEC absolute" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x40.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x4000.U)
      dut.io.memDataIn.poke(0x42.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x41.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "DEC absolute to zero" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x50.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x5000.U)
      dut.io.memDataIn.poke(0x01.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0x00.U)
      dut.io.flagZ.expect(true.B)
      dut.io.flagN.expect(false.B)
      dut.io.done.expect(true.B)
    }
  }

  it should "DEC absolute wrap to 0xFF" in {
    test(new IncDecAbsoluteTestModule) { dut =>
      dut.io.opcode.poke(0xCE.U)
      dut.io.cycle.poke(0.U)
      dut.io.operand.poke(0.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(1.U)
      dut.io.operand.poke(0x00.U)
      dut.io.memDataIn.poke(0x60.U)
      dut.clock.step()
      dut.io.cycle.poke(2.U)
      dut.io.operand.poke(0x6000.U)
      dut.io.memDataIn.poke(0x00.U)
      dut.clock.step()
      dut.io.cycle.poke(3.U)
      dut.clock.step()
      dut.io.memWrite.expect(true.B)
      dut.io.memDataOut.expect(0xFF.U)
      dut.io.flagZ.expect(false.B)
      dut.io.flagN.expect(true.B)
      dut.io.done.expect(true.B)
    }
  }
}
