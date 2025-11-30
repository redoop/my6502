OUTCH = $F000
        * = $0300
START:  LDX #$33
        STX $20
        LDX #$00
        LDX $20
        CPX #$33
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        LDY #$44
        STY $21
        LDY #$00
        LDY $21
        CPY #$44
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        CLC
        LDA #$10
        ADC #$20
        CMP #$30
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        SEC
        LDA #$30
        SBC #$10
        CMP #$20
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        JSR SUB
        LDA #'6'
        STA OUTCH
        JMP SUCCESS
SUB:    LDA #'5'
        STA OUTCH
        RTS
SUCCESS:
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
