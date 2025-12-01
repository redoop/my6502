; Mini BASIC Test

OUTCH = $F000

        * = $0300

START:
        LDX #$FF
        TXS
        
        ; Test 1: Loop
        LDX #'A'
L1:     TXA
        JSR PUTCH
        INX
        CPX #'E'
        BNE L1
        
        ; Test 2: Subroutine
        JSR HELLO
        
        ; Test 3: Numbers
        LDX #'0'
L2:     TXA
        JSR PUTCH
        INX
        CPX #'5'
        BNE L2
        
        ; Done
        LDA #' '
        JSR PUTCH
        LDA #'O'
        JSR PUTCH
        LDA #'K'
        JSR PUTCH
        
STOP:   JMP STOP

HELLO:  LDA #'X'
        JSR PUTCH
        LDA #'Y'
        JSR PUTCH
        LDA #'Z'
        JSR PUTCH
        RTS

PUTCH:  STA OUTCH
        RTS

        * = $FFFC
        .word START
