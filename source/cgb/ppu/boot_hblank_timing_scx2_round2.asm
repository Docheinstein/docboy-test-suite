INCLUDE "all.inc"

; Check the timing of STAT with various SCX from boot.

EntryPoint:
    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    LongWait 14 * 114

    Nops 10

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess
