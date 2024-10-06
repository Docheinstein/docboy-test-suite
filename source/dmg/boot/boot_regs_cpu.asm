INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the CPU registers at boot time.

EntryPoint:
    ; A
    cp $01
    jp nz, TestFail

    ; B
    ld a, $00
    cp b
    jp nz, TestFail

    ; C
    ld a, $13
    cp c
    jp nz, TestFail

    ; D
    ld a, $00
    cp d
    jp nz, TestFail

    ; E
    ld a, $D8
    cp e
    jp nz, TestFail

    ; H
    ld a, $01
    cp h
    jp nz, TestFail

    ; L
    ld a, $4D
    cp l
    jp nz, TestFail

    jp TestSuccess