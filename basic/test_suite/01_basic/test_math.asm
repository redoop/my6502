; Test ADC/SBC instructions

OUTCH = $F000

        * = $0300

START:
        CLC
        LDA #$10
        ADC #$20
        CMP #$30
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH

        SEC
        LDA #$10
        ADC #$20
        CMP #$31
        BEQ T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH

        CLC
        LDA #$FF
        ADC #$01
        BCC FAIL
        CMP #$00
        BEQ T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH

        SEC
        LDA #$30
        SBC #$10
        CMP #$20
        BEQ T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH

        CLC
        LDA #$30
        SBC #$10
        CMP #$1F
        BEQ T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH

        CLC
        LDA #$10
        ADC #$F0
        BEQ T6
        JMP FAIL
T6:     LDA #'6'
        STA OUTCH

        CLC
        LDA #$00
        ADC #$FF
        BMI T7
        JMP FAIL
T7:     LDA #'7'
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
