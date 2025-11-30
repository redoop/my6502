
OUTCH = $F000
        * = $0300
START:  
        ; INY
        LDY #$10
        INY
        CPY #$11
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        ; DEX
        LDX #$20
        DEX
        CPX #$1F
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        ; DEY
        LDY #$30
        DEY
        CPY #$2F
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        ; INC zp
        LDA #$40
        STA $10
        INC $10
        LDA $10
        CMP #$41
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        
        ; DEC zp
        LDA #$50
        STA $10
        DEC $10
        LDA $10
        CMP #$4F
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
