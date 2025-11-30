; Test LDA/STA instructions

OUTCH = $F000

        * = $0300

START:
        LDA #$42
        CMP #$42
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH

        LDA #$AA
        STA $0200
        LDA $0200
        CMP #$AA
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH

        LDA #$55
        STA $10
        LDA $10
        CMP #$55
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH

        LDX #$05
        LDA #$33
        STA $10,X
        LDA $10,X
        CMP #$33
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH

        LDX #$10
        LDA #$77
        STA $0200,X
        LDA $0200,X
        CMP #$77
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH

        LDY #$20
        LDA #$99
        STA $0200,Y
        LDA $0200,Y
        CMP #$99
        BEQ T6
        JMP FAIL
T6:     LDA #'6'
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
