INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of HDMA5 register.

EntryPoint:
    ; Write 00 -> Read FF
    ld a, $00
    ldh [rHDMA5], a
    ldh a, [rHDMA5]

    cp $ff
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rHDMA5], a
    ldh a, [rHDMA5]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB