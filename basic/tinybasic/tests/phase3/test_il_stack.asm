; Phase 3 Test 2: IL Stack Operations

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Push value
        LDA #$42
        PHA
        
        ; Pop value
        PLA
        CMP #$42
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
