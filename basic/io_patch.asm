; I/O patch for my6502
; Replace ACIA functions with simple I/O

; Get character from input (with echo)
RCCHR:
        LDA INCH                   ; Read from input port
        BEQ RCCHR                  ; Loop until we get one
        ; Fall through to SNDCHR for echo

; Send character to output
SNDCHR:
        STA $FE                    ; Save the character
        CMP #$FF                   ; Filter unwanted characters
        BEQ EXSC
        CMP #$00
        BEQ EXSC
        CMP #$91
        BEQ EXSC
        CMP #$93
        BEQ EXSC
        CMP #$80
        BEQ EXSC
        LDA $FE                    ; Restore character
        STA OUTCH                  ; Write to output port
EXSC:
        RTS

; Break routine - check for input
BREAK:
        STA $FE                    ; Save A
        CLC                        ; Clear carry
        LDA INCH                   ; Check for input
        BEQ NO_CHR                 ; No character
        SEC                        ; Set carry (break detected)
NO_CHR:
        LDA $FE                    ; Restore A
        RTS
