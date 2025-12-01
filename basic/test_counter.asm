; Simple counter test
OUTCH = $F000

        *= $0200

START:
        LDX #$FF
        TXS
        
        ; Print "Count: "
        LDX #0
PRINT:  LDA MSG,X
        BEQ COUNT
        STA OUTCH
        INX
        JMP PRINT

COUNT:  LDA #'0'
LOOP:   STA OUTCH
        CLC
        ADC #1
        CMP #'9'+1
        BNE LOOP
        
        LDA #$0A
        STA OUTCH
        
DONE:   JMP DONE

MSG:    .byte "Count: ",0

        *= $FFFC
        .word START
