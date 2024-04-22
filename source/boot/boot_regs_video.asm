INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the Interrupts registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rLCDC, $91
    Expect rSTAT, $86
    Expect rSCY, $00
    Expect rSCX, $00
    Expect rLY, $00
    Expect rLYC, $00
    Expect rDMA, $ff
    Expect rBGP, $fc
    ; rOBP0: not deterministic
    ; rOBP1: not deterministic
    Expect rWY, $00
    Expect rWX, $00

    jp TestSuccess