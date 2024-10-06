INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the CPU registers at boot time.

EntryPoint:
    ; A
    cp $11
    jp nz, TestFailCGB

    ; B
    ld a, $00
    cp b
    jp nz, TestFailCGB

    ; C
    ld a, $00
    cp c
    jp nz, TestFailCGB

    ; D
    ld a, $FF
    cp d
    jp nz, TestFailCGB

    ; E
    ld a, $56
    cp e
    jp nz, TestFailCGB

    ; H
    ld a, $00
    cp h
    jp nz, TestFailCGB

    ; L
    ld a, $0D
    cp l
    jp nz, TestFailCGB

    jp TestSuccessCGB