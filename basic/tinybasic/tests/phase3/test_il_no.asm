; Phase 3 Test 1: IL NO opcode

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Execute NO opcode
        JSR IL_NO
        
        ; If we get here, test passed
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

; IL NO opcode handler
IL_NO:
        RTS

*= $FFFC
.word START
