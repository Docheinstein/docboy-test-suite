INCLUDE "all.inc"

; Check the Timers registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rDIV, $ab
    Expect rTIMA, $00
    Expect rTMA, $00
    Expect rTAC, $f8

    jp TestSuccess