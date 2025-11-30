; Mini BASIC - 演示版

OUTCH = $F000
INCH  = $F001

        * = $0300

START:
        LDX #$FF
        TXS
        
        LDX #0
PRMSG:  LDA MSG,X
        BEQ PROMPT
        JSR PUTCH
        INX
        JMP PRMSG

PROMPT:  
        LDA #'>'
        JSR PUTCH
        
        LDX #0
GETLN:  JSR GETCH
        CMP #$0D
        BEQ EXEC
        JSR PUTCH
        STA $0200,X
        INX
        JMP GETLN

EXEC:   JSR CRLF
        LDA $0200
        CMP #'P'
        BNE PROMPT
        
        LDX #6
PRLOOP: LDA $0200,X
        CMP #$0D
        BEQ PROMPT
        CMP #'"'
        BEQ PRSKIP
        JSR PUTCH
PRSKIP: INX
        JMP PRLOOP

CRLF:   LDA #$0D
        JSR PUTCH
        LDA #$0A
        JSR PUTCH
        RTS

PUTCH:  STA OUTCH
        RTS

GETCH:  LDA INCH
        BEQ GETCH
        RTS

MSG:    .byte "Mini BASIC",$0D,$0A,0

        * = $FFFC
        .word START
