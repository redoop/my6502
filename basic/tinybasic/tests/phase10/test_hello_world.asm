; Phase 10: Hello World BASIC Program

OUTCH = $F000

*= $0300

START:
        LDX #$FF
        TXS
        
        LDX #0
LINE10: LDA MSG,X
        BEQ LINE20
        STA OUTCH
        INX
        JMP LINE10

LINE20:
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

MSG:    .byte "HELLO",0

*= $FFFC
.word START
