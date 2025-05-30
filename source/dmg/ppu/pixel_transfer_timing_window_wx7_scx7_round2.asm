INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3) with window enabled.

EntryPoint:
    ; Reset PPU phase
    DisablePPU

    ; Set SCX=7
    ld a, 7
    ldh [rSCX], a

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_WINON | LCDCF_BGON
    ldh [rLCDC], a

    ; Wait until HBlank
    WaitScanline 1
    WaitMode 0

    ; Set WX=7
    ld a, 7
    ldh [rWX], a

    ; Wait until next line
    WaitScanline 2

    Nops 53

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess