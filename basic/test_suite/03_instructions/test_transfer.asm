
OUTCH = $F000
        * = $0300
START:  
        ; TAX
        LDA #$42
        TAX
        CPX #$42
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        ; TAY
        LDA #$33
        TAY
        CPY #$33
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        ; TXA
        LDX #$55
        TXA
        CMP #$55
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        ; TYA
        LDY #$66
        TYA
        CMP #$66
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        
        ; TSX
        LDX #$FF
        TXS
        TSX
        CPX #$FF
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH
        
        ; TXS
        LDX #$FD
        TXS
        TSX
        CPX #$FD
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
