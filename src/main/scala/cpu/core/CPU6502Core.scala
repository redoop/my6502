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
  
  // 始终更新 nmiLast
  nmiLast := io.nmi
  
  // 检测 NMI 上升沿
  when(io.nmi && !nmiLast) {
    nmiEdge := true.B
  }
  
  // 在进入 NMI 状态时清除边沿标志
  when(state === sNMI) {
    nmiEdge := false.B
  }

  // 默认内存接口信号
  io.memAddr    := regs.pc
  io.memDataOut := 0.U
  io.memWrite   := false.B
  io.memRead    := false.B

  // 指令执行结果
  val execResult = Wire(new ExecutionResult)
  execResult := ExecutionResult.hold(regs, operand)

  // 状态机
  when(io.reset) {
    // Reset 时初始化状态
    state := sReset
    cycle := 0.U
    regs.pc := 0.U
    regs.sp := 0xFF.U
  }.otherwise {
    switch(state) {
        is(sReset) {
          // Reset 序列: 读取 Reset Vector ($FFFC-$FFFD)
          // 注意：即使 PRG ROM 使用 Mem (异步读)，在 Verilator 中仍需要时序考虑
          when(cycle === 0.U) {
            // 周期 0: 发起读取低字节
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            cycle := 1.U

          }.elsewhen(cycle === 1.U) {
            // 周期 1: 保存低字节到 operand 寄存器
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            operand := io.memDataIn  // 保存到寄存器
            cycle := 2.U

          }.elsewhen(cycle === 2.U) {
            // 周期 2: 发起读取高字节（operand 已经在上个周期保存）
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            cycle := 3.U

          }.elsewhen(cycle === 3.U) {
            // 周期 3: 等待数据稳定
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            cycle := 4.U

          }.otherwise {  // cycle === 4
            // 周期 4: 读取高字节，设置 PC 并进入 Fetch
            io.memAddr := 0xFFFD.U  // 保持地址
            io.memRead := true.B
            val resetVector = Cat(io.memDataIn, operand(7, 0))
            regs.pc := resetVector
            regs.sp := 0xFD.U  // 初始化 SP
            regs.flagI := true.B  // 设置中断禁止标志
            cycle := 0.U
            state := sFetch

          }
        }
    
        is(sFetch) {
          // 检查是否有 NMI 中断
          when(nmiEdge) {
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
            operand := io.memDataIn
            cycle := 5.U
          }.elsewhen(cycle === 5.U) {
            // 周期 6: 读取高字节 (0xFFFB)
            io.memAddr := 0xFFFB.U
            io.memRead := true.B
            cycle := 6.U
          }.otherwise {  // cycle === 6
            // 周期 7: 设置 PC
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
      
      // ========== ADC/SBC 零页 ==========
      is(0x65.U, 0xE5.U) {
        result := ArithmeticInstructions.executeADCSBCZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC 零页 X ==========
      is(0x75.U, 0xF5.U) {
        result := ArithmeticInstructions.executeADCSBCZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC 绝对 ==========
      is(0x6D.U, 0xED.U) {
        result := ArithmeticInstructions.executeADCSBCAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC 间接 X ==========
      is(0x61.U, 0xE1.U) {
        result := ArithmeticInstructions.executeADCSBCIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC 间接 Y ==========
      is(0x71.U, 0xF1.U) {
        result := ArithmeticInstructions.executeADCSBCIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC 零页 ==========
      is(0xE6.U, 0xC6.U) {
        result := ArithmeticInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC 零页 X ==========
      is(0xF6.U, 0xD6.U) {
        result := ArithmeticInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC 绝对 ==========
      is(0xEE.U, 0xCE.U) {
        result := ArithmeticInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC 绝对 X ==========
      is(0xFE.U, 0xDE.U) {
        result := ArithmeticInstructions.executeAbsoluteX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC 绝对索引 ==========
      is(0x79.U, 0xF9.U, 0x7D.U, 0xFD.U) {
        result := ArithmeticInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 立即寻址 ==========
      is(0x29.U, 0x09.U, 0x49.U) {
        result := LogicInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Logic 零页 ==========
      is(0x24.U) {
        result := LogicInstructions.executeBIT(cycle, regs, operand, memDataIn)
      }
      is(0x25.U, 0x05.U, 0x45.U) {
        result := LogicInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 零页 X ==========
      is(0x35.U, 0x15.U, 0x55.U) {
        result := LogicInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 绝对 ==========
      is(0x2C.U, 0x2D.U, 0x0D.U, 0x4D.U) {
        result := LogicInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 绝对索引 ==========
      is(0x3D.U, 0x1D.U, 0x5D.U, 0x39.U, 0x19.U, 0x59.U) {
        result := LogicInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 间接 X ==========
      is(0x21.U, 0x01.U, 0x41.U) {
        result := LogicInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic 间接 Y ==========
      is(0x31.U, 0x11.U, 0x51.U) {
        result := LogicInstructions.executeIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift 累加器 ==========
      is(0x0A.U, 0x4A.U, 0x2A.U, 0x6A.U) {
        result := ShiftInstructions.executeAccumulator(opcode, regs)
      }
      
      // ========== Shift 零页 ==========
      is(0x06.U, 0x46.U, 0x26.U, 0x66.U) {
        result := ShiftInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift 零页 X ==========
      is(0x16.U, 0x56.U, 0x36.U, 0x76.U) {
        result := ShiftInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift 绝对 ==========
      is(0x0E.U, 0x4E.U, 0x2E.U, 0x6E.U) {
        result := ShiftInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift 绝对 X ==========
      is(0x1E.U, 0x5E.U, 0x3E.U, 0x7E.U) {
        result := ShiftInstructions.executeAbsoluteX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 立即寻址 ==========
      is(0xC9.U, 0xE0.U, 0xC0.U) {
        result := CompareInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Compare 零页 ==========
      is(0xC5.U, 0xE4.U, 0xC4.U) {
        result := CompareInstructions.executeZeroPageGeneric(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 零页 X ==========
      is(0xD5.U) {
        result := CompareInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 绝对 ==========
      is(0xCD.U, 0xEC.U, 0xCC.U) {
        result := CompareInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 绝对索引 ==========
      is(0xDD.U, 0xD9.U) {
        result := CompareInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 间接 X ==========
      is(0xC1.U) {
        result := CompareInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 间接 Y ==========
      is(0xD1.U) {
        result := CompareInstructions.executeIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare 间接 (65C02) ==========
      is(0xD2.U) {
        result := CompareInstructions.executeIndirect(opcode, cycle, regs, operand, memDataIn)
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
      is(0xA5.U, 0x85.U, 0x86.U, 0x84.U, 0xA6.U, 0xA4.U) {
        result := LoadStoreInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 零页 X ==========
      is(0xB5.U, 0x95.U, 0xB4.U, 0x94.U) {
        result := LoadStoreInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 零页 Y ==========
      is(0xB6.U, 0x96.U) {
        result := LoadStoreInstructions.executeZeroPageY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 绝对寻址 ==========
      is(0xAD.U, 0x8D.U, 0x8E.U, 0x8C.U, 0xAE.U, 0xAC.U) {
        result := LoadStoreInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 绝对索引 ==========
      is(0xBD.U, 0xB9.U, 0xBC.U, 0xBE.U, 0x9D.U, 0x99.U) {
        result := LoadStoreInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 间接 X ==========
      is(0xA1.U, 0x81.U) {
        result := LoadStoreInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore 间接 Y ==========
      is(0x91.U, 0xB1.U) {
        result := LoadStoreInstructions.executeIndirectY(opcode, cycle, regs, operand, memDataIn)
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
      is(0x6C.U) { result := JumpInstructions.executeJMPIndirect(cycle, regs, operand, memDataIn) }
      is(0x20.U) { result := JumpInstructions.executeJSR(cycle, regs, operand, memDataIn) }
      is(0x60.U) { result := JumpInstructions.executeRTS(cycle, regs, operand, memDataIn) }
      is(0x00.U) { result := JumpInstructions.executeBRK(cycle, regs, operand, memDataIn) }
      is(0x40.U) { result := JumpInstructions.executeRTI(cycle, regs, operand, memDataIn) }
    }
    
    result
  }
}
