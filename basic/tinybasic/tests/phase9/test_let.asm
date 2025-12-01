; Phase 9: Test LET command

OUTCH = $F000
VAR_A = $0800

*= $0300

START:
        LDX #$FF
        TXS
        
        ; LET A=42
        LDA #42
        STA VAR_A
        
        ; Verify
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
