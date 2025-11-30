
OUTCH = $F000
        * = $0300
START:  
        ; Setup indirect address
        LDA #$10
        STA $20
        LDA #$03
        STA $21
        
        ; JMP indirect
        JMP ($0020)
        
        ; Should not reach here
        LDA #'F'
        STA OUTCH
        BRK
        
        * = $0310
TARGET: LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK
        
        * = $FFFC
        .word START
