INCLUDE "all.inc"

; Check the Video registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rNR10, $80
    Expect rNR11, $BF
    Expect rNR12, $F3
    Expect rNR13, $FF
    Expect rNR14, $BF

    Expect rNR21, $3F
    Expect rNR22, $00
    Expect rNR23, $FF
    Expect rNR24, $BF

    Expect rNR30, $7F
    Expect rNR31, $FF
    Expect rNR32, $9F
    Expect rNR33, $FF
    Expect rNR34, $BF

    Expect rNR41, $FF
    Expect rNR42, $00
    Expect rNR43, $00
    Expect rNR44, $BF

    Expect rNR50, $77
    Expect rNR51, $F3
    Expect rNR52, $F1

    ; Wave RAM is not deterministic

    jp TestSuccess