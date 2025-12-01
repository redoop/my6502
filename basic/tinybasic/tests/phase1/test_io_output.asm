; Phase 1 Test 1: Character Output
; Test basic character output to $F000

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Output "OK"
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

*= $FFFC
.word START
