INCLUDE "all.inc"

; KEY0 can't be written to.

EntryPoint:
    ld a, $04
    ldh a, [rKEY0]
    cp $ff
    jp nz, TestFail

    ld a, $80
    ldh a, [rKEY0]
    cp $ff
    jp nz, TestFail

    ld a, $c0
    ldh a, [rKEY0]
    cp $ff
    jp nz, TestFail

    ld a, $00
    ldh a, [rKEY0]
    cp $ff
    jp nz, TestFail

    jp TestSuccess