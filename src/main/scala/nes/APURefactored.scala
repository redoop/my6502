package nes

import chisel3._
import chisel3.util._
import nes.core._

/**
 * APU 重构版本
 * 参考 CPU6502Refactored 的模块化设计
 * 合并现有 APU 实现
 * 与测试用例衔接
 */
class APURefactored extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(8.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // 音频输出
    val audioOut = Output(UInt(16.W))
    
    // IRQ 输出
    val irq = Output(Bool())
    
    // 调试接口
    val debug = Output(new Bundle {
      val pulse1Active = Bool()
      val pulse2Active = Bool()
      val triangleActive = Bool()
      val noiseActive = Bool()
      val dmcActive = Bool()
    })
  })
  
  // 寄存器控制模块
  val regControl = Module(new APURegisterControl)
  regControl.io.cpuAddr := io.cpuAddr
  regControl.io.cpuDataIn := io.cpuDataIn
  regControl.io.cpuWrite := io.cpuWrite
  regControl.io.cpuRead := io.cpuRead
  io.cpuDataOut := regControl.io.cpuDataOut
  
  val regs = regControl.io.regs
  
  // 功能模块实例化
  val envelope1 = Module(new Envelope)
  val envelope2 = Module(new Envelope)
  val envelopeNoise = Module(new Envelope)
  
  val lengthCounter1 = Module(new LengthCounter)
  val lengthCounter2 = Module(new LengthCounter)
  val lengthCounterTriangle = Module(new LengthCounter)
  val lengthCounterNoise = Module(new LengthCounter)
  
  val linearCounter = Module(new LinearCounter)
  
  // 帧计数器
  val frameCounter = RegInit(0.U(15.W))
  val frameStep = RegInit(0.U(3.W))
  val frameMode = regs.frameCounter(7)  // 0=4步, 1=5步
  
  frameCounter := frameCounter + 1.U
  
  val quarterFrame = WireDefault(false.B)
  val halfFrame = WireDefault(false.B)
  
  when(frameMode === 0.U) {
    // 4步模式
    when(frameCounter === 7457.U) {
      quarterFrame := true.B
      frameStep := 1.U
    }.elsewhen(frameCounter === 14913.U) {
      quarterFrame := true.B
      halfFrame := true.B
      frameStep := 2.U
    }.elsewhen(frameCounter === 22371.U) {
      quarterFrame := true.B
      frameStep := 3.U
    }.elsewhen(frameCounter === 29829.U) {
      quarterFrame := true.B
      halfFrame := true.B
      frameStep := 0.U
      frameCounter := 0.U
    }
  }.otherwise {
    // 5步模式
    when(frameCounter === 7457.U) {
      quarterFrame := true.B
      frameStep := 1.U
    }.elsewhen(frameCounter === 14913.U) {
      quarterFrame := true.B
      halfFrame := true.B
      frameStep := 2.U
    }.elsewhen(frameCounter === 22371.U) {
      quarterFrame := true.B
      frameStep := 3.U
    }.elsewhen(frameCounter === 29829.U) {
      halfFrame := true.B
      frameStep := 4.U
    }.elsewhen(frameCounter === 37281.U) {
      frameStep := 0.U
      frameCounter := 0.U
    }
  }
  
  // Pulse 1 包络
  envelope1.io.start := false.B  // TODO: 连接到寄存器写入
  envelope1.io.loop := regs.pulse1.loop
  envelope1.io.constantVolume := regs.pulse1.constantVolume
  envelope1.io.volume := regs.pulse1.volume
  envelope1.io.dividerPeriod := regs.pulse1.volume
  envelope1.io.clock := quarterFrame
  
  // Pulse 1 长度计数器
  lengthCounter1.io.enable := regs.status(0)
  lengthCounter1.io.halt := regs.pulse1.loop
  lengthCounter1.io.load := regs.pulse1.lengthCounter
  lengthCounter1.io.loadTrigger := false.B  // TODO
  lengthCounter1.io.clock := halfFrame
  
  // Pulse 2 包络
  envelope2.io.start := false.B
  envelope2.io.loop := regs.pulse2.loop
  envelope2.io.constantVolume := regs.pulse2.constantVolume
  envelope2.io.volume := regs.pulse2.volume
  envelope2.io.dividerPeriod := regs.pulse2.volume
  envelope2.io.clock := quarterFrame
  
  // Pulse 2 长度计数器
  lengthCounter2.io.enable := regs.status(1)
  lengthCounter2.io.halt := regs.pulse2.loop
  lengthCounter2.io.load := regs.pulse2.lengthCounter
  lengthCounter2.io.loadTrigger := false.B
  lengthCounter2.io.clock := halfFrame
  
  // Triangle 线性计数器
  linearCounter.io.control := regs.triangle.control
  linearCounter.io.reload := regs.triangle.linearCounter
  linearCounter.io.reloadTrigger := false.B  // TODO
  linearCounter.io.clock := quarterFrame
  
  // Triangle 长度计数器
  lengthCounterTriangle.io.enable := regs.status(2)
  lengthCounterTriangle.io.halt := regs.triangle.control
  lengthCounterTriangle.io.load := regs.triangle.lengthCounter
  lengthCounterTriangle.io.loadTrigger := false.B
  lengthCounterTriangle.io.clock := halfFrame
  
  // Noise 包络
  envelopeNoise.io.start := false.B
  envelopeNoise.io.loop := regs.noise.loop
  envelopeNoise.io.constantVolume := regs.noise.constantVolume
  envelopeNoise.io.volume := regs.noise.volume
  envelopeNoise.io.dividerPeriod := regs.noise.volume
  envelopeNoise.io.clock := quarterFrame
  
  // Noise 长度计数器
  lengthCounterNoise.io.enable := regs.status(3)
  lengthCounterNoise.io.halt := regs.noise.loop
  lengthCounterNoise.io.load := regs.noise.lengthCounter
  lengthCounterNoise.io.loadTrigger := false.B
  lengthCounterNoise.io.clock := halfFrame
  
  // 简单的混音器
  val pulse1Out = Mux(lengthCounter1.io.active, envelope1.io.output, 0.U)
  val pulse2Out = Mux(lengthCounter2.io.active, envelope2.io.output, 0.U)
  val triangleOut = Mux(lengthCounterTriangle.io.active && linearCounter.io.active, 15.U, 0.U)
  val noiseOut = Mux(lengthCounterNoise.io.active, envelopeNoise.io.output, 0.U)
  
  io.audioOut := (pulse1Out +& pulse2Out +& triangleOut +& noiseOut) << 8
  
  // IRQ
  io.irq := false.B  // TODO
  
  // 调试输出
  io.debug.pulse1Active := lengthCounter1.io.active
  io.debug.pulse2Active := lengthCounter2.io.active
  io.debug.triangleActive := lengthCounterTriangle.io.active && linearCounter.io.active
  io.debug.noiseActive := lengthCounterNoise.io.active
  io.debug.dmcActive := false.B
}
