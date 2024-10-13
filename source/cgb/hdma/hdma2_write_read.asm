INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of HDMA2 register.

EntryPoint:
    ; Write 00 -> Read FF
    ld a, $00
    ldh [rHDMA2], a
    ldh a, [rHDMA2]

    cp $ff
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rHDMA2], a
    ldh a, [rHDMA2]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB