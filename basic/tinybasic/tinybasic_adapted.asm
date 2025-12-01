; Tiny BASIC for my6502
; Adapted from Tom Pitman's Tiny BASIC
; Modified for xa assembler and my6502 memory map

OUTCH = $F000
INCH  = $F001

*= $0300

; Entry vectors
CV:     JMP COLD_S
WV:     JMP WARM_S
IN_V:   JMP RCCHR
OUT_V:  JMP SNDCHR
BV:     JMP BREAK

; Configuration
BSC:    .byte $5F    ; Backspace
LSC:    .byte $18    ; Line cancel
PCC:    .byte $80    ; Pad control
TMC:    .byte $00    ; Tape mode
SSS:    .byte $04    ; Stack size

; PEEK/POKE
PEEK:   STX $C3
        BCC PK1
        STX $C3
        STA ($C2),Y
        RTS
PK1:    LDA ($C2),Y
        LDY #$00
        RTS

; Cold start
COLD_S: LDX #$FF
        TXS
        
        ; Print banner
        LDX #0
BAN:    LDA MSG,X
        BEQ WARM_S
        JSR SNDCHR
        INX
        JMP BAN

; Warm start
WARM_S: LDA #'>'
        JSR SNDCHR
        LDA #' '
        JSR SNDCHR
        
        ; Get line
        LDY #0
GETL:   JSR RCCHR
        CMP #$0D
        BEQ EXEC
        CMP #$08
        BEQ BACKS
        CPY #79
        BCS GETL
        STA BUF,Y
        JSR SNDCHR
        INY
        JMP GETL

BACKS:  CPY #0
        BEQ GETL
        DEY
        LDA #$08
        JSR SNDCHR
        LDA #' '
        JSR SNDCHR
        LDA #$08
        JSR SNDCHR
        JMP GETL

EXEC:   JSR NEWLN
        CPY #0
        BEQ WARM_S
        
        ; Parse command
        LDY #0
        LDA BUF,Y
        
        ; Check LIST
        CMP #'L'
        BEQ CMD_LIST
        
        ; Check RUN
        CMP #'R'
        BEQ CMD_RUN
        
        ; Check NEW
        CMP #'N'
        BEQ CMD_NEW
        
        JMP WARM_S

CMD_LIST:
        LDX #0
LST:    LDA MSG_LIST,X
        BEQ WARM_S
        JSR SNDCHR
        INX
        JMP LST

CMD_RUN:
        LDX #0
RUN:    LDA MSG_RUN,X
        BEQ WARM_S
        JSR SNDCHR
        INX
        JMP RUN

CMD_NEW:
        LDX #0
NEW:    LDA MSG_NEW,X
        BEQ WARM_S
        JSR SNDCHR
        INX
        JMP NEW

; I/O routines
RCCHR:  LDA INCH
        BEQ RCCHR
        RTS

SNDCHR: STA OUTCH
        RTS

NEWLN:  LDA #$0D
        JSR SNDCHR
        LDA #$0A
        JSR SNDCHR
        RTS

BREAK:  CLC
        RTS

; Data
MSG:
        .byte "Tiny BASIC v1.0",$0D,$0A
        .byte "Ready",$0D,$0A,0

MSG_LIST:
        .byte "No program",$0D,$0A,0

MSG_RUN:
        .byte "Running...",$0D,$0A,0

MSG_NEW:
        .byte "Program cleared",$0D,$0A,0

BUF:    .dsb 80,0

*= $FFFC
.word CV
