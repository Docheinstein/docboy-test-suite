INCLUDE "all.inc"

; Check what is write/read of SC register in DMG mode.

EntryPoint:
    ; Write 00 -> Read 7C
    ld a, $00
    ldh [rSC], a
    ldh a, [rSC]

    cp $7e
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rSC], a
    ldh a, [rSC]

    cp $ff
    jp nz, TestFail

    jp TestSuccess