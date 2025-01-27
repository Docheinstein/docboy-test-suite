INCLUDE "docboy.inc"

; Writing to LY.

EntryPoint:
    ; Wait for start of scanline
    Nops 8

    ; Write to LY
    ld a, $42
    ldh [rLY], a

    ; Read from LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    jp TestSuccess
