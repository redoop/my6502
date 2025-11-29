package cpu6502.instructions

import chisel3._
import chisel3.util._
import cpu6502.core._

// 加载/存储指令: LDA, LDX, LDY, STA, STX, STY
object LoadStoreInstructions {
  val immediateOpcodes = Seq(0xA9, 0xA2, 0xA0)
  val zeroPageOpcodes = Seq(0xA5, 0x85, 0x86, 0x84, 0xA6, 0xA4)  // LDA/STA/STX/STY/LDX/LDY
  val zeroPageXOpcodes = Seq(0xB5, 0x95, 0xB4, 0x94)  // LDA/STA zp,X + LDY/STY zp,X
  val zeroPageYOpcodes = Seq(0xB6, 0x96)  // LDX/STX zp,Y
  val absoluteOpcodes = Seq(0xAD, 0x8D, 0x8E, 0x8C, 0xAE, 0xAC)  // LDA/STA/STX/STY/LDX/LDY
  val absoluteXOpcodes = Seq(0xBD, 0xBC, 0x9D, 0x99)  // LDA/LDY abs,X + STA abs,X/Y
  val absoluteYOpcodes = Seq(0xB9, 0xBE)  // LDA/LDX abs,Y
  val indirectXOpcodes = Seq(0xA1, 0x81)  // LDA/STA (ind,X)
  val indirectYOpcodes = Seq(0x91, 0xB1)  // STA/LDA (ind),Y
  
  val opcodes = immediateOpcodes ++ zeroPageOpcodes ++ zeroPageXOpcodes ++ zeroPageYOpcodes ++
                absoluteOpcodes ++ absoluteXOpcodes ++ absoluteYOpcodes ++ 
                indirectXOpcodes ++ indirectYOpcodes
  
  // 立即寻址 (LDA, LDX, LDY)
  def executeImmediate(opcode: UInt, cycle: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    // Fetch 已经预读了立即数，直接使用 memDataIn
    switch(opcode) {
      is(0xA9.U) { newRegs.a := memDataIn }  // LDA
      is(0xA2.U) { newRegs.x := memDataIn }  // LDX
      is(0xA0.U) { newRegs.y := memDataIn }  // LDY
    }
    
    newRegs.flagN := memDataIn(7)
    newRegs.flagZ := memDataIn === 0.U
    newRegs.pc := regs.pc + 1.U
    
    result.done := true.B
    result.nextCycle := 0.U
    result.regs := newRegs
    result.memAddr := regs.pc
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := 0.U
    result
  }
  
  // 零页寻址 (LDA, STA, STX, STY)
  def executeZeroPage(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoadA = opcode === 0xA5.U
    val isLoadX = opcode === 0xA6.U
    val isLoadY = opcode === 0xA4.U
    val isStoreA = opcode === 0x85.U
    val isStoreX = opcode === 0x86.U
    val isStoreY = opcode === 0x84.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := operand
        when(isLoadA || isLoadX || isLoadY) {
          result.memRead := true.B
          when(isLoadA) {
            newRegs.a := memDataIn
          }.elsewhen(isLoadX) {
            newRegs.x := memDataIn
          }.otherwise {
            newRegs.y := memDataIn
          }
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := Mux(isStoreA, regs.a, Mux(isStoreX, regs.x, regs.y))
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 零页 X 索引
  def executeZeroPageX(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoadA = opcode === 0xB5.U
    val isLoadY = opcode === 0xB4.U
    val isStoreY = opcode === 0x94.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := operand
        when(isLoadA || isLoadY) {
          result.memRead := true.B
          when(isLoadA) {
            newRegs.a := memDataIn
          }.otherwise {
            newRegs.y := memDataIn
          }
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := Mux(opcode === 0x95.U, regs.a, regs.y)
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 零页 Y 索引 (LDX/STX zp,Y)
  def executeZeroPageY(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoad = opcode === 0xB6.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.y)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        result.memAddr := operand
        when(isLoad) {
          result.memRead := true.B
          newRegs.x := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }.otherwise {
          result.memWrite := true.B
          result.memData := regs.x
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 绝对寻址
  def executeAbsolute(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoadA = opcode === 0xAD.U
    val isLoadX = opcode === 0xAE.U
    val isLoadY = opcode === 0xAC.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
        when(opcode === 0x8D.U) {
          printf("[STA abs] Cycle 0: Read low byte = 0x%x from PC=0x%x\n", memDataIn, regs.pc)
        }
      }
      is(1.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := operand  // 保持低字节
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
        when(opcode === 0x8D.U) {
          printf("[STA abs] Cycle 1: Request high byte from PC=0x%x\n", regs.pc)
        }
      }
      is(2.U) {
        // Cycle 2: 读取高字节并组装地址
        result.memAddr := regs.pc
        result.memRead := false.B
        result.operand := Cat(memDataIn, operand(7, 0))
        result.nextCycle := 3.U
        when(opcode === 0x8D.U) {
          printf("[STA abs] Cycle 2: Read high byte = 0x%x, Address = 0x%x\n", 
                 memDataIn, Cat(memDataIn, operand(7, 0)))
        }
      }
      is(3.U) {
        // Cycle 3: 发出读/写请求
        result.memAddr := operand
        when(isLoadA || isLoadX || isLoadY) {
          result.memRead := true.B
        }.otherwise {
          result.memWrite := true.B
          result.memData := MuxCase(regs.a, Seq(
            (opcode === 0x8E.U) -> regs.x,
            (opcode === 0x8C.U) -> regs.y
          ))
        }
        result.nextCycle := 4.U
      }
      is(4.U) {
        // Cycle 4: 完成
        result.memAddr := operand
        when(isLoadA || isLoadX || isLoadY) {
          when(isLoadA) {
            newRegs.a := memDataIn
          }.elsewhen(isLoadX) {
            newRegs.x := memDataIn
          }.otherwise {
            newRegs.y := memDataIn
          }
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
        }
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 绝对 X/Y 索引
  def executeAbsoluteIndexed(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    // 判断使用 X 还是 Y 索引
    val useY = (opcode === 0xB9.U) || (opcode === 0xBE.U) || (opcode === 0x99.U)
    val indexReg = Mux(useY, regs.y, regs.x)
    
    val isLoadA = opcode === 0xBD.U || opcode === 0xB9.U
    val isLoadX = opcode === 0xBE.U
    val isLoadY = opcode === 0xBC.U
    val isStoreA = opcode === 0x9D.U || opcode === 0x99.U
    
    switch(cycle) {
      is(0.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 1.U
      }
      is(1.U) {
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0)) + indexReg
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
        result.nextCycle := 2.U
      }
      is(2.U) {
        result.memAddr := operand
        result.memRead := true.B
        newRegs.a := memDataIn
        newRegs.flagN := memDataIn(7)
        newRegs.flagZ := memDataIn === 0.U
        result.regs := newRegs
        result.done := true.B
      }
    }
    
    result
  }
  
  // 间接 X 索引 (ind,X) - LDA/STA
  def executeIndirectX(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoad = opcode === 0xA1.U
    
    switch(cycle) {
      is(0.U) {
        // 读取零页地址
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := (memDataIn + regs.x)(7, 0)
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // 读取间接地址的低字节
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        // 读取间接地址的高字节
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
      }
      is(3.U) {
        // 访问最终地址
        result.memAddr := operand
        when(isLoad) {
          result.memRead := true.B
        }.otherwise {
          result.memWrite := true.B
          result.memData := regs.a
        }
      }
      is(4.U) {
        // 对于 load，保存数据
        when(isLoad) {
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
          result.regs := newRegs
        }
        result.done := true.B
      }
    }
    
    result
  }
  
  // 间接索引 Y (indirect),Y - LDA/STA
  def executeIndirectY(opcode: UInt, cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    val newRegs = Wire(new Registers)
    newRegs := regs
    
    result.done := false.B
    result.nextCycle := cycle + 1.U
    result.regs := newRegs
    result.memAddr := 0.U
    result.memData := 0.U
    result.memWrite := false.B
    result.memRead := false.B
    result.operand := operand
    
    val isLoad = opcode === 0xB1.U
    
    switch(cycle) {
      is(0.U) {
        // 读取零页地址
        result.memAddr := regs.pc
        result.memRead := true.B
        result.operand := memDataIn
        newRegs.pc := regs.pc + 1.U
        result.regs := newRegs
      }
      is(1.U) {
        // 读取间接地址的低字节
        result.memAddr := operand(7, 0)
        result.memRead := true.B
        result.operand := Cat(operand(15, 8), memDataIn)
      }
      is(2.U) {
        // 读取间接地址的高字节
        result.memAddr := (operand(7, 0) + 1.U)(7, 0)
        result.memRead := true.B
        result.operand := Cat(memDataIn, operand(7, 0))
      }
      is(3.U) {
        // 加上 Y 索引，访问最终地址
        val finalAddr = operand + regs.y
        result.memAddr := finalAddr
        when(isLoad) {
          result.memRead := true.B
        }.otherwise {
          result.memWrite := true.B
          result.memData := regs.a
        }
      }
      is(4.U) {
        // 对于 load，保存数据
        when(isLoad) {
          newRegs.a := memDataIn
          newRegs.flagN := memDataIn(7)
          newRegs.flagZ := memDataIn === 0.U
          result.regs := newRegs
        }
        result.done := true.B
      }
    }
    
    result
  }
}
