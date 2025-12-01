OUTCH = $F000
        * = $0300
START:
        LDA #$00
        STA $20
        LDA #$04
        STA $21
        
        LDA #$00
        STA $30
        LDA #$05
        STA $31
        
        LDX #$10
        LDA #$AA
        STA ($10,X)
        
        LDA #$00
        LDA ($10,X)
        CMP #$AA
        BEQ T1
        JMP FAIL
        
T1:     LDA #'1'
        STA OUTCH
        
        LDY #$05
        LDA #$BB
        STA ($30),Y
        
        LDA #$00
        LDA ($30),Y
        CMP #$BB
        BEQ T2
        JMP FAIL
        
T2:     LDA #'2'
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
