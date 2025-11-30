
OUTCH = $F000
        * = $0300
START:  
        ; CPY immediate
        LDY #$50
        CPY #$50
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        ; CPY zero page
        LDA #$60
        STA $10
        LDY #$60
        CPY $10
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
