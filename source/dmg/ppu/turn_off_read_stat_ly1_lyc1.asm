INCLUDE "all.inc"

; Read STAT after PPU is turned off with LY=1 and LYC=1

EntryPoint:
    WaitVBlank

    ; LYC=1
    ld a, $01
    ld [rLYC], a

    Wait 11 * 114

    DisablePPU

    ldh a, [rSTAT]
    cp $84

    jp nz, TestFail

    jp TestSuccess