package nes.core

import chisel3._
import chisel3.util._

// Pulse
class PulseWaveform extends Module {
  val io = IO(new Bundle {
    val duty = Input(UInt(2.W))
    val timer = Input(UInt(11.W))
    val lengthActive = Input(Bool())
    val envelopeVolume = Input(UInt(4.W))
    val output = Output(UInt(4.W))
  })
  
  val dutyTable = VecInit(Seq(
    "b01000000".U(8.W),  // 12.5%
    "b01100000".U(8.W),  // 25%
    "b01111000".U(8.W),  // 50%
    "b10011111".U(8.W)   // 75% (negated 25%)
  ))
  
  val timerCounter = RegInit(0.U(11.W))
  val sequencePos = RegInit(0.U(3.W))
  
  when(timerCounter === 0.U) {
    timerCounter := io.timer
    sequencePos := (sequencePos + 1.U) & 7.U
  }.otherwise {
    timerCounter := timerCounter - 1.U
  }
  
  val dutyPattern = dutyTable(io.duty)
  val currentBit = (dutyPattern >> sequencePos)(0)
  
  io.output := Mux(io.lengthActive && currentBit, io.envelopeVolume, 0.U)
}

// Triangle
class TriangleWaveform extends Module {
  val io = IO(new Bundle {
    val timer = Input(UInt(11.W))
    val lengthActive = Input(Bool())
    val linearActive = Input(Bool())
    val output = Output(UInt(4.W))
  })
  
  val sequence = VecInit(
    15.U, 14.U, 13.U, 12.U, 11.U, 10.U, 9.U, 8.U,
    7.U, 6.U, 5.U, 4.U, 3.U, 2.U, 1.U, 0.U,
    0.U, 1.U, 2.U, 3.U, 4.U, 5.U, 6.U, 7.U,
    8.U, 9.U, 10.U, 11.U, 12.U, 13.U, 14.U, 15.U
  )
  
  val timerCounter = RegInit(0.U(11.W))
  val sequencePos = RegInit(0.U(5.W))
  
  when(timerCounter === 0.U) {
    timerCounter := io.timer
    when(io.lengthActive && io.linearActive) {
      sequencePos := (sequencePos + 1.U) & 31.U
    }
  }.otherwise {
    timerCounter := timerCounter - 1.U
  }
  
  io.output := Mux(io.lengthActive && io.linearActive, sequence(sequencePos), 0.U)
}

// Noise
class NoiseWaveform extends Module {
  val io = IO(new Bundle {
    val mode = Input(Bool())
    val period = Input(UInt(4.W))
    val lengthActive = Input(Bool())
    val envelopeVolume = Input(UInt(4.W))
    val output = Output(UInt(4.W))
  })
  
  val periodTable = VecInit(
    4.U, 8.U, 16.U, 32.U, 64.U, 96.U, 128.U, 160.U,
    202.U, 254.U, 380.U, 508.U, 762.U, 1016.U, 2034.U, 4068.U
  )
  
  val timerCounter = RegInit(0.U(12.W))
  val shiftReg = RegInit(1.U(15.W))
  
  val timerPeriod = periodTable(io.period)
  
  when(timerCounter === 0.U) {
    timerCounter := timerPeriod
    val feedback = Mux(io.mode, shiftReg(6) ^ shiftReg(0), shiftReg(1) ^ shiftReg(0))
    shiftReg := (shiftReg >> 1) | (feedback << 14)
  }.otherwise {
    timerCounter := timerCounter - 1.U
  }
  
  io.output := Mux(io.lengthActive && !shiftReg(0), io.envelopeVolume, 0.U)
}
