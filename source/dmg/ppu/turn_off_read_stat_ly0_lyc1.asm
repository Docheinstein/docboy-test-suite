INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Read STAT after PPU is turned off with LY=0 and LYC=1

EntryPoint:
    WaitVBlank

    ; LYC=1
    ld a, $01
    ld [rLYC], a

    LongWait 10 * 114

    DisablePPU

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess