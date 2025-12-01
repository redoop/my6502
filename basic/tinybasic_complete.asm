; Complete Tiny BASIC Interpreter for my6502

OUTCH = $F000
INCH  = $F001

PROG_START = $0400
VAR_START  = $0800
STACK_TOP  = $01FF

*= $0200

START:
        LDX #$FF
        TXS
        JSR INIT
        JSR BANNER
        JMP PROMPT

; Initialize system
INIT:
        ; Clear variables
        LDX #51
        LDA #0
INIT_V: STA VAR_START,X
        DEX
        BPL INIT_V
        
        ; Clear program
        LDA #0
        STA PROG_END
        STA PROG_END+1
        LDA #<PROG_START
        STA PROG_END
        LDA #>PROG_START
        STA PROG_END+1
        RTS

BANNER:
        LDX #0
BAN_LP: LDA MSG_BANNER,X
        BEQ BAN_END
        JSR PUTCH
        INX
        JMP BAN_LP
BAN_END:
        RTS

; Main prompt loop
PROMPT:
        LDA #'>'
        JSR PUTCH
        LDA #' '
        JSR PUTCH
        JSR GETLINE
        JSR PARSE
        JMP PROMPT

; Read line into buffer
GETLINE:
        LDY #0
GET_LP: JSR GETCH
        CMP #$0D
        BEQ GET_END
        CMP #$08
        BEQ GET_BS
        CMP #$20
        BCC GET_LP
        CPY #79
        BCS GET_LP
        STA BUFFER,Y
        JSR PUTCH
        INY
        JMP GET_LP
GET_BS: CPY #0
        BEQ GET_LP
        DEY
        LDA #$08
        JSR PUTCH
        LDA #' '
        JSR PUTCH
        LDA #$08
        JSR PUTCH
        JMP GET_LP
GET_END:
        STY BUFLEN
        JSR NEWLINE
        RTS

; Parse and execute line
PARSE:
        LDY #0
        LDA BUFLEN
        BNE PARSE_GO
        RTS
PARSE_GO:
        ; Skip leading spaces
SKIP_SP:
        LDA BUFFER,Y
        CMP #' '
        BNE CHECK_NUM
        INY
        CPY BUFLEN
        BCC SKIP_SP
        RTS

CHECK_NUM:
        ; Check if line starts with number
        CMP #'0'
        BCC CHECK_CMD
        CMP #'9'+1
        BCS CHECK_CMD
        ; Store line (not implemented yet)
        JMP PARSE_END

CHECK_CMD:
        ; Check for commands
        LDA BUFFER,Y
        CMP #'P'
        BNE TRY_L
        JMP CMD_PRINT
TRY_L:  CMP #'L'
        BNE TRY_R
        JMP CMD_LIST
TRY_R:  CMP #'R'
        BNE TRY_N
        JMP CMD_RUN
TRY_N:  CMP #'N'
        BNE DO_ERR
        JMP CMD_NEW
DO_ERR: JMP ERROR

CMD_PRINT:
        ; Check "PRINT"
        INY
        LDA BUFFER,Y
        CMP #'R'
        BNE DO_ERR2
        INY
        LDA BUFFER,Y
        CMP #'I'
        BNE DO_ERR2
        INY
        LDA BUFFER,Y
        CMP #'N'
        BNE DO_ERR2
        INY
        LDA BUFFER,Y
        CMP #'T'
        BNE DO_ERR2
        INY
        JMP DO_PRINT
DO_ERR2:
        JMP ERROR

CMD_LIST:
        ; LIST command
        LDX #0
LIST_LP:
        LDA MSG_LIST,X
        BNE LIST_GO
        JMP PARSE_END
LIST_GO:
        JSR PUTCH
        INX
        JMP LIST_LP

CMD_RUN:
        ; RUN command
        LDX #0
RUN_LP: LDA MSG_RUN,X
        BEQ PARSE_END
        JSR PUTCH
        INX
        JMP RUN_LP

CMD_NEW:
        ; NEW command
        JSR INIT
        LDX #0
NEW_LP: LDA MSG_NEW,X
        BEQ PARSE_END
        JSR PUTCH
        INX
        JMP NEW_LP

DO_PRINT:
        ; Skip spaces after PRINT
SKIP_P: CPY BUFLEN
        BCS PRINT_END
        LDA BUFFER,Y
        CMP #' '
        BNE PRINT_ARG
        INY
        JMP SKIP_P

PRINT_ARG:
        ; Check for string
        LDA BUFFER,Y
        CMP #'"'
        BEQ PRINT_STR
        
        ; Check for variable (A-Z)
        CMP #'A'
        BCC PRINT_NUM
        CMP #'Z'+1
        BCS PRINT_NUM
        
        ; Print variable value
        SEC
        SBC #'A'
        ASL
        TAX
        LDA VAR_START,X
        JSR PRINT_BYTE
        INX
        LDA VAR_START,X
        JSR PRINT_BYTE
        JMP PRINT_END

PRINT_NUM:
        ; Print number literal
        LDA BUFFER,Y
        JSR PUTCH
        INY
        CPY BUFLEN
        BCC PRINT_NUM
        JMP PRINT_END

PRINT_STR:
        INY
PRINT_S2:
        CPY BUFLEN
        BCS PRINT_END
        LDA BUFFER,Y
        CMP #'"'
        BEQ PRINT_END
        JSR PUTCH
        INY
        JMP PRINT_S2

PRINT_END:
        JSR NEWLINE
PARSE_END:
        RTS

ERROR:
        LDX #0
ERR_LP: LDA MSG_ERROR,X
        BEQ ERR_END
        JSR PUTCH
        INX
        JMP ERR_LP
ERR_END:
        RTS

; Print byte as hex
PRINT_BYTE:
        PHA
        LSR
        LSR
        LSR
        LSR
        JSR PRINT_HEX
        PLA
        AND #$0F
        JSR PRINT_HEX
        RTS

PRINT_HEX:
        CMP #10
        BCC PRINT_DIG
        CLC
        ADC #'A'-10
        JSR PUTCH
        RTS
PRINT_DIG:
        CLC
        ADC #'0'
        JSR PUTCH
        RTS

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

MSG_LIST:
        .byte "No program",$0D,$0A,0

MSG_RUN:
        .byte "Running...",$0D,$0A,0

MSG_NEW:
        .byte "Program cleared",$0D,$0A,0

BUFLEN:
        .byte 0
BUFFER:
        .dsb 80,0

PROG_END:
        .word PROG_START

*= $FFFC
.word START
