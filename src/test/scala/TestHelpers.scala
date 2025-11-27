package cpu6502.tests

import chisel3._
import chiseltest._
import cpu6502.core._

/**
 * 测试辅助工具类
 * 提供常用的测试函数和内存模拟
 */
object TestHelpers {
  
  /**
   * 初始化 CPU
   */
  def initCPU(dut: CPU6502Core): Unit = {
    dut.io.reset.poke(true.B)
    dut.io.nmi.poke(false.B)
    dut.clock.step(1)
    dut.io.reset.poke(false.B)
    
    // 等待 reset 序列完成（约 5 个周期）
    for (_ <- 0 until 10) {
      dut.clock.step(1)
    }
  }
  
  /**
   * 等待指定周期数
   */
  def waitCycles(dut: CPU6502Core, cycles: Int): Unit = {
    for (_ <- 0 until cycles) {
      dut.clock.step(1)
    }
  }
  
  /**
   * 等待指令执行完成
   * 通过检查 CPU 状态来判断
   */
  def waitInstructionComplete(dut: CPU6502Core, maxCycles: Int = 20): Int = {
    var cycles = 0
    var lastPC = dut.io.debug.regPC.peek().litValue
    
    for (i <- 0 until maxCycles) {
      dut.clock.step(1)
      cycles += 1
      
      val currentPC = dut.io.debug.regPC.peek().litValue
      val state = dut.io.debug.state.peek().litValue
      
      // 如果 PC 改变且状态是 Fetch，说明指令执行完成
      if (currentPC != lastPC && state == 1) {
        return cycles
      }
      
      lastPC = currentPC
    }
    
    cycles
  }
  
  /**
   * 打印 CPU 状态（用于调试）
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
   * 打印标志位状态
   */
  def printFlags(dut: CPU6502Core): Unit = {
    val flagC = dut.io.debug.flagC.peek().litToBoolean
    val flagZ = dut.io.debug.flagZ.peek().litToBoolean
    val flagV = dut.io.debug.flagV.peek().litToBoolean
    val flagN = dut.io.debug.flagN.peek().litToBoolean
    
    println(s"  Flags: N=$flagN V=$flagV Z=$flagZ C=$flagC")
  }
  
  /**
   * 验证标志位
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
   * 验证寄存器值
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
 * 简单的内存模拟器
 * 用于测试时提供内存数据
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
 * 指令构建器
 * 用于构建测试指令序列
 */
object InstructionBuilder {
  
  /**
   * 构建 ASL zp,X 指令
   */
  def aslZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x16, zpAddr & 0xFF)
  }
  
  /**
   * 构建 INC abs,X 指令
   */
  def incAbsX(absAddr: Int): Seq[Int] = {
    Seq(0xFE, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
   * 构建 ASL abs 指令
   */
  def aslAbs(absAddr: Int): Seq[Int] = {
    Seq(0x0E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
   * 构建 ROL zp,X 指令
   */
  def rolZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x36, zpAddr & 0xFF)
  }
  
  /**
   * 构建 LSR abs,X 指令
   */
  def lsrAbsX(absAddr: Int): Seq[Int] = {
    Seq(0x5E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
   * 构建 SBC (ind,X) 指令
   */
  def sbcIndX(zpAddr: Int): Seq[Int] = {
    Seq(0xE1, zpAddr & 0xFF)
  }
  
  /**
   * 构建 SBC zp 指令
   */
  def sbcZp(zpAddr: Int): Seq[Int] = {
    Seq(0xE5, zpAddr & 0xFF)
  }
  
  /**
   * 构建 LSR zp,X 指令
   */
  def lsrZpX(zpAddr: Int): Seq[Int] = {
    Seq(0x56, zpAddr & 0xFF)
  }
  
  /**
   * 构建 ROL abs,X 指令
   */
  def rolAbsX(absAddr: Int): Seq[Int] = {
    Seq(0x3E, absAddr & 0xFF, (absAddr >> 8) & 0xFF)
  }
  
  /**
   * 构建 SBC (ind),Y 指令
   */
  def sbcIndY(zpAddr: Int): Seq[Int] = {
    Seq(0xF1, zpAddr & 0xFF)
  }
  
  /**
   * 构建 LDA #imm 指令（用于设置 A）
   */
  def ldaImm(value: Int): Seq[Int] = {
    Seq(0xA9, value & 0xFF)
  }
  
  /**
   * 构建 LDX #imm 指令（用于设置 X）
   */
  def ldxImm(value: Int): Seq[Int] = {
    Seq(0xA2, value & 0xFF)
  }
  
  /**
   * 构建 LDY #imm 指令（用于设置 Y）
   */
  def ldyImm(value: Int): Seq[Int] = {
    Seq(0xA0, value & 0xFF)
  }
  
  /**
   * 构建 SEC 指令（设置进位）
   */
  def sec(): Seq[Int] = {
    Seq(0x38)
  }
  
  /**
   * 构建 CLC 指令（清除进位）
   */
  def clc(): Seq[Int] = {
    Seq(0x18)
  }
  
  /**
   * 构建 NOP 指令
   */
  def nop(): Seq[Int] = {
    Seq(0xEA)
  }
}

/**
 * 测试用例数据类
 */
case class TestCase(
  name: String,
  setup: SimpleMemory => Unit,
  instruction: Seq[Int],
  verify: (CPU6502Core, SimpleMemory) => Boolean
)
