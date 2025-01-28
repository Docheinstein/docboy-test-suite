INCLUDE "all.inc"

; Read STAT after PPU is turned off with LY=0 and LYC=0

EntryPoint:
    WaitVBlank

    ; LYC=0
    ld a, $00
    ld [rLYC], a

    LongWait 10 * 114

    DisablePPU

    ldh a, [rSTAT]
    cp $84

    jp nz, TestFail

    jp TestSuccess