; Comprehensive 6502 Instruction Test

OUTCH = $F000

        * = $0300

START:
        ; === Transfer Instructions ===
        LDA #$42
        TAX
        CPX #$42
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        LDA #$33
        TAY
        CPY #$33
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        LDX #$55
        TXA
        CMP #$55
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        LDY #$66
        TYA
        CMP #$66
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        
        ; === Stack Pointer ===
        LDX #$FF
        TXS
        TSX
        CPX #$FF
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH
        
        ; === Logical Operations ===
        LDA #$FF
        ORA #$00
        CMP #$FF
        BEQ T6
        JMP FAIL
T6:     LDA #'6'
        STA OUTCH
        
        LDA #$F0
        EOR #$0F
        CMP #$FF
        BEQ T7
        JMP FAIL
T7:     LDA #'7'
        STA OUTCH
        
        ; === Increment/Decrement ===
        LDX #$10
        INX
        CPX #$11
        BEQ T8
        JMP FAIL
T8:     LDA #'8'
        STA OUTCH
        
        LDX #$10
        DEX
        CPX #$0F
        BEQ T9
        JMP FAIL
T9:     LDA #'9'
        STA OUTCH
        
        LDY #$20
        INY
        CPY #$21
        BEQ TA
        JMP FAIL
TA:     LDA #'A'
        STA OUTCH
        
        LDY #$20
        DEY
        CPY #$1F
        BEQ TB
        JMP FAIL
TB:     LDA #'B'
        STA OUTCH
        
        ; === Memory Inc/Dec ===
        LDA #$10
        STA $10
        INC $10
        LDA $10
        CMP #$11
        BEQ TC
        JMP FAIL
TC:     LDA #'C'
        STA OUTCH
        
        LDA #$10
        STA $10
        DEC $10
        LDA $10
        CMP #$0F
        BEQ TD
        JMP FAIL
TD:     LDA #'D'
        STA OUTCH
        
        ; === Shift Operations ===
        LDA #$80
        ASL
        BCS TE
        JMP FAIL
TE:     CMP #$00
        BEQ TF
        JMP FAIL
TF:     LDA #'E'
        STA OUTCH
        
        CLC
        LDA #$01
        ROL
        CMP #$02
        BEQ TG
        JMP FAIL
TG:     LDA #'F'
        STA OUTCH
        
        SEC
        LDA #$01
        ROR
        BCS TH
        JMP FAIL
TH:     CMP #$80
        BEQ TI
        JMP FAIL
TI:     LDA #'G'
        STA OUTCH
        
        ; === Store X/Y ===
        LDX #$AA
        STX $20
        LDA $20
        CMP #$AA
        BEQ TJ
        JMP FAIL
TJ:     LDA #'H'
        STA OUTCH
        
        LDY #$BB
        STY $21
        LDA $21
        CMP #$BB
        BEQ TK
        JMP FAIL
TK:     LDA #'I'
        STA OUTCH
        
        ; === Compare Y ===
        LDY #$50
        CPY #$50
        BEQ TL
        JMP FAIL
TL:     LDA #'J'
        STA OUTCH
        
        ; === Flag Operations ===
        CLI
        SEI
        CLD
        SED
        LDA #'K'
        STA OUTCH
        
        ; === Stack Operations ===
        LDA #$77
        PHA
        LDA #$00
        PLA
        CMP #$77
        BEQ TM
        JMP FAIL
TM:     LDA #'L'
        STA OUTCH
        
        PHP
        PLP
        LDA #'M'
        STA OUTCH
        
        ; === NOP ===
        NOP
        NOP
        LDA #'N'
        STA OUTCH
        
        ; === Success ===
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

FAIL:   LDA #'F'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'L'
        STA OUTCH
        BRK

        * = $FFFC
        .word START
