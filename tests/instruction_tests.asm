; 6502 指令集完整测试程序
; 测试所有 151 种指令的正确性

.org $8000

RESET:
    ; 初始化
    SEI             ; 禁用中断
    CLD             ; 清除十进制模式
    LDX #$FF
    TXS             ; 初始化栈指针
    
    ; 开始测试
    JSR TEST_TRANSFER
    JSR TEST_LOAD_STORE
    JSR TEST_ARITHMETIC
    JSR TEST_LOGIC
    JSR TEST_SHIFT
    JSR TEST_COMPARE
    JSR TEST_BRANCH
    JSR TEST_STACK
    JSR TEST_FLAGS
    JSR TEST_JUMP
    
    ; 所有测试通过
    LDA #$00
    STA $0200       ; 写入成功标志
    
INFINITE_LOOP:
    JMP INFINITE_LOOP

; ============================================
; 传送指令测试
; ============================================
TEST_TRANSFER:
    ; TAX - Transfer A to X
    LDA #$42
    TAX
    CPX #$42
    BNE TEST_FAIL
    
    ; TAY - Transfer A to Y
    LDA #$33
    TAY
    CPY #$33
    BNE TEST_FAIL
    
    ; TXA - Transfer X to A
    LDX #$55
    TXA
    CMP #$55
    BNE TEST_FAIL
    
    ; TYA - Transfer Y to A
    LDY #$66
    TYA
    CMP #$66
    BNE TEST_FAIL
    
    ; TSX - Transfer SP to X
    TSX
    CPX #$FF
    BNE TEST_FAIL
    
    ; TXS - Transfer X to SP
    LDX #$FE
    TXS
    TSX
    CPX #$FE
    BNE TEST_FAIL
    
    RTS

; ============================================
; 加载/存储指令测试
; ============================================
TEST_LOAD_STORE:
    ; LDA immediate
    LDA #$AA
    CMP #$AA
    BNE TEST_FAIL
    
    ; LDA zero page
    LDA #$BB
    STA $10
    LDA #$00
    LDA $10
    CMP #$BB
    BNE TEST_FAIL
    
    ; LDA zero page,X
    LDX #$05
    LDA #$CC
    STA $15
    LDA #$00
    LDA $10,X
    CMP #$CC
    BNE TEST_FAIL
    
    ; LDA absolute
    LDA #$DD
    STA $0300
    LDA #$00
    LDA $0300
    CMP #$DD
    BNE TEST_FAIL
    
    ; LDA absolute,X
    LDX #$10
    LDA #$EE
    STA $0310
    LDA #$00
    LDA $0300,X
    CMP #$EE
    BNE TEST_FAIL
    
    ; LDA absolute,Y
    LDY #$20
    LDA #$FF
    STA $0320
    LDA #$00
    LDA $0300,Y
    CMP #$FF
    BNE TEST_FAIL
    
    ; LDA (indirect,X)
    LDX #$04
    LDA #$50
    STA $14
    LDA #$03
    STA $15
    LDA #$AB
    STA $0350
    LDA #$00
    LDA ($10,X)
    CMP #$AB
    BNE TEST_FAIL
