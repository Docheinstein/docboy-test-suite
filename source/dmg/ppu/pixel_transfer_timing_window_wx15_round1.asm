INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3) with window enabled.

EntryPoint:
    ; Reset PPU phase
    DisablePPU

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_WINON | LCDCF_BGON
    ldh [rLCDC], a

    ; Wait until HBlank
    WaitScanline 1
    WaitMode 0

    ; Set WX
    ld a, 15
    ldh [rWX], a

    ; Wait until next line
    WaitScanline 2

    Nops 50

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    ld b, a

    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess