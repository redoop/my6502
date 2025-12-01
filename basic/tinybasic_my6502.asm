; Tiny BASIC for my6502
; Adapted from Tom Pitman's Tiny Basic
; Modified for my6502 I/O at $F000/$F001

; I/O ports
OUTCH = $F000
INCH  = $F001

        *= $0200

; Entry vectors
CV:     JMP COLD_S
WV:     JMP WARM_S  
IN_V:   JMP RCCHR
OUT_V:  JMP SNDCHR
BV:     JMP BREAK

; Cold start
COLD_S:
        LDX #$FF
        TXS
        LDX #0
PRINT_MSG:
        LDA MSG,X
        BEQ START_BASIC
        JSR SNDCHR
        INX
        JMP PRINT_MSG

START_BASIC:
        ; Initialize Tiny BASIC here
        ; For now, just echo characters
MAIN_LOOP:
        JSR RCCHR
        JSR SNDCHR
        JMP MAIN_LOOP

; Warm start  
WARM_S:
        JMP START_BASIC

; Get character from input
RCCHR:
        LDA INCH
        BEQ RCCHR
        RTS

; Send character to output
SNDCHR:
        STA OUTCH
        RTS

; Break check
BREAK:
        CLC
        LDA INCH
        BEQ NO_CHR
        SEC
NO_CHR:
        RTS

MSG:
        .byte "Tiny BASIC v0.1",$0D,$0A
        .byte "Ready",$0D,$0A
        .byte 0

; Reset vector
        *= $FFFC
        .word CV
