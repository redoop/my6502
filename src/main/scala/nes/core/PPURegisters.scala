package nes.core

import chisel3._
import chisel3.util._

// PPU 寄存器定义
class PPURegisters extends Bundle {
  val ppuCtrl = UInt(8.W)      // $2000
  val ppuMask = UInt(8.W)      // $2001
  val ppuStatus = UInt(8.W)    // $2002
  val oamAddr = UInt(8.W)      // $2003
  val ppuScroll = UInt(16.W)   // $2005 (X, Y)
  val ppuAddr = UInt(16.W)     // $2006
  val ppuData = UInt(8.W)      // $2007
  
  // 内部状态
  val addrLatch = Bool()       // 地址锁存器
  val scrollLatch = Bool()     // 滚动锁存器
  val vblank = Bool()          // VBlank 标志
  val sprite0Hit = Bool()      // Sprite 0 碰撞
  val spriteOverflow = Bool()  // 精灵溢出
}

object PPURegisters {
  def default(): PPURegisters = {
    val regs = Wire(new PPURegisters)
    regs.ppuCtrl := 0.U
    regs.ppuMask := 0.U
    regs.ppuStatus := 0.U
    regs.oamAddr := 0.U
    regs.ppuScroll := 0.U
    regs.ppuAddr := 0.U
    regs.ppuData := 0.U
    regs.addrLatch := false.B
    regs.scrollLatch := false.B
    regs.vblank := false.B
    regs.sprite0Hit := false.B
    regs.spriteOverflow := false.B
    regs
  }
}

// PPU 寄存器控制模块
class PPURegisterControl extends Module {
  val io = IO(new Bundle {
    // CPU 接口
    val cpuAddr = Input(UInt(3.W))
    val cpuDataIn = Input(UInt(8.W))
    val cpuDataOut = Output(UInt(8.W))
    val cpuWrite = Input(Bool())
    val cpuRead = Input(Bool())
    
    // 寄存器输出
    val regs = Output(new PPURegisters)
    
    // 状态更新输入
    val setVBlank = Input(Bool())
    val clearVBlank = Input(Bool())
    val setSprite0Hit = Input(Bool())
    val setSpriteOverflow = Input(Bool())
  })
  
  val regs = RegInit(PPURegisters.default())
  
  // 读取逻辑
  io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
    2.U -> regs.ppuStatus,  // $2002
    4.U -> 0.U,             // $2004 - OAM data (TODO)
    7.U -> regs.ppuData     // $2007
  ))
  
  // 写入逻辑
  when(io.cpuWrite) {
    switch(io.cpuAddr) {
      is(0.U) { // $2000 - PPUCTRL
        regs.ppuCtrl := io.cpuDataIn
      }
      is(1.U) { // $2001 - PPUMASK
        regs.ppuMask := io.cpuDataIn
      }
      is(3.U) { // $2003 - OAMADDR
        regs.oamAddr := io.cpuDataIn
      }
      is(4.U) { // $2004 - OAMDATA
        // TODO: OAM write
      }
      is(5.U) { // $2005 - PPUSCROLL
        when(!regs.scrollLatch) {
          regs.ppuScroll := Cat(regs.ppuScroll(7, 0), io.cpuDataIn)
        }.otherwise {
          regs.ppuScroll := Cat(io.cpuDataIn, regs.ppuScroll(15, 8))
        }
        regs.scrollLatch := !regs.scrollLatch
      }
      is(6.U) { // $2006 - PPUADDR
        when(!regs.addrLatch) {
          regs.ppuAddr := Cat(io.cpuDataIn, regs.ppuAddr(7, 0))
        }.otherwise {
          regs.ppuAddr := Cat(regs.ppuAddr(15, 8), io.cpuDataIn)
        }
        regs.addrLatch := !regs.addrLatch
      }
      is(7.U) { // $2007 - PPUDATA
        regs.ppuData := io.cpuDataIn
        // TODO: VRAM write
      }
    }
  }
  
  // 读取 PPUSTATUS 清除标志
  when(io.cpuRead && io.cpuAddr === 2.U) {
    regs.vblank := false.B
    regs.addrLatch := false.B
    regs.scrollLatch := false.B
  }
  
  // 状态更新
  when(io.setVBlank) {
    regs.vblank := true.B
  }
  when(io.clearVBlank) {
    regs.vblank := false.B
  }
  when(io.setSprite0Hit) {
    regs.sprite0Hit := true.B
  }
  when(io.setSpriteOverflow) {
    regs.spriteOverflow := true.B
  }
  
  // 组装 PPUSTATUS
  regs.ppuStatus := Cat(
    regs.vblank,
    regs.sprite0Hit,
    regs.spriteOverflow,
    0.U(5.W)
  )
  
  io.regs := regs
}
