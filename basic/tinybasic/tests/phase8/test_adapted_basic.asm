; Phase 8: Test Adapted BASIC

OUTCH = $F000

*= $0300

START:
        LDX #$FF
        TXS
        
        ; Test banner output
        LDX #0
LOOP:   LDA MSG,X
        BEQ DONE
        STA OUTCH
        INX
        CPX #10
        BCC LOOP

DONE:   LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

MSG:    .byte "BASIC OK",0

*= $FFFC
.word START
