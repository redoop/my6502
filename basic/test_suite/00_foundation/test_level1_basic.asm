OUTCH = $F000
        * = $0300
START:  LDA #$42
        CMP #$42
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        LDA #$55
        STA $10
        LDA #$00
        LDA $10
        CMP #$55
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        LDA #$AA
        STA $0200
        LDA #$00
        LDA $0200
        CMP #$AA
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
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
