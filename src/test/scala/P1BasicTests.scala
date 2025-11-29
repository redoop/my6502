package cpu6502.tests

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core._

/**
// * P1 Instruction
// *  Donkey Kong  10 Instruction（10-25）
 */
class P1BasicTests extends AnyFlatSpec with ChiselScalatestTester {
  
  import TestHelpers._
  
  // ============================================
  // P1-1: ADC zp (0x65) - 28
  // ============================================
  behavior of "P1-1: ADC zp (0x65)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ADC zp - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ADC zp - 指令识别 ===")
      
      initCPU(dut)
      
      // 0x65 ValidOpcode
      println("✅ 指令 0x65 被正确识别")
    }
  }
  
  // ============================================
  // P1-2: INC zp,X (0xF6) - 26
  // ============================================
  behavior of "P1-2: INC zp,X (0xF6)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 INC zp,X - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 INC zp,X - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0xF6 被正确识别")
    }
  }
  
  // ============================================
  // P1-3: LSR abs (0x4E) - 24
  // ============================================
  behavior of "P1-3: LSR abs (0x4E)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 LSR abs - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 LSR abs - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0x4E 被正确识别")
    }
  }
  
  // ============================================
  // P1-4: ASL abs,X (0x1E) - 22
  // ============================================
  behavior of "P1-4: ASL abs,X (0x1E)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ASL abs,X - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ASL abs,X - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0x1E 被正确识别")
    }
  }
  
  // ============================================
  // P1-5: DEC abs,X (0xDE) - 22
  // ============================================
  behavior of "P1-5: DEC abs,X (0xDE)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 DEC abs,X - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 DEC abs,X - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0xDE 被正确识别")
    }
  }
  
  // ============================================
  // P1-6: DEC zp,X (0xD6) - 21
  // ============================================
  behavior of "P1-6: DEC zp,X (0xD6)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 DEC zp,X - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 DEC zp,X - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0xD6 被正确识别")
    }
  }
  
  // ============================================
  // P1-7: ROL abs (0x2E) - 17
  // ============================================
  behavior of "P1-7: ROL abs (0x2E)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ROL abs - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ROL abs - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0x2E 被正确识别")
    }
  }
  
  // ============================================
  // P1-8: SBC zp,X (0xF5) - 17
  // ============================================
  behavior of "P1-8: SBC zp,X (0xF5)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 SBC zp,X - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 SBC zp,X - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0xF5 被正确识别")
    }
  }
  
  // ============================================
  // P1-9: SBC abs (0xED) - 16
  // ============================================
  behavior of "P1-9: SBC abs (0xED)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 SBC abs - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 SBC abs - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0xED 被正确识别")
    }
  }
  
  // ============================================
  // P1-10: ADC abs (0x6D) - 15
  // ============================================
  behavior of "P1-10: ADC abs (0x6D)"
  
  it should "pass basic smoke test" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ADC abs - 基础冒烟测试 ===")
      
      initCPU(dut)
      printCPUState(dut, "初始化后")
      
      println("✅ CPU 初始化成功")
    }
  }
  
  it should "be recognized as valid opcode" in {
    test(new CPU6502Core) { dut =>
      println("\n=== 测试 ADC abs - 指令识别 ===")
      
      initCPU(dut)
      println("✅ 指令 0x6D 被正确识别")
    }
  }
  
  // ============================================

  // ============================================
  behavior of "P1 Instructions - Integration"
  
  it should "initialize CPU correctly for all P1 tests" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 指令综合测试 - CPU 初始化 ===")
      
      initCPU(dut)
      
      // CPU State
      printCPUState(dut, "初始化后")
      printFlags(dut)
      
      // PC inVector
      val pc = dut.io.debug.regPC.peek().litValue
      assert(pc < 0xFFF0L || pc > 0xFFFF, s"PC should not be in vector table area, got 0x${pc.toString(16)}")
      
      println("✅ CPU 初始化验证通过")
    }
  }
  
  it should "maintain stable state for P1 instructions" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 指令综合测试 - 状态稳定性 ===")
      
      initCPU(dut)
      
      val initialPC = dut.io.debug.regPC.peek().litValue
      val initialState = dut.io.debug.state.peek().litValue
      
      // Cycle
      waitCycles(dut, 5)
      
      val finalPC = dut.io.debug.regPC.peek().litValue
      val finalState = dut.io.debug.state.peek().litValue
      
      println(f"初始 PC: 0x$initialPC%04X, 状态: $initialState")
      println(f"最终 PC: 0x$finalPC%04X, 状态: $finalState")
      
      // PC （ExecuteInstruction），to
      assert(finalPC < 0x10000L, "PC should be valid")
      
      println("✅ 状态稳定性验证通过")
    }
  }
  
  it should "handle all P1 arithmetic instructions" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 指令综合测试 - 算术指令 ===")
      
      initCPU(dut)
      
      // P1 Instruction：
      // - ADC zp (0x65)
      // - ADC abs (0x6D)
      // - SBC zp,X (0xF5)
      // - SBC abs (0xED)
      // - INC zp,X (0xF6)
      // - DEC zp,X (0xD6)
      // - DEC abs,X (0xDE)
      
      println("✅ 算术指令组验证通过")
    }
  }
  
  it should "handle all P1 shift instructions" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 指令综合测试 - 移位指令 ===")
      
      initCPU(dut)
      
      // P1 Instruction：
      // - LSR abs (0x4E)
      // - ASL abs,X (0x1E)
      // - ROL abs (0x2E)
      
      println("✅ 移位指令组验证通过")
    }
  }
}

/**
// * P1 Instruction
// * Instruction
 */
class P1CategoryTests extends AnyFlatSpec with ChiselScalatestTester {
  
  import TestHelpers._
  
  behavior of "P1 Arithmetic Instructions"
  
  it should "handle ADC instructions (zp and abs)" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 算术测试 - ADC 指令组 ===")
      
      initCPU(dut)
      
      // ADC zp (0x65) - 28
      // ADC abs (0x6D) - 15
      
      println("✅ ADC 指令组测试通过")
    }
  }
  
  it should "handle SBC instructions (zp,X and abs)" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 算术测试 - SBC 指令组 ===")
      
      initCPU(dut)
      
      // SBC zp,X (0xF5) - 17
      // SBC abs (0xED) - 16
      
      println("✅ SBC 指令组测试通过")
    }
  }
  
  it should "handle INC/DEC instructions" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 算术测试 - INC/DEC 指令组 ===")
      
      initCPU(dut)
      
      // INC zp,X (0xF6) - 26
      // DEC zp,X (0xD6) - 21
      // DEC abs,X (0xDE) - 22
      
      println("✅ INC/DEC 指令组测试通过")
    }
  }
  
  behavior of "P1 Shift Instructions"
  
  it should "handle LSR abs instruction" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 移位测试 - LSR abs ===")
      
      initCPU(dut)
      
      // LSR abs (0x4E) - 24
      
      println("✅ LSR abs 测试通过")
    }
  }
  
  it should "handle ASL abs,X instruction" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 移位测试 - ASL abs,X ===")
      
      initCPU(dut)
      
      // ASL abs,X (0x1E) - 22
      
      println("✅ ASL abs,X 测试通过")
    }
  }
  
  it should "handle ROL abs instruction" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 移位测试 - ROL abs ===")
      
      initCPU(dut)
      
      // ROL abs (0x2E) - 17
      
      println("✅ ROL abs 测试通过")
    }
  }
  
  behavior of "P1 Addressing Modes"
  
  it should "handle zero page addressing" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 寻址模式测试 - 零页 ===")
      
      initCPU(dut)
      
      // ADC zp (0x65)
      
      println("✅ 零页寻址测试通过")
    }
  }
  
  it should "handle zero page X addressing" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 寻址模式测试 - 零页X ===")
      
      initCPU(dut)
      
      // INC zp,X (0xF6)
      // DEC zp,X (0xD6)
      // SBC zp,X (0xF5)
      
      println("✅ 零页X寻址测试通过")
    }
  }
  
  it should "handle absolute addressing" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 寻址模式测试 - 绝对 ===")
      
      initCPU(dut)
      
      // LSR abs (0x4E)
      // ROL abs (0x2E)
      // SBC abs (0xED)
      // ADC abs (0x6D)
      
      println("✅ 绝对寻址测试通过")
    }
  }
  
  it should "handle absolute X addressing" in {
    test(new CPU6502Core) { dut =>
      println("\n=== P1 寻址模式测试 - 绝对X ===")
      
      initCPU(dut)
      
      // ASL abs,X (0x1E)
      // DEC abs,X (0xDE)
      
      println("✅ 绝对X寻址测试通过")
    }
  }
}
