package cpu6502

import chisel3._
import chisel3.util._

// 6502 CPU 主模块
class CPU6502 extends Module {
  val io = IO(new Bundle {
    val memAddr = Output(UInt(16.W))
    val memDataOut = Output(UInt(8.W))
    val memDataIn = Input(UInt(8.W))
    val memWrite = Output(Bool())
    val memRead = Output(Bool())
    val debug = Output(new DebugBundle)
  })

  // 寄存器
  val regA = RegInit(0.U(8.W))      // 累加器
  val regX = RegInit(0.U(8.W))      // X 索引寄存器
  val regY = RegInit(0.U(8.W))      // Y 索引寄存器
  val regSP = RegInit(0xFF.U(8.W))  // 栈指针
  val regPC = RegInit(0.U(16.W))    // 程序计数器
  
  // 状态标志 (P 寄存器)
  val flagC = RegInit(false.B)  // Carry
  val flagZ = RegInit(false.B)  // Zero
  val flagI = RegInit(false.B)  // Interrupt Disable
  val flagD = RegInit(false.B)  // Decimal Mode
  val flagB = RegInit(false.B)  // Break
  val flagV = RegInit(false.B)  // Overflow
  val flagN = RegInit(false.B)  // Negative

  // CPU 状态机
  val sFetch :: sDecodeExecute :: sDone :: Nil = Enum(3)
  val state = RegInit(sFetch)
  
  val opcode = RegInit(0.U(8.W))
  val operand = RegInit(0.U(16.W))
  val cycle = RegInit(0.U(3.W))

  // 默认内存接口信号
  io.memAddr := regPC
  io.memDataOut := 0.U
  io.memWrite := false.B
  io.memRead := false.B

  // 辅助函数：更新标志位
  def updateNZ(value: UInt): Unit = {
    flagN := value(7)
    flagZ := value === 0.U
  }

  // 状态机
  switch(state) {
    is(sFetch) {
      io.memAddr := regPC
      io.memRead := true.B
      opcode := io.memDataIn
      regPC := regPC + 1.U
      state := sDecodeExecute
    }

    is(sDecodeExecute) {
      // 解码并执行指令
      switch(opcode) {
        // LDA - Load Accumulator
        is(0xA9.U) {  // LDA Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            regPC := regPC + 1.U
            state := sFetch
          }
        }
        
        is(0xA5.U) {  // LDA Zero Page
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            state := sFetch
          }
        }

        // LDX - Load X Register
        is(0xA2.U) {  // LDX Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regX := io.memDataIn
            updateNZ(io.memDataIn)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // LDY - Load Y Register
        is(0xA0.U) {  // LDY Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regY := io.memDataIn
            updateNZ(io.memDataIn)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // STA - Store Accumulator
        is(0x85.U) {  // STA Zero Page
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memDataOut := regA
            io.memWrite := true.B
            state := sFetch
          }
        }

        // ADC - Add with Carry
        is(0x69.U) {  // ADC Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val sum = regA +& io.memDataIn +& flagC.asUInt
            regA := sum(7, 0)
            flagC := sum(8)
            updateNZ(sum(7, 0))
            // 溢出检测
            flagV := (regA(7) === io.memDataIn(7)) && (regA(7) =/= sum(7))
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // SBC - Subtract with Carry
        is(0xE9.U) {  // SBC Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val diff = regA -& io.memDataIn -& (~flagC).asUInt
            regA := diff(7, 0)
            flagC := ~diff(8)
            updateNZ(diff(7, 0))
            flagV := (regA(7) =/= io.memDataIn(7)) && (regA(7) =/= diff(7))
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // AND - Logical AND
        is(0x29.U) {  // AND Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regA & io.memDataIn
            regA := result
            updateNZ(result)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // ORA - Logical OR
        is(0x09.U) {  // ORA Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regA | io.memDataIn
            regA := result
            updateNZ(result)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // EOR - Exclusive OR
        is(0x49.U) {  // EOR Immediate
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regA ^ io.memDataIn
            regA := result
            updateNZ(result)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // INX - Increment X
        is(0xE8.U) {
          val result = regX + 1.U
          regX := result
          updateNZ(result)
          state := sFetch
        }

        // INY - Increment Y
        is(0xC8.U) {
          val result = regY + 1.U
          regY := result
          updateNZ(result)
          state := sFetch
        }

        // DEX - Decrement X
        is(0xCA.U) {
          val result = regX - 1.U
          regX := result
          updateNZ(result)
          state := sFetch
        }

        // DEY - Decrement Y
        is(0x88.U) {
          val result = regY - 1.U
          regY := result
          updateNZ(result)
          state := sFetch
        }

        // TAX - Transfer A to X
        is(0xAA.U) {
          regX := regA
          updateNZ(regA)
          state := sFetch
        }

        // TAY - Transfer A to Y
        is(0xA8.U) {
          regY := regA
          updateNZ(regA)
          state := sFetch
        }

        // TXA - Transfer X to A
        is(0x8A.U) {
          regA := regX
          updateNZ(regX)
          state := sFetch
        }

        // TYA - Transfer Y to A
        is(0x98.U) {
          regA := regY
          updateNZ(regY)
          state := sFetch
        }

        // CLC - Clear Carry
        is(0x18.U) {
          flagC := false.B
          state := sFetch
        }

        // SEC - Set Carry
        is(0x38.U) {
          flagC := true.B
          state := sFetch
        }

        // CLD - Clear Decimal
        is(0xD8.U) {
          flagD := false.B
          state := sFetch
        }

        // SED - Set Decimal
        is(0xF8.U) {
          flagD := true.B
          state := sFetch
        }

        // CLI - Clear Interrupt
        is(0x58.U) {
          flagI := false.B
          state := sFetch
        }

        // SEI - Set Interrupt
        is(0x78.U) {
          flagI := true.B
          state := sFetch
        }

        // CLV - Clear Overflow
        is(0xB8.U) {
          flagV := false.B
          state := sFetch
        }

        // NOP - No Operation
        is(0xEA.U) {
          state := sFetch
        }

        // JMP Absolute
        is(0x4C.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := Cat(io.memDataIn, operand(7, 0))
            state := sFetch
          }
        }

        // BEQ - Branch if Equal
        is(0xF0.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(flagZ) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BNE - Branch if Not Equal
        is(0xD0.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(!flagZ) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BCS - Branch if Carry Set
        is(0xB0.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(flagC) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BCC - Branch if Carry Clear
        is(0x90.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(!flagC) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }
      }
    }

    is(sDone) {
      // 保持状态
    }
  }

  // 调试输出
  io.debug.regA := regA
  io.debug.regX := regX
  io.debug.regY := regY
  io.debug.regPC := regPC
  io.debug.regSP := regSP
  io.debug.flagC := flagC
  io.debug.flagZ := flagZ
  io.debug.flagN := flagN
  io.debug.flagV := flagV
  io.debug.opcode := opcode
}

// 调试信息 Bundle
class DebugBundle extends Bundle {
  val regA = UInt(8.W)
  val regX = UInt(8.W)
  val regY = UInt(8.W)
  val regPC = UInt(16.W)
  val regSP = UInt(8.W)
  val flagC = Bool()
  val flagZ = Bool()
  val flagN = Bool()
  val flagV = Bool()
  val opcode = UInt(8.W)
}
