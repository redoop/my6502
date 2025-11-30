
OUTCH = $F000
        * = $0300
START:  
        ; ASL A
        LDA #$40
        ASL
        CMP #$80
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        ; LSR A
        LDA #$80
        LSR
        CMP #$40
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        ; ROL A
        CLC
        LDA #$40
        ROL
        CMP #$80
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        ; ROR A
        CLC
        LDA #$02
        ROR
        CMP #$01
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
