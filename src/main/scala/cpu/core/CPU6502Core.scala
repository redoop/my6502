package cpu6502.core

import chisel3._
import chisel3.util._
import cpu6502.instructions._

// 6502 CPU 核心模块 (重构版)
class CPU6502Core extends Module {
  val io = IO(new Bundle {
    val memAddr    = Output(UInt(16.W))
    val memDataOut = Output(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val memWrite   = Output(Bool())
    val memRead    = Output(Bool())
    val debug      = Output(new DebugBundle)
    val reset      = Input(Bool())  // Reset 信号
    val nmi        = Input(Bool())  // NMI 中断信号
  })

  // 寄存器
  val regs = RegInit(Registers.default())
  
  // CPU 状态机
  val sReset :: sFetch :: sExecute :: sNMI :: sDone :: Nil = Enum(5)
  val state = RegInit(sReset)
  
  val opcode  = RegInit(0.U(8.W))
  val operand = RegInit(0.U(16.W))
  val cycle   = RegInit(0.U(3.W))
  
  // NMI 边沿检测
  val nmiLast = RegInit(false.B)
  val nmiEdge = RegInit(false.B)
  
  // 检测 NMI 上升沿
  when(io.nmi && !nmiLast) {
    nmiEdge := true.B
  }
  nmiLast := io.nmi

  // 默认内存接口信号
  io.memAddr    := regs.pc
  io.memDataOut := 0.U
  io.memWrite   := false.B
  io.memRead    := false.B

  // 指令执行结果
  val execResult = Wire(new ExecutionResult)
  execResult := ExecutionResult.hold(regs, operand)

  // Reset 标志：用于检测 reset 刚刚释放
  val resetReleased = RegInit(false.B)
  
  // 状态机
  when(io.reset) {
    // Reset 时初始化状态
    state := sReset
    cycle := 0.U
    regs.pc := 0.U
    resetReleased := false.B
  }.otherwise {
    when(!resetReleased) {
      // Reset 刚释放，等待一个周期让寄存器稳定
      resetReleased := true.B
      cycle := 0.U
    }.otherwise {
      switch(state) {
        is(sReset) {
          // Reset 序列: 读取 Reset Vector ($FFFC-$FFFD)
          when(cycle === 0.U) {
            // 读取低字节
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            operand := io.memDataIn
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // 读取高字节
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            cycle := 3.U
          }.otherwise {  // cycle === 3
            // 设置 PC 并进入 Fetch 状态
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            val resetVector = Cat(io.memDataIn, operand(7, 0))
            regs.pc := resetVector
            cycle := 0.U
            state := sFetch
          }
        }
    
        is(sFetch) {
          // 检查是否有 NMI 中断
          when(nmiEdge) {
            nmiEdge := false.B
            cycle := 0.U
            state := sNMI
          }.otherwise {
            io.memAddr := regs.pc
            io.memRead := true.B
            opcode := io.memDataIn
            regs.pc := regs.pc + 1.U
            cycle := 0.U
            state := sExecute
          }
        }

        is(sExecute) {
          // 根据 opcode 分发到对应指令模块
          execResult := dispatchInstruction(opcode, cycle, regs, operand, io.memDataIn)
          
          // 应用执行结果
          io.memAddr    := execResult.memAddr
          io.memDataOut := execResult.memData
          io.memWrite   := execResult.memWrite
          io.memRead    := execResult.memRead
          
          regs    := execResult.regs
          operand := execResult.operand
          cycle   := execResult.nextCycle
          
          when(execResult.done) {
            cycle := 0.U
            state := sFetch
          }
        }

        is(sNMI) {
          // NMI 中断处理 (7 个周期)
          when(cycle === 0.U) {
            // 周期 1: 空操作
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            // 周期 2: 将 PC 高字节压栈
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := regs.pc(15, 8)
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // 周期 3: 将 PC 低字节压栈
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := regs.pc(7, 0)
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // 周期 4: 将状态寄存器压栈 (B 标志清除)
            val status = Cat(regs.flagN, regs.flagV, 1.U(1.W), 0.U(1.W), 
                           regs.flagD, regs.flagI, regs.flagZ, regs.flagC)
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := status
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 4.U
          }.elsewhen(cycle === 4.U) {
            // 周期 5: 读取 NMI 向量低字节 (0xFFFA)
            io.memAddr := 0xFFFA.U
            io.memRead := true.B
            cycle := 5.U
          }.elsewhen(cycle === 5.U) {
            // 周期 6: 保存低字节，读取高字节 (0xFFFB)
            io.memAddr := 0xFFFA.U
            io.memRead := true.B
            operand := io.memDataIn
            cycle := 6.U
          }.otherwise {  // cycle === 6
            // 周期 7: 读取高字节，设置 PC
            io.memAddr := 0xFFFB.U
            io.memRead := true.B
            val nmiVector = Cat(io.memDataIn, operand(7, 0))
            regs.pc := nmiVector
            regs.flagI := true.B  // 设置中断禁止标志
            cycle := 0.U
            state := sFetch
          }
        }

        is(sDone) {
          // 保持状态
        }
      }
    }
  }

  // 调试输出
  io.debug := DebugBundle.fromRegisters(regs, opcode, state, cycle)

  // 指令分发器
  def dispatchInstruction(
    opcode: UInt, 
    cycle: UInt, 
    regs: Registers, 
    operand: UInt, 
    memDataIn: UInt
  ): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    result := ExecutionResult.hold(regs, operand)
    
    switch(opcode) {
      // ========== Flag 指令 ==========
      is(0x18.U, 0x38.U, 0xD8.U, 0xF8.U, 0x58.U, 0x78.U, 0xB8.U, 0xEA.U) {
        result := FlagInstructions.execute(opcode, regs)
      }
      
      // ========== Transfer 指令 ==========
      is(0xAA.U, 0xA8.U, 0x8A.U, 0x98.U, 0xBA.U, 0x9A.U) {
        result := TransferInstructions.execute(opcode, regs)
      }
      
      // ========== Arithmetic 隐含寻址 ==========
      is(0xE8.U, 0xC8.U, 0xCA.U, 0x88.U, 0x1A.U, 0x3A.U) {
        result := ArithmeticInstructions.executeImplied(opcode, regs)
      }
      
      // ========== Arithmetic 立即寻址 ==========
      is(0x69.U) { result := ArithmeticInstructions.executeADCImmediate(regs, memDataIn) }
      is(0xE9.U) { result := ArithmeticInstructions.executeSBCImmediate(regs, memDataIn) }
      
      // ========== Arithmetic 零页 ==========
      is(0xE6.U, 0xC6.U) {
        result := ArithmeticInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 立即寻址 ==========
      is(0x29.U, 0x09.U, 0x49.U) {
        result := LogicInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Logic BIT 零页 ==========
      is(0x24.U) {
        result := LogicInstructions.executeBIT(cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift 累加器 ==========
      is(0x0A.U, 0x4A.U, 0x2A.U, 0x6A.U) {
        result := ShiftInstructions.executeAccumulator(opcode, regs)
      }
      
      // ========== Shift 零页 ==========
      is(0x06.U, 0x46.U, 0x26.U, 0x66.U) {
        result := ShiftInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 立即寻址 ==========
      is(0xC9.U, 0xE0.U, 0xC0.U) {
        result := CompareInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Compare 零页 ==========
      is(0xC5.U) {
        result := CompareInstructions.executeZeroPage(cycle, regs, operand, memDataIn)
      }
      
      // ========== Branch 指令 ==========
      is(0xF0.U, 0xD0.U, 0xB0.U, 0x90.U, 0x30.U, 0x10.U, 0x50.U, 0x70.U) {
        result := BranchInstructions.execute(opcode, regs, memDataIn)
      }
      
      // ========== LoadStore 立即寻址 ==========
      is(0xA9.U, 0xA2.U, 0xA0.U) {
        result := LoadStoreInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== LoadStore 零页 ==========
      is(0xA5.U, 0x85.U, 0x86.U, 0x84.U) {
        result := LoadStoreInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 零页 X ==========
      is(0xB5.U, 0x95.U) {
        result := LoadStoreInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 绝对寻址 ==========
      is(0xAD.U, 0x8D.U) {
        result := LoadStoreInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 绝对索引 ==========
      is(0xBD.U, 0xB9.U) {
        result := LoadStoreInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Stack Push ==========
      is(0x48.U, 0x08.U) {
        result := StackInstructions.executePush(opcode, regs)
      }
      
      // ========== Stack Pull ==========
      is(0x68.U, 0x28.U) {
        result := StackInstructions.executePull(opcode, cycle, regs, memDataIn)
      }
      
      // ========== Jump 指令 ==========
      is(0x4C.U) { result := JumpInstructions.executeJMP(cycle, regs, operand, memDataIn) }
      is(0x20.U) { result := JumpInstructions.executeJSR(cycle, regs, operand, memDataIn) }
      is(0x60.U) { result := JumpInstructions.executeRTS(cycle, regs, operand, memDataIn) }
      is(0x00.U) { result := JumpInstructions.executeBRK(cycle, regs, operand, memDataIn) }
      is(0x40.U) { result := JumpInstructions.executeRTI(cycle, regs, operand, memDataIn) }
    }
    
    result
  }
}
