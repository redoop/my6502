OUTCH = $F000
        * = $0300
START:
        LDA #'A'
        STA OUTCH
        LDA #'B'
        STA OUTCH
        LDA #'C'
        STA OUTCH
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

        * = $FFFC
        .word START
