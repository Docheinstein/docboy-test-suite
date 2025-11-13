Title "PROMOTIONS"
OldLicenseeCode $01

INCLUDE "all.inc"

; Check the CPU registers at boot time in DMG mode.

EntryPoint:
    ; A
    cp $11
    jp nz, TestFail

    ; B
    ld a, $1a
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
    ld a, $00
    cp h
    jp nz, TestFail

    ; L
    ld a, $7c
    cp l
    jp nz, TestFail

    jp TestSuccess