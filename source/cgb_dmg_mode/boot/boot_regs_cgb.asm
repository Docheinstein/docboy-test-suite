INCLUDE "all.inc"

; Check the CGB registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFail
ENDM

EntryPoint:
    Expect rKEY0, $ff
    Expect rKEY1, $ff
    Expect rVBK, $fe
    Expect rHDMA1, $ff

    Expect rHDMA2, $ff
    Expect rHDMA3, $ff
    Expect rHDMA4, $ff
    Expect rHDMA5, $ff

    Expect rRP, $ff
    Expect rBCPS, $c8
    Expect rBCPD, $ff
    Expect rOCPS, $d0

    Expect rOCPD, $ff
    Expect rSVBK, $ff
    Expect rOPRI, $ff
    Expect $FF72, $00

    Expect $FF73, $00
    Expect $FF74, $ff
    Expect $FF75, $8f

    jp TestSuccess