; Interactive Tiny BASIC for my6502
; Minimal BASIC interpreter with PRINT command

OUTCH = $F000
INCH  = $F001

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Print banner
        LDX #0
BANNER: LDA MSG_BANNER,X
        BEQ PROMPT
        JSR PUTCH
        INX
        JMP BANNER

; Main prompt loop
PROMPT:
        LDA #'>'
        JSR PUTCH
        LDA #' '
        JSR PUTCH
        
        ; Read line into buffer
        LDY #0
GETLINE:
        JSR GETCH
        CMP #$0D           ; Enter?
        BEQ EXECUTE
        CMP #$08           ; Backspace?
        BEQ BACKSP
        CMP #$20           ; Control char?
        BCC GETLINE
        CPY #79            ; Buffer full?
        BCS GETLINE
        STA BUFFER,Y
        JSR PUTCH          ; Echo
        INY
        JMP GETLINE

BACKSP:
        CPY #0
        BEQ GETLINE
        DEY
        LDA #$08
        JSR PUTCH
        LDA #' '
        JSR PUTCH
        LDA #$08
        JSR PUTCH
        JMP GETLINE

EXECUTE:
        STY BUFLEN
        JSR NEWLINE
        
        ; Check if empty
        CPY #0
        BEQ PROMPT
        
        ; Parse command
        LDY #0
        
        ; Skip spaces
SKIP_SP:
        LDA BUFFER,Y
        CMP #' '
        BNE CHECK_CMD
        INY
        CPY BUFLEN
        BCC SKIP_SP
        JMP PROMPT

CHECK_CMD:
        ; Check for PRINT
        LDA BUFFER,Y
        CMP #'P'
        BEQ TRY_PRINT
        CMP #'p'
        BEQ TRY_PRINT
        
        ; Unknown command
        LDX #0
ERR_LP: LDA MSG_ERROR,X
        BEQ PROMPT
        JSR PUTCH
        INX
        JMP ERR_LP

TRY_PRINT:
        ; Check "PRINT"
        LDA BUFFER+1,Y
        CMP #'R'
        BNE NOT_PRINT
        LDA BUFFER+2,Y
        CMP #'I'
        BNE NOT_PRINT
        LDA BUFFER+3,Y
        CMP #'N'
        BNE NOT_PRINT
        LDA BUFFER+4,Y
        CMP #'T'
        BNE NOT_PRINT
        
        ; Found PRINT, skip to argument
        INY
        INY
        INY
        INY
        INY
        
        ; Skip spaces
SKIP_SP2:
        CPY BUFLEN
        BCS PRINT_DONE
        LDA BUFFER,Y
        CMP #' '
        BNE DO_PRINT
        INY
        JMP SKIP_SP2

DO_PRINT:
        ; Check for string (")
        LDA BUFFER,Y
        CMP #'"'
        BEQ PRINT_STR
        
        ; Print number (just echo for now)
PRINT_NUM:
        LDA BUFFER,Y
        JSR PUTCH
        INY
        CPY BUFLEN
        BCC PRINT_NUM
        JMP PRINT_DONE

PRINT_STR:
        INY                ; Skip opening "
PRINT_S2:
        CPY BUFLEN
        BCS PRINT_DONE
        LDA BUFFER,Y
        CMP #'"'           ; Closing "?
        BEQ PRINT_DONE
        JSR PUTCH
        INY
        JMP PRINT_S2

PRINT_DONE:
        JSR NEWLINE
        JMP PROMPT

NOT_PRINT:
        JMP ERR_LP

; I/O routines
GETCH:
        LDA INCH
        BEQ GETCH
        RTS

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
        .byte "Tiny BASIC v1.0",$0D,$0A
        .byte "Ready",$0D,$0A,0

MSG_ERROR:
        .byte "Error",$0D,$0A,0

BUFLEN:
        .byte 0
BUFFER:
        .dsb 80,0

*= $FFFC
.word START
