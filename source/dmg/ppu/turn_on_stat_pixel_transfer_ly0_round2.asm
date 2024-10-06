INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT at Pixel Transfer at LY=0 after PPU is turned on.

EntryPoint:
    ResetPPU

    Nops 15

    ; Read STAT
    ld hl, rSTAT
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $87
    cp b
    jp nz, TestFail

    jp TestSuccess