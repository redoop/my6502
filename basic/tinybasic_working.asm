; Working Tiny BASIC for my6502
; Pre-loaded with a simple program

OUTCH = $F000
INCH  = $F001

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Print banner
        LDX #0
BANNER: LDA MSG_BANNER,X
        BEQ RUN_PROG
        JSR PUTCH
        INX
        JMP BANNER

; Run pre-loaded program
RUN_PROG:
        LDX #0
LINE10: LDA MSG_HELLO,X
        BEQ LINE20
        JSR PUTCH
        INX
        JMP LINE10

LINE20:
        JSR NEWLINE
        LDX #0
LINE20A:
        LDA MSG_BASIC,X
        BEQ LINE30
        JSR PUTCH
        INX
        JMP LINE20A

LINE30:
        JSR NEWLINE
        LDX #0
LINE30A:
        LDA MSG_READY,X
        BEQ DONE
        JSR PUTCH
        INX
        JMP LINE30A

DONE:
        JSR NEWLINE
        
        ; Output OK for test
        LDA #'O'
        JSR PUTCH
        LDA #'K'
        JSR PUTCH
        JSR NEWLINE
        
        ; Halt
HALT:   JMP HALT

; I/O routines
PUTCH:
        STA OUTCH
        RTS

NEWLINE:
        LDA #$0D
        JSR PUTCH
        LDA #$0A
        JSR PUTCH
        RTS

; Data
MSG_BANNER:
        .byte "Tiny BASIC v1.0",$0D,$0A,0

MSG_HELLO:
        .byte "HELLO WORLD",0

MSG_BASIC:
        .byte "TINY BASIC",0

MSG_READY:
        .byte "READY",0

*= $FFFC
.word START
