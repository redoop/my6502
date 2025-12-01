; Phase 7: Test Minimal BASIC Framework

OUTCH = $F000

*= $0300

CV:     JMP COLD_S

COLD_S:
        LDX #$FF
        TXS
        
        LDA #'B'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'S'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'C'
        STA OUTCH
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

*= $FFFC
.word CV
