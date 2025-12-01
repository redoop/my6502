OUTCH = $F000
        * = $0300
START:
        LDA #'1'
        STA OUTCH
        JSR SUB
        LDA #'3'
        STA OUTCH
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

SUB:    LDA #'2'
        STA OUTCH
        RTS

        * = $FFFC
        .word START
