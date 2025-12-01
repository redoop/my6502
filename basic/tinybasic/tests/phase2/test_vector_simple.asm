; Phase 2: Simple Vector Test

OUTCH = $F000

*= $0300

START:
        LDX #$FF
        TXS
        JSR COLD_S
        
HALT:   JMP HALT

COLD_S:
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        RTS

*= $FFFC
.word START
