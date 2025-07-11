INCLUDE "all.inc"

; Read STAT after PPU is turned off with LY=1 and LYC=0

EntryPoint:
    WaitVBlank

    ; LYC=0
    ld a, $00
    ld [rLYC], a

    Wait 11 * 114

    DisablePPU

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess