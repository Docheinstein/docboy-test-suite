INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check write/read behavior of OPRI register.

EntryPoint:
    ; Write 00 -> Read FE
    ld a, $00
    ldh [$FF6C], a
    ldh a, [$FF6C]

    cp $fe
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [$FF6C], a
    ldh a, [$FF6C]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB