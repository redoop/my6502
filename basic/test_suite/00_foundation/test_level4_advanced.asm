; Level 4: Advanced Features Test
;Tests: Stack ops, Transfers, Flags, ROL/ROR

OUTCH = $F000

        * = $0300

START:
        LDA #$77
        PHA
        LDA #$00
        PLA
        CMP #$77
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        LDA #$55
        TAX
        LDA #$00
        TXA
        CMP #$55
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        LDA #$66
        TAY
        LDA #$00
        TYA
        CMP #$66
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        LDX #$FF
        TXS
        TSX
        CPX #$FF
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        
        CLC
        LDA #$01
        ROL
        CMP #$02
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH
        
        SEC
        LDA #$01
        ROR
        CMP #$80
        BEQ T6
        JMP FAIL
T6:     LDA #'6'
        STA OUTCH
        
        CLI
        SEI
        CLD
        SED
        LDA #'7'
        STA OUTCH
        
        NOP
        NOP
        LDA #'8'
        STA OUTCH
        
        ; Success
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
