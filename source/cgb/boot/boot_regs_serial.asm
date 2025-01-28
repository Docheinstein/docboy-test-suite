INCLUDE "all.inc"

; Check the Serial registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rSB, $00
    Expect rSC, $7f

    jp TestSuccess