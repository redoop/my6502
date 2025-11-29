package nes.core

import chisel3._
import chisel3.util._

// APU Registers
class PulseChannelRegs extends Bundle {
  val duty = UInt(2.W)
  val loop = Bool()
  val constantVolume = Bool()
  val volume = UInt(4.W)
  val sweepEnable = Bool()
  val sweepPeriod = UInt(3.W)
  val sweepNegate = Bool()
  val sweepShift = UInt(3.W)
  val timerLow = UInt(8.W)
  val timerHigh = UInt(3.W)
  val lengthCounter = UInt(5.W)
}

class TriangleChannelRegs extends Bundle {
  val control = Bool()
  val linearCounter = UInt(7.W)
  val timerLow = UInt(8.W)
  val timerHigh = UInt(3.W)
  val lengthCounter = UInt(5.W)
}

class NoiseChannelRegs extends Bundle {
  val loop = Bool()
  val constantVolume = Bool()
  val volume = UInt(4.W)
  val mode = Bool()
  val period = UInt(4.W)
  val lengthCounter = UInt(5.W)
}

class DMCChannelRegs extends Bundle {
  val irqEnable = Bool()
  val loop = Bool()
  val frequency = UInt(4.W)
  val loadCounter = UInt(7.W)
  val sampleAddr = UInt(8.W)
  val sampleLength = UInt(8.W)
}

// APU Registers
class APURegisters extends Bundle {
  val pulse1 = new PulseChannelRegs
  val pulse2 = new PulseChannelRegs
  val triangle = new TriangleChannelRegs
  val noise = new NoiseChannelRegs
  val dmc = new DMCChannelRegs
  val status = UInt(8.W)
  val frameCounter = UInt(8.W)
}

object APURegisters {
  def default(): APURegisters = {
    val regs = Wire(new APURegisters)
    regs.pulse1.duty := 0.U
    regs.pulse1.loop := false.B
    regs.pulse1.constantVolume := false.B
    regs.pulse1.volume := 0.U
    regs.pulse1.sweepEnable := false.B
    regs.pulse1.sweepPeriod := 0.U
    regs.pulse1.sweepNegate := false.B
    regs.pulse1.sweepShift := 0.U
    regs.pulse1.timerLow := 0.U
    regs.pulse1.timerHigh := 0.U
    regs.pulse1.lengthCounter := 0.U
    
    regs.pulse2.duty := 0.U
    regs.pulse2.loop := false.B
    regs.pulse2.constantVolume := false.B
    regs.pulse2.volume := 0.U
    regs.pulse2.sweepEnable := false.B
    regs.pulse2.sweepPeriod := 0.U
    regs.pulse2.sweepNegate := false.B
    regs.pulse2.sweepShift := 0.U
    regs.pulse2.timerLow := 0.U
    regs.pulse2.timerHigh := 0.U
    regs.pulse2.lengthCounter := 0.U
    
    regs.triangle.control := false.B
    regs.triangle.linearCounter := 0.U
    regs.triangle.timerLow := 0.U
    regs.triangle.timerHigh := 0.U
    regs.triangle.lengthCounter := 0.U
    
    regs.noise.loop := false.B
    regs.noise.constantVolume := false.B
    regs.noise.volume := 0.U
    regs.noise.mode := false.B
    regs.noise.period := 0.U
    regs.noise.lengthCounter := 0.U
    
    regs.dmc.irqEnable := false.B
    regs.dmc.loop := false.B
    regs.dmc.frequency := 0.U
    regs.dmc.loadCounter := 0.U
    regs.dmc.sampleAddr := 0.U
    regs.dmc.sampleLength := 0.U
    
    regs.status := 0.U
    regs.frameCounter := 0.U
    regs
  }
}

// APU RegistersControlModule
class APURegisterControl extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(8.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // RegistersOutput
    val regs = Output(new APURegisters)
  })
  
  val regs = RegInit(APURegisters.default())
  
  // Read
  io.cpuDataOut := Mux(io.cpuAddr === 0x15.U, regs.status, 0.U)
  
  // Write
  when(io.cpuWrite) {
    switch(io.cpuAddr) {
      // Pulse 1
      is(0x00.U) {
        regs.pulse1.duty := io.cpuDataIn(7, 6)
        regs.pulse1.loop := io.cpuDataIn(5)
        regs.pulse1.constantVolume := io.cpuDataIn(4)
        regs.pulse1.volume := io.cpuDataIn(3, 0)
      }
      is(0x01.U) {
        regs.pulse1.sweepEnable := io.cpuDataIn(7)
        regs.pulse1.sweepPeriod := io.cpuDataIn(6, 4)
        regs.pulse1.sweepNegate := io.cpuDataIn(3)
        regs.pulse1.sweepShift := io.cpuDataIn(2, 0)
      }
      is(0x02.U) {
        regs.pulse1.timerLow := io.cpuDataIn
      }
      is(0x03.U) {
        regs.pulse1.lengthCounter := io.cpuDataIn(7, 3)
        regs.pulse1.timerHigh := io.cpuDataIn(2, 0)
      }
      
      // Pulse 2
      is(0x04.U) {
        regs.pulse2.duty := io.cpuDataIn(7, 6)
        regs.pulse2.loop := io.cpuDataIn(5)
        regs.pulse2.constantVolume := io.cpuDataIn(4)
        regs.pulse2.volume := io.cpuDataIn(3, 0)
      }
      is(0x05.U) {
        regs.pulse2.sweepEnable := io.cpuDataIn(7)
        regs.pulse2.sweepPeriod := io.cpuDataIn(6, 4)
        regs.pulse2.sweepNegate := io.cpuDataIn(3)
        regs.pulse2.sweepShift := io.cpuDataIn(2, 0)
      }
      is(0x06.U) {
        regs.pulse2.timerLow := io.cpuDataIn
      }
      is(0x07.U) {
        regs.pulse2.lengthCounter := io.cpuDataIn(7, 3)
        regs.pulse2.timerHigh := io.cpuDataIn(2, 0)
      }
      
      // Triangle
      is(0x08.U) {
        regs.triangle.control := io.cpuDataIn(7)
        regs.triangle.linearCounter := io.cpuDataIn(6, 0)
      }
      is(0x0A.U) {
        regs.triangle.timerLow := io.cpuDataIn
      }
      is(0x0B.U) {
        regs.triangle.lengthCounter := io.cpuDataIn(7, 3)
        regs.triangle.timerHigh := io.cpuDataIn(2, 0)
      }
      
      // Noise
      is(0x0C.U) {
        regs.noise.loop := io.cpuDataIn(5)
        regs.noise.constantVolume := io.cpuDataIn(4)
        regs.noise.volume := io.cpuDataIn(3, 0)
      }
      is(0x0E.U) {
        regs.noise.mode := io.cpuDataIn(7)
        regs.noise.period := io.cpuDataIn(3, 0)
      }
      is(0x0F.U) {
        regs.noise.lengthCounter := io.cpuDataIn(7, 3)
      }
      
      // DMC
      is(0x10.U) {
        regs.dmc.irqEnable := io.cpuDataIn(7)
        regs.dmc.loop := io.cpuDataIn(6)
        regs.dmc.frequency := io.cpuDataIn(3, 0)
      }
      is(0x11.U) {
        regs.dmc.loadCounter := io.cpuDataIn(6, 0)
      }
      is(0x12.U) {
        regs.dmc.sampleAddr := io.cpuDataIn
      }
      is(0x13.U) {
        regs.dmc.sampleLength := io.cpuDataIn
      }
      
      // Status
      is(0x15.U) {
        regs.status := io.cpuDataIn
      }
      
      // Frame Counter
      is(0x17.U) {
        regs.frameCounter := io.cpuDataIn
      }
    }
  }
  
  io.regs := regs
}
