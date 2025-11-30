; Test Branch instructions

OUTCH = $F000

        * = $0300

START:
        LDA #$00
        BEQ T1
        JMP FAIL
T1:     LDA #'1'
        STA OUTCH

        LDA #$01
        BNE T2
        JMP FAIL
T2:     LDA #'2'
        STA OUTCH

        SEC
        BCS T3
        JMP FAIL
T3:     LDA #'3'
        STA OUTCH

        CLC
        BCC T4
        JMP FAIL
T4:     LDA #'4'
        STA OUTCH

        LDA #$FF
        BMI T5
        JMP FAIL
T5:     LDA #'5'
        STA OUTCH

        LDA #$7F
        BPL T6
        JMP FAIL
T6:     LDA #'6'
        STA OUTCH

        CLV
        LDA #$7F
        ADC #$01
        BVS T7
        JMP FAIL
T7:     LDA #'7'
        STA OUTCH

        CLV
        BVC T8
        JMP FAIL
T8:     LDA #'8'
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
