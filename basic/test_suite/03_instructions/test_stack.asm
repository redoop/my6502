OUTCH = $F000
        * = $0300
START:
        LDA #'1'
        STA OUTCH
        
        LDA #$77
        PHA
        LDA #$00
        PLA
        CMP #$77
        BEQ T1
        JMP FAIL
        
T1:     LDA #'2'
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
