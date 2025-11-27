package nes

import chisel3._
import chisel3.util._

// 包络生成器
class Envelope extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val loop = Input(Bool())
    val constantVolume = Input(Bool())
    val volume = Input(UInt(4.W))
    val dividerPeriod = Input(UInt(4.W))
    val clock = Input(Bool())  // 来自帧计数器
    val output = Output(UInt(4.W))
  })
  
  val startFlag = RegInit(false.B)
  val divider = RegInit(0.U(4.W))
  val decayLevel = RegInit(15.U(4.W))
  
  when(io.start) {
    startFlag := true.B
  }
  
  when(io.clock) {
    when(startFlag) {
      startFlag := false.B
      decayLevel := 15.U
      divider := io.dividerPeriod
    }.otherwise {
      when(divider === 0.U) {
        divider := io.dividerPeriod
        when(decayLevel === 0.U) {
          when(io.loop) {
            decayLevel := 15.U
          }
        }.otherwise {
          decayLevel := decayLevel - 1.U
        }
      }.otherwise {
        divider := divider - 1.U
      }
    }
  }
  
  io.output := Mux(io.constantVolume, io.volume, decayLevel)
}

// 扫描单元
class Sweep extends Module {
  val io = IO(new Bundle {
    val enable = Input(Bool())
    val negate = Input(Bool())
    val shift = Input(UInt(3.W))
    val period = Input(UInt(3.W))
    val reload = Input(Bool())
    val clock = Input(Bool())  // 来自帧计数器
    val channelPeriod = Input(UInt(11.W))
    val onesComplement = Input(Bool())  // Pulse 1 使用 1's complement
    val periodOut = Output(UInt(11.W))
    val mute = Output(Bool())
  })
  
  val divider = RegInit(0.U(3.W))
  val reloadFlag = RegInit(false.B)
  val targetPeriod = Wire(UInt(12.W))
  
  // 计算目标周期
  val changeAmount = io.channelPeriod >> io.shift
  when(io.negate) {
    when(io.onesComplement) {
      targetPeriod := io.channelPeriod - changeAmount - 1.U
    }.otherwise {
      targetPeriod := io.channelPeriod - changeAmount
    }
  }.otherwise {
    targetPeriod := io.channelPeriod + changeAmount
  }
  
  // Mute 条件
  val muted = io.channelPeriod < 8.U || targetPeriod > 0x7FF.U
  io.mute := muted
  
  when(io.reload) {
    reloadFlag := true.B
  }
  
  when(io.clock) {
    when(divider === 0.U && io.enable && !muted) {
      io.periodOut := targetPeriod(10, 0)
    }.otherwise {
      io.periodOut := io.channelPeriod
    }
    
    when(divider === 0.U || reloadFlag) {
      divider := io.period
      reloadFlag := false.B
    }.otherwise {
      divider := divider - 1.U
    }
  }.otherwise {
    io.periodOut := io.channelPeriod
  }
}

// Pulse 波形生成器 (带包络和扫描)
class PulseChannel extends Module {
  val io = IO(new Bundle {
    val enable = Input(Bool())
    val duty = Input(UInt(2.W))
    val volume = Input(UInt(4.W))
    val period = Input(UInt(11.W))
    val envelopeLoop = Input(Bool())
    val constantVolume = Input(Bool())
    val sweepEnable = Input(Bool())
    val sweepNegate = Input(Bool())
    val sweepShift = Input(UInt(3.W))
    val sweepPeriod = Input(UInt(3.W))
    val onesComplement = Input(Bool())
    val lengthCounter = Input(UInt(5.W))
    val quarterFrame = Input(Bool())  // 包络时钟
    val halfFrame = Input(Bool())     // 扫描时钟
    val output = Output(UInt(4.W))
  })
  
  // 占空比序列 (8 步)
  val dutySequences = VecInit(Seq(
    "b01000000".U(8.W),  // 12.5%
    "b01100000".U(8.W),  // 25%
    "b01111000".U(8.W),  // 50%
    "b10011111".U(8.W)   // 75% (negated 25%)
  ))
  
  val timer = RegInit(0.U(11.W))
  val sequencePos = RegInit(0.U(3.W))
  val currentPeriod = RegInit(0.U(11.W))
  
  // 实例化包络和扫描
  val envelope = Module(new Envelope)
  val sweep = Module(new Sweep)
  
  // 连接包络
  envelope.io.start := false.B  // 由外部控制
  envelope.io.loop := io.envelopeLoop
  envelope.io.constantVolume := io.constantVolume
  envelope.io.volume := io.volume
  envelope.io.dividerPeriod := io.volume
  envelope.io.clock := io.quarterFrame
  
  // 连接扫描
  sweep.io.enable := io.sweepEnable
  sweep.io.negate := io.sweepNegate
  sweep.io.shift := io.sweepShift
  sweep.io.period := io.sweepPeriod
  sweep.io.reload := false.B  // 由外部控制
  sweep.io.clock := io.halfFrame
  sweep.io.channelPeriod := currentPeriod
  sweep.io.onesComplement := io.onesComplement
  
  // 更新周期
  when(io.enable) {
    currentPeriod := sweep.io.periodOut
  }.otherwise {
    currentPeriod := io.period
  }
  
  // 定时器
  when(io.enable && io.lengthCounter > 0.U) {
    when(timer === 0.U) {
      timer := currentPeriod
      sequencePos := (sequencePos + 1.U) & 0x7.U
    }.otherwise {
      timer := timer - 1.U
    }
  }
  
  val dutySeq = dutySequences(io.duty)
  val currentBit = (dutySeq >> sequencePos)(0)
  val envelopeVolume = envelope.io.output
  
  io.output := Mux(io.enable && currentBit && !sweep.io.mute && io.lengthCounter > 0.U, 
    envelopeVolume, 0.U)
}

// Triangle 波形生成器
class TriangleChannel extends Module {
  val io = IO(new Bundle {
    val enable = Input(Bool())
    val period = Input(UInt(11.W))
    val output = Output(UInt(4.W))
  })
  
  // Triangle 序列 (32 步)
  val triangleSequence = VecInit(
    15.U, 14.U, 13.U, 12.U, 11.U, 10.U, 9.U, 8.U,
    7.U, 6.U, 5.U, 4.U, 3.U, 2.U, 1.U, 0.U,
    0.U, 1.U, 2.U, 3.U, 4.U, 5.U, 6.U, 7.U,
    8.U, 9.U, 10.U, 11.U, 12.U, 13.U, 14.U, 15.U
  )
  
  val timer = RegInit(0.U(11.W))
  val sequencePos = RegInit(0.U(5.W))
  
  when(io.enable) {
    when(timer === 0.U) {
      timer := io.period
      sequencePos := (sequencePos + 1.U) & 0x1F.U
    }.otherwise {
      timer := timer - 1.U
    }
  }
  
  io.output := Mux(io.enable, triangleSequence(sequencePos), 0.U)
}

// Noise 波形生成器 (带包络)
class NoiseChannel extends Module {
  val io = IO(new Bundle {
    val enable = Input(Bool())
    val volume = Input(UInt(4.W))
    val period = Input(UInt(4.W))
    val mode = Input(Bool())  // 0 = 15-bit, 1 = 1-bit (short mode)
    val envelopeLoop = Input(Bool())
    val constantVolume = Input(Bool())
    val lengthCounter = Input(UInt(5.W))
    val quarterFrame = Input(Bool())
    val output = Output(UInt(4.W))
  })
  
  // Noise 周期查找表
  val noisePeriods = VecInit(
    4.U, 8.U, 16.U, 32.U, 64.U, 96.U, 128.U, 160.U,
    202.U, 254.U, 380.U, 508.U, 762.U, 1016.U, 2034.U, 4068.U
  )
  
  val timer = RegInit(0.U(12.W))
  val shiftReg = RegInit(1.U(15.W))  // LFSR
  
  // 实例化包络
  val envelope = Module(new Envelope)
  envelope.io.start := false.B
  envelope.io.loop := io.envelopeLoop
  envelope.io.constantVolume := io.constantVolume
  envelope.io.volume := io.volume
  envelope.io.dividerPeriod := io.volume
  envelope.io.clock := io.quarterFrame
  
  when(io.enable && io.lengthCounter > 0.U) {
    val actualPeriod = noisePeriods(io.period)
    when(timer === 0.U) {
      timer := actualPeriod
      // LFSR with feedback
      val feedbackBit = Mux(io.mode, 6.U, 1.U)
      val feedback = shiftReg(0) ^ shiftReg(feedbackBit)
      shiftReg := Cat(feedback, shiftReg(14, 1))
    }.otherwise {
      timer := timer - 1.U
    }
  }
  
  val envelopeVolume = envelope.io.output
  io.output := Mux(io.enable && !shiftReg(0) && io.lengthCounter > 0.U, 
    envelopeVolume, 0.U)
}

// DMC (Delta Modulation Channel) - 采样播放通道
class DMCChannel extends Module {
  val io = IO(new Bundle {
    val enable = Input(Bool())
    val rate = Input(UInt(4.W))
    val loop = Input(Bool())
    val irqEnable = Input(Bool())
    val directLoad = Input(UInt(7.W))
    val sampleAddr = Input(UInt(16.W))
    val sampleLength = Input(UInt(12.W))
    
    // 内存访问
    val memAddr = Output(UInt(16.W))
    val memData = Input(UInt(8.W))
    val memRead = Output(Bool())
    
    val output = Output(UInt(7.W))
    val irq = Output(Bool())
  })
  
  // DMC 速率查找表 (NTSC)
  val dmcRates = VecInit(
    428.U, 380.U, 340.U, 320.U, 286.U, 254.U, 226.U, 214.U,
    190.U, 160.U, 142.U, 128.U, 106.U, 84.U, 72.U, 54.U
  )
  
  val timer = RegInit(0.U(12.W))
  val outputLevel = RegInit(0.U(7.W))
  val sampleBuffer = RegInit(0.U(8.W))
  val sampleBufferEmpty = RegInit(true.B)
  val shiftReg = RegInit(0.U(8.W))
  val bitsRemaining = RegInit(0.U(3.W))
  val silence = RegInit(true.B)
  
  val bytesRemaining = RegInit(0.U(12.W))
  val currentAddr = RegInit(0.U(16.W))
  val irqFlag = RegInit(false.B)
  
  // 输出单元
  when(io.enable) {
    val rate = dmcRates(io.rate)
    when(timer === 0.U) {
      timer := rate
      
      when(!silence) {
        val delta = Mux(shiftReg(0), 2.U, -2.S(8.W).asUInt)
        val newLevel = outputLevel +& delta
        when(newLevel <= 127.U) {
          outputLevel := newLevel(6, 0)
        }
        shiftReg := shiftReg >> 1
      }
      
      when(bitsRemaining === 0.U) {
        bitsRemaining := 8.U
        when(sampleBufferEmpty) {
          silence := true.B
        }.otherwise {
          silence := false.B
          shiftReg := sampleBuffer
          sampleBufferEmpty := true.B
        }
      }.otherwise {
        bitsRemaining := bitsRemaining - 1.U
      }
    }.otherwise {
      timer := timer - 1.U
    }
  }
  
  // 内存读取器
  io.memRead := false.B
  io.memAddr := currentAddr
  
  when(io.enable && sampleBufferEmpty && bytesRemaining > 0.U) {
    io.memRead := true.B
    sampleBuffer := io.memData
    sampleBufferEmpty := false.B
    
    currentAddr := Mux(currentAddr === 0xFFFF.U, 0x8000.U, currentAddr + 1.U)
    bytesRemaining := bytesRemaining - 1.U
    
    when(bytesRemaining === 1.U) {
      when(io.loop) {
        currentAddr := io.sampleAddr
        bytesRemaining := io.sampleLength
      }.elsewhen(io.irqEnable) {
        irqFlag := true.B
      }
    }
  }
  
  io.output := Mux(io.enable, outputLevel, io.directLoad)
  io.irq := irqFlag
}

// NES APU (Audio Processing Unit) - 完整版
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
  val pulse1EnvelopeLoop = RegInit(false.B)
  val pulse1ConstantVolume = RegInit(false.B)
  val pulse1SweepEnable = RegInit(false.B)
  val pulse1SweepNegate = RegInit(false.B)
  val pulse1SweepShift = RegInit(0.U(3.W))
  val pulse1SweepPeriod = RegInit(0.U(3.W))
  val pulse1LengthCounter = RegInit(0.U(5.W))
  
  // Pulse 2
  val pulse2Duty = RegInit(0.U(2.W))
  val pulse2Volume = RegInit(0.U(4.W))
  val pulse2Period = RegInit(0.U(11.W))
  val pulse2Enabled = RegInit(false.B)
  val pulse2EnvelopeLoop = RegInit(false.B)
  val pulse2ConstantVolume = RegInit(false.B)
  val pulse2SweepEnable = RegInit(false.B)
  val pulse2SweepNegate = RegInit(false.B)
  val pulse2SweepShift = RegInit(0.U(3.W))
  val pulse2SweepPeriod = RegInit(0.U(3.W))
  val pulse2LengthCounter = RegInit(0.U(5.W))
  
  // Triangle
  val trianglePeriod = RegInit(0.U(11.W))
  val triangleEnabled = RegInit(false.B)
  val triangleLengthCounter = RegInit(0.U(5.W))
  
  // Noise
  val noiseVolume = RegInit(0.U(4.W))
  val noisePeriod = RegInit(0.U(4.W))
  val noiseEnabled = RegInit(false.B)
  val noiseMode = RegInit(false.B)
  val noiseEnvelopeLoop = RegInit(false.B)
  val noiseConstantVolume = RegInit(false.B)
  val noiseLengthCounter = RegInit(0.U(5.W))
  
  // DMC
  val dmcEnabled = RegInit(false.B)
  val dmcRate = RegInit(0.U(4.W))
  val dmcLoop = RegInit(false.B)
  val dmcIrqEnable = RegInit(false.B)
  val dmcDirectLoad = RegInit(0.U(7.W))
  val dmcSampleAddr = RegInit(0.U(16.W))
  val dmcSampleLength = RegInit(0.U(12.W))
  
  // 帧计数器
  val frameCounter = RegInit(0.U(16.W))
  val frameIRQ = RegInit(false.B)
  val frameMode = RegInit(false.B)  // 0 = 4-step, 1 = 5-step
  val quarterFrame = RegInit(false.B)
  val halfFrame = RegInit(false.B)
  
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
        pulse1EnvelopeLoop := io.cpuDataIn(5)
        pulse1ConstantVolume := io.cpuDataIn(4)
        pulse1Volume := io.cpuDataIn(3, 0)
      }
      is(0x01.U) {
        pulse1SweepEnable := io.cpuDataIn(7)
        pulse1SweepPeriod := io.cpuDataIn(6, 4)
        pulse1SweepNegate := io.cpuDataIn(3)
        pulse1SweepShift := io.cpuDataIn(2, 0)
      }
      is(0x02.U) {
        pulse1Period := Cat(pulse1Period(10, 8), io.cpuDataIn)
      }
      is(0x03.U) {
        pulse1Period := Cat(io.cpuDataIn(2, 0), pulse1Period(7, 0))
        pulse1LengthCounter := io.cpuDataIn(7, 3)
      }
      
      // Pulse 2
      is(0x04.U) {
        pulse2Duty := io.cpuDataIn(7, 6)
        pulse2EnvelopeLoop := io.cpuDataIn(5)
        pulse2ConstantVolume := io.cpuDataIn(4)
        pulse2Volume := io.cpuDataIn(3, 0)
      }
      is(0x05.U) {
        pulse2SweepEnable := io.cpuDataIn(7)
        pulse2SweepPeriod := io.cpuDataIn(6, 4)
        pulse2SweepNegate := io.cpuDataIn(3)
        pulse2SweepShift := io.cpuDataIn(2, 0)
      }
      is(0x06.U) {
        pulse2Period := Cat(pulse2Period(10, 8), io.cpuDataIn)
      }
      is(0x07.U) {
        pulse2Period := Cat(io.cpuDataIn(2, 0), pulse2Period(7, 0))
        pulse2LengthCounter := io.cpuDataIn(7, 3)
      }
      
      // Triangle
      is(0x08.U) {
        // Linear counter (简化)
      }
      is(0x0A.U) {
        trianglePeriod := Cat(trianglePeriod(10, 8), io.cpuDataIn)
      }
      is(0x0B.U) {
        trianglePeriod := Cat(io.cpuDataIn(2, 0), trianglePeriod(7, 0))
        triangleLengthCounter := io.cpuDataIn(7, 3)
      }
      
      // Noise
      is(0x0C.U) {
        noiseEnvelopeLoop := io.cpuDataIn(5)
        noiseConstantVolume := io.cpuDataIn(4)
        noiseVolume := io.cpuDataIn(3, 0)
      }
      is(0x0E.U) {
        noiseMode := io.cpuDataIn(7)
        noisePeriod := io.cpuDataIn(3, 0)
      }
      is(0x0F.U) {
        noiseLengthCounter := io.cpuDataIn(7, 3)
      }
      
      // DMC
      is(0x10.U) {
        dmcIrqEnable := io.cpuDataIn(7)
        dmcLoop := io.cpuDataIn(6)
        dmcRate := io.cpuDataIn(3, 0)
      }
      is(0x11.U) {
        dmcDirectLoad := io.cpuDataIn(6, 0)
      }
      is(0x12.U) {
        dmcSampleAddr := Cat(0xC0.U(8.W), io.cpuDataIn)
      }
      is(0x13.U) {
        dmcSampleLength := Cat(io.cpuDataIn, 0.U(4.W)) + 1.U
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
        frameMode := io.cpuDataIn(7)
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
  
  // 帧计数器逻辑
  frameCounter := frameCounter + 1.U
  val framePeriod = Mux(frameMode, 18641.U, 14915.U)  // 5-step vs 4-step
  when(frameCounter >= framePeriod) {
    frameCounter := 0.U
  }
  
  // 生成帧时钟信号
  quarterFrame := (frameCounter === 3728.U) || (frameCounter === 7456.U) || 
                  (frameCounter === 11185.U) || (frameCounter === 14914.U)
  halfFrame := (frameCounter === 7456.U) || (frameCounter === 14914.U)
  
  // 实例化音频通道
  val pulse1Channel = Module(new PulseChannel)
  val pulse2Channel = Module(new PulseChannel)
  val triangleChannel = Module(new TriangleChannel)
  val noiseChannel = Module(new NoiseChannel)
  val dmcChannel = Module(new DMCChannel)
  
  // 连接 Pulse 1
  pulse1Channel.io.enable := pulse1Enabled
  pulse1Channel.io.duty := pulse1Duty
  pulse1Channel.io.volume := pulse1Volume
  pulse1Channel.io.period := pulse1Period
  pulse1Channel.io.envelopeLoop := pulse1EnvelopeLoop
  pulse1Channel.io.constantVolume := pulse1ConstantVolume
  pulse1Channel.io.sweepEnable := pulse1SweepEnable
  pulse1Channel.io.sweepNegate := pulse1SweepNegate
  pulse1Channel.io.sweepShift := pulse1SweepShift
  pulse1Channel.io.sweepPeriod := pulse1SweepPeriod
  pulse1Channel.io.onesComplement := true.B  // Pulse 1 使用 1's complement
  pulse1Channel.io.lengthCounter := pulse1LengthCounter
  pulse1Channel.io.quarterFrame := quarterFrame
  pulse1Channel.io.halfFrame := halfFrame
  
  // 连接 Pulse 2
  pulse2Channel.io.enable := pulse2Enabled
  pulse2Channel.io.duty := pulse2Duty
  pulse2Channel.io.volume := pulse2Volume
  pulse2Channel.io.period := pulse2Period
  pulse2Channel.io.envelopeLoop := pulse2EnvelopeLoop
  pulse2Channel.io.constantVolume := pulse2ConstantVolume
  pulse2Channel.io.sweepEnable := pulse2SweepEnable
  pulse2Channel.io.sweepNegate := pulse2SweepNegate
  pulse2Channel.io.sweepShift := pulse2SweepShift
  pulse2Channel.io.sweepPeriod := pulse2SweepPeriod
  pulse2Channel.io.onesComplement := false.B  // Pulse 2 使用 2's complement
  pulse2Channel.io.lengthCounter := pulse2LengthCounter
  pulse2Channel.io.quarterFrame := quarterFrame
  pulse2Channel.io.halfFrame := halfFrame
  
  // 连接 Triangle
  triangleChannel.io.enable := triangleEnabled
  triangleChannel.io.period := trianglePeriod
  
  // 连接 Noise
  noiseChannel.io.enable := noiseEnabled
  noiseChannel.io.volume := noiseVolume
  noiseChannel.io.period := noisePeriod
  noiseChannel.io.mode := noiseMode
  noiseChannel.io.envelopeLoop := noiseEnvelopeLoop
  noiseChannel.io.constantVolume := noiseConstantVolume
  noiseChannel.io.lengthCounter := noiseLengthCounter
  noiseChannel.io.quarterFrame := quarterFrame
  
  // 连接 DMC
  dmcChannel.io.enable := dmcEnabled
  dmcChannel.io.rate := dmcRate
  dmcChannel.io.loop := dmcLoop
  dmcChannel.io.irqEnable := dmcIrqEnable
  dmcChannel.io.directLoad := dmcDirectLoad
  dmcChannel.io.sampleAddr := dmcSampleAddr
  dmcChannel.io.sampleLength := dmcSampleLength
  dmcChannel.io.memData := 0.U  // 需要连接到内存系统
  dmcChannel.io.memAddr := DontCare
  dmcChannel.io.memRead := DontCare
  
  // 音频采样生成
  audioCounter := audioCounter + 1.U
  val generateSample = audioCounter >= samplePeriod
  when(generateSample) {
    audioCounter := 0.U
  }
  
  // 混合音频通道 (使用 NES 混合公式)
  // Pulse: pulse_out = 95.88 / ((8128 / (pulse1 + pulse2)) + 100)
  // TND: tnd_out = 159.79 / ((1 / (triangle/8227 + noise/12241 + dmc/22638)) + 100)
  // 简化版本: 直接相加并缩放
  val pulse1Out = pulse1Channel.io.output
  val pulse2Out = pulse2Channel.io.output
  val triangleOut = triangleChannel.io.output
  val noiseOut = noiseChannel.io.output
  val dmcOut = dmcChannel.io.output
  
  // 混合并缩放到 16-bit
  val pulseSum = (pulse1Out +& pulse2Out) << 9  // 放大到 16-bit 范围
  val tndSum = ((triangleOut << 8) + (noiseOut << 8) + (dmcOut << 7)) >> 1
  val mixedAudio = pulseSum + tndSum
  
  io.audioOut := mixedAudio
  io.audioValid := generateSample
  io.irq := frameIRQ || dmcChannel.io.irq
}
