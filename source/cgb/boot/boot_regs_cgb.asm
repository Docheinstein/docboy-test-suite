INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the CGB registers at boot time.

MACRO Expect
    ldh a, [\1]
    cp \2
    jp nz, TestFailCGB
ENDM

EntryPoint:
    Expect rKEY1, $7e
    Expect rVBK, $fe
    Expect rHDMA1, $ff
    Expect rHDMA2, $ff
    Expect rHDMA3, $ff
    Expect rHDMA4, $ff
    Expect rHDMA5, $ff
    Expect rRP, $3e
    Expect rBCPS, $c0
    Expect rBCPD, $ff
    Expect rOCPS, $c1
    ; Expect rOCPD, $00
    Expect rSVBK, $f8
    Expect $FF6C, $fe
    Expect $FF72, $00
    Expect $FF73, $00
    Expect $FF74, $00
    Expect $FF75, $8f

    jp TestSuccessCGB