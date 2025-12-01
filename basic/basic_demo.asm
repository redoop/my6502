; Simple BASIC Interpreter Demo
; 预加载BASIC程序并执行

OUTCH = $F000
PROG  = $0400    ; BASIC程序存储区

        * = $0300

START:
        LDX #$FF
        TXS
        
        ; 显示标题
        LDX #0
TITLE:  LDA MSG,X
        BEQ RUN
        JSR PUTCH
        INX
        JMP TITLE

RUN:    ; 执行预加载的BASIC程序
        ; 10 PRINT "HELLO"
        ; 20 PRINT "WORLD"
        ; 30 END
        
        LDX #0
LINE10: LDA PRG1,X
        BEQ LINE20
        JSR PUTCH
        INX
        JMP LINE10
        
LINE20: JSR CRLF
        LDX #0
LINE21: LDA PRG2,X
        BEQ LINE30
        JSR PUTCH
        INX
        JMP LINE21

LINE30: JSR CRLF
        LDX #0
DONE1:  LDA PRG3,X
        BEQ STOP
        JSR PUTCH
        INX
        JMP DONE1

STOP:   JMP STOP

CRLF:   LDA #$0D
        JSR PUTCH
        LDA #$0A
        JSR PUTCH
        RTS

PUTCH:  STA OUTCH
        RTS

MSG:    .byte "BASIC Demo",$0D,$0A,0
PRG1:   .byte "HELLO",0
PRG2:   .byte "WORLD",0
PRG3:   .byte "OK",0

        * = $FFFC
        .word START
