; Test program for Tiny BASIC
; Simulates user input and tests PRINT command

OUTCH = $F000
INCH  = $F001

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Print test message
        LDX #0
TEST_LP:
        LDA MSG,X
        BEQ DONE
        STA OUTCH
        INX
        JMP TEST_LP

DONE:
        ; Output OK for test
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
        ; Halt
HALT:   JMP HALT

MSG:
        .byte "BASIC Test",$0D,$0A,0

*= $FFFC
.word START
