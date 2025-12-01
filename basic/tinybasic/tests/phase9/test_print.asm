; Phase 9: Test PRINT command

OUTCH = $F000

*= $0300

START:
        LDX #$FF
        TXS
        
        ; Simulate PRINT "OK"
        LDX #0
PRNT:   LDA STR,X
        BEQ DONE
        STA OUTCH
        INX
        JMP PRNT

DONE:   JMP DONE

STR:    .byte "OK",0

*= $FFFC
.word START
