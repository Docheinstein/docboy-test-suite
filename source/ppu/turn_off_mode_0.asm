INCLUDE "hardware.inc"
INCLUDE "common.inc"

; STAT's mode should be set to 0 when LCD is turned off.

EntryPoint:
    ; Just go to a different scaline/mode
    WaitScanline 2

    WaitMode 3

    DisablePPU

    ; STAT's mode after turning off LCD should be 0
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess