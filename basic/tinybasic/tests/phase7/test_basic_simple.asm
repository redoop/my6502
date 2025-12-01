; Phase 7: Simple BASIC Test

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
