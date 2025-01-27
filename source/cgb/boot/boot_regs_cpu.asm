INCLUDE "docboy.inc"

; Check the CPU registers at boot time.

EntryPoint:
    ; A
    cp $11
    jp nz, TestFail

    ; B
    ld a, $00
    cp b
    jp nz, TestFail

    ; C
    ld a, $00
    cp c
    jp nz, TestFail

    ; D
    ld a, $FF
    cp d
    jp nz, TestFail

    ; E
    ld a, $56
    cp e
    jp nz, TestFail

    ; H
    ld a, $00
    cp h
    jp nz, TestFail

    ; L
    ld a, $0D
    cp l
    jp nz, TestFail

    jp TestSuccess