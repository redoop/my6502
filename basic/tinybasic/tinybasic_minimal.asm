; Minimal Tiny BASIC for my6502
; Adapted from Tom Pitman's Tiny BASIC

OUTCH = $F000
INCH  = $F001

*= $0200

; Entry vectors
CV:     JMP COLD_S
WV:     JMP WARM_S
IN_V:   JMP RCCHR
OUT_V:   JMP SNDCHR

; Cold start
COLD_S:
        LDX #$FF
        TXS
        
        ; Print banner
        LDX #0
BANNER: LDA MSG,X
        BEQ PROMPT
        JSR SNDCHR
        INX
        JMP BANNER

; Main prompt
PROMPT:
        LDA #'>'
        JSR SNDCHR
        LDA #' '
        JSR SNDCHR
        
        ; Get input
        JSR RCCHR
        
        ; Echo
        JSR SNDCHR
        
        ; Check for commands
        CMP #'L'
        BEQ CMD_LIST
        CMP #'R'
        BEQ CMD_RUN
        
        JMP PROMPT

CMD_LIST:
        LDX #0
LIST_LP:
        LDA MSG_LIST,X
        BEQ PROMPT
        JSR SNDCHR
        INX
        JMP LIST_LP

CMD_RUN:
        LDX #0
RUN_LP: LDA MSG_RUN,X
        BEQ PROMPT
        JSR SNDCHR
        INX
        JMP RUN_LP

; Warm start
WARM_S:
        JMP PROMPT

; I/O routines
RCCHR:
        LDA INCH
        BEQ RCCHR
        RTS

SNDCHR:
        STA OUTCH
        RTS

; Data
MSG:
        .byte "Tiny BASIC",$0D,$0A,0

MSG_LIST:
        .byte $0D,$0A,"No program",$0D,$0A,0

MSG_RUN:
        .byte $0D,$0A,"Running...",$0D,$0A,0

*= $FFFC
.word CV
