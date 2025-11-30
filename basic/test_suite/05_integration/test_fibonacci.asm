; Integration Test: Fibonacci Sequence
; Calculates first 10 Fibonacci numbers

OUTCH = $F000

        * = $0300

START:
        LDA #$00
        STA $20
        LDA #$01
        STA $21
        LDX #$02

        LDA $20
        JSR PRTHEX
        LDA $21
        JSR PRTHEX

LOOP:
        LDA $20
        CLC
        ADC $21
        STA $22
        
        JSR PRTHEX
        
        LDA $21
        STA $20
        LDA $22
        STA $21
        
        INX
        CPX #$0A
        BNE LOOP
        
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

PRTHEX:
        PHA
        LSR
        LSR
        LSR
        LSR
        JSR PRTDIG
        PLA
        AND #$0F
        JSR PRTDIG
        LDA #' '
        STA OUTCH
        RTS

PRTDIG:
        CMP #$0A
        BCC ISNUM
        ADC #$06
ISNUM:  ADC #$30
        STA OUTCH
        RTS

        * = $FFFC
        .word START
