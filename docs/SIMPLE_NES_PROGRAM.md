# 简单的 NES 程序示例

## 🎯 目标

在 NES 系统上运行一个简单的程序，展示基本功能。

## 📝 示例 1: Hello World (显示精灵)

这个程序会在屏幕上显示一个精灵。

### 汇编代码

```assembly
; Simple NES Program - Display a Sprite
; 简单的 NES 程序 - 显示一个精灵

.segment "HEADER"
  .byte "NES", $1A      ; iNES header
  .byte 2               ; 2 x 16KB PRG ROM
  .byte 1               ; 1 x 8KB CHR ROM
  .byte $00, $00        ; Mapper 0, horizontal mirroring
  .byte $00, $00, $00, $00, $00, $00, $00, $00

.segment "VECTORS"
  .word NMI
  .word RESET
  .word IRQ

.segment "CODE"

RESET:
  SEI                   ; 禁用中断
  CLD                   ; 清除十进制模式
  
  ; 初始化栈
  LDX #$FF
  TXS
  
  ; 等待 PPU 准备好
  LDA $2002
:
  LDA $2002
  BPL :-
  
  ; 清除内存
  LDA #$00
  LDX #$00
:
  STA $0000,X
  STA $0100,X
  STA $0200,X
  STA $0300,X
  STA $0400,X
  STA $0500,X
  STA $0600,X
  STA $0700,X
  INX
  BNE :-
  
  ; 等待 VBlank
:
  LDA $2002
  BPL :-
  
  ; 设置调色板
  LDA $2002             ; 重置 PPU 地址锁存
  LDA #$3F
  STA $2006             ; PPU 地址高字节
  LDA #$00
  STA $2006             ; PPU 地址低字节
  
  ; 写入调色板数据
  LDA #$0F              ; 黑色
  STA $2007
  LDA #$30              ; 白色
  STA $2007
  LDA #$27              ; 橙色
  STA $2007
  LDA #$17              ; 红色
  STA $2007
  
  ; 设置精灵
  LDA #$80              ; Y 坐标 = 128
  STA $0200
  LDA #$00              ; 图案索引 = 0
  STA $0201
  LDA #$00              ; 属性 = 0
  STA $0202
  LDA #$80              ; X 坐标 = 128
  STA $0203
  
  ; 启用 PPU
  LDA #%10000000        ; 启用 NMI
  STA $2000
  LDA #%00011000        ; 显示背景和精灵
  STA $2001
  
MainLoop:
  JMP MainLoop          ; 无限循环

NMI:
  ; 在 VBlank 期间更新 OAM
  LDA #$00
  STA $2003             ; OAM 地址 = 0
  LDA #$02
  STA $4014             ; DMA 传输 $0200-$02FF 到 OAM
  
  RTI

IRQ:
  RTI

.segment "CHR"
  ; 精灵图案数据 (8x8 像素)
  .byte $3C,$42,$81,$81,$81,$81,$42,$3C  ; 图案 0 - 笑脸
  .byte $00,$3C,$7E,$7E,$7E,$7E,$3C,$00
```

### Chisel 测试代码

```scala
package nes

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SimpleNESProgramTest extends AnyFlatSpec with ChiselScalatestTester {
  
  "NESSystem" should "run hello world program" in {
    test(new NESSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(0)
      
      // 初始化
      dut.io.controller1.poke(0.U)
      dut.io.controller2.poke(0.U)
      dut.io.romLoadEn.poke(false.B)
      
      // 简单的程序：在屏幕中央显示一个精灵
      val program = Seq(
        // RESET 向量在 $FFFC-$FFFD
        // 程序从 $8000 开始
        
        // 初始化
        0xA2, 0xFF,           // LDX #$FF
        0x9A,                 // TXS
        
        // 设置 PPU
        0xA9, 0x80,           // LDA #$80 (启用 NMI)
        0x8D, 0x00, 0x20,     // STA $2000
        0xA9, 0x18,           // LDA #$18 (显示背景和精灵)
        0x8D, 0x01, 0x20,     // STA $2001
        
        // 设置精灵 (在内存 $0200)
        0xA9, 0x80,           // LDA #$80 (Y = 128)
        0x8D, 0x00, 0x02,     // STA $0200
        0xA9, 0x00,           // LDA #$00 (图案 = 0)
        0x8D, 0x01, 0x02,     // STA $0201
        0xA9, 0x00,           // LDA #$00 (属性 = 0)
        0x8D, 0x02, 0x02,     // STA $0202
        0xA9, 0x80,           // LDA #$80 (X = 128)
        0x8D, 0x03, 0x02,     // STA $0203
        
        // 主循环
        0x4C, 0x1E, 0x80      // JMP $801E (自己)
      )
      
      // 注意：实际实现需要通过 ROM 加载接口
      // 这里只是演示程序结构
      
      // 运行程序
      for (i <- 0 until 1000) {
        dut.clock.step(1)
        
        if (i % 100 == 0) {
          println(s"Cycle $i:")
          println(f"  PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
          println(f"  A: 0x${dut.io.debug.regA.peek().litValue}%02x")
          println(s"  VBlank: ${dut.io.vblank.peek().litToBoolean}")
        }
      }
    }
  }
}
```

## 📝 示例 2: 移动精灵

这个程序会让精灵在屏幕上移动。

### 核心逻辑

```assembly
NMI:
  ; 保存寄存器
  PHA
  TXA
  PHA
  TYA
  PHA
  
  ; 更新精灵位置
  LDA spriteX
  CLC
  ADC #$01              ; X += 1
  STA spriteX
  STA $0203             ; 更新 OAM
  
  ; DMA 传输
  LDA #$00
  STA $2003
  LDA #$02
  STA $4014
  
  ; 恢复寄存器
  PLA
  TAY
  PLA
  TAX
  PLA
  
  RTI

spriteX:
  .byte $00
```

## 📝 示例 3: 读取控制器

```assembly
ReadController:
  ; 锁存控制器
  LDA #$01
  STA $4016
  LDA #$00
  STA $4016
  
  ; 读取 8 个按钮
  LDX #$08
:
  LDA $4016
  LSR A                 ; 按钮状态在 bit 0
  ROL buttons           ; 保存到 buttons 变量
  DEX
  BNE :-
  
  RTS

buttons:
  .byte $00
```

## 🎮 控制器按钮映射

```
Bit 0: A
Bit 1: B
Bit 2: Select
Bit 3: Start
Bit 4: Up
Bit 5: Down
Bit 6: Left
Bit 7: Right
```

## 📊 内存布局

```
$0000-$00FF: Zero Page (快速访问)
$0100-$01FF: Stack (栈)
$0200-$02FF: OAM Buffer (精灵数据)
$0300-$07FF: 程序变量
$8000-$FFFF: PRG ROM (程序代码)
```

## 🔧 调试技巧

### 1. 使用调试输出
```scala
println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04x")
println(f"A: 0x${dut.io.debug.regA.peek().litValue}%02x")
println(f"Opcode: 0x${dut.io.debug.opcode.peek().litValue}%02x")
```

### 2. 查看波形
```bash
gtkwave test_run_dir/*/NESSystem.vcd
```

### 3. 单步执行
```scala
for (i <- 0 until 100) {
  dut.clock.step(1)
  // 检查每一步的状态
}
```

## 📚 下一步

1. **学习 PPU**: 了解如何渲染图形
2. **学习 Mapper**: 了解 bank switching
3. **学习音频**: 了解 APU
4. **运行真实游戏**: 加载魂斗罗 ROM

## 🔗 相关文档

- [NES_SYSTEM.md](NES_SYSTEM.md) - 系统架构
- [CONTRA_GUIDE.md](CONTRA_GUIDE.md) - 运行魂斗罗
- [NesDev Wiki](https://www.nesdev.org/) - 技术参考
