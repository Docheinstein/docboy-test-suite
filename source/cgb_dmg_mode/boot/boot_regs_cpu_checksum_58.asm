;! TITLE=SIMULATIONS
;! OLD_LICENSE=1

INCLUDE "all.inc"

; Check the CPU registers at boot time in DMG mode.

EntryPoint:
    ; A
    cp $11
    jp nz, TestFail

    ; B
    ld a, $58
    cp b
    jp nz, TestFail

    ; C
    ld a, $00
    cp c
    jp nz, TestFail

    ; D
    ld a, $00
    cp d
    jp nz, TestFail

    ; E
    ld a, $08
    cp e
    jp nz, TestFail

    ; H
    ld a, $99
    cp h
    jp nz, TestFail

    ; L
    ld a, $1a
    cp l
    jp nz, TestFail

    jp TestSuccess