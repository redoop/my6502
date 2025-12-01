; Tiny BASIC Test

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        LDX #0
LOOP:   LDA MSG,X
        BEQ DONE
        STA OUTCH
        INX
        CPX #30
        BCC LOOP

DONE:   LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

MSG:    .byte "BASIC OK",0

*= $FFFC
.word START
