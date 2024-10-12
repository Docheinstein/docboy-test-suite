INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the Timers registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFailCGB
ENDM

EntryPoint:
    ; rDIV can't be predicted on CGB
    Expect rTIMA, $00
    Expect rTMA, $00
    Expect rTAC, $f8

    jp TestSuccessCGB