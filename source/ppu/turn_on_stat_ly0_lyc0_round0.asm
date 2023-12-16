INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT after PPU is turned on with LYC=0.

EntryPoint:
    ; Set LYC=0
    xor a
    ldh [rLYC], a

    ResetPPU

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess