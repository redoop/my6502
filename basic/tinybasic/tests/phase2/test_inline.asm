; Phase 2: Inline Test

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

*= $FFFC
.word START
