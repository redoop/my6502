; Phase 4 Test 2: Subtraction

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; 5 - 3 = 2
        LDA #5
        SEC
        SBC #3
        CMP #2
        BNE FAIL
        
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
