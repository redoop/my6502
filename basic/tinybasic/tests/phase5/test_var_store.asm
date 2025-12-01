; Phase 5 Test 1: Variable Storage

OUTCH = $F000
VAR_A = $0800

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Store 42 in variable A
        LDA #42
        STA VAR_A
        
        ; Read back
        LDA VAR_A
        CMP #42
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
