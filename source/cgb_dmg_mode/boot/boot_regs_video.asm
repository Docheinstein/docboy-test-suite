INCLUDE "all.inc"

; Check the Video registers at boot time in DMG mode.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rLCDC, $91
    Expect rSTAT, $81
    Expect rSCY, $00
    Expect rSCX, $00

    Expect rLY, $95
    Expect rLYC, $00
    Expect rDMA, $00
    Expect rBGP, $fc

    ; rOBP0: not deterministic
    ; rOBP1: not deterministic
    Expect rWY, $00
    Expect rWX, $00

    jp TestSuccess