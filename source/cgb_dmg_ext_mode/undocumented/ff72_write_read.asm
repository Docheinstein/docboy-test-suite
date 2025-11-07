INCLUDE "all.inc"

; Check write/read behavior of FF72 register.

EntryPoint:
    ; Write 00 -> Read 00
    ld a, $00
    ldh [$FF72], a
    ldh a, [$FF72]

    cp $00
    jp nz, TestFailBeep

    ; Write FF -> Read FF
    ld a, $ff
    ldh [$FF72], a
    ldh a, [$FF72]

    cp $ff
    jp nz, TestFailBeep

    jp TestSuccess