INCLUDE "docboy.inc"

; Check how much time it takes to read LY increased by 1 from boot.

EntryPoint:
    Nops 65

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    ld a, $91
    cp b
    jp nz, TestFail

    jp TestSuccess

