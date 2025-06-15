INCLUDE "all.inc"

; Check the timing of STAT with various SCX from boot.

EntryPoint:
    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    LongWait 14 * 114

    Nops 9

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess
