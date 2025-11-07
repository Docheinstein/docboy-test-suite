INCLUDE "all.inc"

; Check write/read behavior of KEY1 register.

EntryPoint:
    ; Write 00 -> Read 00
    ld a, $00
    ldh [rKEY1], a
    ldh a, [rKEY1]

    cp $7e
    jp nz, TestFailBeep

    ; Write FF -> Read 7F
    ld a, $ff
    ldh [rKEY1], a
    ldh a, [rKEY1]

    cp $7f
    jp nz, TestFailBeep

    jp TestSuccess