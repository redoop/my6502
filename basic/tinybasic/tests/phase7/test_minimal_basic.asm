; Phase 7: Test Minimal BASIC Framework

OUTCH = $F000

*= $0200

; Entry vectors
CV:     JMP COLD_S

COLD_S:
        LDX #$FF
        TXS
        
        ; Print "BASIC"
        LDX #0
LOOP:   LDA MSG,X
        BEQ DONE
        STA OUTCH
        INX
        JMP LOOP

DONE:   LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

MSG:    .byte "BASIC ",0

*= $FFFC
.word CV
