INCLUDE "all.inc"

; HRAM generally has random data, but the end of HRAM that is used for the function callstack is deterministic.

EntryPoint:
    ld hl, $fffa

    ld a, [hli]
    cp $39
    jp nz, TestFail

    ld a, [hli]
    cp $01
    jp nz, TestFail

    ld a, [hli]
    cp $2e
    jp nz, TestFail

    ld a, [hli]
    cp $00
    jp nz, TestFail

    jp TestSuccess