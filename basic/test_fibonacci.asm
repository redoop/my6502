; Fibonacci sequence (first 10 numbers)
OUTCH = $F000

        *= $0200

START:
        LDX #$FF
        TXS
        
        ; Print "Fib: "
        LDX #0
MSG_LP: LDA MSG,X
        BEQ FIB
        STA OUTCH
        INX
        JMP MSG_LP

FIB:    LDA #0          ; F0 = 0
        STA $10
        LDA #1          ; F1 = 1
        STA $11
        
        LDX #10         ; Count
        
LOOP:   LDA $10         ; Print F0
        CLC
        ADC #'0'
        STA OUTCH
        
        LDA #' '
        STA OUTCH
        
        ; F2 = F0 + F1
        LDA $10
        CLC
        ADC $11
        STA $12
        
        ; F0 = F1
        LDA $11
        STA $10
        
        ; F1 = F2
        LDA $12
        STA $11
        
        DEX
        BNE LOOP
        
        LDA #$0A
        STA OUTCH
        
DONE:   JMP DONE

MSG:    .byte "Fib: ",0

        *= $FFFC
        .word START
