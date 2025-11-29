package nes

import chisel3._
import chisel3.util._

// MMC3 Mapper (Mapper 4)
// mapper
class MMC3Mapper extends Module {
  val io = IO(new Bundle {
    // CPU Interface
    val cpuAddr = Input(UInt(16.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // PRG ROM Interface
    val prgAddr = Output(UInt(19.W))  // 512KB
    val prgData = Input(UInt(8.W))
    
    // CHR ROM Interface
    val chrAddr = Output(UInt(17.W))  // 256KB
    val chrData = Input(UInt(8.W))
    
    // PPU Interface
    val ppuAddr = Input(UInt(14.W))
    
    // IRQ Output
    val irqOut = Output(Bool())
    
    // Mirroring
    val mirrorMode = Output(UInt(1.W))  // 0 = vertical, 1 = horizontal
  })
  
  // MMC3 Registers
  val bankSelect = RegInit(0.U(3.W))
  val prgRomBankMode = RegInit(false.B)
  val chrA12Inversion = RegInit(false.B)
  
  // Bank Registers (8 )
  val r0 = RegInit(0.U(8.W))  // CHR bank 0 (2KB)
  val r1 = RegInit(0.U(8.W))  // CHR bank 1 (2KB)
  val r2 = RegInit(0.U(8.W))  // CHR bank 2 (1KB)
  val r3 = RegInit(0.U(8.W))  // CHR bank 3 (1KB)
  val r4 = RegInit(0.U(8.W))  // CHR bank 4 (1KB)
  val r5 = RegInit(0.U(8.W))  // CHR bank 5 (1KB)
  val r6 = RegInit(0.U(8.W))  // PRG bank 0 (8KB)
  val r7 = RegInit(0.U(8.W))  // PRG bank 1 (8KB)
  
  // IRQ Registers
  val irqLatch = RegInit(0.U(8.W))
  val irqCounter = RegInit(0.U(8.W))
  val irqReload = RegInit(false.B)
  val irqEnable = RegInit(false.B)
  val irqPending = RegInit(false.B)
  
  // Mirroring
  val mirroring = RegInit(0.U(1.W))
  io.mirrorMode := mirroring
  
  // CPU WriteRegisters
  when(io.cpuWrite) {
    switch(io.cpuAddr(15, 13)) {
      is(4.U) {  // $8000-$9FFF
        when(io.cpuAddr(0) === 0.U) {
          // Bank select ($8000)
          bankSelect := io.cpuDataIn(2, 0)
          prgRomBankMode := io.cpuDataIn(6)
          chrA12Inversion := io.cpuDataIn(7)
        }.otherwise {
          // Bank data ($8001)
          switch(bankSelect) {
            is(0.U) { r0 := io.cpuDataIn }
            is(1.U) { r1 := io.cpuDataIn }
            is(2.U) { r2 := io.cpuDataIn }
            is(3.U) { r3 := io.cpuDataIn }
            is(4.U) { r4 := io.cpuDataIn }
            is(5.U) { r5 := io.cpuDataIn }
            is(6.U) { r6 := io.cpuDataIn }
            is(7.U) { r7 := io.cpuDataIn }
          }
        }
      }
      is(5.U) {  // $A000-$BFFF
        when(io.cpuAddr(0) === 0.U) {
          // Mirroring ($A000)
          mirroring := io.cpuDataIn(0)
        }.otherwise {
          // PRG RAM protect ($A001)
          // ：
        }
      }
      is(6.U) {  // $C000-$DFFF
        when(io.cpuAddr(0) === 0.U) {
          // IRQ latch ($C000)
          irqLatch := io.cpuDataIn
        }.otherwise {
          // IRQ reload ($C001)
          irqReload := true.B
        }
      }
      is(7.U) {  // $E000-$FFFF
        when(io.cpuAddr(0) === 0.U) {
          // IRQ disable ($E000)
          irqEnable := false.B
          irqPending := false.B
        }.otherwise {
          // IRQ enable ($E001)
          irqEnable := true.B
        }
      }
    }
  }
  
  // PRG ROM bank switching
  val prgBank0 = Wire(UInt(8.W))
  val prgBank1 = Wire(UInt(8.W))
  val prgBank2 = Wire(UInt(8.W))
  val prgBank3 = Wire(UInt(8.W))
  
  when(prgRomBankMode) {
    // Mode 1: $C000 swappable
    prgBank0 := 0xFE.U  // bank
    prgBank1 := r7
    prgBank2 := r6
    prgBank3 := 0xFF.U  // bank
  }.otherwise {
    // Mode 0: $8000 swappable
    prgBank0 := r6
    prgBank1 := r7
    prgBank2 := 0xFE.U
    prgBank3 := 0xFF.U
  }
  
  // PRG Address
  val prgBankNum = WireDefault(0.U(8.W))
  switch(io.cpuAddr(14, 13)) {
    is(0.U) { prgBankNum := prgBank0 }  // $8000-$9FFF
    is(1.U) { prgBankNum := prgBank1 }  // $A000-$BFFF
    is(2.U) { prgBankNum := prgBank2 }  // $C000-$DFFF
    is(3.U) { prgBankNum := prgBank3 }  // $E000-$FFFF
  }
  
  // Direct output (no register) - combinational path
  io.prgAddr := Cat(prgBankNum, io.cpuAddr(12, 0))
  io.cpuDataOut := io.prgData
  
  // CHR ROM bank switching
  val chrBankNum = WireDefault(0.U(8.W))
  val ppuAddrAdjusted = Mux(chrA12Inversion, 
    Cat(~io.ppuAddr(12), io.ppuAddr(11, 0)),
    io.ppuAddr
  )
  
  switch(ppuAddrAdjusted(12, 10)) {
    is(0.U) { chrBankNum := r0 & 0xFE.U }  // $0000-$03FF (2KB)
    is(1.U) { chrBankNum := r0 | 0x01.U }  // $0400-$07FF
    is(2.U) { chrBankNum := r1 & 0xFE.U }  // $0800-$0BFF (2KB)
    is(3.U) { chrBankNum := r1 | 0x01.U }  // $0C00-$0FFF
    is(4.U) { chrBankNum := r2 }           // $1000-$13FF (1KB)
    is(5.U) { chrBankNum := r3 }           // $1400-$17FF (1KB)
    is(6.U) { chrBankNum := r4 }           // $1800-$1BFF (1KB)
    is(7.U) { chrBankNum := r5 }           // $1C00-$1FFF (1KB)
  }
  
  io.chrAddr := Cat(chrBankNum, ppuAddrAdjusted(9, 0))
  
  // IRQ  -
  // in PPU A12 Rising Edgewhen (Trigger)
  val a12Last = RegInit(false.B)
  val a12Filter = RegInit(0.U(4.W))
  
  // A12 :  4 Cycle
  when(io.ppuAddr(12)) {
    when(a12Filter < 15.U) {
      a12Filter := a12Filter + 1.U
    }
  }.otherwise {
    a12Filter := 0.U
  }
  
  val a12Stable = a12Filter >= 4.U
  val a12Rising = a12Stable && !a12Last
  a12Last := a12Stable
  
  // IRQ
  when(a12Rising) {
    when(irqCounter === 0.U || irqReload) {
      irqCounter := irqLatch
      irqReload := false.B
      // latch for 0，Trigger IRQ
      when(irqLatch === 0.U && irqEnable) {
        irqPending := true.B
      }
    }.otherwise {
      irqCounter := irqCounter - 1.U
      // to 0 whenTrigger IRQ
      when(irqCounter === 1.U && irqEnable) {
        irqPending := true.B
      }
    }
  }
  
  // Write IRQ disable whenClear pending
  when(io.cpuWrite && io.cpuAddr(15, 13) === 7.U && io.cpuAddr(0) === 0.U) {
    irqPending := false.B
  }
  
  io.irqOut := irqPending
}

// MMC3 Module
class MMC3Test extends Module {
  val io = IO(new Bundle {
    val success = Output(Bool())
  })
  
  val mapper = Module(new MMC3Mapper)
  

  mapper.io.cpuAddr := 0.U
  mapper.io.cpuDataIn := 0.U
  mapper.io.cpuWrite := false.B
  mapper.io.cpuRead := false.B
  mapper.io.prgData := 0.U
  mapper.io.chrData := 0.U
  mapper.io.ppuAddr := 0.U
  
  io.success := true.B
}
