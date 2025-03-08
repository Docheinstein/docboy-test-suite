INCLUDE "all.inc"

; Check write/read behavior of SC register.

EntryPoint:
    ; Write 00 -> Read 7C
    ld a, $00
    ldh [rSC], a
    ldh a, [rSC]

    cp $7c
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rSC], a
    ldh a, [rSC]

    cp $ff
    jp nz, TestFail

    jp TestSuccess