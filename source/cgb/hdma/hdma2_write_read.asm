INCLUDE "docboy.inc"

; Check write/read behavior of HDMA2 register.

EntryPoint:
    ; Write 00 -> Read FF
    ld a, $00
    ldh [rHDMA2], a
    ldh a, [rHDMA2]

    cp $ff
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rHDMA2], a
    ldh a, [rHDMA2]

    cp $ff
    jp nz, TestFail

    jp TestSuccess