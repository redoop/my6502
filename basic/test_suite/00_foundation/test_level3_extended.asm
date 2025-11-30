; Level 3: Extended Instructions Test
;Tests: Logic ops, Shifts, Inc/Dec, Compare

OUTCH = $F000

        * = $0300

START:
        LDA #$FF
        AND #$0F
        CMP #$0F
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH
        
        LDA #$F0
        ORA #$0F
        CMP #$FF
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH
        
        LDA #$FF
        EOR #$FF
        CMP #$00
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH
        
        CLC
        LDA #$01
        ASL
        CMP #$02
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH
        
        CLC
        LDA #$02
        LSR
        CMP #$01
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH
        
        LDX #$10
        INX
        DEX
        CPX #$10
        BEQ T6
        JMP FAIL
T6:     LDA #'6'
        STA OUTCH
        
        LDY #$20
        INY
        DEY
        CPY #$20
        BEQ T7
        JMP FAIL
T7:     LDA #'7'
        STA OUTCH
        
        LDA #$10
        STA $10
        INC $10
        DEC $10
        LDA $10
        CMP #$10
        BEQ SUCCESS
        JMP FAIL
        
SUCCESS:
        LDA #'8'
        STA OUTCH
        LDA #' '
        STA OUTCH
        LDA #'O'
        STA OUTCH
        LDA #'K'
        STA OUTCH
        BRK

FAIL:   LDA #'F'
        STA OUTCH
        LDA #'A'
        STA OUTCH
        LDA #'I'
        STA OUTCH
        LDA #'L'
        STA OUTCH
        BRK

        * = $FFFC
        .word START
