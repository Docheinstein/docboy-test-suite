INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of FF75 register.

EntryPoint:
    ; Write 00 -> Read 8F
    ld a, $00
    ldh [$FF75], a
    ldh a, [$FF75]

    cp $8F
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [$FF75], a
    ldh a, [$FF75]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB