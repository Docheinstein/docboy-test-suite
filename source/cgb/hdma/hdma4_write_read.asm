INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of HDMA4 register.

EntryPoint:
    ; Write 00 -> Read FF
    ld a, $00
    ldh [rHDMA4], a
    ldh a, [rHDMA4]

    cp $ff
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rHDMA4], a
    ldh a, [rHDMA4]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB