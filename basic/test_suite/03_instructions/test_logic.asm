
OUTCH = $F000
        * = $0300
START:  
        ; ORA
        LDA #$0F
        ORA #$F0
        CMP #$FF
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        ; EOR
        LDA #$FF
        EOR #$AA
        CMP #$55
        BEQ OK
        JMP FAIL
        
OK:     LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK
        
FAIL:   LDA #'F'
        STA OUTCH
        BRK
        
        * = $FFFC
        .word START
