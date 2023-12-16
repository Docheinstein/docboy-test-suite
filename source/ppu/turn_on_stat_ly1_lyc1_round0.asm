INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT at LY=1 after PPU is turned on with LYC=1.

EntryPoint:
    ; Set LYC=1
    ld a, $01
    ldh [rLYC], a

    ResetPPU

    ; Wait LY=1
    Nops 109

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess