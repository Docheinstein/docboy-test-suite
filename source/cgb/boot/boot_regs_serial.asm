INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the Serial registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFailCGB
ENDM

EntryPoint:
    Expect rSB, $00
    Expect rSC, $7f

    jp TestSuccessCGB