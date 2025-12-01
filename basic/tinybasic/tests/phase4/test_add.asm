; Phase 4 Test 1: Addition

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; 5 + 3 = 8
        LDA #5
        CLC
        ADC #3
        CMP #8
        BNE FAIL
        
        ; Test passed
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        JMP HALT
        
FAIL:   LDA #'F'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'L'
        STA OUTCH
        
HALT:   JMP HALT

*= $FFFC
.word START
