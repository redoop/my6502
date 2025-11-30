OUTCH = $F000
        * = $0300
START:  LDA #'A'
        STA OUTCH
        JSR SUB
        LDA #'C'
        STA OUTCH
        BRK
SUB:    LDA #'B'
        STA OUTCH
        RTS
        * = $FFFC
        .word START
