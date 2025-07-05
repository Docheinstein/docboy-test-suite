INCLUDE "all.inc"

; Check the timing of STAT with various SCX from boot.

EntryPoint:
    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    Wait 14 * 114

    Nops 10

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess
