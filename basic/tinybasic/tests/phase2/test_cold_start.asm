; Phase 2 Test 1: Cold Start Vector
; Test cold start vector jump

OUTCH = $F000

*= $0200

START:
        JMP CV

; Vector table
CV:     JMP COLD_S
WV:     JMP WARM_S

COLD_S:
        LDX #$FF
        TXS
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
HALT:   JMP HALT

WARM_S:
        JMP HALT

*= $FFFC
.word START
