
OUTCH = $F000
        * = $0300
START:  
        ; CLI, SEI
        CLI
        SEI
        LDA #'1'
        STA OUTCH
        
        ; CLD, SED
        CLD
        SED
        LDA #'2'
        STA OUTCH
        
        ; NOP
        NOP
        NOP
        LDA #'3'
        STA OUTCH
        
OK:     LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK
        
        * = $FFFC
        .word START
