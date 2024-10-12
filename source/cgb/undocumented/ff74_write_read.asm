INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of FF74 register.

EntryPoint:
    ; Write 00 -> Read 00
    ld a, $00
    ldh [$FF74], a
    ldh a, [$FF74]

    cp $00
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [$FF74], a
    ldh a, [$FF74]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB