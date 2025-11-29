package cpu6502.core

import chisel3._
import chisel3.util._
import cpu6502.instructions._

// 6502 CPU Core Module (Refactored Version)
class CPU6502Core extends Module {
  val io = IO(new Bundle {
    val memAddr    = Output(UInt(16.W))
    val memDataOut = Output(UInt(8.W))
    val memDataIn  = Input(UInt(8.W))
    val memWrite   = Output(Bool())
    val memRead    = Output(Bool())
    val memReady   = Input(Bool())   // Memory ready signal
    val debug      = Output(new DebugBundle)
    val reset      = Input(Bool())  // Reset Signal
    val nmi        = Input(Bool())  // NMI Interrupt Signal
  })

  // Registers
  val regs = RegInit(Registers.default())
  
  // CPU State Machine
  val sReset :: sFetch :: sExecute :: sNMI :: sDone :: Nil = Enum(5)
  val state = RegInit(sReset)  // from Reset Start，Read Reset Vector
  
  val opcode  = RegInit(0.U(8.W))
  val operand = RegInit(0.U(16.W))
  val cycle   = RegInit(0.U(4.W))  // 4 bits to support NMI (9 cycles)
  
  // NMI Edge Detection
  val nmiLast = RegInit(false.B)
  val nmiPending = RegInit(false.B)
  
  // Update nmiLast
  nmiLast := io.nmi
  
  // Detect NMI Rising EdgeandSet pending Flag
  when(io.nmi && !nmiLast) {
    nmiPending := true.B
  }
  
  // inStartProcess NMI whenClear pending Flag
  when(state === sFetch && nmiPending) {
    nmiPending := false.B
  }

  // Memory InterfaceSignal
  io.memAddr    := regs.pc
  io.memDataOut := 0.U
  io.memWrite   := false.B
  io.memRead    := false.B

  // InstructionsExecuteResult
  val execResult = Wire(new ExecutionResult)
  execResult := ExecutionResult.hold(regs, operand)

  // State Machine
  when(io.reset) {
    // Reset whenState
    state := sReset
    cycle := 0.U
    opcode := 0.U
    operand := 0.U
    nmiPending := false.B
    nmiLast := false.B
  }.otherwise {
    // ExecuteState Machine
    switch(state) {
        is(sReset) {
          // Reset Sequence: Read Reset Vector ($FFFC-$FFFD)
          when(cycle === 0.U) {
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            // WaitCycleDataReady
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // Read
            io.memAddr := 0xFFFC.U
            io.memRead := true.B
            operand := io.memDataIn
            printf("[CPU Reset] Read $FFFC = 0x%x (low byte)\n", io.memDataIn)
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // ReadAddress
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            cycle := 4.U
          }.elsewhen(cycle === 4.U) {
            // WaitCycleDataReady
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            cycle := 5.U
          }.otherwise {
            // cycle=5: Complete reset and Fetch
            io.memAddr := 0xFFFD.U
            io.memRead := true.B
            val resetVector = Cat(io.memDataIn, operand(7, 0))
            printf("[CPU Reset] Read $FFFD = 0x%x (high byte), Reset Vector = 0x%x\n", 
                   io.memDataIn, resetVector)
            regs.pc := resetVector
            regs.sp := 0xFD.U
            regs.flagI := true.B
            cycle := 0.U
            state := sFetch
          }
        }
    
        is(sFetch) {
          // NMI
          when(nmiPending) {
            cycle := 0.U
            state := sNMI
          }.otherwise {
            // Fetch with memReady support
            when(cycle === 0.U) {
              // Cycle 0: Issue read request
              io.memAddr := regs.pc
              io.memRead := true.B
              when(io.memReady) {
                cycle := 1.U
              }
            }.otherwise {
              // Cycle 1: Read data and execute
              io.memAddr := regs.pc
              io.memRead := true.B
              when(io.memReady) {
                opcode := io.memDataIn
                regs.pc := regs.pc + 1.U
                cycle := 0.U
                state := sExecute
              }
            }
          }
        }

        is(sExecute) {
          // opcode toInstructionsModule
          execResult := dispatchInstructions(opcode, cycle, regs, operand, io.memDataIn)
          
          // ApplyExecuteResult
          io.memAddr    := execResult.memAddr
          io.memDataOut := execResult.memData
          io.memWrite   := execResult.memWrite
          io.memRead    := execResult.memRead
          
          regs    := execResult.regs
          operand := execResult.operand
          
          when(execResult.done) {
            printf("[Execute] Done! opcode=0x%x cycle=%d -> Fetch\n", opcode, cycle)
            cycle := 0.U
            state := sFetch
          }.otherwise {
            cycle := execResult.nextCycle
          }
        }

        is(sNMI) {
          // NMI Process (9 Cycle)
          printf("[NMI State] cycle=%d\n", cycle)
          when(cycle === 0.U) {
            // Cycle 1:
            cycle := 1.U
          }.elsewhen(cycle === 1.U) {
            // Cycle 2:  PC
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := regs.pc(15, 8)
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 2.U
          }.elsewhen(cycle === 2.U) {
            // Cycle 3:  PC
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := regs.pc(7, 0)
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 3.U
          }.elsewhen(cycle === 3.U) {
            // Cycle 4: StateRegisters (B FlagClear)
            val status = Cat(regs.flagN, regs.flagV, 1.U(1.W), 0.U(1.W), 
                           regs.flagD, regs.flagI, regs.flagZ, regs.flagC)
            io.memAddr := Cat(0x01.U(8.W), regs.sp)
            io.memDataOut := status
            io.memWrite := true.B
            regs.sp := regs.sp - 1.U
            cycle := 4.U
          }.elsewhen(cycle === 4.U) {
            // Cycle 5: Read NMI Vector (0xFFFA)
            io.memAddr := 0xFFFA.U
            io.memRead := true.B
            cycle := 5.U
          }.elsewhen(cycle === 5.U) {
            // Cycle 6: WaitDataReady
            io.memAddr := 0xFFFA.U
            io.memRead := true.B
            cycle := 6.U
          }.elsewhen(cycle === 6.U) {
            // Cycle 7: Save，Read
            operand := io.memDataIn
            io.memAddr := 0xFFFB.U
            io.memRead := true.B
            cycle := 7.U
          }.elsewhen(cycle === 7.U) {
            // Cycle 8: WaitDataReady
            io.memAddr := 0xFFFB.U
            io.memRead := true.B
            cycle := 8.U
            printf("[NMI] Setting cycle to 8\n")
          }.otherwise {  // cycle === 8
            // Cycle 9: SaveVectorandSet PC
            printf("[NMI] Cycle 8: completing, vector=0x%x\n", Cat(io.memDataIn, operand(7, 0)))
            val nmiVector = Cat(io.memDataIn, operand(7, 0))
            regs.pc := nmiVector
            regs.flagI := true.B  // SetFlag
            cycle := 0.U
            state := sFetch
          }
        }

      is(sDone) {
        // State
      }
    }
  }

  // Output
  val debugBundle = Wire(new DebugBundle)
  debugBundle := DebugBundle.fromRegisters(regs, opcode, state, cycle)
  io.debug := debugBundle

  // Instructions
  def dispatchInstructions(
    opcode: UInt, 
    cycle: UInt, 
    regs: Registers, 
    operand: UInt, 
    memDataIn: UInt
  ): ExecutionResult = {
    val result = Wire(new ExecutionResult)
    result := ExecutionResult.hold(regs, operand)
    
    switch(opcode) {
      // ========== Flag Instructions ==========
      is(0x18.U, 0x38.U, 0xD8.U, 0xF8.U, 0x58.U, 0x78.U, 0xB8.U, 0xEA.U) {
        result := FlagInstructions.execute(opcode, regs)
      }
      
      // ========== Transfer Instructions ==========
      is(0xAA.U, 0xA8.U, 0x8A.U, 0x98.U, 0xBA.U, 0x9A.U) {
        result := TransferInstructions.execute(opcode, regs)
      }
      
      // ========== Arithmetic  ==========
      is(0xE8.U, 0xC8.U, 0xCA.U, 0x88.U, 0x1A.U, 0x3A.U) {
        result := ArithmeticInstructions.executeImplied(opcode, regs)
      }
      
      // ========== Arithmetic  ==========
      is(0x69.U) { result := ArithmeticInstructions.executeADCImmediate(regs, memDataIn) }
      is(0xE9.U) { result := ArithmeticInstructions.executeSBCImmediate(regs, memDataIn) }
      
      // ========== ADC/SBC  ==========
      is(0x65.U, 0xE5.U) {
        result := ArithmeticInstructions.executeADCSBCZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC  X ==========
      is(0x75.U, 0xF5.U) {
        result := ArithmeticInstructions.executeADCSBCZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC  ==========
      is(0x6D.U, 0xED.U) {
        result := ArithmeticInstructions.executeADCSBCAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC  X ==========
      is(0x61.U, 0xE1.U) {
        result := ArithmeticInstructions.executeADCSBCIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC  Y ==========
      is(0x71.U, 0xF1.U) {
        result := ArithmeticInstructions.executeADCSBCIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC  ==========
      is(0xE6.U, 0xC6.U) {
        result := ArithmeticInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC  X ==========
      is(0xF6.U, 0xD6.U) {
        result := ArithmeticInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC  ==========
      is(0xEE.U, 0xCE.U) {
        result := ArithmeticInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== INC/DEC  X ==========
      is(0xFE.U, 0xDE.U) {
        result := ArithmeticInstructions.executeAbsoluteX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== ADC/SBC  ==========
      is(0x79.U, 0xF9.U, 0x7D.U, 0xFD.U) {
        result := ArithmeticInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  ==========
      is(0x29.U, 0x09.U, 0x49.U) {
        result := LogicInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Logic  ==========
      is(0x24.U) {
        result := LogicInstructions.executeBIT(cycle, regs, operand, memDataIn)
      }
      is(0x25.U, 0x05.U, 0x45.U) {
        result := LogicInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  X ==========
      is(0x35.U, 0x15.U, 0x55.U) {
        result := LogicInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  ==========
      is(0x2C.U, 0x2D.U, 0x0D.U, 0x4D.U) {
        result := LogicInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  ==========
      is(0x3D.U, 0x1D.U, 0x5D.U, 0x39.U, 0x19.U, 0x59.U) {
        result := LogicInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  X ==========
      is(0x21.U, 0x01.U, 0x41.U) {
        result := LogicInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Logic  Y ==========
      is(0x31.U, 0x11.U, 0x51.U) {
        result := LogicInstructions.executeIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift  ==========
      is(0x0A.U, 0x4A.U, 0x2A.U, 0x6A.U) {
        result := ShiftInstructions.executeAccumulator(opcode, regs)
      }
      
      // ========== Shift  ==========
      is(0x06.U, 0x46.U, 0x26.U, 0x66.U) {
        result := ShiftInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift  X ==========
      is(0x16.U, 0x56.U, 0x36.U, 0x76.U) {
        result := ShiftInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift  ==========
      is(0x0E.U, 0x4E.U, 0x2E.U, 0x6E.U) {
        result := ShiftInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Shift  X ==========
      is(0x1E.U, 0x5E.U, 0x3E.U, 0x7E.U) {
        result := ShiftInstructions.executeAbsoluteX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  ==========
      is(0xC9.U, 0xE0.U, 0xC0.U) {
        result := CompareInstructions.executeImmediate(opcode, regs, memDataIn)
      }
      
      // ========== Compare  ==========
      is(0xC5.U, 0xE4.U, 0xC4.U) {
        result := CompareInstructions.executeZeroPageGeneric(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  X ==========
      is(0xD5.U) {
        result := CompareInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  ==========
      is(0xCD.U, 0xEC.U, 0xCC.U) {
        result := CompareInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  ==========
      is(0xDD.U, 0xD9.U) {
        result := CompareInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  X ==========
      is(0xC1.U) {
        result := CompareInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  Y ==========
      is(0xD1.U) {
        result := CompareInstructions.executeIndirectY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Compare  (65C02) ==========
      is(0xD2.U) {
        result := CompareInstructions.executeIndirect(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== Branch Instructions ==========
      is(0xF0.U, 0xD0.U, 0xB0.U, 0x90.U, 0x30.U, 0x10.U, 0x50.U, 0x70.U) {
        result := BranchInstructions.execute(opcode, regs, memDataIn)
      }
      
      // ========== LoadStore  ==========
      is(0xA9.U, 0xA2.U, 0xA0.U) {
        result := LoadStoreInstructions.executeImmediate(opcode, cycle, regs, memDataIn)
      }
      
      // ========== LoadStore  ==========
      is(0xA5.U, 0x85.U, 0x86.U, 0x84.U, 0xA6.U, 0xA4.U) {
        result := LoadStoreInstructions.executeZeroPage(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  X ==========
      is(0xB5.U, 0x95.U, 0xB4.U, 0x94.U) {
        result := LoadStoreInstructions.executeZeroPageX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  Y ==========
      is(0xB6.U, 0x96.U) {
        result := LoadStoreInstructions.executeZeroPageY(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  ==========
      is(0xAD.U, 0x8D.U, 0x8E.U, 0x8C.U, 0xAE.U, 0xAC.U) {
        result := LoadStoreInstructions.executeAbsolute(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  ==========
      is(0xBD.U, 0xB9.U, 0xBC.U, 0xBE.U, 0x9D.U, 0x99.U) {
        result := LoadStoreInstructions.executeAbsoluteIndexed(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  X ==========
      is(0xA1.U, 0x81.U) {
        result := LoadStoreInstructions.executeIndirectX(opcode, cycle, regs, operand, memDataIn)
      }
      
      // ========== LoadStore  Y ==========
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
      
      // ========== Jump Instructions ==========
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
