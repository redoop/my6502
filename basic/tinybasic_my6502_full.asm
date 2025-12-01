; Tiny BASIC for my6502
; Adapted from Tom Pitman's Tiny Basic
; I/O adapted for $F000/$F001

OUTCH = $F000
INCH  = $F001

*= $0200

; Entry vectors
CV:      JMP COLD_S
WV:      JMP WARM_S
IN_V:    JMP RCCHR
OUT_V:   JMP SNDCHR
BV:      JMP BREAK

; Include the main Tiny BASIC code here
; For now, create a minimal working version

COLD_S:
        LDX #$FF
        TXS
        LDX #0
PRINT_WELCOME:
        LDA WELCOME,X
        BEQ MAIN_LOOP
        JSR SNDCHR
        INX
        JMP PRINT_WELCOME

MAIN_LOOP:
        JSR RCCHR          ; Get character
        CMP #$0D           ; Check for Enter
        BEQ DO_NEWLINE
        JSR SNDCHR         ; Echo it
        JMP MAIN_LOOP

DO_NEWLINE:
        LDA #$0D
        JSR SNDCHR
        LDA #$0A
        JSR SNDCHR
        LDA #'>'
        JSR SNDCHR
        LDA #' '
        JSR SNDCHR
        JMP MAIN_LOOP

WARM_S:
        JMP MAIN_LOOP

; I/O Functions
RCCHR:
        LDA INCH
        BEQ RCCHR
        RTS

SNDCHR:
        STA $FE
        CMP #$00
        BEQ EXSC
        LDA $FE
        STA OUTCH
EXSC:
        RTS

BREAK:
        CLC
        LDA INCH
        BEQ NO_CHR
        SEC
NO_CHR:
        RTS

WELCOME:
        .byte "Tiny BASIC v1.0",$0D,$0A
        .byte "Ready",$0D,$0A
        .byte "> ",0

*= $FFFC
.word CV
