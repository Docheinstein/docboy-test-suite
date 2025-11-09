INCLUDE "all.inc"

; Check the Interrupts registers at boot time in DMG mode.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rIF, $e1
    Expect rIE, $00

    jp TestSuccess