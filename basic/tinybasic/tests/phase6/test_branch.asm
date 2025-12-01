; Phase 6 Test 1: Branch

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Test BEQ
        LDA #0
        BEQ PASS
        
FAIL:   LDA #'F'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'L'
        STA OUTCH
        JMP HALT
        
PASS:   LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

*= $FFFC
.word START
