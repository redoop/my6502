; Simple Tiny BASIC for my6502

OUTCH = $F000

*= $0200

START:
        LDX #$FF
        TXS
        
        ; Print messages
        LDX #0
LOOP1:  LDA MSG1,X
        BEQ NEXT1
        STA OUTCH
        INX
        JMP LOOP1

NEXT1:  LDA #$0D
        STA OUTCH
        LDA #$0A
        STA OUTCH
        
        LDX #0
LOOP2:  LDA MSG2,X
        BEQ NEXT2
        STA OUTCH
        INX
        JMP LOOP2

NEXT2:  LDA #$0D
        STA OUTCH
        LDA #$0A
        STA OUTCH
        
        LDX #0
LOOP3:  LDA MSG3,X
        BEQ DONE
        STA OUTCH
        INX
        JMP LOOP3

DONE:   LDA #$0D
        STA OUTCH
        LDA #$0A
        STA OUTCH
        
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        
HALT:   JMP HALT

MSG1:   .byte "Tiny BASIC v1.0",0
MSG2:   .byte "HELLO WORLD",0
MSG3:   .byte "READY",0

*= $FFFC
.word START
