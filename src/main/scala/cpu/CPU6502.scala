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
    require(value.getWidth >= 8, s"updateNZ requires at least 8-bit value, got ${value.getWidth} bits")
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
            val sum8 = sum(7, 0)
            regA := sum8
            flagC := sum(8)
            updateNZ(sum8)
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
            val diff8 = diff(7, 0)
            regA := diff8
            flagC := ~diff(8)
            updateNZ(diff8)
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

        // BMI - Branch if Minus
        is(0x30.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(flagN) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BPL - Branch if Plus
        is(0x10.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(!flagN) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BVC - Branch if Overflow Clear
        is(0x50.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(!flagV) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // BVS - Branch if Overflow Set
        is(0x70.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            regPC := regPC + 1.U
            when(flagV) {
              val offset = io.memDataIn.asSInt
              regPC := (regPC.asSInt + offset).asUInt
            }
            state := sFetch
          }
        }

        // CMP - Compare Accumulator (Immediate)
        is(0xC9.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regA -& io.memDataIn
            flagC := regA >= io.memDataIn
            flagZ := regA === io.memDataIn
            flagN := result(7)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // CMP Zero Page
        is(0xC5.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            val result = regA -& io.memDataIn
            flagC := regA >= io.memDataIn
            flagZ := regA === io.memDataIn
            flagN := result(7)
            state := sFetch
          }
        }

        // CPX - Compare X (Immediate)
        is(0xE0.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regX -& io.memDataIn
            flagC := regX >= io.memDataIn
            flagZ := regX === io.memDataIn
            flagN := result(7)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // CPY - Compare Y (Immediate)
        is(0xC0.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            val result = regY -& io.memDataIn
            flagC := regY >= io.memDataIn
            flagZ := regY === io.memDataIn
            flagN := result(7)
            regPC := regPC + 1.U
            state := sFetch
          }
        }

        // BIT - Bit Test (Zero Page)
        is(0x24.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            val data = io.memDataIn
            flagZ := (regA & data) === 0.U
            flagN := data(7)
            flagV := data(6)
            state := sFetch
          }
        }

        // ASL - Arithmetic Shift Left (Accumulator)
        is(0x0A.U) {
          flagC := regA(7)
          val result = WireDefault(0.U(8.W))
          result := (regA << 1)(7, 0)
          regA := result
          updateNZ(result)
          state := sFetch
        }

        // ASL Zero Page
        is(0x06.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val data = io.memDataIn
            flagC := data(7)
            val result = Cat(data(6, 0), 0.U(1.W))
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // LSR - Logical Shift Right (Accumulator)
        is(0x4A.U) {
          flagC := regA(0)
          val result = Cat(0.U(1.W), regA(7, 1))
          regA := result
          updateNZ(result)
          state := sFetch
        }

        // LSR Zero Page
        is(0x46.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val data = io.memDataIn
            flagC := data(0)
            val result = Cat(0.U(1.W), data(7, 1))
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // ROL - Rotate Left (Accumulator)
        is(0x2A.U) {
          val oldCarry = flagC.asUInt
          flagC := regA(7)
          val result = Cat(regA(6, 0), oldCarry)
          regA := result
          updateNZ(result)
          state := sFetch
        }

        // ROL Zero Page
        is(0x26.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val data = io.memDataIn
            val oldCarry = flagC.asUInt
            flagC := data(7)
            val result = Cat(data(6, 0), oldCarry)
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // ROR - Rotate Right (Accumulator)
        is(0x6A.U) {
          val oldCarry = flagC.asUInt
          flagC := regA(0)
          val result = Cat(oldCarry, regA(7, 1))
          regA := result
          updateNZ(result)
          state := sFetch
        }

        // ROR Zero Page
        is(0x66.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val data = io.memDataIn
            val oldCarry = flagC.asUInt
            flagC := data(0)
            val result = Cat(oldCarry, data(7, 1))
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // INC - Increment Memory (Zero Page)
        is(0xE6.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val result = io.memDataIn + 1.U
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // DEC - Decrement Memory (Zero Page)
        is(0xC6.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            val result = io.memDataIn - 1.U
            io.memDataOut := result
            io.memWrite := true.B
            updateNZ(result)
            state := sFetch
          }
        }

        // STX - Store X (Zero Page)
        is(0x86.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memDataOut := regX
            io.memWrite := true.B
            state := sFetch
          }
        }

        // STY - Store Y (Zero Page)
        is(0x84.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memDataOut := regY
            io.memWrite := true.B
            state := sFetch
          }
        }

        // TSX - Transfer SP to X
        is(0xBA.U) {
          regX := regSP
          updateNZ(regSP)
          state := sFetch
        }

        // TXS - Transfer X to SP
        is(0x9A.U) {
          regSP := regX
          state := sFetch
        }

        // PHA - Push Accumulator
        is(0x48.U) {
          io.memAddr := Cat(0x01.U(8.W), regSP)
          io.memDataOut := regA
          io.memWrite := true.B
          regSP := regSP - 1.U
          state := sFetch
        }

        // PHP - Push Processor Status
        is(0x08.U) {
          val status = Cat(flagN, flagV, 1.U(1.W), 1.U(1.W), flagD, flagI, flagZ, flagC)
          io.memAddr := Cat(0x01.U(8.W), regSP)
          io.memDataOut := status
          io.memWrite := true.B
          regSP := regSP - 1.U
          state := sFetch
        }

        // PLA - Pull Accumulator
        is(0x68.U) {
          when(cycle === 0.U) {
            regSP := regSP + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            state := sFetch
          }
        }

        // PLP - Pull Processor Status
        is(0x28.U) {
          when(cycle === 0.U) {
            regSP := regSP + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            val status = io.memDataIn
            flagC := status(0)
            flagZ := status(1)
            flagI := status(2)
            flagD := status(3)
            flagV := status(6)
            flagN := status(7)
            state := sFetch
          }
        }

        // JSR - Jump to Subroutine
        is(0x20.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(io.memDataIn, operand(7, 0))
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // Push high byte of return address
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memDataOut := regPC(15, 8)
            io.memWrite := true.B
            regSP := regSP - 1.U
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // Push low byte of return address
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memDataOut := regPC(7, 0)
            io.memWrite := true.B
            regSP := regSP - 1.U
            regPC := operand
            state := sFetch
          }
        }

        // RTS - Return from Subroutine
        is(0x60.U) {
          when(cycle === 0.U) {
            regSP := regSP + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            operand := io.memDataIn
            regSP := regSP + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            regPC := Cat(io.memDataIn, operand(7, 0)) + 1.U
            state := sFetch
          }
        }

        // BRK - Break
        is(0x00.U) {
          when(cycle === 0.U) {
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            // Push PC high byte
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memDataOut := regPC(15, 8)
            io.memWrite := true.B
            regSP := regSP - 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // Push PC low byte
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memDataOut := regPC(7, 0)
            io.memWrite := true.B
            regSP := regSP - 1.U
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // Push status with B flag set
            val status = Cat(flagN, flagV, 1.U(1.W), 1.U(1.W), flagD, flagI, flagZ, flagC)
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memDataOut := status
            io.memWrite := true.B
            regSP := regSP - 1.U
            flagI := true.B
            flagB := true.B
            cycle := 4.U
          }.elsewhen(cycle === 4.U) {
            // Read IRQ vector low byte
            io.memAddr := 0xFFFE.U
            io.memRead := true.B
            operand := io.memDataIn
            cycle := 5.U
          }.elsewhen(cycle === 5.U) {
            // Read IRQ vector high byte
            io.memAddr := 0xFFFF.U
            io.memRead := true.B
            regPC := Cat(io.memDataIn, operand(7, 0))
            state := sFetch
          }
        }

        // RTI - Return from Interrupt
        is(0x40.U) {
          when(cycle === 0.U) {
            regSP := regSP + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            // Pull status
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            val status = io.memDataIn
            flagC := status(0)
            flagZ := status(1)
            flagI := status(2)
            flagD := status(3)
            flagV := status(6)
            flagN := status(7)
            regSP := regSP + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // Pull PC low byte
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            operand := io.memDataIn
            regSP := regSP + 1.U
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // Pull PC high byte
            io.memAddr := Cat(0x01.U(8.W), regSP)
            io.memRead := true.B
            regPC := Cat(io.memDataIn, operand(7, 0))
            state := sFetch
          }
        }

        // LDA Absolute
        is(0xAD.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(io.memDataIn, operand(7, 0))
            regPC := regPC + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            state := sFetch
          }
        }

        // STA Absolute
        is(0x8D.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(io.memDataIn, operand(7, 0))
            regPC := regPC + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            io.memDataOut := regA
            io.memWrite := true.B
            state := sFetch
          }
        }

        // LDA Zero Page,X
        is(0xB5.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(0.U(8.W), (io.memDataIn + regX)(7, 0))
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

        // STA Zero Page,X
        is(0x95.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(0.U(8.W), (io.memDataIn + regX)(7, 0))
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := operand
            io.memDataOut := regA
            io.memWrite := true.B
            state := sFetch
          }
        }

        // LDA Absolute,X
        is(0xBD.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(io.memDataIn, operand(7, 0)) + regX
            regPC := regPC + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            state := sFetch
          }
        }

        // LDA Absolute,Y
        is(0xB9.U) {
          when(cycle === 0.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := io.memDataIn
            regPC := regPC + 1.U
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            io.memAddr := regPC
            io.memRead := true.B
            operand := Cat(io.memDataIn, operand(7, 0)) + regY
            regPC := regPC + 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            io.memAddr := operand
            io.memRead := true.B
            regA := io.memDataIn
            updateNZ(io.memDataIn)
            state := sFetch
          }
        }

        // INC Accumulator (65C02 extension, but useful)
        is(0x1A.U) {
          val result = regA + 1.U
          regA := result
          updateNZ(result)
          state := sFetch
        }

        // DEC Accumulator (65C02 extension, but useful)
        is(0x3A.U) {
          val result = regA - 1.U
          regA := result
          updateNZ(result)
          state := sFetch
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
