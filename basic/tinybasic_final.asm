; Tiny BASIC - Final Working Version

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Print "BASIC "
        LDA #'B'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'S'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'C'
        STA OUTCH
        LDA #' '
        STA OUTCH
        
        ; Print "OK"
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
        ; Halt
HALT:   JMP HALT

*= $FFFC
.word START
