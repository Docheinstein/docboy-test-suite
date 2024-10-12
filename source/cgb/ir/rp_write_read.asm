INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"
INCLUDE "print.inc"
INCLUDE "debug.inc"

; Check write/read behavior of RP register.

EntryPoint:
    ; Write 00 -> Read 3E
    ld a, $00
    ldh [rRP], a
    ldh a, [rRP]

    cp $3e
    jp nz, TestFailCGB

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rRP], a
    ldh a, [rRP]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB