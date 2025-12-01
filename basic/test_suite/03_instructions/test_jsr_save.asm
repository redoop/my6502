OUTCH = $F000
        * = $0300
START:
        LDX #$FF
        TXS
        
        LDA #'1'
        STA OUTCH
        
        JSR SUB
        
        BRK

SUB:    TSX
        LDA $0102,X
        CMP #$03
        BNE FAIL
        
        LDA #'2'
        STA OUTCH
        
        LDA $0101,X
        CMP #$0A
        BNE FAIL
        
        LDA #'3'
        STA OUTCH
        
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

FAIL:   LDA #'F'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'L'
        STA OUTCH
        BRK

        * = $FFFC
        .word START
