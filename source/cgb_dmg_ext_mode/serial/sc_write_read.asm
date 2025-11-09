INCLUDE "all.inc"

; Check what is write/read of SC register in DMG mode.

EntryPoint:
    ; Write 00 -> Read 7C
    ld a, $00
    ldh [rSC], a
    ldh a, [rSC]

    cp $7c
    jp nz, TestFailBeep

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rSC], a
    ldh a, [rSC]

    cp $ff
    jp nz, TestFailBeep

    jp TestSuccess