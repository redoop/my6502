; Simple BASIC demo

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        LDX #0
BANNER: LDA MSG1,X
        BEQ CMD1
        STA OUTCH
        INX
        JMP BANNER

; Command 1
CMD1:   LDX #0
PRT1:   LDA MSG2,X
        BEQ EXEC1
        STA OUTCH
        INX
        JMP PRT1

EXEC1:  LDX #0
OUT1:   LDA STR1,X
        BEQ CMD2
        STA OUTCH
        INX
        JMP OUT1

; Command 2
CMD2:   LDX #0
PRT2:   LDA MSG3,X
        BEQ EXEC2
        STA OUTCH
        INX
        JMP PRT2

EXEC2:  LDX #0
OUT2:   LDA STR2,X
        BEQ CMD3
        STA OUTCH
        INX
        JMP OUT2

; Command 3
CMD3:   LDX #0
PRT3:   LDA MSG4,X
        BEQ EXEC3
        STA OUTCH
        INX
        JMP PRT3

EXEC3:  LDX #0
OUT3:   LDA STR3,X
        BEQ DONE
        STA OUTCH
        INX
        JMP OUT3

DONE:   JMP DONE

MSG1:   .byte "Tiny BASIC v1.0",$0D,$0A
        .byte "Ready",$0D,$0A,0

MSG2:   .byte "> PRINT ",$22,"HELLO",$22,$0D,$0A,0
STR1:   .byte "HELLO",$0D,$0A,0

MSG3:   .byte "> PRINT 123",$0D,$0A,0
STR2:   .byte "123",$0D,$0A,0

MSG4:   .byte "> PRINT ",$22,"DONE",$22,$0D,$0A,0
STR3:   .byte "DONE",$0D,$0A,0

*= $FFFC
.word START
