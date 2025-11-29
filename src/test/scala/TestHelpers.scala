package cpu6502.tests

import chisel3._
import chiseltest._
import cpu6502.core._

/**
// *
// *
 */
object TestHelpers {
  
  /**
// * Initialize CPU
   */
  def initCPU(dut: CPU6502Core): Unit = {
    dut.io.reset.poke(true.B)
    dut.io.nmi.poke(false.B)
    dut.clock.step(1)
    dut.io.reset.poke(false.B)
    
    // Wait reset SequenceComplete（ 5 Cycle）
    for (_ <- 0 until 10) {
      dut.clock.step(1)
    }
  }
  
  /**
// * WaitCycle
   */
  def waitCycles(dut: CPU6502Core, cycles: Int): Unit = {
    for (_ <- 0 until cycles) {
      dut.clock.step(1)
    }
  }
  
  /**
// * WaitInstructionExecuteComplete
// *  CPU State
   */
  def waitInstructionComplete(dut: CPU6502Core, maxCycles: Int = 20): Int = {
    var cycles = 0
    var lastPC = dut.io.debug.regPC.peek().litValue
    
    for (i <- 0 until maxCycles) {
      dut.clock.step(1)
      cycles += 1
      
      val currentPC = dut.io.debug.regPC.peek().litValue
      val state = dut.io.debug.state.peek().litValue
      
      // PC State Fetch，InstructionExecuteComplete
      if (currentPC != lastPC && state == 1) {
        return cycles
      }
      
      lastPC = currentPC
    }
    
    cycles
  }
  
  /**
// *  CPU State（）
   */
  def printCPUState(dut: CPU6502Core, label: String = ""): Unit = {
    val pc = dut.io.debug.regPC.peek().litValue
    val a = dut.io.debug.regA.peek().litValue
    val x = dut.io.debug.regX.peek().litValue
    val y = dut.io.debug.regY.peek().litValue
    val sp = dut.io.debug.regSP.peek().litValue
    val state = dut.io.debug.state.peek().litValue
    val cycle = dut.io.debug.cycle.peek().litValue
    
    println(s"$label CPU State:")
    println(f"  PC: 0x$pc%04X  A: 0x$a%02X  X: 0x$x%02X  Y: 0x$y%02X  SP: 0x$sp%02X")
    println(f"  State: $state  Cycle: $cycle")
  }
  
  /**
// * FlagState
   */
  def printFlags(dut: CPU6502Core): Unit = {
    val flagC = dut.io.debug.flagC.peek().litToBoolean
    val flagZ = dut.io.debug.flagZ.peek().litToBoolean
    val flagV = dut.io.debug.flagV.peek().litToBoolean
    val flagN = dut.io.debug.flagN.peek().litToBoolean
    
    println(s"  Flags: N=$flagN V=$flagV Z=$flagZ C=$flagC")
  }
  
  /**
// * Flag
   */
  def verifyFlags(
    dut: CPU6502Core,
    expectedC: Option[Boolean] = None,
    expectedZ: Option[Boolean] = None,
    expectedN: Option[Boolean] = None,
    expectedV: Option[Boolean] = None
  ): Boolean = {
    var allMatch = true
    
    if (expectedC.isDefined) {
      val actual = dut.io.debug.flagC.peek().litToBoolean
      if (actual != expectedC.get) {
        println(s"  ❌ Carry flag mismatch: expected ${expectedC.get}, got $actual")
        allMatch = false
      }
    }
    
    if (expectedZ.isDefined) {
      val actual = dut.io.debug.flagZ.peek().litToBoolean
      if (actual != expectedZ.get) {
        println(s"  ❌ Zero flag mismatch: expected ${expectedZ.get}, got $actual")
        allMatch = false
      }
    }
    
    if (expectedN.isDefined) {
      val actual = dut.io.debug.flagN.peek().litToBoolean
      if (actual != expectedN.get) {
        println(s"  ❌ Negative flag mismatch: expected ${expectedN.get}, got $actual")
        allMatch = false
      }
    }
    
    if (expectedV.isDefined) {
      val actual = dut.io.debug.flagV.peek().litToBoolean
      if (actual != expectedV.get) {
        println(s"  ❌ Overflow flag mismatch: expected ${expectedV.get}, got $actual")
        allMatch = false
      }
    }
    
    if (allMatch) {
      println("  ✅ All flags match")
    }
    
    allMatch
  }
  
  /**
// * Registers
   */
  def verifyRegister(
    dut: CPU6502Core,
    reg: String,
    expected: Int
  ): Boolean = {
    val actual = reg.toUpperCase match {
      case "A" => dut.io.debug.regA.peek().litValue.toInt
      case "X" => dut.io.debug.regX.peek().litValue.toInt
      case "Y" => dut.io.debug.regY.peek().litValue.toInt
      case "SP" => dut.io.debug.regSP.peek().litValue.toInt
      case _ => -1
    }
    
    if (actual == expected) {
      println(f"  ✅ $reg = 0x$expected%02X")
      true
    } else {
      println(f"  ❌ $reg mismatch: expected 0x$expected%02X, got 0x$actual%02X")
      false
    }
  }
}

/**
// *
// * whenData
 */
class SimpleMemory {
  private val mem = scala.collection.mutable.Map[Int, Int]()
  
  def write(addr: Int, data: Int): Unit = {
    mem(addr & 0xFFFF) = data & 0xFF
  }
  
  def read(addr: Int): Int = {
    mem.getOrElse(addr & 0xFFFF, 0)
  }
  
  def writeWord(addr: Int, data: Int): Unit = {
    write(addr, data & 0xFF)
    write(addr + 1, (data >> 8) & 0xFF)
  }
  
  def readWord(addr: Int): Int = {
    val lo = read(addr)
    val hi = read(addr + 1)
    (hi << 8) | lo
  }
  
  def clear(): Unit = {
    mem.clear()
  }
  
  def dump(start: Int, length: Int): Unit = {
    println(f"Memory dump from 0x$start%04X:")
    for (i <- 0 until length by 16) {
      val addr = start + i
      print(f"  $addr%04X: ")
      for (j <- 0 until 16) {
        if (i + j < length) {
          val data = read(addr + j)
          print(f"$data%02X ")
        }
      }
      println()
    }
  }
}

/**
// * Instruction
// * InstructionSequence
 */
object InstructionBuilder {
  
  /**
// *  ASL zp,X Instruction
   */
  def aslZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x16, zpAddr & 0xFF)
  }
  
  /**
// *  INC abs,X Instruction
   */
  def incAbsX(absAddr: Int): Seq[Int] = {
    Seq(0xFE, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
// *  ASL abs Instruction
   */
  def aslAbs(absAddr: Int): Seq[Int] = {
    Seq(0x0E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
// *  ROL zp,X Instruction
   */
  def rolZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x36, zpAddr & 0xFF)
  }
  
  /**
// *  LSR abs,X Instruction
   */
  def lsrAbsX(absAddr: Int): Seq[Int] = {
    Seq(0x5E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
// *  SBC (ind,X) Instruction
   */
  def sbcIndX(zpAddr: Int): Seq[Int] = {
    Seq(0xE1, zpAddr & 0xFF)
  }
  
  /**
// *  SBC zp Instruction
   */
  def sbcZp(zpAddr: Int): Seq[Int] = {
    Seq(0xE5, zpAddr & 0xFF)
  }
  
  /**
// *  LSR zp,X Instruction
   */
  def lsrZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x56, zpAddr & 0xFF)
  }
  
  /**
// *  ROL abs,X Instruction
   */
  def rolAbsX(absAddr: Int): Seq[Int] = {
    Seq(0x3E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
// *  SBC (ind),Y Instruction
   */
  def sbcIndY(zpAddr: Int): Seq[Int] = {
    Seq(0xF1, zpAddr & 0xFF)
  }
  
  /**
// *  LDA #imm Instruction（Set A）
   */
  def ldaImm(value: Int): Seq[Int] = {
    Seq(0xA9, value & 0xFF)
  }
  
  /**
// *  LDX #imm Instruction（Set X）
   */
  def ldxImm(value: Int): Seq[Int] = {
    Seq(0xA2, value & 0xFF)
  }
  
  /**
// *  LDY #imm Instruction（Set Y）
   */
  def ldyImm(value: Int): Seq[Int] = {
    Seq(0xA0, value & 0xFF)
  }
  
  /**
// *  SEC Instruction（Set）
   */
  def sec(): Seq[Int] = {
    Seq(0x38)
  }
  
  /**
// *  CLC Instruction（Clear）
   */
  def clc(): Seq[Int] = {
    Seq(0x18)
  }
  
  /**
// *  NOP Instruction
   */
  def nop(): Seq[Int] = {
    Seq(0xEA)
  }
}

/**
// * Data
 */
case class TestCase(
  name: String,
  setup: SimpleMemory => Unit,
  instruction: Seq[Int],
  verify: (CPU6502Core, SimpleMemory) => Boolean
)
