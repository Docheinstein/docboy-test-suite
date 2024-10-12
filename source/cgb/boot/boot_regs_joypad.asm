INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the Joypad registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFailCGB
ENDM

EntryPoint:
    Expect rP1, $cf

    jp TestSuccessCGB