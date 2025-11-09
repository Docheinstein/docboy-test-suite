INCLUDE "all.inc"

; Check the Joypad registers at boot time in DMG mode.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rP1, $ff

    jp TestSuccess