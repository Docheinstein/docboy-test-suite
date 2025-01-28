INCLUDE "all.inc"

; Check the Joypad registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rP1, $cf

    jp TestSuccess