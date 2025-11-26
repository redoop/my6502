package nes

import chisel3._
import chisel3.util._

// NES APU (Audio Processing Unit) - 简化版
class APU extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(5.W))      // $4000-$4017
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // 音频输出
    val audioOut = Output(UInt(16.W))   // 16-bit 音频样本
    val audioValid = Output(Bool())     // 样本有效信号
    
    // 帧计数器 IRQ
    val irq = Output(Bool())
  })

  // APU 寄存器
  // Pulse 1
  val pulse1Duty = RegInit(0.U(2.W))
  val pulse1Volume = RegInit(0.U(4.W))
  val pulse1Period = RegInit(0.U(11.W))
  val pulse1Enabled = RegInit(false.B)
  
  // Pulse 2
  val pulse2Duty = RegInit(0.U(2.W))
  val pulse2Volume = RegInit(0.U(4.W))
  val pulse2Period = RegInit(0.U(11.W))
  val pulse2Enabled = RegInit(false.B)
  
  // Triangle
  val trianglePeriod = RegInit(0.U(11.W))
  val triangleEnabled = RegInit(false.B)
  
  // Noise
  val noiseVolume = RegInit(0.U(4.W))
  val noisePeriod = RegInit(0.U(4.W))
  val noiseEnabled = RegInit(false.B)
  
  // DMC
  val dmcEnabled = RegInit(false.B)
  
  // 帧计数器
  val frameCounter = RegInit(0.U(16.W))
  val frameIRQ = RegInit(false.B)
  
  // 音频生成计数器
  val audioCounter = RegInit(0.U(16.W))
  val sampleRate = 44100.U  // 44.1 kHz
  val cpuClock = 1789773.U  // NTSC CPU 时钟
  val samplePeriod = cpuClock / sampleRate
  
  // CPU 寄存器访问
  io.cpuDataOut := 0.U
  
  when(io.cpuWrite) {
    switch(io.cpuAddr) {
      // Pulse 1
      is(0x00.U) {
        pulse1Duty := io.cpuDataIn(7, 6)
        pulse1Volume := io.cpuDataIn(3, 0)
      }
      is(0x02.U) {
        pulse1Period := Cat(pulse1Period(10, 8), io.cpuDataIn)
      }
      is(0x03.U) {
        pulse1Period := Cat(io.cpuDataIn(2, 0), pulse1Period(7, 0))
      }
      
      // Pulse 2
      is(0x04.U) {
        pulse2Duty := io.cpuDataIn(7, 6)
        pulse2Volume := io.cpuDataIn(3, 0)
      }
      is(0x06.U) {
        pulse2Period := Cat(pulse2Period(10, 8), io.cpuDataIn)
      }
      is(0x07.U) {
        pulse2Period := Cat(io.cpuDataIn(2, 0), pulse2Period(7, 0))
      }
      
      // Triangle
      is(0x0A.U) {
        trianglePeriod := Cat(trianglePeriod(10, 8), io.cpuDataIn)
      }
      is(0x0B.U) {
        trianglePeriod := Cat(io.cpuDataIn(2, 0), trianglePeriod(7, 0))
      }
      
      // Noise
      is(0x0C.U) {
        noiseVolume := io.cpuDataIn(3, 0)
      }
      is(0x0E.U) {
        noisePeriod := io.cpuDataIn(3, 0)
      }
      
      // Status
      is(0x15.U) {
        pulse1Enabled := io.cpuDataIn(0)
        pulse2Enabled := io.cpuDataIn(1)
        triangleEnabled := io.cpuDataIn(2)
        noiseEnabled := io.cpuDataIn(3)
        dmcEnabled := io.cpuDataIn(4)
      }
      
      // Frame Counter
      is(0x17.U) {
        frameCounter := 0.U
        when(io.cpuDataIn(6)) {
          frameIRQ := false.B
        }
      }
    }
  }
  
  when(io.cpuRead) {
    switch(io.cpuAddr) {
      is(0x15.U) {
        // Status register
        io.cpuDataOut := Cat(
          frameIRQ,
          0.U(2.W),
          dmcEnabled,
          noiseEnabled,
          triangleEnabled,
          pulse2Enabled,
          pulse1Enabled
        )
        frameIRQ := false.B
      }
    }
  }
  
  // 简化的音频生成
  audioCounter := audioCounter + 1.U
  val generateSample = audioCounter >= samplePeriod
  when(generateSample) {
    audioCounter := 0.U
  }
  
  // 混合音频通道 (简化)
  val pulse1Out = Mux(pulse1Enabled, pulse1Volume << 8, 0.U)
  val pulse2Out = Mux(pulse2Enabled, pulse2Volume << 8, 0.U)
  val triangleOut = Mux(triangleEnabled, 0x800.U, 0.U)
  val noiseOut = Mux(noiseEnabled, noiseVolume << 8, 0.U)
  
  val mixedAudio = pulse1Out + pulse2Out + triangleOut + noiseOut
  
  io.audioOut := mixedAudio
  io.audioValid := generateSample
  io.irq := frameIRQ
}
