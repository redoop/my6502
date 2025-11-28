package cpu6502.instructions

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import cpu6502.core.Registers

class JumpInstructionsSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "JumpInstructions - JMP"
  
  it should "JMP cycle 0 reads low byte" in {
    val regs = Registers.default()
    regs.pc := 0x1000.U
    
    val result = JumpInstructions.executeJMP(0.U, regs, 0.U, 0x34.U)
    
    assert(result.memAddr.litValue == 0x1000)
    assert(result.memRead.litToBoolean)
    assert(result.operand.litValue == 0x34)
    assert(result.regs.pc.litValue == 0x1001)
    assert(!result.done.litToBoolean)
  }
  
  it should "JMP cycle 1 reads high byte and jumps" in {
    val regs = Registers.default()
    regs.pc := 0x1001.U
    
    val result = JumpInstructions.executeJMP(1.U, regs, 0x34.U, 0x12.U)
    
    assert(result.memAddr.litValue == 0x1001)
    assert(result.memRead.litToBoolean)
    assert(result.operand.litValue == 0x1234)
    assert(result.regs.pc.litValue == 0x1234)
    assert(result.done.litToBoolean)
  }
  
  behavior of "JumpInstructions - JSR"
  
  it should "JSR cycle 0 reads low byte" in {
    val regs = Registers.default()
    regs.pc := 0x1000.U
    regs.sp := 0xFF.U
    
    val result = JumpInstructions.executeJSR(0.U, regs, 0.U, 0x34.U)
    
    assert(result.memAddr.litValue == 0x1000)
    assert(result.memRead.litToBoolean)
    assert(result.operand.litValue == 0x34)
    assert(result.regs.pc.litValue == 0x1001)
    assert(!result.done.litToBoolean)
  }
  
  it should "JSR cycle 1 reads high byte" in {
    val regs = Registers.default()
    regs.pc := 0x1001.U
    regs.sp := 0xFF.U
    
    val result = JumpInstructions.executeJSR(1.U, regs, 0x34.U, 0x12.U)
    
    assert(result.memAddr.litValue == 0x1001)
    assert(result.memRead.litToBoolean)
    assert(result.operand.litValue == 0x1234)
    assert(result.regs.pc.litValue == 0x1002)
    assert(!result.done.litToBoolean)
  }
  
  it should "JSR cycle 2 pushes PC-1 high byte" in {
    val regs = Registers.default()
    regs.pc := 0x1002.U
    regs.sp := 0xFF.U
    
    val result = JumpInstructions.executeJSR(2.U, regs, 0x1234.U, 0.U)
    
    // Should push (PC-1) high byte = 0x1001 high = 0x10
    assert(result.memAddr.litValue == 0x01FF)
    assert(result.memWrite.litToBoolean)
    assert(result.memData.litValue == 0x10)
    assert(result.regs.sp.litValue == 0xFE)
    assert(!result.done.litToBoolean)
  }
  
  it should "JSR cycle 3 pushes PC-1 low byte and jumps" in {
    val regs = Registers.default()
    regs.pc := 0x1002.U
    regs.sp := 0xFE.U
    
    val result = JumpInstructions.executeJSR(3.U, regs, 0x1234.U, 0.U)
    
    // Should push (PC-1) low byte = 0x1001 low = 0x01
    assert(result.memAddr.litValue == 0x01FE)
    assert(result.memWrite.litToBoolean)
    assert(result.memData.litValue == 0x01)
    assert(result.regs.sp.litValue == 0xFD)
    assert(result.regs.pc.litValue == 0x1234)
    assert(result.done.litToBoolean)
  }
  
  behavior of "JumpInstructions - RTS"
  
  it should "RTS cycle 0 increments SP" in {
    val regs = Registers.default()
    regs.sp := 0xFD.U
    
    val result = JumpInstructions.executeRTS(0.U, regs, 0.U, 0.U)
    
    assert(result.regs.sp.litValue == 0xFE)
    assert(!result.done.litToBoolean)
  }
  
  it should "RTS cycle 1 reads low byte" in {
    val regs = Registers.default()
    regs.sp := 0xFE.U
    
    val result = JumpInstructions.executeRTS(1.U, regs, 0.U, 0x01.U)
    
    assert(result.memAddr.litValue == 0x01FE)
    assert(result.memRead.litToBoolean)
    assert(result.operand.litValue == 0x01)
    assert(result.regs.sp.litValue == 0xFF)
    assert(!result.done.litToBoolean)
  }
  
  it should "RTS cycle 2 reads high byte and returns" in {
    val regs = Registers.default()
    regs.sp := 0xFF.U
    
    val result = JumpInstructions.executeRTS(2.U, regs, 0x01.U, 0x10.U)
    
    assert(result.memAddr.litValue == 0x01FF)
    assert(result.memRead.litToBoolean)
    // RTS should return to (stacked_addr + 1) = 0x1001 + 1 = 0x1002
    assert(result.regs.pc.litValue == 0x1002)
    assert(result.done.litToBoolean)
  }
}
